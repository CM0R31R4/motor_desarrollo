#include <stdio.h>
//#include "OleDatabase.h"
#include <xml.h>
#include <errno.h>
#include <sys/socket.h>

int FLG_ERROR_GRAVE;

int nProcesos_MSQL;

DBPROCESS *OpenDatabaseMSSQL(int id);
int msg_handler(DBPROCESS *dbproc, DBINT msgno, int msgstate, int severity, char *msgtext, char *srvname, char *procname, int line);
int err_handler(DBPROCESS * dbproc, int severity, int dberr, int oserr, char *dberrstr, char *oserrstr)
;
	int TransactionThread(int id)
	{
		int nQuery,sts;
		char szData[MAX_BUFFER];
		char szAux[MAX_BUFFER];
		//Tipo_XML *xml=NULL;
		//PGresult *res=NULL;
		int nFila,nReg;
		int nSocketCerrado;
		char szTmp[200];
		int ref,len;
		Tipo_Data *pData=NULL;
		int nReintenta;
		char szTagFinal[200];
		
		
		printf("(%02i) INICIA THREAD SOCKET ",id);
		Conexion[id].nAbierta=0;
		Conexion[id].id_thread=pthread_self();
		sprintf(szTmp,"pthread_self=%lu",Conexion[id].pid);
		WriteLog(id,szTmp);
		while(1)
		{
		   EsperaActivacion2(id,&Conexion[id]);

		   if (Conexion[id].nAbierta==0)
		   {
			if (!Conexion[id].nAbierta)
			{	
		   	    WriteError(id,"Abre Conexion BD");
			    //Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
			    Conexion[id].dbconn=OpenDatabaseMSSQL(id);
			}
			if (Conexion[id].dbconn==NULL)
			{
		   	        WriteError(id,"Falla Conexion BD");
				goto fin;
			}
			Conexion[id].nAbierta=1;
		   }
		   //sprintf(szAux,"Inicia Socket=%i",Conexion[id].nSocket);
		   //WriteLogEst(id,szAux);
		   printf("(%02i) Conexion %i\n\r",id,Conexion[id].nSocket); 

		   dbmsghandle( (MHANDLEFUNC)msg_handler  );
		   dberrhandle( (EHANDLEFUNC)err_handler  );
		   FLG_ERROR_GRAVE = 0;

		   //Inicia Puntero
		   pData=CreaData();
		   nQuery=0;
		   //GetMemoria(id,szTmp);
		   //WriteError(id,szTmp);
		   //while ((sts=LeePaqueteBD(id,Conexion[id].nSocket,szData,MAX_BUFFER,global.nTimeoutBaseDatos))>0)
		   //while ((sts=LeePaquete(id,Conexion[id].nSocket,pData,global.nTimeoutBaseDatos))>0)
		   while ((sts=LeePaquete(id,Conexion[id].nSocket,pData,Conexion[id].nTimeoutBaseDatos))>0)
		   {
			//printf("(%02i) LEE %s\n\r",id,szData);
			Conexion[id].xml=CierraXML(Conexion[id].xml);
			//xml=CierraXML(xml);
			//xml=ProcesaInputXML1(xml,szData);
			//if (GetStrXML(xml,"GET_RECORD",szComando,MAX_BUFFER))
			//WriteLog(id,pData->data);
			sprintf(szData,"%s",pData->data);
			pData=LiberaData(pData);
			pData=CreaData();
			nReintenta=0;
//reintenta:
			//WriteLog(id,"Paso1");
		   	//WriteLog(id,szData);
			//WriteLog(id,"Paso2");
			if (memcmp(szData,"<GET_RECORD>",12)==0)
			{
				ref=12;
				//Eliminamos el final </GET_RECORD>
				//len=strlen(szData)-ref-2;
				len=strlen(szData)-ref-1;
				szData[len]=0;
				//sprintf(szAux,"(%02i) Socket(%i) GET_RECORD %s",id,Conexion[id].nSocket,&szData[ref]);
				sprintf(szTagFinal,"</GET_RECORD>");
				SET_TX(id,&szData[ref]);
				//WriteLog(id,szAux);
				//GetOneRecord(id,Conexion[id].nSocket,&szData[ref]);
				//GetOneRecordAsinc(id,Conexion[id].nSocket,&szData[ref]);
				GetOneRecordMSSQL(id,Conexion[id].nSocket,&szData[ref],"ONE_RECORD");
				nQuery=0;
				break;
			}
			//Eejcuta el Query, responde y vuelve a esperar un query
			if (memcmp(szData,"<GET_RECORD_PERSISTENTE>",24)==0)
			{
				ref=24;
				len=strlen(szData)-ref-1;
				szData[len]=0;
				//sprintf(szAux,"(%02i) Socket(%i) GET_RECORD %s",id,Conexion[id].nSocket,&szData[ref]);
				sprintf(szTagFinal,"</GET_RECORD_PERSISTENTE>");
				SET_TX(id,&szData[ref]);
				//WriteLog(id,szAux);
				GetOneRecordMSSQL(id,Conexion[id].nSocket,&szData[ref],"ONE_RECORD");
				nQuery=1;
				//Aumenta el timeout para que no desconecte
				Conexion[id].nTimeoutBaseDatos=60;
				continue;
			}
			else if (memcmp(szData,"<CLOSE>",7)==0)
			//else if (GetStrXML(xml,"CLOSE",szComando,1024))
			{
				//printf("(%02i) CloseDatabase\n\r",id);
				nQuery=0;
				break;	
			}
			else if (memcmp(szData,"<GET_RECORD_MULTI>",18)==0)
			{	
			        ref=18;
                                //Eliminamos el final </GET_RECORD>
                                //len=strlen(szData)-ref-2;
                                len=strlen(szData)-ref-1;
                                szData[len]=0;
                                //sprintf(szAux,"(%02i) Socket(%i) GET_MULTIPLE %s",id,Conexion[id].nSocket,&szData[ref]);
				sprintf(szTagFinal,"</GET_RECORD_MULTI>");
                                SET_TX(id,&szData[ref]);
                                //WriteLog(id,szAux);
				GetOneRecordMSSQL(id,Conexion[id].nSocket,&szData[ref],"MULTIPLE");
                                //GetOneRecord(id,Conexion[id].nSocket,&szData[ref],Conexion[id].conn);
                                //GetMultipleRecordAsinc(id,Conexion[id].nSocket,&szData[ref],Conexion[id].conn);
                                nQuery=0;
                                break;
			}
			else if (memcmp(szData,"<GET_RECORD_MULTI_PERSISTENTE>",30)==0)
			{	
			        ref=30;
                                //Eliminamos el final </GET_RECORD>
                                //len=strlen(szData)-ref-2;
                                len=strlen(szData)-ref-1;
                                szData[len]=0;
                                //sprintf(szAux,"(%02i) Socket(%i) GET_RECORD_MULTI_PERSISTENTE %s",id,Conexion[id].nSocket,&szData[ref]);
				sprintf(szTagFinal,"</GET_RECORD_MULTI_PERSISTENTE>");
                                //sprintf(szAux,"Coenxion(%02i)-Socket(%i)",id,Conexion[id].nSocket);
                                SET_TX(id,&szData[ref]);
                                //WriteLog(id,szAux);
				GetOneRecordMSSQL(id,Conexion[id].nSocket,&szData[ref],"MULTIPLE");
				nQuery=1;
				//Si se cerro la conexion en la ejecucion, vamos a reabrir el API. falla la Persistencia
		   		if (Conexion[id].nAbierta!=1) break;
				//Aumenta el timeout para que no desconecte
				Conexion[id].nTimeoutBaseDatos=60;
				continue;
			}
			//else if (GetStrXML(xml,"CAMPOS",szComando,1024))
			else if (memcmp(szData,"<CAMPOS>",8)==0)
			{
				ref=8;
				//len=strlen(szData)-ref-2;
				len=strlen(szData)-ref-1;
				szData[len]=0;
				//sprintf(szAux,"(%02i) Socket(%i) CAMPOS %s",id,Conexion[id].nSocket,&szData[ref]);
				SET_TX(id,&szData[ref]);
				//GetCamposSql(id,Conexion[id].nSocket,&szData[ref],Conexion[id].conn);
				GetCamposMSSQL(id,Conexion[id].nSocket,&szData[ref],Conexion[id].dbconn);
				break;
			}
			else if (memcmp(szData,"<SQL>",5)==0)
			//else if (GetStrXML(xml,"SQL",szComando,MAX_BUFFER))
			{
				ref=5;
				//len=strlen(szData)-ref-2;
				len=strlen(szData)-ref-1;
				szData[len]=0;
				//sprintf(szAux,"(%02i) Socket(%i) SQL %s",id,Conexion[id].nSocket,&szData[ref]);
				SET_TX(id,&szData[ref]);
				//res=ExecuteSql(res,id,Conexion[id].nSocket,&szData[ref],Conexion[id].conn);
				nQuery=0;
				nFila=0;
				break;
			}
			else if (memcmp(szData,"<QUERY>",7)==0)
			//else if (GetStrXML(xml,"QUERY",szComando,MAX_BUFFER))
			{
				ref=7;
				//len=strlen(szData)-ref-2;
				len=strlen(szData)-ref-1;
				szData[len]=0;
		   		WriteLog(id,&szData[ref]);
				//sprintf(szAux,"(%02i) Socket(%i) SQL %s",id,Conexion[id].nSocket,&szData[ref]);
				SET_TX(id,&szData[ref]);
				nFila=0;
				nReg=0;
				//res=(PGresult *)ExecuteSql(res,id,Conexion[id].nSocket,&szData[ref],Conexion[id].conn);
				nQuery=1;
			}
			else if (memcmp(szData,"<MOVE_NEXT_100>",15)==0)
			//else if (GetStrXML(xml,"MOVE_NEXT_100",szComando,MAX_BUFFER))
			{
				/*
				if (nQuery)
				{
					sprintf(szAux,"(%02i) Socket(%i) MOVE_NEXT_100",id,Conexion[id].nSocket);
					if (!MoveNextData100(id,Conexion[id].nSocket,res,&nFila,&nReg))
					{
						PQclear(res);
						res=NULL;
						printf("(%02i) Fin de Query...\n\r",id);
						nQuery=0;
						break;
					}
				}
				else
				{
					printf("(%02i) No hay query activa...\n\r",id);
					break;
				}
				*/
			}
			else if (memcmp(szData,"<MOVE_NEXT_NIVEL_100>",21)==0)
			//else if (GetStrXML(xml,"MOVE_NEXT_NIVEL_100",szComando,MAX_BUFFER))
			{
				/*
				if (nQuery)
				{
					sprintf(szAux,"(%02i) Socket(%i) MOVE_NEXT_100",id,Conexion[id].nSocket);
					if (!MoveNextData_100(id,Conexion[id].nSocket,res,&nFila,&nReg))
					{
						PQclear(res);
						res=NULL;
						printf("(%02i) Fin de Query...\n\r",id);
						nQuery=0;
						break;
					}
				}
				else
				{
					printf("(%02i) No hay query activa...\n\r",id);
					break;
				}
				*/
			}
			else if (memcmp(szData,"<MOVE_NEXT>",11)==0)
			//else if (GetStrXML(xml,"MOVE_NEXT",szComando,MAX_BUFFER))
			{
				/*
				if (nQuery)
				{
					sprintf(szAux,"(%02i) Socket(%i) MOVE_NEXT Fila=%i",id,Conexion[id].nSocket,nFila);
					if (!MoveNextData(id,Conexion[id].nSocket,res,nFila++))
					{
						PQclear(res);
						res=NULL;
						printf("(%02i) Fin de Query...\n\r",id);
						nQuery=0;
						break;
					}
				}
				else
				{
					printf("(%02i) No hay query activa...\n\r",id);
					break;
				}
				*/
			}
		   } //while

		   //xml=CierraXML(xml);
		   /*
		   if (res!=NULL) 
		   {
			   WriteLog(id,"PQclear");
			   PQclear(res);
			   res=NULL;
		   }
		*/
		
		   //si esta cerrada la conexion...
		   if (Conexion[id].nAbierta!=1)
		   {
			printf("(%02i) Abre conexion Base Datos..\n\r",id);
			WriteError(id,"Re-Abre Conexion a BD");
			WriteLog(id,"Re-Abre Conexion a BD");
			//Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
			
			Conexion[id].dbconn=OpenDatabaseMSSQL(id);
		 	if (Conexion[id].dbconn==NULL)
			{
				printf("(%02i) Falla Conexion a BD",id);
				WriteError(id,"Falla Re-Conexion a BD");
				//No intento reconectar, simplemente espero la siguiente tx
				goto fin;
			}
			WriteLog(id,"ReAbre Conexion a BD OK");
			Conexion[id].nAbierta=1;

			//Reintento un par de veces
			/*
			if (nReintenta++>1) goto fin; 
			WriteLog(id,"Reintenta Query....");
			strcat(szData,szTagFinal);
			goto reintenta;
			*/
			
	    	   }

	   //WriteError(id,"Paso 5");
	   //GetMemoria(id,szTmp);
	   //WriteError(id,szTmp);
fin:
	   sts=close(Conexion[id].nSocket);
	   WriteLog(id,"DesactivaProceso2");
	   DesactivaProceso2(id);
	}
}

