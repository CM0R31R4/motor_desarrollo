#include <stdio.h>
#include <xml.h>
#include <time.h>
#include <asm/ioctls.h>

Tipo_XML *GetDataHttp(int id,char szData[],char szUrl[]);

int DoPost(int id,int socket,char szData[])
{
	Tipo_XML *xml=NULL;
	char szUrl[2048];
	printf("DATA POST=%s\n\r",szData);

	xml=GetDataHttp(id,szData,szUrl);
	if (xml==NULL)
	{
		char szError[200];
		sprintf(szError,"Lo sentimos, la pagina no trae datos");
		WriteLog(id,szError);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szError,strlen(szError));
#endif
		}
		else send(socket,szError,strlen(szError),0);
		return 0;
	}
	else DoFunctionPost(id,socket,szUrl,xml);
	xml=CierraXML(xml);
}
Tipo_XML *GeneraXML(int id,char *ini)
{
	Tipo_XML *xml=NULL;
	char *igual,*data;
	char szCampo[MAX_LEN_CAMPO];
	char szData[MAX_BUFFER];
	int lenData;
	//Convierte a XML
	do
	{
		igual=(char *)strchr(ini,'=');
		if (igual==NULL) break;
		if (igual-ini<sizeof(szCampo)) 
		{
			memcpy(szCampo,ini,igual-ini); 
			szCampo[igual-ini]=0;
		}
		else 
		{	
			memcpy(szCampo,igual,sizeof(szCampo)); 
			szCampo[sizeof(szCampo)]=0;
			WriteLog(id,"Campo muy largo..");
			printf("Campo muy larga..\n\r");
		}
		WriteLog(id,szCampo);
		igual++;
		data=(char *)strchr(igual,'&');
		//si es el ultimo campo...
		if (data==NULL) 
		{
			lenData= strlen(igual);
			if (lenData<0) lenData=0;
		}
		else lenData = data-igual;

		if (lenData<sizeof(szData)) 
		{
			memcpy(szData,igual,lenData); 
			szData[lenData]=0;
		}
		else 
		{	
			memcpy(szData,igual,sizeof(szData)); 
			szData[sizeof(szData)]=0;
			WriteLog(id,"Data muy larga");
		}
		SacaCaracControl(szData);
		//El campo SERVICIO determina todo..
		//printf("ASIGNA Campo=%s Data=%s\n\r",szCampo,szData);
		ConvierteCaracteresWeb(szData);
		//printf("ASIGNA2 Campo=%s Data=%s\n\r",szCampo,szData);
		xml=InsertaDataXML(xml,szCampo,szData);

		if (data==NULL) break;
		ini=data;
		ini++;
	}while(1);
	//ImprimeXML(xml);
	return xml;
}

Tipo_XML *GetDataHttp(int id,char szData[],char szUrl[])
{
	char *dta,*ini,*fin;
	char szError[100];
		
	//WriteLog(id,szData);
	printf("LEIDO = %s\n\r",szData);

	dta=szData;
	//Ubicamos lo que indica la data..
	ini=(char *)strstr(dta,"POST /");
	fin=(char *)strstr(dta,"HTTP");
	if (ini==NULL) return NULL;
	if (fin==NULL) return NULL;
	
	ini+=6;
	
	memcpy(szUrl,ini,fin-ini-1); szUrl[fin-ini-1]=0;
	WriteLog(id,szUrl);

	//Busca los campos
	ini=(char *)strstr(dta,"\r\n\r\n");
	if (ini==NULL)
	{
		ini=(char *)strstr(dta,"\n\n");
		if (ini==NULL)
		{
			sprintf(szError,"Lo sentimos, el comando no trae ningu dato [%s].",szUrl);
			WriteLog(id,szError);
			return NULL;
		}
		else {ini+=2;}
	}
	else {ini+=4;}
	return GeneraXML(id,ini);
}

#define TIPO_WWW	1
#define TIPO_ZAP	2

