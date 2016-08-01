#include <stdio.h>
//#include "OleDatabase.h"
#include <xml.h>
#include <errno.h>
#include <sys/socket.h>
#include <libpq-fe.h>


DBPROCESS *OpenDatabaseMSSQL(int id);
int msg_handler(int id, DBPROCESS *dbproc, DBINT msgno, int msgstate, int severity, char *msgtext, char *srvname, char *procname, int line);

#define IP_BD   "8010"

	char szBaseDatos[100];

	int TransactionThread(int id)
	{
		int nQuery,sts;
		char szData[MAX_BUFFER];
		char szAux[1000];
		char szComando[MAX_BUFFER];
		Tipo_XML *xml=NULL;
		/*PGresult *res=NULL;*/
		int nFila,nReg;
		int nSocketCerrado;
		char szTmp[200];
		
		printf("(%02i) INICIA THREAD SOCKET ",id);
		Conexion[id].nAbierta=0;
		while(1)
		{
		   EsperaActivacion2(id,&Conexion[id]);
		   if (Conexion[id].nAbierta==0)
		   {
			if (!Conexion[id].nAbierta)
			{	
			   WriteLog(id,"Abre Conexion BD");
			   Conexion[id].dbconn=OpenDatabaseMSSQL(id);
			}
			if (Conexion[id].dbconn==NULL)
			{
				printf("(%02i) Falla Conexion a BD",id);
				WriteLog(id,"Falla Conexion a BD");
				goto fin;
			}
			Conexion[id].nAbierta=1;
		   }
		   printf("(%02i) Conexion MSSQL %i\n\r",id,Conexion[id].nSocket); 
                   dbmsghandle( (MHANDLEFUNC)msg_handler  );

		   nQuery=0;
		   while ((sts=LeePaquete(id,Conexion[id].nSocket,szData,MAX_BUFFER,global.nTimeoutBaseDatos))>0)
		   {
			//printf("(%02i) LEE %s\n\r",id,szData);
			xml=CierraXML(xml);
			xml=ProcesaInputXML1(xml,szData);
			if (GetStrXML(xml,"GET_RECORD",szComando,MAX_BUFFER))
			{
				sprintf(szAux,"(%02i) Socket(%i) GET_RECORD %s",id,Conexion[id].nSocket,szComando);
				SET_TX(id,szComando);
				WriteLog(id,szAux);
				GetOneRecordMSSQL(id,Conexion[id].nSocket,szComando,Conexion[id].dbconn);//Descomentar cuando este implementado
				nQuery=0;
				break;
			}
			else if (GetStrXML(xml,"CLOSE",szComando,1024))
			{
				printf("(%02i) CloseDatabase\n\r",id);
				nQuery=0;
				break;	
			}
			else if (GetStrXML(xml,"CAMPOS",szComando,1024))
			{
				sprintf(szAux,"(%02i) Socket(%i) CAMPOS %s",id,Conexion[id].nSocket,szComando);
				SET_TX(id,szComando);
				WriteLog(id,szAux);
				GetCamposMSSQL(id,Conexion[id].nSocket,szComando,Conexion[id].dbconn);//Descomentar cuando este implementado
				break;
			}
			else if (GetStrXML(xml,"SQL",szComando,MAX_BUFFER))
			{
				sprintf(szAux,"(%02i) Socket(%i) SQL %s",id,Conexion[id].nSocket,szComando);
				SET_TX(id,szComando);
				WriteLog(id,szAux);
				//res=ExecuteSql(id,Conexion[id].nSocket,szComando,Conexion[id].dbconn);//Descomentar cuando este implementado
				nQuery=0;
				nFila=0;
				break;
			}
			else if (GetStrXML(xml,"QUERY",szComando,MAX_BUFFER))
			{
				sprintf(szAux,"(%02i) Socket(%i) SQL %s",id,Conexion[id].nSocket,szComando);
				SET_TX(id,szComando);
				WriteLog(id,szAux);
				//res=ExecuteSql(id,Conexion[id].nSocket,szComando,Conexion[id].dbconn);//Descomentar cuando este implementado
				nQuery=1;
				nFila=0;
				nReg=0;
			}
			else if (GetStrXML(xml,"MOVE_NEXT",szComando,MAX_BUFFER))
			{
				if (nQuery)
				{
					sprintf(szAux,"(%02i) Socket(%i) MOVE_NEXT Fila=%i",id,Conexion[id].nSocket,nFila);
					WriteLog(id,szAux);
                                        //Descomentar cuando este implementado
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
			else if (GetStrXML(xml,"MOVE_NEXT_100",szComando,MAX_BUFFER))
			{
				if (nQuery)
				{
					sprintf(szAux,"(%02i) Socket(%i) MOVE_NEXT_100",id,Conexion[id].nSocket);
					WriteLog(id,szAux);
                                        //Descomentar cuando este implementado
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
			else if (GetStrXML(xml,"MOVE_NEXT_NIVEL_100",szComando,MAX_BUFFER))
			{
				if (nQuery)
				{
					sprintf(szAux,"(%02i) Socket(%i) MOVE_NEXT_100",id,Conexion[id].nSocket);
					WriteLog(id,szAux);
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
		   }

		   xml=CierraXML(xml);
                   /*Comentado Por Felipe Avendano
		   if (res!=NULL) 
		   {
			   WriteLog(id,"PQclear");
			   //PQclear(res);//Comentado por FelipeAvendano
			   res=NULL;
		   }
		   */

		   //si esta cerrada la conexion...
		   while (Conexion[id].nAbierta!=1)
		   {
			printf("(%02i) Abre conexion Base Datos..\n\r",id);
			WriteError(id,"Re-Abre Conexion a BD");
			 sprintf(szTmp,IP_BD);
			Conexion[id].dbconn=OpenDatabaseMSSQL(id);
		 	if (Conexion[id].dbconn==NULL)
			{
				printf("(%02i) Falla Conexion a BD",id);
				WriteLog(id,"Falla Conexion a BD");
				WriteError(id,"Falla Re-Conexion a BD");
				sleep(1);
				continue;
			}
			WriteLog(id,"ReAbre Conexion a BD");
			Conexion[id].nAbierta=1;
	    }

fin:
	   sts=close(Conexion[id].nSocket);
	   WriteLog(id,"DesactivaProceso2");
	   DesactivaProceso2(id);
	}
}

int Thread_Exit(int id)
{
	if (Conexion[id].nAbierta) 
          //PQfinish(Conexion[id].dbconn);//Descomentar cuando este implementado
          dbfreebuf(Conexion[id].dbconn);
          dbclose(Conexion[id].dbconn);
          dbexit();
}

int test( char szBaseDatos[])
{
	int id=0;
	Conexion[id].dbconn=OpenDatabaseMSSQL(id);
 	if (Conexion[id].dbconn==NULL)
	{
		printf("(%02i) Falla Conexion a BD",id);
		exit(1);
	}
	//GetOneRecordMSSQL(id,Conexion[id].nSocket,"SELECT * FROM mc_giro_actividad_economica",Conexion[id].dbconn);//Descomentar cuando este implementado
        GetCamposMSSQL(id,Conexion[id].nSocket,"LISTADO_RPT",Conexion[id].dbconn);//(int id,int nSocket,char szTabla[],DBPROCESS *dbconn)
	Thread_Exit(id);
}

int msg_handler(int id, DBPROCESS *dbproc, DBINT msgno, int msgstate, int severity, char *msgtext, char *srvname, char *procname, int line)
{
        char szAux[MAX_BUFFER];

        printf ("SQL Server message %ld, state %d, severity %d: \n\t%s\n", msgno, msgstate, severity, msgtext);
        sprintf(szAux,"SQL Server message %ld, state %d, severity %d: \n\t%s\n", msgno, msgstate, severity, msgtext);
        WriteLog(id,szAux);

        if (strlen (srvname) != 0){
                 //printf ("Server %s \n", srvname);
                 sprintf(szAux,"Server %s \n", srvname);
                 WriteLog(id,szAux);
        }
        if (strlen (procname) != 0){
                //printf ("Procedure %s \n", procname);
                sprintf(szAux, "Procedure %s \n", procname);
                WriteLog(id,szAux);
        }
        if (line !=0){
                 //printf ("Line %d \n", line);
                 sprintf(szAux, "Line %d \n", line);
                 WriteLog(id,szAux);
        }

        return (0);

}

int main(int argc, char* argv[])
{
	Tipo_Proceso stProceso;
	int nProcesos;
	char szTmp[100];


	test("test");

	INIT_GLOBAL();
	ProcesaArgumentos(argc,argv);
	sprintf(szBaseDatos,"%s",argv[1]);
	printf("paso 1 [%s]\n\r",szBaseDatos);
	WriteLog(0,szBaseDatos);
	nProcesos=atoi(argv[2]);
	sprintf(szTmp,"Base=%s Procesos=%i Puerto=%i",szBaseDatos,nProcesos,Conexion[0].nPortDatabase);
	WriteLog(0,szTmp);
        InicializaServerSocket(Conexion[0].nPortDatabase);
        CreaConexiones("Servicio BaseDatos Ok.",nProcesos);
	return 1;
}