int Thread_Exit(int id)
{
	if (Conexion[id].nAbierta)
	{
		dbfreebuf(Conexion[id].dbconn);
		dbclose(Conexion[id].dbconn);
		dbexit();
	}
}

int err_handler(DBPROCESS * dbproc, int severity, int dberr, int oserr, char *dberrstr, char *oserrstr)
{
	char szAux[MAX_BUFFER];
	int i=0;
	//Busco el pid del proceso que genero el error
	for(i=0;i<nProcesos_MSQL;i++)
 	{
		//sprintf(szAux,"Buscando %lu %lu",pthread_self(),Conexion[i].id_thread);
		//WriteLog(i,szAux);
		if (Conexion[i].id_thread==pthread_self()) break;
	}

	memset(szAux,0,sizeof(szAux));
	//Guardo en el XML el valor del error
	//Conexion[i].xml=CierraXML(Conexion[i].xml);
	Conexion[i].xml=InsertaDataXML(Conexion[i].xml,"API_DESCRIPCION_ERROR",dberrstr);
	sprintf(szAux,"%d",dberr);
	Conexion[i].xml=InsertaDataXML(Conexion[i].xml,"API_ERROR",szAux);
	Conexion[i].xml=InsertaDataXML(Conexion[i].xml,"API_CODRESPUESTA","2");

       	printf("DB-Library Error Number:[%d]  Error Message:[%s]\n", dberr, dberrstr);
       	sprintf(szAux,"DB-Library Error Number:[%d]  Error Message:[%s]\n", dberr, dberrstr);

	WriteLog(i,szAux);
	printf("DB-Library Severity:%d\n", severity);
      	sprintf(szAux,"DB-Library Severity:%d\n ", severity);
     	WriteLog(i,szAux);

      	printf("Operating-System Error Number : [%d] Error Message : [%s]\n", oserr, oserrstr);
      	sprintf(szAux,"Operating-System Error Number : [%d] Error Message : [%s]\n", oserr, oserrstr);
       	WriteLog(i,szAux);

      	if (dbproc == NULL){
        	WriteLog(i,"dbproc es null");
       	}

      	if (DBDEAD(dbproc)){
        	WriteLog(i, "dbproc es esta muerto");
     	}

      	FLG_ERROR_GRAVE = 1;
      	if (severity >= 6 ) {
        	FLG_ERROR_GRAVE = 2;
      	}

      return INT_CANCEL;
}