int GetContentType(char szLinea[])
{
	char *data,*ini,*fin,*ini2;
    	char szLen[10];

	data=szLinea;
	ini=(char *)strstr(data,"Content-Type:");
	if (!ini) 
	{
		ini=(char *)strstr(data,"Content-type:");
		if (!ini) return -1;
	}
	fin=(char *)strchr(ini,':');
	if (!fin) return -1;
	ini=(char *)strstr(fin,"x-sap.rfc");
	if (ini!=NULL) return TIPO_ZAP;
	else return TIPO_WWW;
}

long GetLength(char szLinea[])
{
	char *data,*ini,*fin,*ini2;
    	char szLen[10];

	data=szLinea;
	ini=(char *)strstr(data,"Content-Length:");
	if (!ini) 
	{
		ini=(char *)strstr(data,"Content-length:");
		if (!ini) return -1;
	}
	fin=(char *)strchr(ini,':');
	if (!fin) return -1;
	//printf("FIN =%s\n\r",fin);
	fin++;
	ini2=(char *)strstr(fin,"\r\n");
	if (!ini2) 
	{
		ini2=(char *)strstr(fin,"\n");
		if (!ini2) return -1;
	}
	memcpy(szLen,fin,ini2-fin);
	szLen[ini2-fin]=0;
	return atol(szLen);
}



int RetornaPagina(int id,char szComando[],int socket)
{
	char szError[512];
	char szPagina[512];
	printf("Retorna PAgina %s\n\r",szComando);
	if (!BuscaPagina(id,szComando,szPagina))
	{
		sprintf(szError,"Pagina no Encontrada");
		WriteLog(id,"Pagina no Encontrada (OtraLinea)=");
		WriteLog(id,szComando);
		send(socket,szError,strlen(szError),0);
		return 0;
	}
	WriteLog(id,szPagina);
	return EnviaPagina(id,szPagina,socket);
}

int DoGet(int id,int socket,char szData[])
{
	char *dta,*ini,*fin;
	char szComando[4096];
	dta=szData;
	//Ubicamos lo que indica la data..
	ini=(char *)strstr(dta,"GET /");
	if (ini==NULL) goto falla;
	fin=(char *)strstr(dta,"HTTP");
	if (fin==NULL) goto falla;
	ini+=5;
	if ((fin-ini-1)<0) goto falla;
	if ((fin-ini-1)>4000) goto falla;

	memcpy(szComando,ini,fin-ini-1); szComando[fin-ini-1]=0;
	printf("COMANDO = %s (%i)\n\r",szComando,strlen(szComando));

	if (strlen(szComando)==0)
	{
		WriteLog(id,"MASTER");
		sprintf(szComando,"MASTER");
		usleep(10);
		return RetornaPagina(id,szComando,socket);
	}
	//Si viene con datos el GET...
	ini=(char *)strchr(szComando,'?');
	if (ini!=NULL)
	{
		Tipo_XML *xml=NULL;
		ini++;
		xml=GeneraXML(id,ini);
		szComando[strlen(szComando)-strlen(ini)-1]=0;
		WriteLog(id,"GET con Datos");
		DoFunctionPost(id,socket,szComando,xml);
		xml=CierraXML(xml);
		return 1;
	}
		
	return RetornaPagina(id,szComando,socket);
falla:
	sprintf(szComando,"XXX");
	return RetornaPagina(id,szComando,socket);

}

int SendHeaderHTTP(int id,int socket)
{
  	char szData[1024];
	struct tm time_str;

        char daybuf[100];
        struct timeb sTimeb;

        ftime(&sTimeb);
        localtime_r(&sTimeb.time,&time_str);

        strftime(daybuf, sizeof(daybuf), "%a, %d %b %Y %H:%M:%S %Z", &time_str);

  	sprintf(szData,"HTTP/1.1 200 OK\nDate: %s\nContent-Type: text/html\nConnection: close\n\n",daybuf);
	printf(szData);
 	if (global.SSL) 
	{
#ifdef _ISYS_SSL_
		return SSL_write(Conexion[id].ssl,szData,strlen(szData));
#endif
	}
	return send(socket,szData,strlen(szData),0);
}

