#include <stdio.h>
#include <stdlib.h>
#include<sys/types.h>
#include <sys/stat.h>
#include<dirent.h>
#include <xml.h>
#include <sys/socket.h>

#define CERTF "./certificado.pem"
#define KEYF "./iswitch.pem"

/*Inicializa Contexto para el cliente*/
int InitSSLCliente(id)
{
#ifdef _ISYS_SSL_
	SSL_METHOD *meth;

	SSLeay_add_ssl_algorithms();
    	meth = SSLv2_client_method();
      	SSL_load_error_strings();
        global.ssl_ctxv2 = SSL_CTX_new(meth);
	if (global.ssl_ctxv2==NULL)
	{
		WriteLog(id,"Falla Crear Contexto para metodo SSLv2_client_method");
		return 0;
	}	
#endif
	return 1;
}

int InitSSL()
{
#ifdef _ISYS_SSL_
	SSL_METHOD *meth;

	SSL_load_error_strings();
	SSLeay_add_ssl_algorithms();
	meth = SSLv23_server_method();
	global.ssl_ctx = SSL_CTX_new (meth);
	if (!global.ssl_ctx) 
	{
            WriteLog(0,"Falla SSL_CTX_new");
	    ERR_print_errors_fp(stderr);
            exit(2);
        }

	SSL_CTX_set_default_passwd_cb_userdata(global.ssl_ctx,"qwerty..2103");

	if (SSL_CTX_use_certificate_file(global.ssl_ctx,CERTF,SSL_FILETYPE_PEM) <= 0) 
	{
              WriteLog(0,"Falla SSL_CTX_use_certificate_file");
              WriteLog(0,CERTF);
	      ERR_print_errors_fp(stderr);
              exit(3);
        }
        if (SSL_CTX_use_PrivateKey_file(global.ssl_ctx,KEYF,SSL_FILETYPE_PEM) <= 0) 
	{
              WriteLog(0,"Falla SSL_CTX_use_PrivateKey_file");
              WriteLog(0,KEYF);
              ERR_print_errors_fp(stderr);
	      exit(4);
      }

      if (!SSL_CTX_check_private_key(global.ssl_ctx)) 
      {

	      WriteLog(0,"Falla Comparacion de Llave Publica y Privada");
	      fprintf(stderr,"Private key does not match the certificate public key\n");
	      exit(5);
      }
#endif
}

