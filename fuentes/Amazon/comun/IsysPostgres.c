    #include <stdio.h>
    #include <const.h>
    #include <xml.h>
#ifdef FLAG_POSTGRES
    #include <libpq-fe.h>
    
int is_result_ready( PGconn *connection )
{

     int             my_socket;
     struct timeval  timer;
     fd_set          read_mask;

     if( PQisBusy( connection ) == 0 ) return( TRUE );

        my_socket = PQsocket( connection );
        timer.tv_sec  = (time_t)5;
        timer.tv_usec = 0;

     FD_ZERO( &read_mask );
     FD_SET( my_socket, &read_mask );

     if( select(my_socket + 1, &read_mask, NULL, NULL, &timer) == 0)
     {
       return( FALSE );
     }
     else if( FD_ISSET( my_socket, &read_mask ))
     {
        PQconsumeInput( connection );
        if( PQisBusy( connection ) == 0 ) return( TRUE );
        else return( FALSE );
     }
     else { return( FALSE ); }

 }



    void exit_nicely(PGconn *conn)
    {
        PQfinish(conn);
	conn=NULL;
        exit(1);
    }

    int SendErrorBD(int id,int nSocket,PGconn     *conn,char szEstado[])
    {
	    char szAux[MAX_BUFFER];
	    memset(szAux,0,sizeof(szAux));
            InsertaCampoXML(szAux,"STATUS",szEstado);
	    InsertaCampoXML(szAux,"DESCRIPCION",PQerrorMessage(conn));
	    WriteError(id,szAux);
	    printf("%s\n\r",szAux);
	    return SendSocket(id,nSocket,szAux,strlen(szAux));
    }

    PGconn     *OpenDatabase(int id,char dbName[],char pghost[],char pgport[])
    {
	char       *pgoptions,
                   *pgtty;
        int         nFields;
        int         i,
                    j;
	PGconn     *conn;
	char	*pgLogin;
	char 	*pgPass;
	char szAux[MAX_BUFFER];
        pgoptions = NULL;           /* special options to start up the backend
                                     * server */
        pgtty = NULL;               /* debugging tty for the backend server */
	pgLogin=global.szUsuarioBD;
	pgPass=global.szClaveBD;

        /* make a connection to the database */
	sprintf(szAux,"%i) Conectandose a base %s en %s:%s %x",id,dbName,pghost,pgport,Conexion[id].conn);
	WriteLog(0,szAux);
	WriteMensajeApp(id,szAux);

        //conn = PQsetdb(pghost, pgport, pgoptions, pgtty, dbName);
        conn = PQsetdbLogin(pghost, pgport, pgoptions, pgtty, dbName,pgLogin,pgPass);

        if (PQstatus(conn) == CONNECTION_BAD)
        {
            fprintf(stderr, "Connection to database '%s' failed.\n", dbName);
	    //SendErrorBD(id,nSocket,conn);
	    WriteError(id,"Falla Conexion");
	    WriteMensajeApp(id,"Falla Conexion BD");
            //exit_nicely(conn);
	    return NULL;
	}
	return conn;
    }
	
    int CierraSql(PGconn     *conn)
    {
	PQfinish(conn);
	conn=NULL;
    }

    PGresult *GetCamposSql(int id,int nSocket,char szTabla[],PGconn *conn)
    {
        PGresult *res;	
	int i;
	char szAux[MAX_BUFFER];
	char szSql[500];
	char szTmp[100];
	sprintf(szSql,"select * from %s limit 1",szTabla);
	printf("%s\n\r",szSql);
	res=PQexec(conn,szSql);
	if (res==NULL)
        {
	    sprintf(szAux,"Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
       	    WriteLog(id,szAux);
            fprintf(stderr, "Falla Envio de Query %s\n\r",PQerrorMessage(conn));
	    SendErrorBD(id,nSocket,conn,"FALLA");
            exit_nicely(conn);
        }

        switch(PQresultStatus(res))
        {
                case PGRES_COMMAND_OK:
                case PGRES_TUPLES_OK: 
			memset(szAux,0,sizeof(szAux));
			InsertaCampoXML(szAux,"STATUS","OK");
			for(i=0;i<PQnfields(res);i++) 
			{
			   sprintf(szTmp,"CAMPO%i",i);
			   InsertaCampoXML(szAux,szTmp,PQfname(res,i));
			   sprintf(szTmp,"SIZE%i",i);
			   InsertaCampoIntXML(szAux,szTmp,PQfsize(res,i));
			}
            		PQclear(res);
			SendSocket(id,nSocket,szAux,strlen(szAux));
			return NULL;
		case PGRES_FATAL_ERROR:
	    		sprintf(szAux,"Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
			WriteLog(id,szAux);
			WriteMensajeApp(id,"Error en BD");	
	    		SendErrorBD(id,nSocket,conn,"FALLA");
                        PQclear(res);
			PQfinish(Conexion[id].conn);
			Conexion[id].conn=NULL;
			Conexion[id].nAbierta=0;
			return NULL;
		default: 
	    		sprintf(szAux,"Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
			WriteLog(id,szAux);
			WriteMensajeApp(id,"Error en BD");
            		PQclear(res);
			PQfinish(Conexion[id].conn);
			Conexion[id].conn=NULL;
			Conexion[id].nAbierta=0;
			return NULL;
	}
    }

    //void GetOneRecord(int id,int nSocket,char szSql[],PGconn *conn)
    void GetOneRecord(int id,int nSocket,char szSql[])
    {
        PGresult *res;	
	char szAux[MAX_BUFFER];
	int i;
	int nIntentos;
	nIntentos=0;
reintenta:
       	//WriteLog(id,szSql);
	res=PQexec(Conexion[id].conn,szSql);
	if (res==NULL)
        {
	    sprintf(szAux,"Error en PQexec Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
       	    WriteLog(id,szAux);
	    WriteError(id,szAux);
	    WriteError(id,PQerrorMessage(Conexion[id].conn));
            fprintf(stderr, "Falla Envio de Query %s\n\r",PQerrorMessage(Conexion[id].conn));

	    //Vamos a reabrir la conexion a la base de datos
            if (nIntentos++<2)
            {
            	WriteError(id,"Reintento");
            	WriteLog(id,"Reintento");
                PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
                if (Conexion[id].conn==NULL)
                {
                	WriteError(id,"Falla Re-Conexion a BD");
	                WriteLog(id,"Falla Re-Conexion a BD");
        	        SendSocket(id,nSocket,szAux,strlen(szAux));
                	Conexion[id].nAbierta=0;
                	return;
                }
                else
                {
                	WriteError(id,"Conexion OK");
	                WriteLog(id,"Conexion OK");
        	        goto reintenta;
                }
             }
             else
             {
                WriteError(id,"Fin Reintentos");
                WriteLog(id,"Fin Reintentos");
                SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA");
                PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].nAbierta=0;
                return;
             }
	    return;
        }
        switch(PQresultStatus(res))
        {
		//Si envio bien query pero no tiene rerorno..
                case PGRES_COMMAND_OK:
			memset(szAux,0,sizeof(szAux));
			InsertaCampoXML(szAux,"STATUS","SIN_DATA");
			SendSocket(id,nSocket,szAux,strlen(szAux));
                        PQclear(res);
			return;
                case PGRES_TUPLES_OK: 
			if (PQntuples(res)==0)
			{
				memset(szAux,0,sizeof(szAux));
				InsertaCampoXML(szAux,"STATUS","SIN_DATA");
				SendSocket(id,nSocket,szAux,strlen(szAux));
        	                PQclear(res);
				return;
			}
			memset(szAux,0,sizeof(szAux));
			InsertaCampoXML(szAux,"STATUS","OK");
        		for(i=0;i<PQnfields(res);i++)
			{	
				InsertaCampoXML(szAux,PQfname(res,i),PQgetvalue(res,0,i));
			}
			SendSocket(id,nSocket,szAux,strlen(szAux));
			WriteLog(id,szAux);
                        PQclear(res);
			return;
		case PGRES_FATAL_ERROR:
	    		sprintf(szAux,"*Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
			WriteLog(id,szAux);
			WriteMensajeApp(id,"Error en BD");
			WriteError(id,szAux);
			//Reintentamos 1 vez
			if (nIntentos++<2) 
			{
	                        WriteError(id,"Reintento");
	                        WriteLog(id,"Reintento");
                        	PQclear(res);
				PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
				Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
				if (Conexion[id].conn==NULL)
		                {
	                                WriteError(id,"Falla Re-Conexion a BD");
	                                WriteLog(id,"Falla Re-Conexion a BD");
	    				SendSocket(id,nSocket,szAux,strlen(szAux));
					Conexion[id].nAbierta=0;
					return;
                        	}
				else
				{
	                                WriteError(id,"Conexion OK");
	                                WriteLog(id,"Conexion OK");
					goto reintenta;
				}
			}
			else
			{
	                        WriteError(id,"Fin Reintentos");
	                        WriteLog(id,"Fin Reintentos");
	    			SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA");
	                        PQclear(res);
				PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
				Conexion[id].nAbierta=0;
				return;
			}
		default: 
	    		sprintf(szAux,"Error default Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
			WriteLog(id,szAux);
			WriteError(id,szAux);
            		PQclear(res);
			PQfinish(Conexion[id].conn);
			Conexion[id].conn=NULL;
			Conexion[id].nAbierta=0;
			return;
	}
    }
     
    int EnviaQuery(int id,char szSql[])
    {
        PGresult *res=NULL;
        char szAux[MAX_BUFFER];
        int i;
        int nIntentos;
        nIntentos=0;
        time_t  time1,time2;
	int nLen;
reintenta:
	if (Conexion[id].nAbierta==0)
        {
        	if (!Conexion[id].nAbierta)
               {
                            WriteError(id,"Abre Conexion BD");
                            Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
               }
               if (Conexion[id].conn==NULL)
               {
                             WriteError(id,"Falla Conexion BD");
                             return 0;
               }
               Conexion[id].nAbierta=1;
        }


        //WriteLog(id,szSql);
	//WriteLog(id,"PQsendQuery");
        if (PQsendQuery(Conexion[id].conn,szSql) == 0)
        {
            sprintf(szAux,"Error en PQsendQuery Postgres %s",PQerrorMessage(Conexion[id].conn));
            WriteLog(id,szAux);
            WriteError(id,szAux);
            fprintf(stderr, "Falla Envio de Query %s\n\r",PQerrorMessage(Conexion[id].conn));

            //Vamos a reabrir la conexion a la base de datos
            if (nIntentos++<2)
            {
                WriteError(id,"Reintento");
                WriteLog(id,"Reintento");
                //PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
                if (Conexion[id].conn==NULL)
                {
                        WriteLog(id,"FALLA_RECONEXION_BD");
                        Conexion[id].nAbierta=0;
                        return 0;
                }
                else
                {
                        WriteError(id,"Conexion OK");
                        WriteLog(id,"Conexion OK");
                        goto reintenta;
                }
             }
             else
             {
                WriteLog(id,"FALLA_FIN_REINTENTOS");
                //PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].nAbierta=0;
                return 0;
             }
        }
         return 1;
}

PGresult *EsperoResultados(int id,int *nTotal)
{

	PGresult	*res=NULL;
        char szAux[MAX_BUFFER];
        int i;
        int nIntentos;
        nIntentos=0;
        time_t  time1,time2;
	int nLen;
        time(&time1);

	printf("Paso1 %x\n\r",Conexion[id].conn);
                //Esperamos a que este lista la respuesta
                while( is_result_ready( Conexion[id].conn ) == FALSE )
                {
                        //WriteError(id,"Verifica Timeout");
                        time(&time2);
                        //Si se cumple el Timeout
                        if (time2-time1>global.nTimeoutLeeData)
                        {
                                WriteError(id,"FALLA_BASE_DATOS_TIMEOUT");
                                //Intento cancelar el query
                                if (PQrequestCancel(Conexion[id].conn) == TRUE)
                                {
					WriteLog(id,"FALLA_TIMEOUT_QUERY_CANCELADO");
                                }
                                else
                                {
					WriteLog(id,"FALLA_TIMEOUT_QUERY_NO_CANCELADO");
                                }
                                if (res) PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return NULL;
                        }
                }

                //Sacamos los resultados
	printf("Saco Resultados %x\n\r",Conexion[id].conn);
                res=PQgetResult( Conexion[id].conn );
	printf("res=%x\n\r",res);
                if (res==NULL)
                {
			printf("No hay mas datos\n\r");
			//Fin de Query normal
                        //PQfinish(Conexion[id].conn);
			//Conexion[id].conn=NULL;
                        //Conexion[id].nAbierta=0;
                        //PQclear(res);
			return NULL;
                }

                //WriteError(id,"Lee Resultado");
                switch(PQresultStatus(res))
                {
                        //Si envio bien query pero no tiene rerorno..
                        case PGRES_COMMAND_OK:
                                //WriteError(id,"Sin DAta");
				//WriteLog(id,"SIN_DATA");
				printf("PGRES_COMMAND_OK sin data\n");
                                PQclear(res);
                                //PQfinish(Conexion[id].conn);
				//Conexion[id].conn=NULL;
                                //Conexion[id].nAbierta=0;
				*nTotal=0;
                                return NULL;
                        case PGRES_TUPLES_OK:
                                if (PQntuples(res)==0)
                                {
                                        //WriteError(id,"Sin DAta2");
					//WriteLog(id,"SIN_DATA1");
					printf("PGRES_TUPLES_OK sin tupla\n");
                			res=PQgetResult( Conexion[id].conn );
                                        PQclear(res);
                                        //PQfinish(Conexion[id].conn);
					//Conexion[id].conn=NULL;
                                        //Conexion[id].nAbierta=0;
					 *nTotal=0;
                                	return NULL;
                                }
				*nTotal=PQntuples(res);
				return res;
                        case PGRES_FATAL_ERROR:
                                sprintf(szAux,"*Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
                                WriteLog(id,szAux);
				WriteLog(id,PQerrorMessage(Conexion[id].conn));
                                WriteError(id,szAux);
				WriteMensajeApp(id,"Error en BD");
                                PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
				Conexion[id].nAbierta=0;
				return NULL;
                        default:
                                sprintf(szAux,"Error default Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
                                WriteLog(id,szAux);
				WriteLog(id,PQerrorMessage(Conexion[id].conn));
			
                                WriteError(id,szAux);
				WriteMensajeApp(id,"Error en BD");
                                PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return NULL;
                }
	return NULL;
}


Tipo_Data *SacoResultados(int id,PGresult *res,int nReg,Tipo_Data *pData)
{
	int i;
	printf("PQntuples(res)=%i\n\r",PQntuples(res));
	if (nReg==PQntuples(res))
	{
		printf("Fin de Registros\n\r");
		PQclear(res);
		return NULL;
	}
	printf("Saco Datos\n\r");
        for(i=0;i<PQnfields(res);i++)
        {
			pData=InsertaDataLen(PQfname(res,i),strlen(PQfname(res,i)),pData);
			pData=InsertaDataLen("[]=",3,pData);
			pData=InsertaDataLen(PQgetvalue(res,nReg,i),strlen(PQgetvalue(res,nReg,i)),pData);
			pData=InsertaDataLen("###",3,pData);
        }
	WriteLog(id,pData->data);
	return pData;
}


    Tipo_Data *GetOneRecordAsinc1(int id,char szSql[],Tipo_Data *pData)
    {
	PGresult *res=NULL;
        char szAux[MAX_BUFFER];
        int i;
        int nIntentos;
        nIntentos=0;
        time_t  time1,time2;
	int nLen;
	char szTmp[50];
reintenta:
	if (Conexion[id].nAbierta==0)
        {
        	if (!Conexion[id].nAbierta)
               {
                            WriteError(id,"Abre Conexion BD");
                            Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
               }
               if (Conexion[id].conn==NULL)
               {
                             WriteError(id,"Falla Conexion BD");
                             return pData;
               }
               Conexion[id].nAbierta=1;
        }


        //WriteLog(id,szSql);
	//WriteLog(id,"PQsendQuery");
        if (PQsendQuery(Conexion[id].conn,szSql) == 0)
        {
            sprintf(szAux,"Error en PQsendQuery Postgres %s",PQerrorMessage(Conexion[id].conn));
            WriteLog(id,szAux);
            WriteError(id,szAux);
            fprintf(stderr, "Falla Envio de Query %s\n\r",PQerrorMessage(Conexion[id].conn));

            //Vamos a reabrir la conexion a la base de datos
            if (nIntentos++<2)
            {
                WriteError(id,"Reintento");
                WriteLog(id,"Reintento");
                //PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
                if (Conexion[id].conn==NULL)
                {
                        WriteLog(id,"FALLA_RECONEXION_BD");
                        Conexion[id].nAbierta=0;
                        return pData;
                }
                else
                {
                        WriteError(id,"Conexion OK");
                        WriteLog(id,"Conexion OK");
                        goto reintenta;
                }
             }
             else
             {
                WriteLog(id,"FALLA_FIN_REINTENTOS");
                //PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].nAbierta=0;
                return pData;
             }
            return pData;
        }

        time(&time1);

        do
        {
                //Esperamos a que este lista la respuesta
                while( is_result_ready( Conexion[id].conn ) == FALSE )
                {
                        //WriteError(id,"Verifica Timeout");
                        time(&time2);
                        //Si se cumple el Timeout
                        if (time2-time1>global.nTimeoutLeeData)
                        {
                                WriteError(id,"FALLA_BASE_DATOS_TIMEOUT");
                                WriteError(id,szSql);
                                //Intento cancelar el query
                                if (PQrequestCancel(Conexion[id].conn) == TRUE)
                                {
					WriteLog(id,"FALLA_TIMEOUT_QUERY_CANCELADO");
                                }
                                else
                                {
					WriteLog(id,"FALLA_TIMEOUT_QUERY_NO_CANCELADO");
                                }
                                if (res) PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return pData;
                        }
                }

                //Sacamos los resultados
                res=PQgetResult( Conexion[id].conn );
                if (res==NULL)
                {
			//Fin de Query normal
			return pData;
                        /*SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_OBTENER_RESULTADOS");
                        if (res) PQclear(res);
                        PQfinish(Conexion[id].conn);
                        Conexion[id].nAbierta=0;
                        return;
			*/
                }

                //WriteError(id,"Lee Resultado");
                switch(PQresultStatus(res))
                {
                        //Si envio bien query pero no tiene rerorno..
                        case PGRES_COMMAND_OK:
                                //WriteError(id,"Sin DAta");
				//WriteLog(id,"SIN_DATA");
				printf("PGRES_COMMAND_OK\n");
				while ((res=PQgetResult(Conexion[id].conn))!=NULL);
                                PQclear(res);
				sprintf(szTmp,"__QUERY__[]=OK###");
				pData=InsertaData(szTmp,pData);
                                //PQfinish(Conexion[id].conn);
				//Conexion[id].conn=NULL;
                                //Conexion[id].nAbierta=0;
                                return pData;
                        case PGRES_TUPLES_OK:
                                if (PQntuples(res)==0)
                                {
                                        //WriteError(id,"Sin DAta2");
					//WriteLog(id,"SIN_DATA1");
					printf("PGRES_TUPLES_OK\n");
					while ((res=PQgetResult(Conexion[id].conn))!=NULL);
        	                        PQclear(res);
					sprintf(szTmp,"__QUERY__[]=OK###");
					pData=InsertaData(szTmp,pData);
                                        PQclear(res);
                                        //PQfinish(Conexion[id].conn);
					//Conexion[id].conn=NULL;
                                        //Conexion[id].nAbierta=0;
                                        return pData;
                                }
				//FAY para que pueda contestar todo lo que necesite
	//WriteLog(id,"Paso 3");
                                for(i=0;i<PQnfields(res);i++)
                                {
					pData=InsertaDataLen(PQfname(res,i),strlen(PQfname(res,i)),pData);
					pData=InsertaDataLen("[]=",3,pData);
					pData=InsertaDataLen(PQgetvalue(res,0,i),strlen(PQgetvalue(res,0,i)),pData);
					pData=InsertaDataLen("###",3,pData);
                                }
				WriteLog(id,pData->data);
				//WriteLog(id,"SendSocketV1pData");
				//SendSocket(id,nSocket,pData->data,strlen(pData->data));
				//pData=LiberaData(pData);
                                PQclear(res);
                                //WriteError(id,"OK");
                                //Verificamos que no existan mas datos
                                //res=PQgetResult( Conexion[id].conn );
                                //if (res==NULL) return;
                                break; //VA a leer el proximo resultado que no debe exitir
                        case PGRES_FATAL_ERROR:
                                sprintf(szAux,"*Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
                                WriteLog(id,szAux);
				WriteLog(id,PQerrorMessage(Conexion[id].conn));
                                WriteError(id,szAux);
                                WriteError(id,szSql);
				WriteMensajeApp(id,"Error en BD");
                                //Reintentamos 1 vez
                                if (nIntentos++<2)
                                {
                                        WriteError(id,"Reintento");
                                        WriteLog(id,"Reintento");
                                        PQclear(res);
                                        PQfinish(Conexion[id].conn);
					Conexion[id].conn=NULL;
                                        Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
                                        if (Conexion[id].conn==NULL)
                                        {
						WriteLog(id,"FALLA_RECONEXION_BD");
                                                Conexion[id].nAbierta=0;
                                                return pData;
                                        }
                                        else
                                        {
                                                WriteError(id,"Conexion OK");
                                                WriteLog(id,"Conexion OK");
                                                goto reintenta;
                                        }
                                }
                                else
                                {
					WriteLog(id,"FALLA_FIN_REINTENTOS");
                                        PQclear(res);
                                        PQfinish(Conexion[id].conn);
					Conexion[id].conn=NULL;
                                        Conexion[id].nAbierta=0;
                                        return pData;
                                }
                        default:
                                sprintf(szAux,"Error default Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
                                WriteLog(id,szAux);
				WriteLog(id,PQerrorMessage(Conexion[id].conn));
			
                                WriteError(id,szAux);
                                WriteError(id,szSql);
				WriteMensajeApp(id,"Error en BD");
                                PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return pData;
                }
        } while( res != NULL );
	sprintf(szAux,"pData=%x",pData);
	WriteLog(id,szAux);
        //WriteError(id,"res=NULL");
	return pData;
}

    void GetOneRecordAsinc(int id,int nSocket,char szSql[])
    {
        PGresult *res=NULL;
        char szAux[MAX_BUFFER];
	Tipo_Data *pData=NULL;
        int i;
        int nIntentos;
        nIntentos=0;
        time_t  time1,time2;
	int nLen;
reintenta:
        //WriteLog(id,szSql);
	//WriteLog(id,"PQsendQuery");
        if (PQsendQuery(Conexion[id].conn,szSql) == 0)
        {
            sprintf(szAux,"Error en PQsendQuery Postgres %s",PQerrorMessage(Conexion[id].conn));
            WriteLog(id,szAux);
            WriteError(id,szAux);
            fprintf(stderr, "Falla Envio de Query %s\n\r",PQerrorMessage(Conexion[id].conn));

            //Vamos a reabrir la conexion a la base de datos
            if (nIntentos++<2)
            {
                WriteError(id,"Reintento");
                WriteLog(id,"Reintento");
                //PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
                if (Conexion[id].conn==NULL)
                {
                        SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_RECONEXION_BD");
                        Conexion[id].nAbierta=0;
                        return;
                }
                else
                {
                        WriteError(id,"Conexion OK");
                        WriteLog(id,"Conexion OK");
                        goto reintenta;
                }
             }
             else
             {
                SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_FIN_REINTENTOS");
                //PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].nAbierta=0;
                return;
             }
            return;
        }

        time(&time1);

        do
        {
                //Esperamos a que este lista la respuesta
                while( is_result_ready( Conexion[id].conn ) == FALSE )
                {
                        //WriteError(id,"Verifica Timeout");
                        time(&time2);
                        //Si se cumple el Timeout
                        if (time2-time1>global.nTimeoutLeeData)
                        {
                                WriteError(id,"FALLA_BASE_DATOS_TIMEOUT");
                                WriteError(id,szSql);
                                //Intento cancelar el query
                                if (PQrequestCancel(Conexion[id].conn) == TRUE)
                                {
                                        SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_TIMEOUT_QUERY_CANCELADO");
                                }
                                else
                                {
                                        SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_TIMEOUT_QUERY_NO_CANCELADO");
                                }
                                if (res) PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return;
                        }
                }

                //Sacamos los resultados
                res=PQgetResult( Conexion[id].conn );
                if (res==NULL)
                {
			//Fin de Query normal
			return;
                        /*SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_OBTENER_RESULTADOS");
                        if (res) PQclear(res);
                        PQfinish(Conexion[id].conn);
                        Conexion[id].nAbierta=0;
                        return;
			*/
                }

                //WriteError(id,"Lee Resultado");
                switch(PQresultStatus(res))
                {
                        //Si envio bien query pero no tiene rerorno..
                        case PGRES_COMMAND_OK:
                                WriteError(id,"Sin DAta");
                                SendErrorBD(id,nSocket,Conexion[id].conn,"SIN_DATA");
                                PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return;
                        case PGRES_TUPLES_OK:
                                if (PQntuples(res)==0)
                                {
                                        WriteError(id,"Sin DAta2");
                                        SendErrorBD(id,nSocket,Conexion[id].conn,"SIN_DATA");
                                        PQclear(res);
                                        PQfinish(Conexion[id].conn);
					Conexion[id].conn=NULL;
                                        Conexion[id].nAbierta=0;
                                        return;
                                }
				//FAY para que pueda contestar todo lo que necesite
	//WriteLog(id,"CreaData");
				pData=CreaData();
				//CAlculamos el largo a enviar
				nLen=0;
                                for(i=0;i<PQnfields(res);i++)
                                {
					nLen+=strlen(PQgetvalue(res,0,i));
					nLen+=strlen(PQfname(res,i))*2+5;
                                }
				//Agregar mas cosas
				nLen+=1024;
				pData->data=(char *)malloc(nLen+1);
				pData->nLenData=nLen;
				pData->data[0]=0;
	//WriteLog(id,"Paso 3");
                                InsertaCampoXMLpData(pData->data,"STATUS","OK");
                                for(i=0;i<PQnfields(res);i++)
                                {
                                        InsertaCampoXMLpData(pData->data,PQfname(res,i),PQgetvalue(res,0,i));
                                }
				//WriteLog(id,"SendSocketV1pData");
				SendSocket(id,nSocket,pData->data,strlen(pData->data));
				pData=LiberaData(pData);
                                PQclear(res);
                                //WriteError(id,"OK");
                                //Verificamos que no existan mas datos
                                //res=PQgetResult( Conexion[id].conn );
                                //if (res==NULL) return;
                                break; //VA a leer el proximo resultado que no debe exitir
                        case PGRES_FATAL_ERROR:
                                sprintf(szAux,"*Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
                                WriteLog(id,szAux);
                                WriteError(id,szAux);
                                WriteError(id,szSql);
				WriteMensajeApp(id,"Error en BD");
                                //Reintentamos 1 vez
                                if (nIntentos++<2)
                                {
                                        WriteError(id,"Reintento");
                                        WriteLog(id,"Reintento");
                                        PQclear(res);
                                        PQfinish(Conexion[id].conn);
					Conexion[id].conn=NULL;
                                        Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
                                        if (Conexion[id].conn==NULL)
                                        {
                                                SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_RECONEXION_BD");
                                                Conexion[id].nAbierta=0;
                                                return;
                                        }
                                        else
                                        {
                                                WriteError(id,"Conexion OK");
                                                WriteLog(id,"Conexion OK");
                                                goto reintenta;
                                        }
                                }
                                else
                                {
                                        SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_FIN_REINTENTOS");
                                        PQclear(res);
                                        PQfinish(Conexion[id].conn);
					Conexion[id].conn=NULL;
                                        Conexion[id].nAbierta=0;
                                        return;
                                }
                        default:
                                sprintf(szAux,"Error default Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
                                WriteLog(id,szAux);
                                WriteError(id,szAux);
                                WriteError(id,szSql);
				WriteMensajeApp(id,"Error en BD");
                                SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_PG");
                                PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return;
                }
        } while( res != NULL );
        //WriteError(id,"res=NULL");
    }




    PGresult *ExecuteSql(PGresult *res,int id,int nSocket,char szSql[],PGconn *conn)
    {
	char szAux[MAX_BUFFER];
	char szTmp[20];
	int i;
	res=PQexec(conn,szSql);
	if (res==NULL)
        {
	    sprintf(szAux,"Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
       	    WriteLog(id,szAux);
            fprintf(stderr, "Falla Envio de Query %s\n\r",PQerrorMessage(conn));
	    SendErrorBD(id,nSocket,conn,"FALLA");
	    return NULL;
        }

        switch(PQresultStatus(res))
        {
                case PGRES_COMMAND_OK:
                        //fprintf(stderr, "Comando sin Retorno Ok.\n");
		        memset(szAux,0,sizeof(szAux));	
			InsertaCampoXML(szAux,"STATUS","OK");
			sprintf(szTmp,"<CAMPOS>");
			strcat(szAux,szTmp);
			for(i=0;i<PQnfields(res);i++) 
			{
			   sprintf(szTmp,"CAMPO%i",i);
			   InsertaCampoXML(szAux,szTmp,PQfname(res,i));
			}
			sprintf(szTmp,"</CAMPOS>");
			strcat(szAux,szTmp);
			SendSocket(id,nSocket,szAux,strlen(szAux));
                        PQclear(res);
			return NULL;

                case PGRES_TUPLES_OK: 
			memset(szAux,0,sizeof(szAux));
			InsertaCampoXML(szAux,"STATUS","OK");
			sprintf(szTmp,"<CAMPOS>");
			strcat(szAux,szTmp);
			for(i=0;i<PQnfields(res);i++) 
			{
			   sprintf(szTmp,"CAMPO%i",i);
			   InsertaCampoXML(szAux,szTmp,PQfname(res,i));
			}
			InsertaCampoIntXML(szAux,"TOTAL_CAMPOS",PQnfields(res));
			sprintf(szTmp,"</CAMPOS>");
			strcat(szAux,szTmp);
			SendSocket(id,nSocket,szAux,strlen(szAux));
			return res;
		case PGRES_FATAL_ERROR:
	    		sprintf(szAux,"Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
			WriteLog(id,szAux);
			WriteMensajeApp(id,"Error en BD");
	    		SendErrorBD(id,nSocket,conn,"FALLA");
                        PQclear(res);
			PQfinish(Conexion[id].conn);
			Conexion[id].conn=NULL;
			Conexion[id].nAbierta=0;
			return NULL;
		default: 
	    		sprintf(szAux,"Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
			WriteLog(id,szAux);
			WriteMensajeApp(id,"Error en BD");
            		PQclear(res);
			return NULL;
	}
    }

    int MoveNextData_100(int id,int nSocket,PGresult   *res,int *nFila,int *nReg)
    {
	int i,j;
	char szAux[MAX_BUFFER];
	char szTmp[512];
	char szCampo[512];
	int nTemp=*nFila;
	int nMaxReg,bStatus,nInicio;

	memset(szAux,0,sizeof(szAux));
	InsertaCampoXML(szAux,"STATUS","OK");
	nMaxReg=1;
	bStatus=0;
	nInicio=*nReg;
	printf("Inicio de Buffer Registro=%i Campo=%i\n\r",nTemp,nInicio);
	do
	{
	   //si se acabo el resulta..
	   if (nTemp==PQntuples(res))
	   {
		//si al menos paso una vez
		if (bStatus)
		{
			WriteLog(id,szAux);
			SendSocket(id,nSocket,szAux,strlen(szAux));
			*nReg=i;
			*nFila=nTemp;
			return 1;
		}

		memset(szAux,0,sizeof(szAux));
		InsertaCampoXML(szAux,"STATUS","FIN");
		InsertaCampoIntXML(szAux,"TOTAL_REGISTROS",nTemp);
		SendSocket(id,nSocket,szAux,strlen(szAux));
		printf("Fin Query Registro=%i\n\r",nTemp);
		//PQclear(res);
		return 0;
	   }
	   //Agrega al paquete
           for(i=nInicio;i<PQnfields(res);i++)
	   {
		int nLen;
		sprintf(szCampo,"%s[%i]",PQfname(res,i),nTemp);
		nLen = strlen(szAux)+strlen(szCampo)+strlen(PQgetvalue(res,nTemp,i));
		if ((nLen+100)>MAX_BUFFER)
		{
			*nReg=i;
			*nFila=nTemp;
			WriteLog(id,szAux);
			SendSocket(id,nSocket,szAux,strlen(szAux));
			printf("Fin de Buffer Registro=%i Campo=%i\n\r",nTemp,i);
			return 1;
		}
		InsertaCampoXML(szAux,szCampo,PQgetvalue(res,nTemp,i));
		//WriteLog(0,szCampo);
		//WriteLog(0,PQgetvalue(res,nTemp,i));
		bStatus=1;
	   }
	   nInicio=0;
	   nTemp++;
	}while(1);
    }
    
    int MoveNextData100(int id,int nSocket,PGresult   *res,int *nFila,int *nReg)
    {
	int i,j;
	char szAux[MAX_BUFFER];
	char szTmp[512];
	char szCampo[512];
	int nTemp=*nFila;
	int nMaxReg,bStatus,nInicio;

	memset(szAux,0,sizeof(szAux));
	InsertaCampoXML(szAux,"STATUS","OK");
	nMaxReg=1;
	bStatus=0;
	nInicio=*nReg;
	printf("Inicio de Buffer Registro=%i Campo=%i\n\r",nTemp,nInicio);
	do
	{
	   //si se acabo el resulta..
	   if (nTemp==PQntuples(res))
	   {
		//si al menos paso una vez
		if (bStatus)
		{
			WriteLog(id,szAux);
			SendSocket(id,nSocket,szAux,strlen(szAux));
			*nReg=i;
			*nFila=nTemp;
			return 1;
		}

		memset(szAux,0,sizeof(szAux));
		InsertaCampoXML(szAux,"STATUS","FIN");
		InsertaCampoIntXML(szAux,"TOTAL_REGISTROS",nTemp);
		SendSocket(id,nSocket,szAux,strlen(szAux));
		printf("Fin Query Registro=%i\n\r",nTemp);
		//PQclear(res);
		return 0;
	   }
	   //Agrega al paquete
           for(i=nInicio;i<PQnfields(res);i++)
	   {
		int nLen;
		sprintf(szCampo,"%s%i",PQfname(res,i),nTemp);
		nLen = strlen(szAux)+strlen(szCampo)+strlen(PQgetvalue(res,nTemp,i));
		if ((nLen+100)>MAX_BUFFER)
		{
			*nReg=i;
			*nFila=nTemp;
			WriteLog(id,szAux);
			SendSocket(id,nSocket,szAux,strlen(szAux));
			printf("Fin de Buffer Registro=%i Campo=%i\n\r",nTemp,i);
			return 1;
		}
		InsertaCampoXML(szAux,szCampo,PQgetvalue(res,nTemp,i));
		//WriteLog(0,szCampo);
		//WriteLog(0,PQgetvalue(res,nTemp,i));
		bStatus=1;
	   }
	   nInicio=0;
	   nTemp++;
	}while(1);
    }

    int MoveNextData(int id,int nSocket,PGresult   *res,int nFila)
    {
	int i;
	char szAux[MAX_BUFFER];
	char szTmp[512];
	//si se acabo el resulta..
	if (nFila==PQntuples(res))
	{
		memset(szAux,0,sizeof(szAux));
		InsertaCampoXML(szAux,"STATUS","FIN");
		SendSocket(id,nSocket,szAux,strlen(szAux));
		//PQclear(res);
		return 0;
	}

	memset(szAux,0,sizeof(szAux));
	InsertaCampoXML(szAux,"STATUS","OK");
	//SendCaracter(nSocket,0x02);
	//SendData(nSocket,"STATUS","OK");
        for(i=0;i<PQnfields(res);i++)
	{
		//sprintf(szTmp,"i=%i CAMPO=%s DATA=%s",i,PQfname(res,i),PQgetvalue(res,nFila,i));
		//WriteLog(id,szTmp);
		InsertaCampoXML(szAux,PQfname(res,i),PQgetvalue(res,nFila,i));
		//SendData(nSocket,PQfname(res,i),PQgetvalue(res,nFila,i));
	}
	SendSocket(id,nSocket,szAux,strlen(szAux));
	//SendCaracter(nSocket,0x03);
    }

    test()
    {
        char       *pghost,
                   *pgport,
                   *pgoptions,
                   *pgtty;
        char       *dbName;
        int         nFields;
        int         i,
                    j;
    
        PGconn     *conn;
        PGresult   *res;
	char *dbUsuario;
	char *dbPass;
	char szComando[]="SELECT * from usuarios";
    
        /*
         * begin, by setting the parameters for a backend connection if the
         * parameters are null, then the system will try to use reasonable
         * defaults by looking up environment variables or, failing that,
         * using hardwired constants
         */
        pghost = NULL;              /* host name of the backend server */
        pgport = NULL;              /* port of the backend server */
        pgoptions = NULL;           /* special options to start up the backend
                                     * server */
        pgtty = NULL;               /* debugging tty for the backend server */
	dbName="transtel";
    
        /* make a connection to the database */
        conn = PQsetdb(pghost, pgport, pgoptions, pgtty, dbName);
    
        /*
         * check to see that the backend connection was successfully made
         */
        if (PQstatus(conn) == CONNECTION_BAD)
        {
            fprintf(stderr, "Connection to database '%s' failed.\n", dbName);
            fprintf(stderr, "%s", PQerrorMessage(conn));
            exit_nicely(conn);
        }

        printf("USU=%s PASS=%s PORT=%s HOST=%s\n\r",PQuser(conn),PQpass(conn),PQport(conn),PQhost(conn));
        if (!PQsendQuery(conn,szComando))
	{
            fprintf(stderr, "Falla Envio de Query %s\n\r",PQerrorMessage(conn));
            exit_nicely(conn);
	}
        if (!res)
	{
            fprintf(stderr, "Comando erroneo %s\n\r",PQerrorMessage(conn));
            PQclear(res);
            exit_nicely(conn);
	}

	while((res=PQgetResult(conn))!=NULL)
	{
		switch(PQresultStatus(res))
		{
	   	case PGRES_COMMAND_OK:
	   	case PGRES_TUPLES_OK:
			for(i=0;i<PQnfields(res);i++) 
				printf("Columna = %s\n\r",PQfname(res,i));
            		//fprintf(stderr, "Comando sin Retorno Ok.\n");
            		PQclear(res);
            		exit_nicely(conn);
			break;
			/*
	   	case PGRES_TUPLES_OK:
			printf("Filas %i Columnas %i\n\r",PQntuples(res),PQnfields(res));
			for(i=0;i<PQnfields(res);i++) 
				printf("Columna = %s\n\r",PQfname(res,i));

			printf("Data \n\r");
			break;
			*/
		}
	}
		
        /*
         * should PQclear PGresult whenever it is no longer needed to avoid
         * memory leaks
         */
        PQclear(res);
    
        /* close the connection to the database and cleanup */
        PQfinish(conn);
	printf("Fin \n\r");
    
        return 0;
    }
    
    Tipo_XML *ExecuteSql1(int id,char szSql[],int *nTotal,int nTipo,Tipo_XML *xml1,int *sts)
    {
        PGresult *res;	
	char szCampo[1024];
	char szAux[MAX_BUFFER];
	char szTmp[100];
	int i,j;
	PGconn *conn=NULL;
	*sts=0;
	printf("Ejecuta %s\n",szSql);
	if (Conexion[id].conn==NULL) 
	{
		//sprintf(szTmp,"%i",global.nPortBase);
		//Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,szTmp);
		Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
		printf("Conectando a Base %s:%s",global.szBaseDatos,global.szPortPostgres);
		if (Conexion[id].conn==NULL) 
		{
			Conexion[id].nAbierta=0;
			return xml1;
		}
		conn=Conexion[id].conn;
		Conexion[id].nAbierta=1;
	}
	else conn=Conexion[id].conn;

	//WriteLog(id,szSql);
	//WriteMensajeApp(id,"Ejecuta Query Postgres");
	res=PQexec(conn,szSql);
	if (res==NULL)
        {
	    sprintf(szAux,"Error Postgres %i %s %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)),PQerrorMessage(conn));
       	    WriteLog(id,szAux);
	    PQfinish(conn);
	    Conexion[id].conn=NULL;
	    Conexion[id].nAbierta=0;
	    return xml1;
        }

        switch(PQresultStatus(res))
        {
                case PGRES_COMMAND_OK:
			WriteLog(id,"PGRES_COMMAND_OK");
			xml1=InsertaDataXML(xml1,"STATUS","OK");
			memset(szAux,0,sizeof(szAux));
			for(i=0;i<PQnfields(res);i++) 
			{
			   sprintf(szTmp,"CAMPO%i",i);
			   InsertaCampoXML(szAux,szTmp,PQfname(res,i));
			}
			xml1=InsertaDataXML(xml1,"CAMPOS",szAux);
			*nTotal=0;
                        PQclear(res);
			//WriteXML(id,xml1);
			*sts=1;
			return xml1;

                case PGRES_TUPLES_OK: 
			WriteLog(id,"PGRES_TUPLES_OK");
			xml1=InsertaDataXML(xml1,"STATUS","OK");
			memset(szAux,0,sizeof(szAux));
			for(i=0;i<PQnfields(res);i++) 
			{
			   sprintf(szTmp,"CAMPO%i",i);
			   InsertaCampoXML(szAux,szTmp,PQfname(res,i));
			}
			InsertaCampoIntXML(szAux,"TOTAL_CAMPOS",PQnfields(res));
			InsertaCampoIntXML(szAux,"TOTAL_REGISTROS",PQntuples(res));

			xml1=InsertaDataXML(xml1,"CAMPOS",szAux);
			*nTotal=PQntuples(res);
			if (PQntuples(res)>0) 
			{
			   *sts=1;
			   for(j=0;j<PQntuples(res);j++)
			   {
           		      for(i=0;i<PQnfields(res);i++)
	   		      {
				   if (nTipo==2) sprintf(szCampo,"%s[%i]",PQfname(res,i),j);
				   //else if (nTipo==3) sprintf(szCampo,"%s%i",PQfname(res,i),j);
				   else if (nTipo==3) sprintf(szCampo,"%s%i",PQfname(res,i),j);
				   else sprintf(szCampo,"%s",PQfname(res,i));
			      
			           xml1=InsertaDataXML(xml1,szCampo,PQgetvalue(res,j,i));
			      }
			   }
			}
			else
			{
				//xml1=CierraXML(xml1);
				*sts=0;
			}
                        PQclear(res);
			//WriteXML(id,xml1);
			//ImprimeXML(xml1);
			return xml1;
			break;
		case PGRES_FATAL_ERROR:
		default: 
			WriteLog(id,"PGRES_FATAL_ERROR");
			*nTotal=(-1);
	    		sprintf(szAux,"#Error Postgres %i %s %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)),PQerrorMessage(conn));
       	    		WriteLog(id,szAux);
			WriteMensajeApp(id,"Error en BD");
                        PQclear(res);
	    		PQfinish(conn);
			Conexion[id].conn=NULL;
	    		Conexion[id].nAbierta=0;
			return xml1;
	}
    }


    //void GetOneRecord(int id,int nSocket,char szSql[],PGconn *conn)
    void GetMultipleRecordAsinc(int id,int nSocket,char szSql[])
    {
        PGresult *res=NULL;
        char szAux[MAX_BUFFER];
        char szAux1[MAX_BUFFER];
        char szCampo[1024];
        int i,j;
        int nIntentos;
        nIntentos=0;
        time_t  time1,time2;
        int nEnvioCampos=0;
        int nFields;
        int nTotal=0;
        char szTmp[20];
reintenta:
        //WriteLog(id,szSql);
        if (PQsendQuery(Conexion[id].conn,szSql) == 0)
        {
            sprintf(szAux,"Error en PQsendQuery Postgres %s",PQerrorMessage(Conexion[id].conn));
            WriteLog(id,szAux);
            WriteError(id,szAux);
            fprintf(stderr, "Falla Envio de Query %s\n\r",PQerrorMessage(Conexion[id].conn));

            //Vamos a reabrir la conexion a la base de datos
            if (nIntentos++<2)
            {
                WriteError(id,"Reintento");
                WriteLog(id,"Reintento");
                //PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
                if (Conexion[id].conn==NULL)
                {
                        SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_RECONEXION_BD");
                        Conexion[id].nAbierta=0;
                        return;
                }
                else
                {
                        WriteError(id,"Conexion OK");
                        WriteLog(id,"Conexion OK");
                        goto reintenta;
                }
             }
             else
             {
                SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_FIN_REINTENTOS");
                //PQclear(res);
                PQfinish(Conexion[id].conn);
		Conexion[id].conn=NULL;
                Conexion[id].nAbierta=0;
                return;
             }
            return;
        }

        time(&time1);

        do
        {
                //Esperamos a que este lista la respuesta
                while( is_result_ready( Conexion[id].conn ) == FALSE )
                {
                        //WriteError(id,"Verifica Timeout");
                        time(&time2);
                        //Si se cumple el Timeout
                        if (time2-time1>global.nTimeoutLeeData)
                        {
                                WriteError(id,"FALLA_BASE_DATOS_TIMEOUT");
                                //Intento cancelar el query
                                if (PQrequestCancel(Conexion[id].conn) == TRUE)
                                {
                                        SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_TIMEOUT_QUERY_CANCELADO");
                                }
                                else
                                {
                                        SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_TIMEOUT_QUERY_NO_CANCELADO");
                                }
                                if (res) PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return;
                        }
                }

                //Sacamos los resultados
                res=PQgetResult( Conexion[id].conn );
                if (res==NULL)
                {
                        memset(szAux,0,sizeof(szAux));
                        InsertaCampoXML(szAux,"STATUS","FIN");
                        sprintf(szTmp,"%i",nTotal);
                        strcat(szAux,szTmp);
                        SendSocket(id,nSocket,szAux,strlen(szAux));
                        //SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_OBTENER_RESULTADOS");
                        if (res) PQclear(res);
                        PQfinish(Conexion[id].conn);
			Conexion[id].conn=NULL;
                        Conexion[id].nAbierta=0;
                        return;
                }

                //WriteError(id,"Lee Resultado");
                switch(PQresultStatus(res))
                {
                        //Si envio bien query pero no tiene rerorno..
                        case PGRES_COMMAND_OK:
                                WriteError(id,"Sin DAta");
                                SendErrorBD(id,nSocket,Conexion[id].conn,"SIN_DATA");
                                if (res) PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return;
                        case PGRES_TUPLES_OK:
                                if (PQntuples(res)==0)
                                {
                                        WriteError(id,"Sin DAta2");
                                        SendErrorBD(id,nSocket,Conexion[id].conn,"SIN_DATA");
                                        if (res) PQclear(res);
                                        PQfinish(Conexion[id].conn);
					Conexion[id].conn=NULL;
                                        Conexion[id].nAbierta=0;
                                        return;
                                }

                                //Si no ha enviado los campos es lo primero que hace
                                if (nEnvioCampos==0)
                                {
                                        memset(szAux,0,sizeof(szAux));
                                        InsertaCampoXML(szAux,"STATUS","CAMPOS");
                                        for(i=0;i<PQnfields(res);i++)
                                        {
                                                sprintf(szAux1,"%s,",PQfname(res,i));
                                                strcat(szAux,szAux1);
                                        }
                                        nEnvioCampos=1;
                                        //send(nSocket,szAux,strlen(szAux),0);
                                        SendSocket(id,nSocket,szAux,strlen(szAux));
                                }
                                nFields=PQnfields(res);
                                //Indica que esta OK primero, luego envia datos
                                memset(szAux,0,sizeof(szAux));
                                InsertaCampoXML(szAux,"STATUS","DATA");
                                /* next, print out the rows */
                                for (i = 0; i < PQntuples(res); i++)
                                {
                                        for (j = 0; j < nFields; j++)
                                        {
                                                int nLen;
						char  *data;
                                                nLen=strlen(PQgetvalue(res,i,j));
                                                if (nLen>0)
                                                {
                                                        //sprintf(szAux1,"%i,%i,%i,%s",i,j,nLen,PQgetvalue(res,i,j));
                                                        //sprintf(szAux1,"%i,%i,%s",j,nLen,PQgetvalue(res,i,j));
                                                        //La primera posicion es el Nro de registro
							//Verificamos si al concatenar el campo no pasamos el largo del buffer
							if (strlen(szAux)+nLen<MAX_BUFFER)
							{
                                                        	sprintf(szAux1,"%i,%i,%s",i,nLen,PQgetvalue(res,i,j));
	                                                        strcat(szAux,szAux1);
							}
							else
							{
								int nEnviado=0;
								//Si no me alcanza
								WriteLog(id,"NO ALCANZA");
                                                        	sprintf(szAux1,"%i,%i,",i,nLen);
								strcat(szAux,szAux1);
                        	                        	//SendSocket(id,nSocket,szAux,strlen(szAux));
								data=PQgetvalue(res,i,j);
								while(nEnviado<nLen)
								{
									char szTmp[200];
									sprintf(szTmp,"Enviado Paquete %i %i MAX_BUFFER=%i strlen(szAux)=%i nLen=%i",nEnviado,MAX_BUFFER-strlen(szAux)-100,MAX_BUFFER,strlen(szAux),nLen);
									WriteLog(id,szTmp);
								
									//Si alcanzo a enviar todo...	
									if (strlen(&data[nEnviado])<MAX_BUFFER-strlen(szAux)-100)
									{
										memcpy(szAux1,&data[nEnviado],strlen(&data[nEnviado]));
										szAux1[strlen(&data[nEnviado])]=0;
									}
									else
									{
										memcpy(szAux1,&data[nEnviado],MAX_BUFFER-strlen(szAux)-100);
										szAux1[MAX_BUFFER-strlen(szAux)-100]=0;
									}
									nEnviado+=strlen(szAux1);
									strcat(szAux,szAux1);
                        	                        		SendSocket(id,nSocket,szAux,strlen(szAux));
									WriteLog(id,szAux);
									memset(szAux,0,sizeof(szAux));
								}
								WriteLog(id,"Termino Enviar");
                	                                	memset(szAux,0,sizeof(szAux));
		                                                InsertaCampoXML(szAux,"STATUS","DATA");
							}
                                                }
                                                //Se envia un 0 para los datos nulos
                                                else
                                                {
                                                        sprintf(szAux1,"%i,0,",i);
                                                        strcat(szAux,szAux1);
                                                }
                                        }
                                        nTotal++;
                                        if (strlen(szAux)+30>=MAX_BUFFER)
                                        {
                                                //sprintf(szAux1,"Envia SendSocket=%i",strlen(szAux));
                                                //WriteLog(id,szAux1);

                                                SendSocket(id,nSocket,szAux,strlen(szAux));
                                                memset(szAux,0,sizeof(szAux));
                                                InsertaCampoXML(szAux,"STATUS","DATA");
                                        }
                                }

                                //sprintf(szAux1,"Envia SendSocket=%i",strlen(szAux));
                                //WriteLog(id,szAux1);
				//Si el mayor a 22 <STATUS>DATA</STATUS> envia
			
				if (strlen(szAux)>21) SendSocket(id,nSocket,szAux,strlen(szAux));
                                //if (res) PQclear(res);
                                //WriteError(id,"OK");
                                //Verificamos que no existan mas datos
                                //res=PQgetResult( Conexion[id].conn );
                                //if (res==NULL) return;
                                break; //VA a leer el proximo resultado que no debe exitir
                        case PGRES_FATAL_ERROR:
                                sprintf(szAux,"*Error Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
                                WriteLog(id,szAux);
                                WriteError(id,szAux);
				WriteMensajeApp(id,"Error en BD");
                                //Reintentamos 1 vez
                                if (nIntentos++<2)
                                {
                                        WriteError(id,"Reintento");
                                        WriteLog(id,"Reintento");
                                        if (res) PQclear(res);
                                        PQfinish(Conexion[id].conn);
					Conexion[id].conn=NULL;
                                        Conexion[id].conn=OpenDatabase(id,global.szBaseDatos,global.szIpBd,global.szPortPostgres);
                                        if (Conexion[id].conn==NULL)
                                        {
                                                SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_RECONEXION_BD");
                                                Conexion[id].nAbierta=0;
                                                return;
                                        }
                                        else
                                        {
                                                WriteError(id,"Conexion OK");
                                                WriteLog(id,"Conexion OK");
                                                goto reintenta;
                                        }
                                }
                                else
                                {
                                        SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_FIN_REINTENTOS");
                                        if (res) PQclear(res);
                                        PQfinish(Conexion[id].conn);
					Conexion[id].conn=NULL;
                                        Conexion[id].nAbierta=0;
                                        return;
                                }
                        default:
                                sprintf(szAux,"Error default Postgres %i %s",PQresultStatus(res),PQresStatus(PQresultStatus(res)));
                                WriteLog(id,szAux);
                                WriteError(id,szAux);
				WriteMensajeApp(id,"Error en BD");
                                SendErrorBD(id,nSocket,Conexion[id].conn,"FALLA_PG");
                                if (res) PQclear(res);
                                PQfinish(Conexion[id].conn);
				Conexion[id].conn=NULL;
                                Conexion[id].nAbierta=0;
                                return;
                }
        } while( res != NULL );
        //WriteError(id,"res=NULL");
    }



#endif