int EnviaPagina(int id,char szPagina[],int socket)
{
	FILE *f;
	long len_file;
	//char szError[100];
	char *data_file,nLeidos;
	
	f = fopen(szPagina,"rb");
	if (f==NULL)
	{
		char szError[100];
		sprintf(szError,"Falla Abrir Archivo = %s\n\r",szPagina);
		WriteLog(id,szError);
		sprintf(szError,"Lo sentimos, la pagina no existe en el servidor.");
		SendHeaderHTTP(id,socket);
		if (global.SSL) 
		{
#ifdef _ISYS_SSL_
			SSL_write(Conexion[id].ssl,szError,strlen(szError));
#endif
		}
		else send(socket,szError,strlen(szError),0);
		return 0;
	}
	
	fseek(f,0L,SEEK_END);
	len_file=ftell(f);
	SendHeaderHTTP(id,socket);
	fseek(f,0L,SEEK_SET);
	data_file = (char *)malloc(len_file+10);
	nLeidos=fread(data_file, sizeof(char),len_file,f);
	data_file[len_file]=0;
	if (global.SSL) 
	{
#ifdef  _ISYS_SSL_
		SSL_write(Conexion[id].ssl,data_file,len_file);
#endif
	}
	else send(socket,data_file,len_file,0);
	printf(data_file);
	/*printf(data_file);
	WriteLog(id,"PAGINA ENVIADA");
	WriteLog(id,data_file);
	*/
	fclose(f);
	free(data_file);
	printf("Bytes[%ld] Data[%s]\n\r",len_file,szPagina);
	return 1;
}

int LeeDataHttp(int socket,int nTimeout,int id)
{
	char szLinea[MAX_BUFFER];
	return LeeDataFaltanteHttp(id,socket,szLinea,0,15);
}

//Lee el largo inicial de una data en protocolo sgci <largo>:
long LeeLargoSCGI(int id,int socket,char szLinea[],int nMaxLinea,int nTimeout)
{

    int nLen,sts;
    char szTmp[200];
    time_t t1,t2;
    int i,j;
    nLen=0;
	
    i=0;
    time(&t1);
    while (1)
    {
	//WriteLog(id,"EsperaDataSocket LeeLinea");
        sts=EsperaDataSocket(id,socket,nTimeout);
        if (sts==CLOSE_SOCKET) return -1;
        if (sts<0)
        {
                char szTmp1[30];
                sprintf(szTmp1,"STATUS = %i",sts);
                WriteLog(id,szTmp1);
                goto timeout;
        }
        time(&t2);
        ioctl(socket,FIONREAD,&nLen);
        //printf("Bytes Por Leer = %i\n\r",nLen);
        if (nLen<0)
        {
                WriteLog(id,"Falla en ioctl LeeLargoSCGI");
                return -1;
        }
        else if ((nTimeout!=0) && (t2-t1>nTimeout)) goto timeout;

	//sprintf(szTmp,"Total por Leer=%i",nLen);
	//WriteLog(id,szTmp);
	for(j=0;j<nLen;j++)
	{
        	sts=recv(socket,&szLinea[i],1,0);
	 	//WriteData(id,&szLinea[i],1);
	        if (sts<0)
        	{
                	WriteLog(id,"Falla al leer en LeeLargoSCGI");
	                return -1;
        	}
	        else if (sts==0)
        	{
                	WriteLog(id,"No lee nada");
	                return -1;
        	}
		//Si es un fin de linea, se acabo el largo
		if (szLinea[i]==':') 
		{
			szLinea[i]=0;
			//WriteLog(id,szLinea);
			return atol(szLinea);
			//break;
		}	
		if (i==nMaxLinea) 
		{
			WriteLog(id,"Falla largo de linea");
			szLinea[i]=0;
			return -1;	
			//break;
		}
		i++;
	}
    }
    i++;
    szLinea[i]=0;
    WriteLog(id,"Falla lectura en LeeLargoSCGI");
    //WriteLog(id,szLinea);
    return -1;

timeout:
    if (nLen>0)
    {
        sts=recv(socket,szLinea,1024,0);
        sprintf(szTmp,"Solo llegan %i",sts);
        WriteLog(id,szTmp);
        WriteLog(id,"Data Leida:");
        WriteLog(id,szLinea);
    }
    WriteLog(id,"Timeout en LeeLinea");
    return -1;
}