int ProcesaTransaccion(int id,int nPosLlave,char szData[],int nTipoXml,int nLenData)
{
	Tipo_XML *xml=NULL;
	//Tipo_XML *xml1=NULL;
	//Tipo_XML *xmlin=NULL;
	//Tipo_XML *xml2=NULL;
	Tipo_XML *xmlllave=stTablaTxForm.xml;
	Tipo_Formatos *pForOk,*pForNk;
	int nSocket=Conexion[id].nSocket;

	int sts;
	char szSql[1024];
	char szTmp[200];
	char szError[1024];
	char szResp[MAX_BUFFER];
	int nFor,nDataWeb;
	char szTag[100];
	Tipo_Servicio stServ;
	char szRutaPagina[512];
	int nSalidaXml=1;
	Tipo_Data *pFileIn=NULL;


	
	GetNivelIntXML(xmlllave,"SALIDA_XML",&nSalidaXml,nPosLlave);
	GetNivelStrXML(xmlllave,"TAG_PAGINA_RESPUESTA",szTag,sizeof(szTag),nPosLlave);
	memset(szResp,0,sizeof(szResp));
	if (strlen(szTag)>0) 
	{
		WriteLog(id,"PAGINA RESP");
		WriteLog(id,szTag);
		if (!BuscaPagina(id,szTag,szRutaPagina))
		{	
	    		sprintf(szError,"Lo sentimos, no se encuentra registrada la pagina [%s] en la tabla",szTag);
	    		WriteLog(id,szError);
			goto error;
		}
	        pFileIn=LeeArchivo(szRutaPagina);
		WriteLog(id,"Lee Archivo");

	}
	//Si es data web, la convierte a texto 
	GetNivelIntXML(xmlllave,"DATA_WEB",&nDataWeb,nPosLlave);
	if (nDataWeb) 
	{
		printf("Converite Caracteres Web\n\r");
		ConvierteCaracteresWeb(szData);
	}

			
	WriteLog(id,"(TMP)Busca Servicio");
	GetNivelIntXML(xmlllave,"SERVICIO",&stServ.nTx,nPosLlave);
	if (!BuscaServicio(id,&stServ,BUSCA_TX))
	{
		sprintf(szError,"Lo sentimos, el servicio [%i] no esta registrado en la tabla servicios.",stServ.nTx);
		WriteLog(id,szError);
		goto error;
	}

	//FAY Si tiene el servicio activado escribe_file, entonces graba a file
	if (memcmp(stServ.szEscribeFile,"SI",2)==0)
	{
		FILE *f;
		struct timeb sTimeb;
        	struct tm thoy;
		char szFile1[2048];
		char szFile2[2048];
		//Tipo_Data *pFile=NULL;
		Tipo_Data *pDataRespuesta=NULL;
		Tipo_Data *pDataHeader=NULL;
		Tipo_Data *pSql=NULL;
		char *pDataHex;
		Tipo_Data *pSqlResp=NULL;
		struct stat buf_stat;
		int i;
		char daybuf[100];

		ftime(&sTimeb);
		localtime_r(&sTimeb.time,&thoy);

		strftime(daybuf, sizeof(daybuf), "%a, %d %b %Y %H:%M:%S %Z", &thoy);
		
		sprintf(szTmp,"%i",stServ.nTx);
		xml=InsertaDataXML(xml,"TX",szTmp);
		xml=InsertaDataXML(xml,"_PROC_LISTENER_",global.szProceso);
		xml=InsertaDataXML(xml,"DATE_WEB",daybuf);
		Conexion[id].nCorrelativo++;
		if (Conexion[id].nCorrelativo>global.nTotalTablasEscritura) 
			Conexion[id].nCorrelativo=1;
		sprintf(szTmp,"%i",Conexion[id].nCorrelativo);
		xml=InsertaDataXML(xml,"ID",szTmp);
		//Ingresa la fecha
		sprintf(szTmp,"%04i",thoy.tm_year+1900);
		xml=InsertaDataXML(xml,"ANO",szTmp);	
		sprintf(szTmp,"%02i",thoy.tm_mon+1);
		xml=InsertaDataXML(xml,"MES",szTmp);	
		sprintf(szTmp,"%02d",thoy.tm_mday);
		xml=InsertaDataXML(xml,"DIA",szTmp);	
		sprintf(szTmp,"%02i",thoy.tm_hour);
		xml=InsertaDataXML(xml,"HORA",szTmp);	
		sprintf(szTmp,"%02i",thoy.tm_min);
		xml=InsertaDataXML(xml,"MINUTO",szTmp);	
		sprintf(szTmp,"%02i",thoy.tm_sec);
		xml=InsertaDataXML(xml,"SEGUNDO",szTmp);	
		//pFile=ReemplazaTagsStr1(xml,stServ.szRutaFile);		


	 	/*
			
		//Verifico si existe el direcotrio
		stat(pFile->data,&buf_stat);
		//Si no es un directorio
		if ((buf_stat.st_mode & S_IFDIR ) == 0 )
		{
			FILE *fp;
			WriteLog(id,"No existe el directorio");
			WriteLog(id,pFile->data);
			WriteLog(id,"Se crea el directorio");
			sprintf(szResp,"mkdir %s",pFile->data);
			fp = popen(szResp, "r");
			if (fp == NULL)
			{
				WriteLog(id,"Falla Ejecutar Comando");
			}
			else
			{
				pclose(fp);
			}
			stat(pFile->data,&buf_stat);
			//Verifico si esta creado
			if ((buf_stat.st_mode & S_IFDIR ) == 0 )
			{
				WriteLog(id,"Falla Creacion del Directorio");
				xml=CierraXML(xml);
				return 1;
			}
		}
		sprintf(szFile1,"%s/%04i%02i%02i_%02i%02i%02i%03i_%02i.tmp",pFile->data,thoy.tm_year,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id);
		sprintf(szFile2,"%s/%04i%02i%02i_%02i%02i%02i%03i_%02i.file",pFile->data,thoy.tm_year,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id);

		pFile=LiberaData(pFile);
		//Escribo el archivo
		f=fopen(szFile1,"w+");
		if (f)
		{
			//fprintf(f,"%s",szData);
			fwrite(szData , 1 , nLenData , f );
			fflush(f);
			fclose(f);
			
			//Cambia el nombre del archivo
			if (rename(szFile1,szFile2)!=0)
			{
			}
		}
		else
		{
			WriteLog(id,"Falla Escribir Archivo");
			WriteLog(id,szFile1);
			xml=CierraXML(xml);
			return 1;
		}
		//Envio XML al servicio
		if (global.getip) 
		{
			sprintf(szError,"IP = %s",Conexion[id].szIp);
			WriteLog(id,szError);
			xml=InsertaDataXML(xml,"_IP_CONEXION_",Conexion[id].szIp);
		}

		*/

		//Graba en Base de Datos

		//Se pasa a HEX
		pDataHex=(char *)malloc((nLenData*2)+1);
		memset(pDataHex,0,(nLenData*2)+1);
		writenhex(szData,pDataHex,nLenData);

		sprintf(szTmp,"select sp_inserta_data(%i,'",Conexion[id].nCorrelativo);
		pSql=InsertaData(szTmp,pSql);
		pSql=InsertaDataLen(pDataHex,nLenData*2,pSql);
		pSql=InsertaData("');",pSql);
		WriteLog(id,pSql->data);
		free(pDataHex);
#ifdef FLAG_POSTGRES
		pSqlResp=GetOneRecordAsinc1(id,pSql->data,pSqlResp,0);
		if (pSqlResp==NULL) 
		{
			WriteLog(id,"Falla Ejecutar SQL");
			pSql=LiberaData(pSql);
			return 1;
		}
		pSql=LiberaData(pSql);
		pSqlResp=LiberaData(pSqlResp);
#endif


		//Parseo el input como XML para obtener algunos datos desde la data entrante
		xml=ProcesaInputXML2(xml,szData);

	
		//Parseo para aplicac
		//xml=ProcesaInputXML2(xml,"<Log><Process id='aml' version='1.0'><item name='custodium-uri'>http://pruebasacepta1303.acepta.com/v01/3d5817bca2fa3cb4504b25a6a6268a9212968deb?k=87081943ef654e32b1c56b9ceb8a2690</item></Process></Log>");
		//ImprimeXML1(xml,id);

		WriteLog(id,"(TMP)Va por EscribeFile");
		sprintf(szResp,"%c%c",13,10);
		//Verifico el separado si es chr(10) o chr(13)||chr(10) en la primera linea entrante
		for (i=0;i<strlen(szData);i++)
		{
			if (szData[i]==13 && szData[i+1]==10) 
			{
				WriteLog(id,"Separador chr(13)||chr(10)");
				xml=InsertaDataXML(xml,"SEP",szResp);
				break;
			}
			if (szData[i]==10)
			{
				WriteLog(id,"Separador chr(10)");
				sprintf(szResp,"%c",10);
				xml=InsertaDataXML(xml,"SEP",szResp);
				break;
			}
		}

		pDataRespuesta=ReemplazaTagsStr1(xml,stServ.szDataRespuesta);
		//Aplico Funciones para agregar otros datos al xml
		pDataRespuesta=AplicaFuncionesData(pDataRespuesta,szData);
		//WriteLog(id,pDataRespuesta->data);
		//Saco el largo de la respuesta
		sprintf(szResp,"%i",strlen(pDataRespuesta->data));
		xml=InsertaDataXML(xml,"LARGO_RESPUESTA",szResp);
		pDataHeader=ReemplazaTagsStr1(xml,stServ.szDataHeader);
		pDataHeader=AplicaFuncionesData(pDataHeader,szData);
		//WriteLog(id,pDataHeader->data);
			
		//Contesta valor por defecto
		sprintf(szResp,"%s%s",pDataHeader->data,pDataRespuesta->data);
		//WriteLog(id,szResp);
		WriteData(id,szResp,strlen(szResp));
		send(nSocket,szResp,strlen(szResp),MSG_NOSIGNAL );
		pDataHeader=LiberaData(pDataHeader);
		pDataRespuesta=LiberaData(pDataRespuesta);
		xml=CierraXML(xml);
		return 1;
	}
	else
        {
		//Empieza a procesa la tx.
		printf("DATA ENTRANTE %i =%s\n\r",nTipoXml,szData);
		sprintf(szError,"DATA ENTRANTE %i\n\r",nTipoXml);
		WriteLog(id,szError);
		//WriteLog(id,szData);
		//Truquito momentaneo...
		/*
		if (nSalidaXml==2) xml=TransformaDataEntranteNivel1(id,xmlllave,szData,nPosLlave,nLenData);
		else if (nTipoXml==0) xml=TransformaDataEntranteNivel(id,xmlllave,szData,nPosLlave);
		//El tipo 3 solo inserta la data
		else if (nTipoXml==3) xml=InsertaDataLenXML(xml,"INPUT",szData,nLenData);
		else xml=TransformaDataEntranteNivelXML(id,xmlllave,xml,nPosLlave);
		*/
		xml=InsertaDataLenXML(xml,"INPUT",szData,nLenData);

		GetNivelIntXML(xmlllave,"FORMATO_RESPUESTA_OK",&nFor,nPosLlave);
		printf("Lee Formato Salida %i\n\r",nFor);
		WriteLog(id,"(TMP)Lee Formato Salida");
		pForOk=LeeFormato(id,nFor);
		if (nSalidaXml)
		{
			sprintf(szTmp,"%i",stServ.nTx);
			xml=InsertaDataXML(xml,"TX",szTmp);
			xml=InsertaDataXML(xml,"_PROC_LISTENER_",global.szProceso);
			if (global.getip) 
			{
				sprintf(szError,"IP = %s",Conexion[id].szIp);
				WriteLog(id,szError);
				xml=InsertaDataXML(xml,"_IP_CONEXION_",Conexion[id].szIp);
			}
	
			WriteLog(id,"(TMP)Va por AutorizaServicio1");
			xml=AutorizaServicio1(id,xml,&stServ,&sts);
			if (!sts) 
			{
				sprintf(szError,"Falla Servicio %i a %s:%i",stServ.nTx,stServ.szIp,stServ.nPort);
				WriteLog(id,szError);
				goto error;
			}
			GetStrXML(xml,"STATUS",szTmp,sizeof(szTmp));
			if (memcmp(szTmp,"OK",2)) 
			{
				WriteLog(id,"Falla no viene OK");
				goto error;
			}
		}
		else
		{
			Tipo_Formatos *pForTexto;
			int nF1;
			GetNivelIntXML(xmlllave,"FORMATO_SALIDA_TEXTO",&nF1,nPosLlave);
			printf("Lee Formato Salida %i\n\r",nF1);
			pForTexto=LeeFormato(id,nF1);
			if (global.getip) 
			{
				sprintf(szError,"IP = %s",Conexion[id].szIp);
				WriteLog(id,szError);
				xml=InsertaDataXML(xml,"_IP_CONEXION_",Conexion[id].szIp);
			}
			WriteLog(id,"(TMP)Va por AutorizaServicioXML");
			xml=AutorizaServicioXML(id,xml,pForTexto,pForOk,&stServ,&sts);
			if (!sts) 
			{
				sprintf(szError,"Falla Servicio2 %i a %s:%i",stServ.nTx,stServ.szIp,stServ.nPort);
				WriteLog(id,szError);
				goto error;
			}
		}
	}
	
	//si no ha especificado un archivo de salida...
	if (pFileIn==NULL)
	{
		char szPag1[300];
		//verificamos si viene una pagina de respuesta
		GetStrXML(xml,"PAGINA",szPag1,sizeof(szPag1));
		if (strlen(szPag1)>0) 
		{
			WriteLog(id,"PAGINA1 RESP");
			WriteLog(id,szPag1);
			if (BuscaPagina(id,szPag1,szRutaPagina))
			{	
	        		pFileIn=LeeArchivo(szRutaPagina);
				WriteLog(id,"Lee Archivo1");
			}
			else WriteLog(id,"Pagina no encontrada");
		}
	}
		
        if (pFileIn)
        {
		printf("Len Entrada1 %i\n\r",strlen(szResp));
		xml=AplicaFormatoEntrada(id,xml,szResp,pForOk,strlen(szResp));
		//xml1=StrcatXML(xml1,xml2);
		pFileIn=ReemplazaTags(pFileIn,xml,"@@");
		pFileIn=BorraTags(pFileIn,"@@");
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,pFileIn->data,pFileIn->nLenData);
#endif
		}
			
		else EnviaData(pFileIn,nSocket);
		printf("Archivo Enviado Ok\n\r");
		WriteLog(id,"Archivo Ok");
		WriteLog(id,pFileIn->data);
		pFileIn=LiberaData(pFileIn);
	}
	else
	{
		int nLenResp;
		WriteLog(id,"(TMP)AplicaFormatoSalida");
		AplicaFormatoSalida(id,szResp,xml,pForOk,&nLenResp);
		WriteData(id,szResp,nLenResp);
		//printf("RESPONDE (%i)= %s\n\r",nLenResp,szResp);
		WriteLog(id,"(TMP)SEND");
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szResp,nLenResp);
#endif
		}
		else send(nSocket,szResp,nLenResp,MSG_NOSIGNAL );
	}

	//xml1=CierraXML(xml1);
	xml=CierraXML(xml);
	WriteLog(id,"(TMP)return");
	return 1;