int msg_handler(DBPROCESS *dbproc, DBINT msgno, int msgstate, int severity, char *msgtext, char *srvname, char *procname, int line)
{
        char szAux[MAX_BUFFER];
	int i=0;

	//Busco el pid del proceso que genero el error
	for(i=0;i<nProcesos_MSQL;i++)
 	{
		//sprintf(szAux,"Buscando %lu %lu",pthread_self(),Conexion[i].id_thread);
		//WriteLog(i,szAux);
		if (Conexion[i].id_thread==pthread_self()) break;
	}

        printf ("SQL Server message %ld, state %d, severity %d: \n\t%s\n", msgno, msgstate, severity, msgtext);
        sprintf(szAux,"PID=%i SQL Server message %ld, state %d, severity %d: message %s ",getpid(), msgno, msgstate, severity, msgtext);
        WriteLog(i,szAux);

	//Guardo en el XML el valor del error
	//Conexion[i].xml=CierraXML(Conexion[i].xml);
	Conexion[i].xml=InsertaDataXML(Conexion[i].xml,"API_DESCRIPCION_MSG",msgtext);
	//Conexion[i].xml=InsertaDataXML(Conexion[i].xml,"API_DESCRIPCION_MSG","Error al convertir el tipo de datos nvarchar a datetime");
	//sprintf(szAux,"%ld",msgno);
	//Conexion[i].xml=InsertaDataXML(Conexion[i].xml,"API_ERROR",szAux);
	//Conexion[i].xml=InsertaDataXML(Conexion[i].xml,"API_CODRESPUESTA","2");

	/*
        if (strlen (srvname) != 0){
                 printf ("Server %s \n", srvname);
                 sprintf(szAux,"Server %s ", srvname);
                 WriteLog(i,szAux);
        }
        if (strlen (procname) != 0){
                printf ("Procedure %s \n", procname);
                sprintf(szAux, "Procedure %s ", procname);
                WriteLog(0,szAux);
        }
        if (line !=0){
                 printf ("Line %d \n", line);
                 sprintf(szAux, "Line %d ", line);
                 WriteLog(0,szAux);
        }
	*/

        return (0);
}

 

int main(int argc, char* argv[])
{
	Tipo_Proceso stProceso;
	char szTmp[100];
	INIT_GLOBAL();
	ProcesaArgumentos(argc,argv);
	GetIntXML(global.xml,"HILOS",&nProcesos_MSQL);
	sprintf(szTmp,"Base=%s Procesos=%i Puerto=%i",global.szBaseDatos,nProcesos_MSQL,Conexion[0].nPortDatabase);
	WriteLog(0,szTmp);
	WriteError(0,szTmp);
        InicializaServerSocket(Conexion[0].nPortDatabase);
        CreaConexiones("Servicio BaseDatos Ok.",nProcesos_MSQL);
	return 1;
}