int LeeLineaSocket(int id,int socket,char szLinea[],int nMaxLinea,int nTimeout)
{

    int nLen,sts;
    char szTmp[200];
    time_t t1,t2;
    int i,j;
    nLen=0;
	
    i=0;
    time(&t1);
    while (1)
    {
	//WriteLog(id,"EsperaDataSocket LeeLinea");
        sts=EsperaDataSocket(id,socket,nTimeout);
        if (sts==CLOSE_SOCKET) return -1;
        if (sts<0)
        {
                char szTmp1[30];
                sprintf(szTmp1,"STATUS = %i",sts);
                WriteLog(id,szTmp1);
                goto timeout;
        }
        time(&t2);
        ioctl(socket,FIONREAD,&nLen);
        //printf("Bytes Por Leer = %i\n\r",nLen);
        if (nLen<0)
        {
                WriteLog(id,"Falla en LeeNData");
                return -1;
        }
        else if ((nTimeout!=0) && (t2-t1>nTimeout)) goto timeout;

	//sprintf(szTmp,"Total por Leer=%i",nLen);
	//WriteLog(id,szTmp);
	for(j=0;j<nLen;j++)
	{
	 	//WriteLog(id,szLinea);
        	sts=recv(socket,&szLinea[i],1,0);
	        if (sts<0)
        	{
                	WriteLog(id,"Falla al leer en LeeLineaSocket");
	                return -1;
        	}
	        else if (sts==0)
        	{
                	WriteLog(id,"No lee nada");
	                return -1;
        	}
		//Si es un fin de linea
		if (szLinea[i]==10) 
		{
			i++;
			szLinea[i]=0;
			//WriteLog(id,szLinea);
			return i;
			//break;
		}	
		//si es un \r lo ignor0
		if (szLinea[i]!=13)
		{
			i++;
		}

		if (i==nMaxLinea) 
		{
			WriteLog(id,"Falla largo de linea");
			szLinea[i]=0;
			return i;	
			//break;
		}
	}
    }
    i++;
    szLinea[i]=0;
    //WriteLog(id,szLinea);
    return i;

timeout:
    if (nLen>0)
    {
        sts=recv(socket,szLinea,1024,0);
        sprintf(szTmp,"Solo llegan %i",sts);
        WriteLog(id,szTmp);
        WriteLog(id,"Data Leida:");
        WriteLog(id,szLinea);
    }
    WriteLog(id,"Timeout en LeeLinea");
    return -1;
}