error:
	GetNivelIntXML(xmlllave,"FORMATO_RESPUESTA_NK",&nFor,nPosLlave);
	printf("Lee Formato Salida Error %i\n\r",nFor);
	pForNk=LeeFormato(id,nFor);
        if (pFileIn)
        {
		xml=AplicaFormatoEntrada(id,xml,szResp,pForNk,strlen(szResp));
		//xml1=StrcatXML(xml1,xml2);
		pFileIn=ReemplazaTags(pFileIn,xml,"@@");
		pFileIn=BorraTags(pFileIn,"@@");
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,pFileIn->data,pFileIn->nLenData);
#endif
		}
		else EnviaData(pFileIn,nSocket);
		pFileIn=LiberaData(pFileIn);
		WriteLog(id,"Archivo con Error");
	}
	if (global.SSL)
	{	
#ifdef _ISYS_SSL_
		SSL_write(Conexion[id].ssl,szResp,strlen(szResp));
#endif
	}
	else send(nSocket,szResp,strlen(szResp),MSG_NOSIGNAL );
	//xml1=CierraXML(xml1);
	xml=CierraXML(xml);
	return 1;
}



int DoFunctionPost(int id,int socket,char szUrl[],Tipo_XML *xml1)

{
	char szIp[30];
	int nPort;
	char szPagina[100];
	char response[1024];
	char szAux[MAX_BUFFER];
	char szRutaPagina[512];
	Tipo_Socket stSocketServicio;
	Tipo_Data *pFileIn=NULL;
	int bNext,lenData,nTimeout;
	Tipo_Servicio stServ;
	Tipo_XML *xml=NULL;
	char szError[2048];
	char szPaqueteXML[MAX_BUFFER];
	int sts;

	printf("Entra a DoFunctionPost\n\r");

	//ImprimeXML(xml1);
	stServ.nTx=0;
	if (GetIntXML(xml1,"TX",&stServ.nTx))
	{
	   if (!BuscaServicio(id,&stServ,BUSCA_TX))
	   {
		sprintf(szError,"Lo sentimos, el servicio [%i] no esta registrado en la tabla servicios.",stServ.nTx);
		WriteLog(id,szError);
		SendHeaderHTTP(id,socket);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szError,strlen(szError));
#endif
		}
		else send(socket,szError,strlen(szError),MSG_NOSIGNAL );
		return 0;
	   }
	}
	//Si no esta registrada la tx, se busca por URL
	else if (strlen(szUrl)>0)
	{ 
	   char szTmp[10];
	   sprintf(stServ.szUrl,"%s",szUrl);
	   if (!BuscaServicio(id,&stServ,BUSCA_URL))
	   {
		sprintf(szError,"Lo sentimos, el url [%s] no esta registrado en la tabla servicios.",szUrl);
		WriteLog(id,szError);
		SendHeaderHTTP(id,socket);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szError,strlen(szError));
#endif
		}
		else send(socket,szError,strlen(szError),MSG_NOSIGNAL );
		return 0;
	   }
	   sprintf(szTmp,"%i",stServ.nTx);
	   xml1=InsertaDataXML(xml1,"TX",szTmp);
	   if (global.getip) xml1=InsertaDataXML(xml1,"_IP_CONEXION_",Conexion[id].szIp);

	}
	else  
	{
		char szComando[100];
		sprintf(szComando,"MASTER");
		WriteLog(id,"MASTER");
		return RetornaPagina(id,szComando,socket);
	}

	sprintf(szIp,"%s",stServ.szIp);
	nPort=stServ.nPort;

	//Si no tiene asignado ip ni port..., devolvemos la pagina
	if ((strlen(szIp)==0) && (nPort==0))
		return RetornaPagina(id,stServ.szPagina,socket);

	sprintf(szError,"SERVICIO=%i, URL=%s Conectando %s:%i",stServ.nTx,szUrl,szIp,nPort);
	WriteLog(id,szError);
	InicializaSocket(&stSocketServicio,"Socket Servicio");
	if (!ConectaCliente(id,nPort,szIp,&stSocketServicio))
	{
		sprintf(szError,"Lo sentimos, no se puede conectar al servicio [%i %s](servicio no activado)",stServ.nTx,szUrl);
		WriteLog(id,szError);
		ErrorXML1(response,szError);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,response,strlen(response));
