#include <stdio.h>
#include <stdlib.h>
#include <xml.h>
#include<sys/types.h>
#include<dirent.h>

int TipoQueryThread(int id,Tipo_XML *xml)
{
	Tipo_Data *pFile=NULL;
	Tipo_IpBackoffices *pIp;
	char szInput[MAX_BUFFER];
	int sts,nLenFormato,nFormatoSalida,nFormatoAck;
	Tipo_Formatos *pForSalida,*pForAck;
	char szError[200];
	Tipo_Servicio stServ;
	Tipo_XML *xml1=NULL;
	Tipo_XML *xml2=NULL;
	Tipo_XML *xmlserv=NULL;
	Tipo_XML *xmlresp=NULL;
	Tipo_XML *xml12resp=NULL;
	Tipo_XML *xmlrec=NULL;
	Tipo_XML *xmlent=NULL;
	//Tipo_XML *xml3=NULL;
	char szData[MAX_BUFFER];
	char szQuerySalida[MAX_BUFFER];
	char szQueryAck[MAX_BUFFER];
	char szQueryEntrada[MAX_BUFFER];
	int nTotal,i,nServicio;
	int bStateQuery=0,bState;
	int nTotalRegistros=0;
	int nNivel=0,nNivelEnt=0;
	int nBaseEntrada,nBaseSalida,nBaseAck,nBaseTmp;
	char szTmp[100];
	char szIpSalida[30],szPortSalida[30];
	int bFile;
	char szIp[30],szPort[30];
	int nLog=LOG(id);
	char szQueryFinal[MAX_BUFFER];
	int nBaseQueryFinal=0;
	int nServicioQueryInicial=0;

	char szFile[512];
	printf("LOG = %i\n\r",nLog);
	SET_LOG(id,0);

	//printf("Inicia Thread %i\n\r",id);
	//EsperaActivacion(id);
	GetIntXML(xml,"SERVICIO_QUERY_INICIAL",&nServicioQueryInicial);

	//Lee la ruta y el patron
	GetIntXML(xml,"BASE_QUERY_ENTRADA",&nBaseEntrada);
	GetStrXML(xml,"QUERY_ENTRADA",szQueryEntrada,sizeof(szQueryEntrada));
	GetIntXML(xml,"FORMATO_SALIDA",&nFormatoSalida);
	GetIntXML(xml,"FORMATO_ACK",&nFormatoAck);
	//GetIntXML(xml,"SERVICIO",&nServicio);
	GetStrXML(xml,"IP_SALIDA",szIpSalida,sizeof(szIpSalida));
	GetStrXML(xml,"PORT_SALIDA",szPortSalida,sizeof(szPortSalida));
	GetIntXML(xml,"BASE_QUERY_SALIDA",&nBaseSalida);
	GetStrXML(xml,"QUERY_SALIDA",szQuerySalida,sizeof(szQuerySalida));
	GetIntXML(xml,"BASE_QUERY_ACK",&nBaseAck);
	GetStrXML(xml,"QUERY_ACK",szQueryAck,sizeof(szQueryAck));
	GetStrXML(xml,"FILE_SALIDA",szFile,sizeof(szFile));
	GetIntXML(xml,"BASE_QUERY_FINAL",&nBaseQueryFinal);
	GetStrXML(xml,"QUERY_FINAL",szQueryFinal,sizeof(szQueryFinal));
 	if (strlen(szFile)>0) bFile=1;
	else bFile=0;
	//GetStrXML(xml,"QUERY_INICIAL",szQueryInicial,sizeof(szQueryInicial));
	pForSalida = LeeFormato(id,nFormatoSalida);
	pForAck = LeeFormato(id,nFormatoAck);



	nNivel=0;
	nBaseTmp=GET_DATABASE(id);
	SET_GLOBAL_DATABASE(id,nBaseEntrada);
	xmlrec=GetRecords(id,szQueryEntrada,&nTotal);
	if (nTotal>0)
	{
		SET_LOG(id,nLog);
		WriteLog(id,szQueryEntrada);
		sprintf(szTmp,"Total Registros Entrada =%i",nTotal);
		WriteLog(id,szTmp);
	}
		
	//ImprimeXML(xmlrec);
	SET_GLOBAL_DATABASE(id,nBaseTmp);
	//ImprimeXML(xml1);
	xml1=GetNivelXML(xmlrec,nNivel++);
	printf("Inicia Query %s\n\r",szQueryEntrada);
	printf("LOG = %i\n\r",nLog);
	if (xml1!=NULL)
	{
		printf("Query no nulo\n\r");
	}
	else printf("Query nulo\n\r");
		
	if (nServicioQueryInicial>0)
	{
      		int bContesta;
      		char szTmp1[30];
		int n=nServicioQueryInicial;
		Tipo_XML *xmlaux;
      		sprintf(szTmp1,"Ejecuta Servicio Inicial %i",n);
      		printf("%s\n\r",szTmp1);
      		WriteLog(id,szTmp1);
      		xmlaux=AplicaQuerysServicio(id,xml1,n,&bContesta);
      		xmlaux=CierraXML(xmlaux);
	}
	   
	while(xml1!=NULL)
	{
	
		if ((nBaseSalida) &&(strlen(szQuerySalida)>0))
		{
			char szSql[MAX_BUFFER];
			ReemplazaTagsStr(xml1,szQuerySalida,szSql);
			//WriteLog(id,szSql);
	   		nBaseTmp=GET_DATABASE(id);
	   		SET_GLOBAL_DATABASE(id,nBaseSalida);
	   		//xmlent=GetRecords(id,szSql,&nTotal);
			xml2=QueryDatabase1(id,szSql,"QUERY",szError);
			//sprintf(szTmp,"Total Registros Salida =%i",nTotal);
			//WriteLog(id,szTmp);
	   		SET_GLOBAL_DATABASE(id,nBaseTmp);
			//nNivelEnt=0;
	   		//nTotalRegistros=0;
	   		//xml2=GetNivelXML(xmlent,nNivelEnt++);
		}
		else WriteLog(id,"No query de salida");
			  
		//Si el query entrega resultado
		if (xml2!=NULL)
		{
		      xml2=CierraXML(xml2);
		      //nNivelEnt=0;
	   	      nTotalRegistros=0;
		      //Por cada registro del query de salida
		      while((xml2=MoveNext(id,&sts))!=NULL)
		      {
			if (sts==ERROR_BASE)
			{
				char szTmp[500];
				WriteLog(id,"Error en la base");
				sprintf(szTmp,"Solo Procesa Reg= %i",nTotalRegistros);
				WriteLog(id,szTmp);
				break;
			}
			else if (sts==NO_HAY_DATOS) 
			{
				char szTmp[500];
				sprintf(szTmp,"Registros Procesados = %i",nTotalRegistros);
				WriteLog(id,szTmp);
				break;
			}
			//Haga algo..
			//ImprimeXML(xml2);
			xmlserv=StrcpyXML(xml1,xml2);
			printf("Inserta en File %i\n\r",bFile);
			if (bFile) pFile=InsertaDataFile(id,pFile,xmlserv,pForSalida,xml);
			nTotalRegistros++;
			ReemplazaTagsStr(xmlserv,szPortSalida,szPort);
			ReemplazaTagsStr(xmlserv,szIpSalida,szIp);
			sprintf(stServ.szIp,"%s",szIp);
			stServ.nPort=atoi(szPort);
			stServ.nTimeout=global.nTimeoutLeeData;
			if ((nFormatoSalida) && (strlen(szIp)>0))
			{
				WriteLog(id,"Autoriza Con Formatos");
				xmlresp=AutorizaServicioXML(id,xmlserv,pForSalida,pForAck,&stServ);
			}
			else if ((nFormatoSalida==0) && (nFormatoAck==0) && (strlen(szIp)>0))
			{
				WriteLog(id,"Autoriza Directo XML");
				xmlresp=AutorizaServicio1(id,xmlserv,&stServ);
			}
			if (nBaseAck)
			{
			    WriteLog(id,"Query Ack Activado");
			    xml12resp=StrcpyXML(xmlresp,xml1);
	   		    nBaseTmp=GET_DATABASE(id);
	   		    SET_GLOBAL_DATABASE(id,nBaseAck);
			    QueryAck(id,xml12resp,szQueryAck);
	   		    SET_GLOBAL_DATABASE(id,nBaseTmp);
			    xml12resp=CierraXML(xml12resp);
			}
			//else WriteLog(id,"Sin Query Ack");
			xmlresp=CierraXML(xmlresp);
			xmlserv=CierraXML(xmlserv);
			xml2=CierraXML(xml2);
	   		//xml2=GetNivelXML(xmlent,nNivelEnt++);
		      } //while((xml2=MoveNext(id,&sts))!=NULL)
		      //Termina la recursion cierro la BD
		      if (!global.nFormaConexionBD) CloseDatabase(id);
		}
		else
		{
			 WriteLog(id,"Sin Recursion Query Salida");
			 if (bFile) pFile=InsertaDataFile(id,pFile,xml1,pForSalida,xml);
			 nTotalRegistros++;
			 ReemplazaTagsStr(xml1,szPortSalida,szPort);
			 ReemplazaTagsStr(xml1,szIpSalida,szIp);
			 sprintf(stServ.szIp,"%s",szIp);
			 stServ.nPort=atoi(szPort);
			 stServ.nTimeout=global.nTimeoutLeeData;
			 if ((nFormatoAck) && (strlen(szIp)>0))
			 {
				WriteLog(id,"Autoriza Con Formatos");
		         	xmlresp=AutorizaServicioXML(id,xml1,pForSalida,pForAck,&stServ);
			 }
			 else if ((nFormatoSalida==0) && (nFormatoAck==0) && (strlen(szIp)>0))
			 {
				WriteLog(id,"Autoriza Directo XML");
				xmlresp=AutorizaServicio1(id,xmlserv,&stServ);
			 }
			 else WriteLog(id,"Sin Servicio Socket Activado");
		   	 //sleep(2);
			 if (nBaseAck)
			 {
			    WriteLog(id,"Query Ack Activado");
			    xml12resp=StrcpyXML(xmlresp,xml1);
	   		    nBaseTmp=GET_DATABASE(id);
	   		    SET_GLOBAL_DATABASE(id,nBaseAck);
			    QueryAck(id,xml12resp,szQueryAck);
	   		    SET_GLOBAL_DATABASE(id,nBaseTmp);
			    xml12resp=CierraXML(xml12resp);
			 }
			 //else WriteLog(id,"Sin Query Ack");
			 xmlresp=CierraXML(xmlresp);
		}
		xmlserv=StrcpyXML(xml,xml1);
		sprintf(szTmp,"%i",nTotalRegistros);
		xmlserv=InsertaDataXML(xmlserv,"TOTAL_REGISTROS",szTmp); 
		if (bFile) pFile=CierraDataFile(id,xmlserv,pFile);
       		xmlent=CierraXML(xmlent);
		xmlserv=CierraXML(xmlserv);
		xml1=CierraXML(xml1);
		xml1=GetNivelXML(xmlrec,nNivel++);
		printf("Nivel = %i %x\n\r",nNivel,xml1);
	}

 	//Query final	
	if ((nBaseQueryFinal) && (strlen(szQueryFinal)>0))
	{
		char szSql[MAX_BUFFER];
		ReemplazaTagsStr(xml,szQueryFinal,szSql);
		printf("SQL Final=%s\n\r",szSql);
		WriteLog(id,szSql);
  		nBaseTmp=GET_DATABASE(id);
		SET_GLOBAL_DATABASE(id,nBaseQueryFinal);
   		SendDatabase(id,szSql);
  		SET_GLOBAL_DATABASE(id,nBaseTmp);
	}
			   
       	xmlrec=CierraXML(xmlrec);
	SET_LOG(id,0);
	CloseDatabase(id);
	SET_LOG(id,nLog);
	printf("Fin Query\n\r");
	//xml=CierraXML(xml);
	//Libera al archivo
	//DATA_PROCESO(id,"");
	//DesactivaProceso(id);
}