//Funcion que lee un POST o GET y luego procesa
Tipo_Data *LeeWebServer(int id,int socket,Tipo_Data *pData,int nTimeout,int *nLeidos)
//int LeeWebServer(int id,int socket,char szBuffer[],int nMaxLenBuffer,int nTimeout)
{
	char szLinea[1024];
	long lLen=0;
	int sts;
	int bChunked=0;
	int j=0;
	char szAux[1024];
	int i;
	char szStatus[100];

	//La primera linea es mas corta
recibe_continue:
	WriteLog(id,"LeeLineaSocket");
	memset(szLinea,0,sizeof(szLinea));
	sts=LeeLineaSocket(id,socket,szLinea,1024,nTimeout);
	if (sts == -1) {
		*nLeidos=-1;
		WriteLog(id,"Falla Lectura");
		pData=LiberaData(pData);
		return NULL;
	}
	if (sts)
	{
		//Sacamos el status de la respuesta HTTP HTTP/1.1 500 Internal Server Error
		memcpy(szStatus,&szLinea[9],3);
		szStatus[3]=0;
		sprintf(szAux,"Status Code=%s",szStatus);
		WriteLog(id,szAux);
		WriteMensajeApp(id,szAux);
		//Copio lo leido en la primera linea al buffer
		pData=ConcatenaData(szLinea,pData,sts);
		//memcpy(szBuffer,szLinea,sts);
		*nLeidos=sts;
		//WriteLog(id,"pData1");
		//WriteLog(id,pData->data);
		//szBuffer[sts]=0;

		//La primera linea siempre hay que leerla si no es post o get sale o una respuesta
		if ((memcmp(szLinea,"POST",4)!=0) && (memcmp(szLinea,"GET",3)!=0) && (memcmp(szLinea,"HTTP",4)!=0))
		{
			//Si no es POST lee lo que hay y sale
			//WriteLog(id,szBuffer);
			WriteLog(id,"NO ES POST ni GET");
			// FC 2011-08-12 Si no es POST o GET , entonces seguimos leyendo y eliminamos el 
			// caracter cero....
			//nLeidos=LeeData(id,socket,&szBuffer[sts-1],MAX_BUFFER-sts,nTimeout);
			
			pData=LeeDataVariable(id,socket,pData,global.nTimeoutLeeData,&sts);
			WriteLog(id,pData->data);
			//return sts+nLeidos;
			*nLeidos+=sts;
			return pData;
		}
		//Si es un POST o GET lee el header
		while(1)
		{
			memset(szLinea,0,sizeof(szLinea));
			sts=LeeLineaSocket(id,socket,szLinea,sizeof(szLinea),nTimeout);
			WriteLog(id,"Lectura Linea HTTP");
			WriteLog(id,szLinea);
			if (sts<=0) 
			{
				WriteLog(id,"Falla Lectura de Lineas");
				pData=LiberaData(pData);
				*nLeidos=-1;
				return NULL;
			}
			pData=ConcatenaData(szLinea,pData,sts);
			*nLeidos+=sts;
			//memcpy(&szBuffer[nLeidos],szLinea,sts);
			//sprintf(szAux,"nLeidos=%i sts=%i szLinea=%s &szBuffer[nLeidos]=%s",nLeidos,sts,szLinea,&szBuffer[nLeidos]);
			//WriteLog(id,szAux);
			//nLeidos+=sts;
			//szBuffer[nLeidos+1]=0;
			//WriteLog(id,szBuffer);
			//WriteLog(id,"Linea");
			//WriteLog(id,szLinea);
			//Si la linea esta vacia se acaba el header
			if (szLinea[0]==10) break;
			if (strstr(szLinea,"Transfer-Encoding: chunked")>0)
			{
				WriteLog(id,"Respuesta chunked");
				bChunked=1;
			}
			if (strstr(szLinea,"transfer-encoding: chunked")>0)
			{
				WriteLog(id,"Respuesta chunked");
				bChunked=1;
			}
			if (strstr(szLinea,"Content-Length:")>0)
			{
				WriteLog(id,"Se encuetra Content-Length:");
				lLen=GetLength(szLinea);
				sprintf(szAux,"Largo=%ld",lLen);
				WriteLog(id,szAux);
				//WriteAppLog(id,szAux);
				//WriteMensajeApp(id,szAux);
			}
			if (strstr(szLinea,"content-length:")>0)
			{
				WriteLog(id,"Se encuetra content-length:");
				lLen=GetLength(szLinea);
				sprintf(szAux,"Largo=%ld",lLen);
				WriteLog(id,szAux);
				//WriteAppLog(id,szAux);
				//WriteMensajeApp(id,szAux);
			}
			if (j++>30)
			{
				WriteLog(id,"Falla total Lineas");
				break;
			}
			//WriteLog(id,szLinea);
			memset(szLinea,0,sizeof(szLinea));
		}
chunked:
		//Saco el largo como chunked
		if (bChunked)
		{
			//Lee largo chunked
			WriteLog(id,"Lee Largo Chunked");
			memset(szLinea,0,sizeof(szLinea));
			sts=LeeLineaSocket(id,socket,szLinea,sizeof(szLinea),nTimeout);
			//WriteMensajeApp(id,szLinea);
			if (sts<=0) 
			{
				WriteLog(id,"Falla Largo Chunked");
				pData=LiberaData(pData);
				*nLeidos=-1;
				return NULL;
			}
			pData=ConcatenaData(szLinea,pData,sts);
			*nLeidos+=sts;
			//Saco los ultimos caracterres si son 10 o 13
			for(i=0;i<sts;i++)
			{
				//sprintf(szAux,"Ch[%i]=%i",i,szLinea[i]);
				//WriteMensajeApp(id,szAux);
				if ((szLinea[i]==10) || (szLinea[i]==13) ||(szLinea[i]==' ')) {szLinea[i]=0; break;}
			}
			//Si es el final...
			if ((szLinea[0]=='0') && (szLinea[1]==0)) lLen=0;
			else lLen=hex2long(szLinea);
			sprintf(szLinea,"Largo Chunked %ld",lLen);
			WriteLog(id,szLinea);
			//WriteMensajeApp(id,szLinea);
			if (lLen==0) 
			{
				WriteLog(id,"Fin Largo Chunked");
				return pData;
			}

			//Se Lee la data 	
			pData=LeeNData_sin_CRLF(id,socket,lLen,pData,nTimeout,&sts);
			if (sts>0)
			{	
				if (pData)
				{
					*nLeidos+=sts;
					//Debo Leer el CR-LF que viene despues de un chunked
					pData=LeeNData(id,socket,2,pData,nTimeout,&sts);
					*nLeidos+=sts;
					*nLeidos=pData->nLenData;
				}
				else
				{	
					*nLeidos=0;
				}
				//WriteLog(id,szBuffer
				//Por Defecto no cierro el socket si leo correctamente un GET o un POST
				goto chunked;
			}	
			else
			{
				//Falla la lectura salimos
				WriteLog(id,"Falla leer Chunked HTTP");
				pData=LiberaData(pData);
				*nLeidos=-1;
				return NULL;
			}
		}	
		
		//Si el header trae un continue se ignora
		if (memcmp(szStatus,"100",3)==0)
		{
			WriteLog(id,"Recibe CONTINUE");
			goto recibe_continue;
		}
		//Obtengo el Largo
		if (lLen==0)
                {
                        char szError[100];
                        sprintf(szError,"SIN LARGO");
                        WriteLog(id,szError);
			//WriteLog(id,szBuffer);
			Conexion[id].nNoCierreConexionHttp=0;
			//return nLeidos;
			return pData;
                }
		//szBuffer[nLeidos+1]=0;
		//WriteLog(id,"BUFFER");
		//WriteLog(id,szBuffer);
		//WriteLog(id,"pData3");
		//WriteLog(id,pData->data);

		if (strstr(pData->data,"Connection: keep-alive")>0)
		{
			Conexion[id].nNoCierreConexionHttp=1;
		}
		else
		{
			WriteLog(id,"NO Send CONTINUE");
		}

		//Leee el largo del ContentLength
		//sts=LeeNData(id,socket,lLen,&szBuffer[nLeidos],nTimeout);
		//pData=LeeNData(id,socket,lLen,pData,nTimeout,&sts);
		pData=LeeNDataWebServer(id,socket,lLen,pData,nTimeout,&sts);
		if (sts>0)
		{	
		//WriteLog(id,"pData4");
		//WriteLog(id,pData->data);
			//szBuffer[nLeidos+sts+1]=0;
			//WriteLog(id,"BUFFER LEIDO");
			if (pData)
			{
				*nLeidos+=sts;
				*nLeidos=pData->nLenData;
			}
			else
			{	
				*nLeidos=0;
			}
			//WriteLog(id,szBuffer
			//Por Defecto no cierro el socket si leo correctamente un GET o un POST
			WriteLog(id,"Fin Lectura HTTP");
			Conexion[id].nNoCierreConexionHttp=1;
			if (bChunked) goto chunked;
			return pData;
		}
		else 
		{	
			WriteLog(id,"Falla el cuerpo HTTP");
			pData=LiberaData(pData);
			return NULL;
		}
	}
	else 
	{ 
		pData=LiberaData(pData);
		*nLeidos=-1;
		return NULL;
	}
	//else return LeeData(id,socket,&szBuffer[sts],MAX_BUFFER,nTimeout);
}


