#include <stdio.h>
//#include "OleDatabase.h"
#include <xml.h>
#include <errno.h>
#include <sys/socket.h>


//PGresult *ExecuteSql(PGresult *res,int id,int nSocket,char szSql[],PGconn *conn);

	int TransactionThread(int id)
	{
		int nQuery,sts;
		//char pData->data[MAX_BUFFER];
		//char *pData->data;
		char szAux[MAX_BUFFER];
		//Tipo_XML *xml=NULL;
		//PGresult *res=NULL;
		int nFila,nReg;
		int nSocketCerrado;
		char szTmp[200];
		int ref,len;
		Tipo_Data *pData=NULL;

		 mysql_thread_init();
		
		printf("(%02i) INICIA THREAD SOCKET ",id);
		Conexion[id].nAbierta=0;
		while(1)
		{
		   EsperaActivacion2(id,&Conexion[id]);
		   if (Conexion[id].nAbierta==0)
		   {
			if (!Conexion[id].nAbierta)
			{	
		   	    WriteError(id,"Abre Conexion BD");
			    Conexion[id].pMysqlconn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
			}
			if (Conexion[id].pMysqlconn==NULL)
			{
		   	        WriteError(id,"Falla Conexion BD");
				goto fin;
			}
			Conexion[id].nAbierta=1;
		   }
		   //sprintf(szAux,"Inicia Socket=%i",Conexion[id].nSocket);
		   //WriteLogEst(id,szAux);
		   printf("(%02i) Conexion %i\n\r",id,Conexion[id].nSocket); 
		//sprintf(szAux,"Puntero6=%x",Conexion[id].pMysqlconn);
		//WriteLog(id,szAux);




		   //Inicia Puntero
		   pData=CreaData();
		   nQuery=0;
		   //GetMemoria(id,szTmp);
		   //WriteError(id,szTmp);
		   //while ((sts=LeePaqueteBD(id,Conexion[id].nSocket,pData->data,MAX_BUFFER,global.nTimeoutBaseDatos))>0)
		   while ((sts=LeePaquete(id,Conexion[id].nSocket,pData,Conexion[id].nTimeoutBaseDatos))>0)
		   {
			//printf("(%02i) LEE %s\n\r",id,pData->data);
			//xml=CierraXML(xml);
			//xml=ProcesaInputXML1(xml,pData->data);
			//if (GetStrXML(xml,"GET_RECORD",szComando,MAX_BUFFER))
			WriteLog(id,pData->data);
			//sprintf(pData->data,"%s",pData->data);
			//pData=LiberaData(pData);
			//pData=CreaData();
			//WriteLog(id,"Paso1");
		   	//WriteLog(id,pData->data);
			//WriteLog(id,"Paso2");
			if (memcmp(pData->data,"<GET_RECORD>",12)==0)
			{
				ref=12;
				//Eliminamos el final </GET_RECORD>
				//len=strlen(pData->data)-ref-2;
				len=strlen(pData->data)-ref-1;
				pData->data[len]=0;
				//sprintf(szAux,"(%02i) Socket(%i) GET_RECORD %s",id,Conexion[id].nSocket,&pData->data[ref]);
				//WriteLog(id,szAux);
				SET_TX(id,&pData->data[ref]);
				//GetOneRecord(id,Conexion[id].nSocket,&pData->data[ref]);
				GetOneRecordAsinc(id,Conexion[id].nSocket,&pData->data[ref]);
				nQuery=0;
				break;
			}
			else if (memcmp(pData->data,"<CLOSE>",7)==0)
			//else if (GetStrXML(xml,"CLOSE",szComando,1024))
			{
				//printf("(%02i) CloseDatabase\n\r",id);
				nQuery=0;
				break;	
			}
			else if (memcmp(pData->data,"<GET_MULTIPLE>",14)==0)
			{	
			        ref=14;
                                //Eliminamos el final </GET_RECORD>
                                //len=strlen(pData->data)-ref-2;
                                len=strlen(pData->data)-ref-1;
                                pData->data[len]=0;
                                //sprintf(szAux,"(%02i) Socket(%i) GET_MULTIPLE %s",id,Conexion[id].nSocket,&pData->data[ref]);
                                SET_TX(id,&pData->data[ref]);
                                //WriteLog(id,szAux);
                                //GetOneRecord(id,Conexion[id].nSocket,&pData->data[ref],Conexion[id].conn);
                                //GetMultipleRecordAsinc(id,Conexion[id].nSocket,&pData->data[ref],Conexion[id].conn);
                                nQuery=0;
                                break;
			}
			//else if (GetStrXML(xml,"CAMPOS",szComando,1024))
			else if (memcmp(pData->data,"<CAMPOS>",8)==0)
			{
				ref=8;
				//len=strlen(pData->data)-ref-2;
				len=strlen(pData->data)-ref-1;
				pData->data[len]=0;
				//sprintf(szAux,"(%02i) Socket(%i) CAMPOS %s",id,Conexion[id].nSocket,&pData->data[ref]);
				SET_TX(id,&pData->data[ref]);
				//GetCamposSql(id,Conexion[id].nSocket,&pData->data[ref],Conexion[id].conn);
				break;
			}
			else if (memcmp(pData->data,"<SQL>",5)==0)
			//else if (GetStrXML(xml,"SQL",szComando,MAX_BUFFER))
			{
				ref=5;
				//len=strlen(pData->data)-ref-2;
				len=strlen(pData->data)-ref-1;
				pData->data[len]=0;
				//sprintf(szAux,"(%02i) Socket(%i) SQL %s",id,Conexion[id].nSocket,&pData->data[ref]);
				SET_TX(id,&pData->data[ref]);
				//res=ExecuteSql(res,id,Conexion[id].nSocket,&pData->data[ref],Conexion[id].conn);
				nQuery=0;
				nFila=0;
				break;
			}
			else if (memcmp(pData->data,"<QUERY>",7)==0)
			//else if (GetStrXML(xml,"QUERY",szComando,MAX_BUFFER))
			{
				ref=7;
				//len=strlen(pData->data)-ref-2;
				len=strlen(pData->data)-ref-1;
				pData->data[len]=0;
		   		WriteLog(id,&pData->data[ref]);
				//sprintf(szAux,"(%02i) Socket(%i) SQL %s",id,Conexion[id].nSocket,&pData->data[ref]);
				SET_TX(id,&pData->data[ref]);
				nFila=0;
				nReg=0;
				//res=(PGresult *)ExecuteSql(res,id,Conexion[id].nSocket,&pData->data[ref],Conexion[id].conn);
				nQuery=1;
			}
			else if (memcmp(pData->data,"<MOVE_NEXT_100>",15)==0)
			//else if (GetStrXML(xml,"MOVE_NEXT_100",szComando,MAX_BUFFER))
			{
				if (nQuery)
				{
					//sprintf(szAux,"(%02i) Socket(%i) MOVE_NEXT_100",id,Conexion[id].nSocket);
					/*
					if (!MoveNextData100(id,Conexion[id].nSocket,res,&nFila,&nReg))
					{
						PQclear(res);
						res=NULL;
						printf("(%02i) Fin de Query...\n\r",id);
						nQuery=0;
						break;
					}
					*/
				}
				else
				{
					printf("(%02i) No hay query activa...\n\r",id);
					break;
				}
			}
			else if (memcmp(pData->data,"<MOVE_NEXT_NIVEL_100>",21)==0)
			//else if (GetStrXML(xml,"MOVE_NEXT_NIVEL_100",szComando,MAX_BUFFER))
			{
				if (nQuery)
				{
					//sprintf(szAux,"(%02i) Socket(%i) MOVE_NEXT_100",id,Conexion[id].nSocket);
					/*
					if (!MoveNextData_100(id,Conexion[id].nSocket,res,&nFila,&nReg))
					{
						PQclear(res);
						res=NULL;
						printf("(%02i) Fin de Query...\n\r",id);
						nQuery=0;
						break;
					}
					*/
				}
				else
				{
					printf("(%02i) No hay query activa...\n\r",id);
					break;
				}
			}
			else if (memcmp(pData->data,"<MOVE_NEXT>",11)==0)
			//else if (GetStrXML(xml,"MOVE_NEXT",szComando,MAX_BUFFER))
			{
				if (nQuery)
				{
					//sprintf(szAux,"(%02i) Socket(%i) MOVE_NEXT Fila=%i",id,Conexion[id].nSocket,nFila);
					/*
					if (!MoveNextData(id,Conexion[id].nSocket,res,nFila++))
					{
						PQclear(res);
						res=NULL;
						printf("(%02i) Fin de Query...\n\r",id);
						nQuery=0;
						break;
					}
					*/
				}
				else
				{
					printf("(%02i) No hay query activa...\n\r",id);
					break;
				}
			}
		   } //while

		   //Libero el Buffer
		   pData=LiberaData(pData);
		   pData=CreaData();
		   //xml=CierraXML(xml);
		/*
		   if (res!=NULL) 
		   {
			   WriteLog(id,"PQclear");
			   PQclear(res);
			   res=NULL;
		   }
			*/
		
		//sprintf(szAux,"Puntero9=%x",Conexion[id].pMysqlconn);
		//WriteLog(id,szAux);
		   //si esta cerrada la conexion...
		   if (Conexion[id].nAbierta!=1)
		   {
			printf("(%02i) Abre conexion Base Datos..\n\r",id);
			WriteError(id,"Re-Abre Conexion a BD");
			Conexion[id].pMysqlconn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
		 	if (Conexion[id].pMysqlconn==NULL)
			{
				printf("(%02i) Falla Conexion a BD",id);
				WriteError(id,"Falla Re-Conexion a BD");
				//No intento reconectar, simplemente espero la siguiente tx
				goto fin;
			}
			WriteLog(id,"ReAbre Conexion a BD");
			Conexion[id].nAbierta=1;
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
	mysql_thread_end();
	if (Conexion[id].nAbierta) CierraMysql(id);
}

int main(int argc, char* argv[])
{
	Tipo_Proceso stProceso;
	int nProcesos;
	char szTmp[100];
	INIT_GLOBAL();
	ProcesaArgumentos(argc,argv);
	nProcesos=atoi(argv[2]);
	sprintf(szTmp,"Base=%s Procesos=%i Puerto=%i",global.szBaseDatos,nProcesos,Conexion[0].nPortDatabase);
	WriteLog(0,szTmp);
	WriteError(0,szTmp);

  	if (mysql_library_init(0, NULL, NULL)) 
        {
		WriteError(0,"Falla mysql_library_init");
   		 fprintf(stderr, "could not initialize MySQL library\n");
	    exit(1);
        }


        if (!mysql_thread_safe()) {
		WriteError(0,"Falla mysql_thread_safe");
   		 fprintf(stderr, "Falla mysql_thread_safen");
	    exit(1);
	}


        InicializaServerSocket(Conexion[0].nPortDatabase);
        CreaConexiones("Servicio BaseDatos Ok.",nProcesos);
        mysql_library_end();
	return 1;
}

