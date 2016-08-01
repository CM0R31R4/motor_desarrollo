#include <stdio.h>
#include <const.h>
#include <xml.h>
#include <unistd.h>
#include <sys/param.h>
#include <sybfront.h>
#include <sybdb.h>
#include <syberror.h>

#define  ERR_LEVE   1
#define  ERR_GRAVE  2


char *trim(char *str);
char *RTrim(char *l);  

extern int FLG_ERROR_GRAVE;


int SendErrorBDMSSQL(int id,int nSocket,DBPROCESS *conn)
{
   char szAux[MAX_BUFFER];
   Tipo_XML *xml1=NULL;
   memset(szAux,0,sizeof(szAux));
   InsertaCampoXML(szAux,"STATUS","FALLA");
   InsertaCampoXML(szAux,"API_CODRESPUESTA","2");
   InsertaCampoXML(szAux,"API_TIPO","SQL");
   xml1=GetStrXMLData(Conexion[id].xml,"API_DESCRIPCION_ERROR");
   if (xml1)
   {
	InsertaCampoXML(szAux,"ERROR",xml1->pData);
	InsertaCampoXML(szAux,"API_DESCRIPCION_ERROR",xml1->pData);
	//InsertaCampoXML(szAux,"API_DESCRIPCION_MSG",xml1->pData);
   }
   xml1=NULL;
   xml1=GetStrXMLData(Conexion[id].xml,"API_ERROR");
   if (xml1)
   {
	InsertaCampoXML(szAux,"API_ERROR",xml1->pData);
   }
   xml1=NULL;
   xml1=GetStrXMLData(Conexion[id].xml,"API_DESCRIPCION_MSG");
   if (xml1)
   {
	InsertaCampoXML(szAux,"API_DESCRIPCION_MSG",xml1->pData);
   }

   //printf("%s\n\r",szAux);
   return SendSocket(id,nSocket,szAux,strlen(szAux));
}

DBPROCESS *OpenDatabaseMSSQL(int id)
{
   char       *pgport, *pgoptions, *pgtty;
   int         nFields;
   int         i,
                    j;
   DBPROCESS   *conn;
   char     szAux[MAX_BUFFER];
   LOGINREC *login;
   char hostname[MAXHOSTNAMELEN];
   int max_len = MAXHOSTNAMELEN;

   fprintf(stderr, "Abriendo conexion \n");

      WriteLog(id,"dbinit");
   /* Init the DB library */
   if (dbinit() == FAIL) {
      fprintf(stderr, "Could not init db.\n");
      WriteLog(id,"Falla dbinit()");
      return NULL;
   }

      WriteLog(id,"dblogin");
   /* Allocate a login params structure */
   if ((login = dblogin()) == FAIL) {
      fprintf(stderr, "Could not initialize dblogin() structure.\n");
      WriteLog(id,"Falla dblogin()");
      return NULL;
   }

      WriteLog(id,"DBSETLUSER");
   /* Initialize the login params in the structure */
   DBSETLUSER(login, global.szUsuarioBD);
   DBSETLPWD(login, global.szClaveBD);
   DBSETLAPP(login, "motor");
   if (gethostname(hostname, max_len) == 0)
      DBSETLHOST(login, hostname);

      WriteLog(id,"dbopen");
   /* Now connect to the DB Server */
   if ((conn = dbopen(login, global.szIpBd)) == NULL) {
      fprintf(stderr, "Could not connect to DB Server: %s\n", global.szIpBd);
      WriteLog(id,"Falla dbopen");
      return NULL;
   }else{
     WriteLog(id, "Connected to DB MS SQL!!");
   }

   /* Now switch to the correct database */
      WriteLog(id,"dbuse");
   if ((dbuse(conn,global.szBaseDatos )) == FAIL) {
      fprintf(stderr, "Could not switch to database %s on DB Server %s\n", global.szBaseDatos, global.szIpBd);
      WriteLog(id,"Falla dbuse");
      return NULL;
   }else{
      printf("Switched to database %s on DB Server %s\n", global.szBaseDatos, global.szIpBd);
	sprintf(szAux,"Conectado a %s on DB Server %s",global.szBaseDatos, global.szIpBd);
      WriteLog(id,szAux);
   }
   
      WriteLog(id,"dbloginfree");
   /* You can free the login structure now, as it is no longer needed after logging in */
   dbloginfree(login);
   printf("Freeing db login \n");
	
   WriteLog(id,"fin conn");
   //Limpio los errores
   FLG_ERROR_GRAVE=0;
   return conn;
}

int CierraMSSQL(DBPROCESS *dbconn)
{
   printf("Cleaning buffer and closing connection\n");
   dbfreebuf(dbconn);
   dbclose(dbconn);
   dbexit();
}