#endif
		}
		else send(socket,response,strlen(response),MSG_NOSIGNAL );
		return 0;
	}

	//Envia Data al Servicio.
	if (SendSocketXML1(id,stSocketServicio.m_socket,xml1)<0)
	{
		sprintf(szError,"Lo sentimos, No es posible enviar datos al servicio [%i %s]",stServ.nTx,szUrl);
		WriteLog(id,szError);
		ErrorXML1(response,szError);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,response,strlen(response));
#endif
		}
		else send(socket,response,strlen(response),MSG_NOSIGNAL );
		return 0;
	}

	bNext=0;
	nTimeout=stServ.nTimeout;
	do
	{
	//memset(szPaqueteXML,0,sizeof(szPaqueteXML));
	//Espera la Respuesta
	printf("Esperando Respuesta...\n\r");
	//if (LeePaquete(id,stSocketServicio.m_socket,szPaqueteXML,sizeof(szPaqueteXML),nTimeout)<0)
	xml=LeePaqueteXML(id,stSocketServicio.m_socket,nTimeout,xml,&sts);
	if (!sts)
	{
		sprintf(szError,"Lo sentimos, el Servicio [%i %s] no responde t(%i)",stServ.nTx,szUrl,nTimeout);
		ErrorXML1(response,szError);
		SendHeaderHTTP(id,socket);
		if (global.SSL)
		{	
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,response,strlen(response));
#endif
		}
		else send(socket,response,strlen(response),MSG_NOSIGNAL );
		WriteLog(id,szError);
		goto fin;
	}

	//printf("Respuesta Servicio: %s\n\r",szPaqueteXML);

	//Procesamos la respuesta del servicio..
	//xml=ProcesaInputXML1(szPaqueteXML);
	//Indica si viene otro paquete..
	if (GetStrXML(xml,"NEXT",szAux,sizeof(szAux))) bNext=1;
	else bNext=0;
	if (GetStrXML(xml,"TIMEOUT",szAux,sizeof(szAux)))
	{
		nTimeout=atoi(szAux);
	}	
	if (!GetStrXML(xml,"STATUS",szAux,sizeof(szAux)))
	{
		sprintf(szError,"Error en respuesta de Servicio, no viene STATUS(3)");
		WriteLog(id,szError);
		SendHeaderHTTP(id,socket);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szError,strlen(szError));