//Lee y Procesa la data faltante..
int LeeDataFaltanteHttp(int id,int socket,char szLinea[],int nLeido,int nTimeout)
{
    int sts;
    int nState=0;
    int nPos=0;
    unsigned long nLen;
    long lsts=1;
    long lBytesFaltantes=0;
    long lLen;
    char *ini;
    char szAux[200];
    int bEsperaLeer=0;
    char szError[512];
    int nTipo;

    if (nLeido==0)
    {
	    sprintf(szLinea,"");
	    bEsperaLeer=1;
    }
				

	//FAY 04-10-2010
	//Cuando faltan bytes por leer le envio al cliente un continue
	//HTTP/1.1 100 Continue
	//sprintf(szAux,"HTTP/1.1 100 Continue\n");
	//send(socket,szAux,strlen(szAux));

    while (1)
    {
	    	if (bEsperaLeer)
		{
			//Primero esperamos para conservar el flujo
	        	sts=EsperaDataSocket(id,socket,nTimeout);
			//si es por timeout
			if (sts==TIMEOUT_SOCKET)
			{
				WriteLog(id,"TIMEOUT SOCKET");
				//Verificamos si ha terminado
				ini=(char *)strstr(szLinea,"\r\n\r\n");
				if (ini!=NULL)
				{
					char szError[100];
					//Procesamos igual
					sprintf(szError,"Leido Parcial=%i",nLeido);
					WriteLog(id,szError);
					WriteLog(id,szLinea);
					WriteLog(id,"PROCESO IGUAL");
					return 1;
				}
			}
			
	        	if (EsperaDataSocket(id,socket,1)<0) 
			{
				char szError[100];
				sprintf(szError,"Leido Parcial=%i",nLeido);
				WriteLog(id,szError);
				WriteLog(id,szLinea);
				WriteLog(id,"NO PROCESO");
				return -1;
			}

			if (global.SSL) 
			{
#ifdef _ISYS_SSL_
				sts=SSL_read(Conexion[id].ssl,&szLinea[nLeido],MAX_BUFFER);
#endif
			}
			else sts=recv(socket,&szLinea[nLeido],MAX_BUFFER,0);
			szLinea[nLeido+sts]=0;
		}
		else sts=strlen(szLinea);
		if (memcmp(szLinea,"GET",3)==0) return 1;
		WriteLog(id,&szLinea[nLeido]);
		bEsperaLeer=1;
		switch(nState)
		{
			case 0:
			if ((lLen=GetLength(szLinea))<0)
			{
				char szError[100];
				sprintf(szError,"SIN LARGO leidos=%i totales=%i",sts,nLeido);
				WriteLog(id,szError);
				bEsperaLeer=1;
				nState=1;
				continue;
			}

			if ((nTipo=GetContentType(szLinea))<0)
			{
				char szError[100];
				sprintf(szError,"SIN TIPO leidos=%i totales=%i",sts,nLeido);
				WriteLog(id,szError);
				bEsperaLeer=1;
				nState=1;
				continue;
			}
			
			ini=(char *)strstr(szLinea,"\r\n\r\n");
			if (ini==NULL)
			{
				ini=(char *)strstr(szLinea,"\n\n");
				if (ini==NULL)
				{
					WriteLog(id,"Falta Data <cr><lr><cr><lr>");
					nLeido+=sts;
					nState=1;
					bEsperaLeer=1;
					continue;
				}
			}
			
			if (nTipo==TIPO_WWW) lBytesFaltantes=sts-(ini-szLinea)-6-lLen;
			else lBytesFaltantes=sts-lLen;
			if (lBytesFaltantes>=(-2))
			{
				int nLen=0;
				usleep(100);
				ioctl(socket,FIONREAD,&nLen);
				if (nLen>0)
				{
				        WriteLog(id,"Falta por Leer");
					nState=1;
					bEsperaLeer=1;
					continue;
				}
				return 1;
			}
			else
			{
				
				nLeido=sts;
				printf("TOTAL=%i falta=%ld LEIDO=%s\n\r",sts,lBytesFaltantes,szLinea);
				sprintf(szAux,"FALTA POR LEER:Leido %i falta %ld",sts,lBytesFaltantes);
				WriteLog(id,szAux);
				nState=1;
				bEsperaLeer=1;
				continue;
			}
			break;
			case 1:
			//WriteLog(id,"ESTADO 1");
			//WriteLog(id,szLinea);
			if ((lLen=GetLength(szLinea))<0)
			{
				char szError[100];
				WriteLog(id,&szLinea[nLeido]);
				nLeido+=sts;
				sprintf(szError,"*SIN LARGO leidos=%i totales=%i",sts,nLeido);
				WriteLog(id,szError);
				nState=1;
				bEsperaLeer=1;
				continue;
			}
			if ((nTipo=GetContentType(szLinea))<0)
			{
				char szError[100];
				nLeido+=sts;
				sprintf(szError,"SIN TIPO leidos=%i totales=%i",sts,nLeido);
				WriteLog(id,szError);
				bEsperaLeer=1;
				nState=1;
				continue;
			}
			ini=(char *)strstr(szLinea,"\r\n\r\n");
			//Desde aqui se cuenta el largo...
			if (ini==NULL)
			{
				WriteLog(id,"*Falta Data <cr><lr><cr><lr>");
				nLeido+=sts;
				nState=1;
				bEsperaLeer=1;
				continue;
			}
			nLeido+=sts;
			
			//printf("STS = %i %i\n\r",sts,ini-szLinea);
			//lBytesFaltantes=(sts+nLeido)-(ini-szLinea)-6-lLen;
			if (nTipo==TIPO_WWW) lBytesFaltantes=lLen+(ini-szLinea)-(nLeido);
			else lBytesFaltantes=lLen-nLeido;
			sprintf(szError,"Bytes Faltantes=%i nLeido=%i lLen=%i (ini-szLinea)=%i",lBytesFaltantes,nLeido,lLen,(ini-szLinea));
			WriteLog(id,szError);
			//La condicion de termino debe ser que se leyo
			//el contentlength
			if (lBytesFaltantes<=0) 
			{
				int nLen=0;
				usleep(100);
				ioctl(socket,FIONREAD,&nLen);
				if (nLen>0)
				{
				        WriteLog(id,"Falta por Leer");
					nState=1;
					bEsperaLeer=1;
					continue;
				}
				else WriteLog(id,"Nada Por Leer");
				return 1;
			}
			else
			{
				//sprintf(szAux,"*FALTA POR LEER:Leido %i falta %i",sts,lBytesFaltantes);
				//WriteLog(id,szAux);
				nState=1;
				bEsperaLeer=1;
				continue;
			}
			break;
		}
    }
    return 1;
}