RETCODE  *GetCamposMSSQL(int id,int nSocket,char szTabla[],DBPROCESS *dbconn)
{
   //PGresult *res;	
   int i;
   char szAux[MAX_BUFFER];
   char szSql[MAX_BUFFER];
   char szTmp[MAX_BUFFER];

   printf("Entro por GetCamposMSSQL \n");
   sprintf(szSql,"select top 1 * from %s ",szTabla);
   printf("%s\n\r",szSql);
   /* Now prepare a SQL statement */
   printf("Preparando el statement \n");
   printf("szSql [%s] \n", szSql);
   dbfcmd(dbconn, szSql);
   /* Now execute the SQL statement */
   printf("Ejecutando el statement \n");
   if (dbsqlexec(dbconn) == FAIL) 
   {
      printf("error 1 \n");
      //sprintf(szAux,"Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
      //sprintf(szAux,"Error MSSQL %s %ld",dbresults(dbconn), dbhasretstat(dbconn));
      //WriteLog(id,szAux);
      //fprintf(stderr, "Falla Envio de Query %s\n\r",PQerrorMessage(conn));
      fprintf(stderr, "Falla Envio de Query GetCamposMSSQL %s\n\r", szSql);
      SendErrorBDMSSQL(id,nSocket,dbconn);
      dbfreebuf(dbconn);
      dbclose(dbconn);
      return NULL;
   }   
   switch(dbresults(dbconn))
   {      
      //NO_MORE_RESULTS
      case SUCCEED : 
	   memset(szAux,0,sizeof(szAux));
	   InsertaCampoXML(szAux,"STATUS","OK");
	   InsertaCampoXML(szAux,"API_CODRESPUESTA","1");
	   InsertaCampoXML(szAux,"API_TIPO","SQL");
           if (dbnextrow(dbconn) != NO_MORE_ROWS) 
           {
	      for(i=1;i<=dbnumcols(dbconn);i++) 
	      {
	         sprintf(szTmp,"CAMPO%i",i);
                 printf("%s %s \n", szTmp, dbcolname(dbconn, i) );
	         InsertaCampoXML(szAux,szTmp, dbcolname(dbconn, i) );
	         sprintf(szTmp,"SIZE%i",i);
	         InsertaCampoIntXML(szAux,szTmp, dbcollen(dbconn, i) );
	      }
           }
           //PQclear(res); //Revisar, al parecer en FreeTSD No aplica
           dbfreebuf(dbconn);
	   SendSocket(id,nSocket,szAux,strlen(szAux));
	   return NULL;
      case FAIL :
	       //sprintf(szAux,"Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
	       //sprintf(szAux,"Error MSSQL %s %i",dbresults(dbconn), dbhasretstat(dbconn));
	       //WriteLog(id,szAux);
	       SendErrorBDMSSQL(id,nSocket,dbconn);
               dbfreebuf(dbconn);
               dbclose(dbconn);
	       return NULL;
       default: 
	       //sprintf(szAux,"Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
	       //sprintf(szAux,"Error MSSQL %s %i",dbresults(dbconn), dbhasretstat(dbconn));
	       //WriteLog(id,szAux);
               dbfreebuf(dbconn);
   	       return NULL;
   }
   
}