#endif
		}
		else send(socket,szError,strlen(szError),MSG_NOSIGNAL );
		goto error;
	}

	if (memcmp(szAux,"ERROR",2)==0)
	{
		if (GetStrXML(xml,"ERROR",szError,sizeof(szError))>0)
		WriteLog(id,szError);
		SendHeaderHTTP(id,socket);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szError,strlen(szError));
#endif
		}
		else send(socket,szError,strlen(szError),MSG_NOSIGNAL );
		goto error;
	}
	else if (memcmp(szAux,"OK",2)!=0)
	{
		sprintf(szError,"Error en Servicio, no viene STATUS con %s",szAux);
		WriteLog(id,szError);
		SendHeaderHTTP(id,socket);
		if (global.SSL)
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szError,strlen(szError));
#endif
		}
		else send(socket,szError,strlen(szError),MSG_NOSIGNAL );
		goto error;
	}
	
	//Verificamos si viene una pagina...	
	if (GetStrXML(xml,"PAGINA",szPagina,sizeof(szPagina))>0)
	{
		if (!BuscaPagina(id,szPagina,szRutaPagina))
		{
			sprintf(szError,"Lo sentimos, no se encuentra registrada la pagina [%s] en la tabla",szPagina);
			WriteLog(id,szError);
			SendHeaderHTTP(id,socket);
			if (global.SSL) 
			{
#ifdef _ISYS_SSL_
				SSL_write(Conexion[id].ssl,szError,strlen(szError));
#endif
			}
			else send(socket,szError,strlen(szError),MSG_NOSIGNAL );
			goto error;
		}

		pFileIn=LiberaData(pFileIn);
		printf("Lee Archivo = %s\n\r",szRutaPagina);
		pFileIn=LeeArchivo(szRutaPagina);
		if (pFileIn==NULL)
		{
			 sprintf(szError,"Falla Abrir Archivo = %s\n\r",szPagina);
			 WriteLog(id,szError);
			 sprintf(szError,"Lo sentimos, la pagina no existe en el servidor.");
			 SendSocket(id,socket,szError,strlen(szError));
			 goto error;
                }
		pFileIn=ReemplazaTags(pFileIn,xml,"@@");
		//return EnviaPagina(szRutaPagina,socket);
	}
	else if (GetStrXML(xml,"HTML",szAux,sizeof(szAux))>0)
	{
		SendHeaderHTTP(id,socket);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szAux,strlen(szAux));
