    #include <stdio.h>
    #include <const.h>
    #include <xml.h>
    #include <mysql.h>
    
#ifdef FLAG_MYSQL
  void CierraMysql(int id)
    {
	mysql_close(Conexion[id].pMysqlconn);
	Conexion[id].pMysqlconn=NULL;	
	Conexion[id].nAbierta=0;
    }
    MYSQL     *OpenDatabase(int id,char dbName[],char pghost[],char pgport[])
    {
	char       *pgoptions,
                   *pgtty;
        int         nFields;
        int         i,
                    j;
	MYSQL *conn;
	char	*pgLogin;
	char 	*pgPass;
	unsigned int ui;
	char szAux[MAX_BUFFER];
        pgoptions = NULL;           /* special options to start up the backend
                                     * server */
        pgtty = NULL;               /* debugging tty for the backend server */
	pgLogin=global.szUsuarioBD;
	pgPass=global.szClaveBD;

        /* make a connection to the database */
	sprintf(szAux,"%i) Conectandose a base %s en %s:%s %x",id,dbName,pghost,pgport,Conexion[id].pMysqlconn);
	WriteLog(0,szAux);
	WriteMensajeApp(id,szAux);

        //conn = PQsetdb(pghost, pgport, pgoptions, pgtty, dbName);
	Conexion[id].pMysqlconn = mysql_init(Conexion[id].pMysqlconn);

	//Timeout de conexion
	ui=3;
	mysql_options(Conexion[id].pMysqlconn,MYSQL_OPT_CONNECT_TIMEOUT,&ui);
	mysql_options(Conexion[id].pMysqlconn,MYSQL_OPT_READ_TIMEOUT,&ui);


	if (!mysql_real_connect(Conexion[id].pMysqlconn,pghost,pgLogin,pgPass,dbName, 0, NULL,CLIENT_MULTI_STATEMENTS|CLIENT_MULTI_RESULTS)) 
	{
            fprintf(stderr, "Connection to database '%s' failed.\n", dbName);
	    //SendErrorBD(id,nSocket,conn);
	    WriteError(id,"Falla Conexion");
	    WriteMensajeApp(id,"Falla Conexion BD");
	    CierraMysql(id);
	    return NULL;
	}
	//Para que se reconecte
	//ui=1;
	//mysql_options(Conexion[id].pMysqlconn,MYSQL_OPT_RECONNECT,&ui);
	return Conexion[id].pMysqlconn;
    }


Tipo_Data *GetOneRecordAsinc(int id,int nSocket,char szSql[])
{
        MYSQL_RES *res=NULL;
        char szAux[MAX_BUFFER];
        int i;
        int nIntentos;
        nIntentos=0;
        time_t  time1,time2;
        int nLen;
	MYSQL_ROW row;
	MYSQL_FIELD *fields;
	Tipo_Data *pData=NULL;
	int num_fields;
reintenta:
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
                             return pData;
               }
               Conexion[id].nAbierta=1;
        }

	
	//sprintf(szAux,"SQL=%s Len=%i",szSql,strlen(szSql));
	//WriteLog(id,szAux);
	if ( mysql_real_query(Conexion[id].pMysqlconn,szSql,strlen(szSql)) != 0)
	{
            sprintf(szAux,"Error en PQsendQuery Mysql %s",mysql_error(Conexion[id].pMysqlconn));
            WriteLog(id,szAux);
            WriteError(id,szAux);
            fprintf(stderr, "Falla Envio de Query %s\n\r",mysql_error(Conexion[id].pMysqlconn));
	
	
            //Vamos a reabrir la conexion a la base de datos
            if (nIntentos++<2)
            {
                WriteError(id,"Reintento");
                WriteLog(id,"Reintento");
                //PQclear(res);
                CierraMysql(id);
                Conexion[id].pMysqlconn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
                if (Conexion[id].pMysqlconn==NULL)
                {
                        WriteLog(id,"FALLA_RECONEXION_BD");
                        Conexion[id].nAbierta=0;
                        return pData;
                }
                else
                {
                        WriteError(id,"Conexion OK");
                        WriteLog(id,"Conexion OK");
               		Conexion[id].nAbierta=1;
                        goto reintenta;
                }
             }
             else
             {
                WriteLog(id,"FALLA_FIN_REINTENTOS");
		CierraMysql(id);
                return pData;
             }
            return pData;
        }
	do
	{

        	time(&time1);
		res=mysql_use_result(Conexion[id].pMysqlconn);
		if (res==NULL)
		{	
			//WriteError(id,"Error al obtener resultado");
			mysql_free_result(res);
			return NULL;
			//CierraMysql(id);
			//return pData;
		}
	
        	num_fields = mysql_num_fields(res);

		while ((row = mysql_fetch_row(res)) != NULL)
		{
   			unsigned long *lengths;
			WriteLog(id,"Entre");
   			lengths = mysql_fetch_lengths(res);
			fields = mysql_fetch_fields(res);
			//Nombre del campo
   			for(i = 0; i < num_fields; i++) 
			{
				pData=InsertaData("<STATUS>OK</STATUS>",pData);
				pData=InsertaDataLen("<",1,pData);
				pData=InsertaData(fields[i].name,pData);
				pData=InsertaDataLen(">",1,pData);
				pData=InsertaDataLen(row[i],(int) lengths[i],pData);
				pData=InsertaDataLen("</",2,pData);
				pData=InsertaData(fields[i].name,pData);
				pData=InsertaDataLen(">",1,pData);
	   		}	
			SendSocket(id,nSocket,pData->data,strlen(pData->data));
			pData=LiberaData(pData);
		}
	} while (mysql_next_result(Conexion[id].pMysqlconn)==0);
	//sprintf(szAux,"Puntero2=%x",Conexion[id].pMysqlconn);
	//WriteLog(id,szAux);
	mysql_free_result(res);
	return NULL;
}

	

#endif
	