void GetOneRecordMSSQL(int id,int nSocket,char szSql[],char szTipo[])
{
        //PGresult *res;
        char szAux[MAX_BUFFER];
        int i;
        int numcol = 0;
        char* namecol;
        char put[MAX_BUFFER];
	char szCampo[MAX_BUFFER];
        DBINT valorcol, objectid;
        DBINT size;
        BYTE* valor;
        int   tipo;
	int 	flag_ok=0;
	int 	nRegistro;
	RETCODE sw_retorno;
	int nIntentos=0;
	char szTmp[1024];
reintenta:
	//Si la conexion esta cerrada
        if (Conexion[id].nAbierta==0)
        {
               WriteError(id,"Abre Conexion BD");
	       Conexion[id].dbconn=OpenDatabaseMSSQL(id);
               if (Conexion[id].dbconn==NULL)
               {
                        WriteError(id,"Falla Conexion BD");
                        SendErrorBDMSSQL(id,nSocket,Conexion[id].dbconn);
                        dbfreebuf(Conexion[id].dbconn);
                        dbclose(Conexion[id].dbconn);
                        Conexion[id].nAbierta=0;
                        return;
               }
               Conexion[id].nAbierta=1;
        }

     
        /* Now prepare a SQL statement */
        printf("Preparando el statement \n");
        printf("%s\n\r",szSql);
        dbfcmd(Conexion[id].dbconn, szSql);
        /* Now execute the SQL statement */
        printf("Ejecutando el statement \n");
	sprintf(szAux,"Intento %i",nIntentos);
	WriteLog(id,szAux);
	WriteLog(id,szSql);
	sw_retorno = dbsqlexec(Conexion[id].dbconn);
	//if (dbsqlexec(dbconn) == FAIL) 
	if (sw_retorno == FAIL) 
        {
            	fprintf(stderr, "Falla Envio de Query GetOneRecordMSSQL\n\r");
		WriteError(id,"Falla Envio de Query GetOneRecordMSSQL");
		WriteLog(id,"Falla Envio de Query GetOneRecordMSSQL");
                dbfreebuf(Conexion[id].dbconn);
                dbclose(Conexion[id].dbconn);
                Conexion[id].nAbierta=0;
		//Si falla la ejecucion
		if (nIntentos++<2)
		{
			//WriteError(id,"Reintenta Query");
			WriteLog(id,"Reintenta Query");
			goto reintenta;
		}
		else
		{	
			WriteLog(id,"Contesta Error");
			FLG_ERROR_GRAVE = 0;
			dbfreebuf(Conexion[id].dbconn);
        	        dbclose(Conexion[id].dbconn);
                	Conexion[id].nAbierta=0;
            		SendErrorBDMSSQL(id,nSocket,Conexion[id].dbconn);
			return;
		}
        }

	if ( FLG_ERROR_GRAVE == ERR_GRAVE ) {
		sprintf(szAux,"Flag de Error Grave %i ", FLG_ERROR_GRAVE);
		WriteLog(id,szAux);
		FLG_ERROR_GRAVE = 0;
		dbfreebuf(Conexion[id].dbconn);
                dbclose(Conexion[id].dbconn);
                Conexion[id].nAbierta=0;
            	SendErrorBDMSSQL(id,nSocket,Conexion[id].dbconn);
		return;
	}

        memset(szAux,0,sizeof(szAux));
	nRegistro=0;
	while ((sw_retorno=dbresults(Conexion[id].dbconn)) != NO_MORE_RESULTS) 
  	{
	    WriteLog(id,"Obtengo resultados");
            //switch(dbresults(dbconn))
	    switch(sw_retorno)
            {
                case SUCCEED:
			WriteLog(id," Succeed ");
			if (DBROWS(Conexion[id].dbconn)){
				WriteLog(id," dbnextrow ");
				while (dbnextrow(Conexion[id].dbconn) != NO_MORE_ROWS) {
	    				nRegistro++;
					WriteLog(id," Hay registros");
                        		numcol = dbnumcols(Conexion[id].dbconn);
                        		printf("numcol %d \n", numcol);
					sprintf(szTmp,"numcol %d",numcol);
					WriteLog(id,szTmp);
                        		
					if(numcol == 0)
					{
						WriteLog(id,"Num columnas en cero");
                           			InsertaCampoXML(szAux,"STATUS","SIN_DATA");
                           			InsertaCampoXML(szAux,"API_CODRESPUESTA","3");
                           			InsertaCampoXML(szAux,"API_TIPO","SQL");
                           			SendSocket(id,nSocket,szAux,strlen(szAux));
                           			printf("%s \n ", szAux);
                           			//PQclear(res);
                           			//dbcanquery(dbconn);
                           			//dbfreebuf(dbconn);
                           			//return;
                        		}
					
					if (numcol > 0){
						//WriteLog(id,"Num columnas mayor a cero");
                           			if ( FLG_ERROR_GRAVE == ERR_LEVE ) {
                                			InsertaCampoXML(szAux,"STATUS","KO");
                           				InsertaCampoXML(szAux,"API_CODRESPUESTA","2");
                           				InsertaCampoXML(szAux,"API_TIPO","SQL");
                                			FLG_ERROR_GRAVE = 0;
                           			} else {
                                			if (flag_ok==0) 
							{
								InsertaCampoXML(szAux,"STATUS","OK");
                           					InsertaCampoXML(szAux,"API_CODRESPUESTA","1");
                           					InsertaCampoXML(szAux,"API_TIPO","SQL");
							}
							flag_ok=1;
                           			}

						int len;
                           			char* salida;
						//borrar dorc
						int largoColumna;
						char auxLC[10] = "";
						//end borrar
                           			//printf("paso 2 \n");
                           			//if (dbnextrow(dbconn) != NO_MORE_ROWS) {
							//WriteLog(id,"Hay columnas");
                              				for(i=1; i <=numcol; i++){
                                 				memset(put, 0, MAX_BUFFER);
								//borrar dorc
								largoColumna = dbdatlen(Conexion[id].dbconn, i);
								//WriteLog(id, "largoColumna");
								sprintf(auxLC,"%d",largoColumna);
								//WriteLog(id, auxLC);
								//end borrar
                                 				len = dbconvert(Conexion[id].dbconn, (dbcoltype(Conexion[id].dbconn, i)), (dbdata(Conexion[id].dbconn, i)),(dbdatlen(Conexion[id].dbconn, i)), SYBTEXT, (BYTE *) &put, MAX_BUFFER);

                                 				if (len == FAIL || len == -1)
								{
									WriteLog(id,"Respuesta Err Fail, Error en largo de Columna");
                                 					if (memcmp(szTipo,"MULTIPLE",8)==0)
										sprintf(szCampo,"%s_%i",dbcolname(Conexion[id].dbconn,i),nRegistro);
									else
										sprintf(szCampo,"%s",dbcolname(Conexion[id].dbconn,i));
									/*
                        						sprintf(szAux,"Error en largo de Columna");
						                        SendErrorBDMSSQL(id,nSocket,Conexion[id].dbconn);
						                        dbfreebuf(Conexion[id].dbconn);
						                        dbclose(Conexion[id].dbconn);
						                        Conexion[id].nAbierta=0;
									return;
									*/
                                 					InsertaCampoXML(szAux,szCampo,"NULL");
								}
								else {
									char ss[100];
									//WriteLog(id, "put");
									//Hay que cortar la data segun len
									put[len]=0;
                                 					salida = trim(put);
                                 					//printf("[%s] ", salida);
                                 					//printf("[%s] ", dbcolname(dbconn, i));
                                 					if (memcmp(szTipo,"MULTIPLE",8)==0)
										sprintf(szCampo,"%s_%i",dbcolname(Conexion[id].dbconn,i),nRegistro);
									else
										sprintf(szCampo,"%s",dbcolname(Conexion[id].dbconn,i));
								
									//WriteLog(id, "Columna");
									//WriteLog(id, szCampo);
									//WriteLog(id, salida);
                                 					InsertaCampoXML(szAux,szCampo,salida);
									//WriteLog(id,szAux);
								} //else
                              				} //for
                           			//}
					} //numcols >0	
				} //dbnextrow 

				//=???
				dbfreebuf(Conexion[id].dbconn);
                           			//return;

                        }        //DBROWS 
			break;
                case FAIL:
			//WriteLog(id,dbresults(dbconn));
                        //sprintf(szAux,"Error MSSQL %s",dbresults(dbconn));
                        //WriteLog(id,szAux);
                        //printf("%s \n ", szAux);
			WriteLog(id,"Error MSSQL1**");
                        dbfreebuf(Conexion[id].dbconn);
                        dbclose(Conexion[id].dbconn);
                        Conexion[id].nAbierta=0;
                	//Si falla la ejecucion
	                if (nIntentos++<2)
        	        {
                        	WriteError(id,"Reintenta Query");
        	                goto reintenta;
	                }	
                	else
        	        {
	
	                        SendErrorBDMSSQL(id,nSocket,Conexion[id].dbconn);
                        	return;
			}
			break;
                default:
                        //sprintf(szAux,"Error MSSQL %s %i",dbresults(dbconn), dbhasretstat(dbconn));
                        //WriteLog(id,szAux);
                        //printf("%s \n ", szAux);
			WriteLog(id,"Error MSSQL2**");
                        SendErrorBDMSSQL(id,nSocket,Conexion[id].dbconn);
			dbfreebuf(Conexion[id].dbconn);
                        dbclose(Conexion[id].dbconn);
                        Conexion[id].nAbierta=0;
                	//Si falla la ejecucion
	                if (nIntentos++<2)
        	        {
                        	WriteError(id,"Reintenta Query");
        	                goto reintenta;
	                }	
                	else
        	        {
	
	                        SendErrorBDMSSQL(id,nSocket,Conexion[id].dbconn);
                        	return;
			}
                        //return;
			break;
            }//switch(sw_retorno)
	}//while

	//Se envia al final
        SendSocket(id,nSocket,szAux,strlen(szAux));
       	//WriteLog(id,szAux);

	return;
}

char *trim(char *str){
   char *temp, *inicio;
   if (str==NULL) return NULL;
   //RTrim( str);
   inicio = temp = str;
   while( *str && *str == ' ') str ++;

   if (str==NULL) return NULL;

   while( *str) *temp ++ = *str ++;

   *temp = '\0';

   return inicio;
}

char *RTrim(char *l)
{ 
   char *p;

   p = l + strlen(l) - 1;

   while(*p==' ') p -- ;

   if(p==l + strlen(l) - 1)
   {
      return l;
   }

   p++;
   *p = '\0';

   return l;
}