#endif
		}
		else send(socket,szAux,strlen(szAux),MSG_NOSIGNAL );
	}
	//Si hay un archivo para enviar..
	else if (pFileIn)
	{
		pFileIn=ReemplazaTags(pFileIn,xml,"@@");
	}
	//Si no viene pagina respondemos en forma literal..
	else
	{
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szPaqueteXML,strlen(szPaqueteXML));
#endif
		}
		else send(socket,szPaqueteXML,strlen(szPaqueteXML),MSG_NOSIGNAL );
	}
	xml=CierraXML(xml);
	}while(bNext);
fin:
	
	SET_TIME_EST(ENVIA_RESPUESTA);
	SET_TIME_EST(LLEGA_CONFIRMACION);
	if (pFileIn) 
	{
		pFileIn=BorraTags(pFileIn,"@@");
		printf("Envia Archivo..\n\r");
		SendHeaderHTTP(id,socket);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,pFileIn->data,pFileIn->nLenData);
#endif
		}
		else EnviaData(pFileIn,socket);
		pFileIn=LiberaData(pFileIn);
		printf("Libera FileIn\n\r");
	}
	
	//GrabaEstadistica(id,stServ.nTx,szUrl);
	CierraSocket(&stSocketServicio);
	//xml=CierraXML(xml);
	printf("Cierra Socket\n\r");
	nTimeout=10;
	return 1;