int TipoFileThread(int id,Tipo_XML *xml)
{
	Tipo_Data *pFile=NULL;
	Tipo_Data *pFile2=NULL;
	Tipo_IpBackoffices *pIp;
	char szInput[MAX_BUFFER];
	char szRuta[600],szPatron[30];
	int sts,nFormatoEntrada,nLenFormato,nFormatoSalida,nFormatoAck;
	Tipo_Formatos *pForEntrada,*pForSalida,*pForAck;
	char szError[200];
	Tipo_XML *xml1=NULL;
	Tipo_XML *xml2=NULL;
	Tipo_XML *xmlserv=NULL;
	Tipo_XML *xmlresp=NULL;
	Tipo_XML *xml12resp=NULL;
	Tipo_XML *xmlfile=NULL;
	Tipo_XML *xmlsal=NULL;
	Tipo_Servicio stServ;
	//Tipo_XML *xml3=NULL;
	char szFile[512];
	char szFile1[512];
	char szData[MAX_BUFFER];
	char szQuerySalida[MAX_BUFFER];
	char szQueryAck[MAX_BUFFER];
	char szQueryIni[MAX_BUFFER];
	char szQueryFinal[MAX_BUFFER];
	//char szQueryInicial[MAX_BUFFER];
	int nTotal,i,nServicio;
	int bStateQuery=0,bState,nTotalRegistros=0;
	int nBaseSalida,nBaseAck,nBaseTmp;
	int nBaseQueryIni,nBaseQueryFinal;
	int nNivelEnt;
	char szIpSalida[30],szPortSalida[30];
	char szIp[30],szPort[30];
	int bFile=0;
	int nServicioQuery=0;
	int nServicioQueryFinal=0;
	int nServicioQueryInicial=0;
	int nLog=LOG(id);

	//printf("Inicia Thread %i\n\r",id);
	//EsperaActivacion(id);

	//Lee la ruta y el patron
	GetIntXML(xml,"SERVICIO_QUERY_INICIAL",&nServicioQueryInicial);
	GetIntXML(xml,"SERVICIO_QUERY_SALIDA",&nServicioQuery);
	GetIntXML(xml,"SERVICIO_QUERY_FINAL",&nServicioQueryFinal);
	GetIntXML(xml,"BASE_QUERY_INICIAL",&nBaseQueryIni);
	GetIntXML(xml,"BASE_QUERY_FINAL",&nBaseQueryFinal);
	GetStrXML(xml,"QUERY_INICIAL",szQueryIni,sizeof(szQueryIni));
	GetStrXML(xml,"QUERY_FINAL",szQueryFinal,sizeof(szQueryFinal));

	GetStrXML(xml,"RUTA_ENTRADA",szRuta,sizeof(szRuta));
	GetStrXML(xml,"PATRON_ENTRADA",szPatron,sizeof(szPatron));
	GetIntXML(xml,"FORMATO_ENTRADA",&nFormatoEntrada);
	GetIntXML(xml,"FORMATO_SALIDA",&nFormatoSalida);
	GetIntXML(xml,"FORMATO_ACK",&nFormatoAck);
	//GetIntXML(xml,"SERVICIO",&nServicio);
	GetStrXML(xml,"IP_SALIDA",szIpSalida,sizeof(szIpSalida));
	GetStrXML(xml,"PORT_SALIDA",szPortSalida,sizeof(szPortSalida));
	GetIntXML(xml,"BASE_QUERY_SALIDA",&nBaseSalida);
	GetStrXML(xml,"QUERY_SALIDA",szQuerySalida,sizeof(szQuerySalida));
	GetIntXML(xml,"BASE_QUERY_ACK",&nBaseAck);
	GetStrXML(xml,"QUERY_ACK",szQueryAck,sizeof(szQueryAck));
	GetStrXML(xml,"FILE_SALIDA",szFile,sizeof(szFile));
	if (strlen(szFile)>0) bFile=1;

	SET_LOG(id,0);
	//GetStrXML(xml,"QUERY_INICIAL",szQueryInicial,sizeof(szQueryInicial));
	pForEntrada = LeeFormato(id,nFormatoEntrada);
	pForSalida = LeeFormato(id,nFormatoSalida);
	pForAck = LeeFormato(id,nFormatoAck);
	SET_LOG(id,nLog);

	if (!pForEntrada)
	{
		SET_LOG(id,1);
		sprintf(szError,"No existe formato %i para archivos tipo %s%s",nFormatoEntrada,szRuta,szPatron);
		printf("%s\n\r",szError);
		WriteLog(id,szError);
		SET_LOG(id,nLog);
		goto quit;
	}
	nLenFormato = LargoFormato(pForEntrada);
	//while(Conexion[id].nEstado==C_EJECUTAR)
	//{

	   if (BuscaArchivosPatron(id,szRuta,szPatron,szFile))
	   {
 	   	printf("Lee Archivo %s\n\r",szFile);

		pFile=LeeArchivo(szFile);
	        //sleep(2);
		if (pFile)
		{
			int nLen,nPos;
			char szSql[MAX_BUFFER];
			nLen=pFile->nLenData;

			if (nServicioQueryInicial>0)
			{
			  int bContesta;
			  char szTmp1[30];
			  sprintf(szTmp1,"Ejecuta Servicio Inicial %i",nServicioQuery);
			  printf("%s\n\r",szTmp1);
			  WriteLog(id,szTmp1);
			  xmlsal=AplicaQuerysServicio(id,xml,nServicioQueryInicial,&bContesta);
			  xmlsal=CierraXML(xmlsal);
			}
			else if ((nBaseQueryIni) && (strlen(szQueryIni)>0))
			{
				ReemplazaTagsStr(xml,szQueryIni,szSql);
				printf("SQL Inicial=%s\n\r",szSql);
				WriteLog(id,szSql);
	   			nBaseTmp=GET_DATABASE(id);
	   			SET_GLOBAL_DATABASE(id,nBaseQueryIni);
		   		SendDatabase(id,szSql);
		   		SET_GLOBAL_DATABASE(id,nBaseTmp);
			}

			printf("Largo Archivo = %i, LenFormato= %i\n\r",nLen,nLenFormato);
			nPos=0;
			//Si el archivo es menro que el formato
			//lo hacemos al menos una vez
			if (nLenFormato>nLen) nLenFormato=nLen;

			while(nLen>=nLenFormato)
			{
			   memcpy(szData,&pFile->data[nPos],nLenFormato);
			   szData[nLenFormato]=0;
			   nPos+=nLenFormato;
			   nLen-=nLenFormato;
			   bState=0;
 	   		   printf("Busca Archivo\n\r");
			   xml1=AplicaFormatoEntrada(id,szData,pForEntrada,strlen(szData));
			   //si esta especificado una lista de querys..
			   if (nServicioQuery>0)
			   {
				  int bContesta;
				  char szTmp1[20];
				  sprintf(szTmp1,"Ejecuta Servicio %i",nServicioQuery);
				  printf("%s\n\r",szTmp1);
				  WriteLog(id,szTmp1);
				  xmlsal=AplicaQuerysServicio(id,xml1,nServicioQuery,&bContesta);
				  nNivelEnt=0;
	   			  nTotalRegistros=0;
	   			  xml2=GetNivelXML(xmlsal,nNivelEnt++);
			   }
			   else if ((nBaseSalida) && (strlen(szQuerySalida)>0))
			   {
				char szSql[MAX_BUFFER];
				ReemplazaTagsStr(xml1,szQuerySalida,szSql);
				printf("SQL Salida=%s\n\r",szSql);
				WriteLog(id,szSql);
	   			nBaseTmp=GET_DATABASE(id);
	   			SET_GLOBAL_DATABASE(id,nBaseSalida);
	   			xmlsal=GetRecords(id,szSql,&nTotal);
	   			SET_GLOBAL_DATABASE(id,nBaseTmp);
				nNivelEnt=0;
	   			nTotalRegistros=0;
	   			xml2=GetNivelXML(xmlsal,nNivelEnt++);
			   }

			   if ((xml2!=NULL) || ((strlen(szIpSalida)>0) && (xml2!=NULL)))
		 	   {
		      		//Por cada registro del query de salida
		      		while(xml2!=NULL)
		      		{
			   	   	//Haga algo..
			   		xmlserv=StrcpyXML(xml1,xml2);
					pFile2=InsertaDataFile(id,pFile2,xmlserv,pForSalida,xml);
					nTotalRegistros++;
					ReemplazaTagsStr(xmlserv,szPortSalida,szPort);
					ReemplazaTagsStr(xmlserv,szIpSalida,szIp);
			 		sprintf(stServ.szIp,"%s",szIp);
			 		stServ.nPort=atoi(szPort);
			 		stServ.nTimeout=10;
					if ((nFormatoAck) && (strlen(szIp)>0))
					{
			        		xmlresp=AutorizaServicioXML(id,xmlserv,pForSalida,pForAck,&stServ);
					}
			 		else if ((nFormatoSalida==0) && (nFormatoAck==0) && (strlen(szIp)>0))
			 		{
						xmlresp=AutorizaServicio1(id,xmlserv,&stServ);
			 		}
					xml12resp=StrcpyXML(xmlresp,xmlserv);
					if (nBaseAck)
					{
	   				   nBaseTmp=GET_DATABASE(id);
	   			 	   SET_GLOBAL_DATABASE(id,nBaseAck);
					   QueryAck(id,xml12resp,szQueryAck);
	   				   SET_GLOBAL_DATABASE(id,nBaseTmp);
					}
					xml12resp=CierraXML(xml12resp);
					xmlresp=CierraXML(xmlresp);
					xmlserv=CierraXML(xmlserv);
					xml2=CierraXML(xml2);
	   				xml2=GetNivelXML(xmlsal,nNivelEnt++);
				}
			   }
			   else 
			   {
				 printf("Autoriza Servicio\n\r");
				 pFile2=InsertaDataFile(id,pFile2,xml1,pForSalida,xml);
				 nTotalRegistros++;
				 xmlfile=StrcpyXML(xml,xml1);
				 ReemplazaTagsStr(xml1,szPortSalida,szPort);
				 ReemplazaTagsStr(xml1,szIpSalida,szIp);
				 sprintf(stServ.szIp,"%s",szIp);
				 stServ.nPort=atoi(szPort);
				 stServ.nTimeout=10;
				 if ((nFormatoAck) && (strlen(szIp)>0))
				 {
			         	xmlresp=AutorizaServicioXML(id,xml1,pForSalida,pForAck,&stServ);
				 }
			 	 else if ((nFormatoSalida==0) && (nFormatoAck==0) && (strlen(szIp)>0))
			 	 {
					xmlresp=AutorizaServicio1(id,xmlserv,&stServ);
			 	 }
				xml12resp=StrcpyXML(xmlresp,xmlserv);
				if (nBaseAck)
				{
	   			   nBaseTmp=GET_DATABASE(id);
	   		 	   SET_GLOBAL_DATABASE(id,nBaseAck);
				   QueryAck(id,xml12resp,szQueryAck);
	   			   SET_GLOBAL_DATABASE(id,nBaseTmp);
				}
				xml12resp=CierraXML(xml12resp);
				xmlresp=CierraXML(xmlresp);
				xmlserv=CierraXML(xmlserv);
				xml2=CierraXML(xml2);
	   			xml2=GetNivelXML(xmlsal,nNivelEnt++);
			   }

			   //Borra el archivo
		 	   SetValorIntXML(xmlfile,"TOTAL_REGISTROS",nTotalRegistros); 
		 	   pFile2=CierraDataFile(id,xmlfile,pFile2);
			   xmlfile=CierraXML(xmlfile);
			   xml1=CierraXML(xml1);
			   xmlsal=CierraXML(xmlsal);
			} //fin while
			
			
		 	//Query final	
			if ((nBaseQueryFinal) && (strlen(szQueryFinal)>0))
			{
				ReemplazaTagsStr(xml,szQueryFinal,szSql);
				printf("SQL Final=%s\n\r",szSql);
				WriteLog(id,szSql);
	   			nBaseTmp=GET_DATABASE(id);
	   			SET_GLOBAL_DATABASE(id,nBaseQueryFinal);
		   		SendDatabase(id,szSql);
		   		SET_GLOBAL_DATABASE(id,nBaseTmp);
			}
			   
			//si esta especificado una lista de querys..
			if (nServicioQueryFinal>0)
			{
			  int bContesta;
			  char szTmp1[20];
			  Tipo_XML *xml55;
			  sprintf(szTmp1,"Ejecuta Servicio %i",nServicioQuery);
			  printf("%s\n\r",szTmp1);
			  WriteLog(id,szTmp1);
			  xml55=AplicaQuerysServicio(id,xml,nServicioQueryFinal,&bContesta);
			  xml55=CierraXML(xml55);
			  nNivelEnt=0;
	   		  nTotalRegistros=0;
			}
			printf("Borra Archivo\n\r");
			//if (remove(szFile)<0)
			sprintf(szFile1,"%s_OK",szFile);
			if (rename(szFile,szFile1))
			{
				sleep(1);
				sprintf(szError,"Falla Mover archivo %s\n\r",szFile);
				printf("%s\n\r",szError);
				WriteLog(id,szError);
			}
			
		}
		else
		{
			printf("Falla Abrir Archivo\n\r");
			WriteLog(id,"Falla Abrir Archivo");
		}
		//Cierra el buffer de archivo
		if (pFile) LiberaData(pFile);
	   }
	   //usleep(100);
	//}
	return 1;
quit:
	return 0;
	//xml=CierraXML(xml);
	//Libera al archivo
	//DATA_PROCESO(id,"");
	//DesactivaProceso(id);
}
		      