error:
	CierraSocket(&stSocketServicio);
	xml=CierraXML(xml);
	printf("Cierra Socket\n\r");
	nTimeout=10;
	return 0;
}


int BuscaLlaves(int id,char szData[],int *nLenDataOri)
{
	Tipo_Tabla_XML *p;
	int i;
	int j;
	int nPosLlave1,nPosLlave2,nLenLlave1,nLenLlave2;
	int nLenLlave;
	int nHttp,nTotal;
	char szLlave[200],szLlaveBD[200];
	char szLlaveAuxBD[200],szLlaveHex[500];
	char szTipoLlave[30];
	int nLenData=*nLenDataOri;
	char szDescr[120];
	char szTmp[4096];
	p=&stTablaTxForm;

	//WriteData(id,szData,nLenData);
	for(i=0;i<p->nTotal;i++)
	{
		printf("i=%i Total=%i\n",i,p->nTotal);
       		GetNivelIntXML(p->xml,"POSICION_LLAVE1",&nPosLlave1,i);
       		GetNivelIntXML(p->xml,"LARGO_LLAVE1",&nLenLlave1,i);
       		GetNivelIntXML(p->xml,"POSICION_LLAVE2",&nPosLlave2,i);
       		GetNivelIntXML(p->xml,"LARGO_LLAVE2",&nLenLlave2,i);
		//sprintf(szTmp,"POSICION_LLAVE1=%i LARGO_LLAVE1=%i POSICION_LLAVE2=%i LARGO_LLAVE2=%i",nPosLlave1,nLenLlave1,nPosLlave2,nLenLlave2);
		//WriteLog(id,szTmp);
	        if (nPosLlave1>nPosLlave2) nTotal=nPosLlave1+nLenLlave1;
	        else nTotal=nPosLlave2+nLenLlave2;
	        if (nLenData<nTotal)
	        {
		      printf("LArgo de llave mayor a leido leidos=%i len_llave=%i\n\r",nLenData,nTotal);
		      WriteLog(id,"Largo de llave mayor a leidos");
	        }
	        else
	        {
		   	int nPos;
		      //WriteLog(id,"POaso 1");
			memset(szLlave,0,sizeof(szLlave));
		//sprintf(szTmp,"POSICION_LLAVE1=%i LARGO_LLAVE1=%i POSICION_LLAVE2=%i LARGO_LLAVE2=%i",nPosLlave1,nLenLlave1,nPosLlave2,nLenLlave2);
		//WriteLog(id,szTmp);
	      		memcpy(szLlave,&szData[nPosLlave1],nLenLlave1);
			//WriteData(id,szLlave,nLenLlave1);
			//WriteData(id,&szData[nPosLlave1],nLenLlave1);
			//WriteData(id,szData,10);


			memcpy(&szLlave[nLenLlave1],&szData[nPosLlave2],nLenLlave2);
			//WriteData(id,&szLlave[nLenLlave1],nLenLlave2);
			nLenLlave=nLenLlave1+nLenLlave2;
	      		szLlave[nLenLlave]=0;
			//WriteData(id,szLlave,nLenLlave);
		        //WriteLog(id,szLlave);
			memset(szTipoLlave,0,sizeof(szTipoLlave));
       			GetNivelStrXML(p->xml,"TIPO_LLAVE",szTipoLlave,sizeof(szTipoLlave),i);
       			GetNivelStrXML(p->xml,"LLAVE",szLlaveAuxBD,sizeof(szLlaveAuxBD),i);
       			GetNivelStrXML(p->xml,"DESCRIPCION",szDescr,sizeof(szDescr),i);
			printf("Tipo_Llave=%s Llave=%s Descripcion=%s\n",szTipoLlave,szLlaveAuxBD,szDescr);
		        //WriteLog(id,szTipoLlave);
		        WriteLog(id,szDescr);
			//si es XML el input
			if (memcmp(szTipoLlave,"XML",3)==0)
			{
				char *ini=NULL;
				char szDataHex[MAX_BUFFER];
				char szDataTmp[MAX_BUFFER];
				//En LLAVE viene tag que debo buscar...
				//<TX>1</TX>
				
				//FAY 20-09-2012Cambio el buffer original por uno termporal para no tocar el original
				memcpy(szDataTmp,szData,nLenData);
				szDataTmp[nLenData]=0;
				//Si hay algun dato en 00 lo limpiamos
				/*
                                for (j=0;j<nLenData;j++)
                                {
                                         if (szDataTmp[j]==0)
                                         {
                                                 szDataTmp[j]=0x20;
                                         }
                                }
				*/
		        	//WriteLog(id,"Llave XML");
				writenhex(szDataTmp,szDataHex,nLenData);
				writenhex(szLlaveAuxBD,szLlaveHex,strlen(szLlaveAuxBD));
				ini=strstr(szDataHex,szLlaveHex);
				//Fallaba cuando venia un dato en 0
				//ini=strstr(szData,szLlaveAuxBD);
				if (ini!=NULL)
				{
				   printf("Transaccion Encontrada %s %i\n\r",szLlaveAuxBD,i);
				   WriteLog(id,szDescr);
				   WriteLog(id,szLlaveAuxBD);
				   SET_TX(id,szDescr);
				   return i;
				}
			}
			else if (memcmp(szTipoLlave,"HEX",3)==0)
			{
				char szDataHex[MAX_BUFFER];
		        	//WriteLog(id,"Llave HEX");
				writenhex(szData,szDataHex,nLenData);
				printf("DATA HEX=%s\n\r",szDataHex);
				writenhex(szLlave,szLlaveHex,nLenLlave);
			        sprintf(szTmp,"LLAVEHEX = %s LlaveHEXBD=%s\n\r",szLlaveHex,szLlaveAuxBD);
				WriteLog(id,szTmp);
			        //si corresponde a la llave buscada...
			        if ((strlen(szLlaveAuxBD)==strlen(szLlaveHex)) &&
			        (memcmp(szLlaveAuxBD,szLlaveHex,strlen(szLlaveHex))==0))
			        {
				   printf("Transaccion Encontrada %s %i\n\r",szLlaveHex,i);
				   writenhex(szData,szDataHex,nLenData);
				   memcpy(szData,szDataHex,strlen(szDataHex));
				   szData[strlen(szDataHex)]=0;
				   
				   //Asignamos nuevo largo como si leyera HEX
				   *nLenDataOri=strlen(szData);

				   //printf("DATA HEX=%s\n\r",szDataHex);
				   WriteLog(id,szDescr);
				   WriteLog(id,szLlaveBD);
				   SET_TX(id,szDescr);
				   return i;
				}
			}
			else
			{
		       	   //WriteLog(id,"Llave .");
			   sprintf(szLlaveBD,"%s",szLlaveAuxBD);
			   //WriteData(id,szLlave,nLenLlave);
			   //WriteData(id,szLlaveBD,strlen(szLlaveBD));

			   printf("LLAVE = %s LlaveBD=%s\n\r",szLlave,szLlaveBD);
			   //si corresponde a la llave buscada...
			   if ((strlen(szLlaveBD)==nLenLlave) &&
			    (memcmp(szLlaveBD,szLlave,strlen(szLlaveBD))==0))
			   {
				printf("Transaccion Encontrada %s %i\n\r",szLlave,i);
				WriteLog(id,szDescr);
				WriteLog(id,szLlaveBD);
				SET_TX(id,szDescr);
				return i;
			   }
			}
	        }
	}
	printf("Transaccion no registrada\n\r");
	WriteLog(id,"Tx no registrada");
	return -1;
}

