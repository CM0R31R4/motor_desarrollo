#include <stdio.h>
#include <stdlib.h>
#include <xml.h>
#include <tipos.h>
#include <tiposocket.h>
#include <fnmatch.h>
#include <pthread.h>
#include <const.h>


char Modulo11(long lRut)
{
   char szRut[20];
   int lMultiplo = 2,i;
   int lTotal=0,lResto;
   int lDigito;
   sprintf(szRut,"%ld",lRut);
			        
   for(i=strlen(szRut)-1;i>=0;i--)
   {
          lTotal += lMultiplo * (szRut[i]-'0');
          if (lMultiplo==7) lMultiplo = 2;
          else lMultiplo++;
   }

   lResto = lTotal%11;
   lDigito = 11-lResto;
   if (lDigito==11) return '0';
   else if (lDigito==10) return 'K';
   else return (lDigito+'0');
}


int EditaFecha(char szEdit[],char szFecha[])
{
	char szAux[10];
	int dia,mes,ano;

	memcpy(szAux,szFecha,4); szAux[4]=0;
	ano=atoi(szAux);
	
	memcpy(szAux,&szFecha[4],2); szAux[2]=0;
	mes=atoi(szAux);
	
	memcpy(szAux,&szFecha[6],2); szAux[2]=0;
	dia=atoi(szAux);
	
	sprintf(szEdit,"%02i/%02i/%04i",dia,mes,ano);
	return 1;
}

int EditaHora(char szEdit[],char szHora[])
{
	char szAux[10];
	int hora,min;

	memcpy(szAux,szHora,2); szAux[2]=0;
	hora=atoi(szAux);
	
	memcpy(szAux,&szHora[2],2); szAux[2]=0;
	min=atoi(szAux);
	
	sprintf(szEdit,"%02i:%02i",hora,min);
	return 1;
}



int EditaMonto(char *strmonto,long paso)
{
   int i,j;
   int k,md;
   char str2[15];
   md=3;
   if (paso==0)
   {
      strmonto[0]='0';
      strmonto[1]='\0';
   }
   else
   {
      strmonto[0]='\0';
      sprintf(strmonto,"%8ld",paso);
      j=0;
      k=1;
      i=strlen(strmonto)-1;
      memset(str2,0,15);
      while (strmonto[i]!=' ' && i >=0)
      {
         str2[j++]=strmonto[i--];
         if ((k%3==0) && strmonto[i]!=' ') str2[j++]='.';
         k++;
      }
      str2[j]=0;
      i=strlen(str2)-1;
      j=0;
      strmonto[0]=0;
      while (i>=0) strmonto[j++]=str2[i--];
      strmonto[j]=0;
   }
   return 1;
}

int hex(int n)  /* convert hex nibble into integer */
{
    if (n >= 'A' && n <= 'F') return n - 'A' + 10;
    else if (n >= 'a' && n <= 'f') return n - 'a' + 10;
    return n - '0';
}

long hex2long(char szHex[])
{
    int i,j=0;
    long l1=0;
    int len1;
    char szTmp[20];
    int arrValor[] = {1,16,256,4096};
    //len1=strlen(szHex);
    //sprintf(szTmp,"largo szHex=%i",len1);
    //WriteMensajeApp(0,szTmp);
    strrev(szHex);
    len1=strlen(szHex);
    //sprintf(szTmp,"largo szHex=%i",len1);
    //WriteMensajeApp(0,szTmp);

    //WriteMensajeApp(0,szHex);
    for (i = 0; i < len1; i+=1)
    {
    	  //sprintf(szTmp,"l1=%ld",l1);
	  //WriteMensajeApp(0,szTmp);

          l1+=hex(szHex[i])*arrValor[i];
    }
	/*
    for (i = 0; i < len1; i+=2)
    {
    	  sprintf(szTmp,"l1=%ld",l1);
	  WriteMensajeApp(0,szTmp);

          l1+=(hex(szHex[i+1])*arrValor[j+1])+(hex(szHex[i])*arrValor[j]);
	  j+=2;
    }
	*/
    return l1;
}

void readhex(char szHex[],char szout[])
{
    int i,j=0;
    int len;
    len=strlen(szHex);
    for (i = 0; i < len; i+=2)
    {
          szout[j++]=hex(szHex[i])*16+hex(szHex[i+1]);
    }
    szout[j++]=0;
}

/* write the 64-bit hex string */
void writenhex(char str[],char out[],int nLen)   
{   
    int i;
    int j=0;
    char buf[10];
    out[0]=0;
    for (i =0;i<nLen;i++)
   {
           sprintf(buf,"%02x",str[i]&0377);
	   out[j]=buf[0]; j++; 
	   out[j]=buf[1]; j++; 
           //strcat(out,buf);
   }
   out[j]=0;
}

/*^
void writehex(char str[],char out[])  
{   
    int i;
    char buf[10];
    out[0]=0;
    for (i = 0; i < 8; i++)
   {
           sprintf(buf,"%02x", str[i] & 0377);
           strcat(out,buf);
   }
}
*/
int ConvierteCaracteresWeb(char szData[])
{
    int i;
    char *ini,*fin;
    char szTmp[MAX_BUFFER],szTmp1[1024];
    char szHex[5],szOut[2];
    
    ini=szData;
    //printf("INI=%s\n\r",ini);
    fin=(char *)strchr(ini,'%');
    if (fin==NULL) return 1;
    memset(szTmp,0,sizeof(szTmp));
    do
    {
	//Copiamos el buffer antes...
        memcpy(szTmp1,ini,fin-ini); szTmp1[fin-ini]=0;
	strcat(szTmp,szTmp1);
	//printf("szTmp=%s\n\r",szTmp);
	//OBtenemos el hex...
	memcpy(szHex,fin+1,2); szHex[2]=0;
	readhex(szHex,szOut);
	strncat(szTmp,szOut,1);
    	//printf("szHex=%s %c\n\r",szHex,szOut[0]);
	//printf("szTmp=%s\n\r",szTmp);
	ini=fin+3;
    	fin=(char *)strchr(ini,'%');
    	if (fin==NULL) 
	{
		memcpy(szTmp1,ini,strlen(ini)); szTmp1[strlen(ini)]=0;
		strcat(szTmp,szTmp1);
		//printf("szTmp=%s\n\r",szTmp);
		sprintf(szData,"%s",szTmp);
		//printf("szData=%s\n\r",szData);
		return 1;
	}
    } while(1);

}

int SacaPorcentaje(char szData[])
{
    int i;
    char *ini;
    char szAux[10];
    do
    {
    	ini=(char *)strchr(szData,'%');
	memcpy(szAux,ini+1,2); szAux[2]=0;
    } while(1);
}

int SacaEspacios(char szData[])
{
    int i;
    int len1=strlen(szData);
    for(i=len1-1;i>=0;i--)
    {
        if (szData[i]==' ') szData[i]=0;
        else { break; }
    }
}

int SacaCaracControl(char szData[])
{
    int i;
    int len1=strlen(szData);
    for(i=0;i<len1;i++)
    {
        if (szData[i]=='+') szData[i]=' ';
	else if (szData[i]==10) szData[i]=0;
	else if (szData[i]==13) szData[i]=0;
    }
}

int ReemplazaChrxTxt(char szData[],int chr,char szReemplazo[])
{
	char szTmp[MAX_BUFFER],szAux[20];
	int i,j=0;
	int len1=strlen(szData);
	memset(szTmp,0,sizeof(szTmp));
	for(i=0;i<len1;i++)
	{
		//Caracter
		if (szData[i]==chr)
		{	
			sprintf(szAux,"%s",szReemplazo); //"&#39;");
			strcat(szTmp,szAux);
			j+=strlen(szAux);
		}
		else 
		{
			szTmp[j++]=szData[i];
		}
	}
	sprintf(szData,"%s",szTmp);
	return 1;
}

int DatosProceso(int id,Tipo_Proceso *pProceso,char szProceso[])
{
	char szSql[1000];
	Tipo_XML *xml=NULL;
	int sts;
	sprintf(szSql,"select ip,cantidad,port from procesos where proceso='%s'",szProceso);
	xml=GetRecord(id,szSql,xml,&sts);
	if (sts==0) 
	{
		printf("El proceso %s, no existe en la tabla de procesos\n\r",szProceso);
		xml=CierraXML(xml);
		exit(1);
	}

	//ImprimeXML(xml);
	if (!GetIntXML(xml,"CANTIDAD",&pProceso->nCantidad)) goto close;
	if (!GetIntXML(xml,"PORT",&pProceso->nPort)) goto close;
	//if (!GetIntXML(xml,"FORMA_CONEXION_BD",&pProceso->nFormaConexionBD)) goto close;
	GetStrXML(xml,"IP",pProceso->szIp,sizeof(pProceso->szIp));
	xml=CierraXML(xml);
	global.nProcesos = pProceso->nCantidad;
	return 1;
close:
	CloseDatabase(id);
	exit(1);
}

int BuscaPagina(int id,char szComando[],char szRuta[])
{
	Tipo_XML *xml=NULL;
	int i,sts;
	char szAux[512];
	char szComando1[256];
	FILE *f;
	//printf("Busca Pagina\n\r");
	if (global.xml_paginas==NULL)
	{
		char szSql[1024];
		sprintf(szSql,"select * from paginas");
		global.xml_paginas=GetRecords(id,szSql,&global.nTotalPaginas,global.xml_paginas,&sts);
		if (!sts)
		{
			WriteLog(id,"No puede leer tabla paginas");
			WriteLog(id,szSql);
			printf("Falla leer paginas");
			exit(0);
		}
	}
	//printf("Total Paginas %i\n\r",global.nTotalPaginas);

	for(i=0;i<global.nTotalPaginas;i++)
	{
		xml=global.xml_paginas;
		memset(szComando1,0,sizeof(szComando1));
		GetNivelStrXML(xml,"COMANDO",szComando1,sizeof(szComando1),i);
		printf("TAG=%s(%i)  %s(%i)\n\r",szComando1,strlen(szComando1),szComando,strlen(szComando));
		if ((strlen(szComando1)==strlen(szComando)) &&
		    (memcmp(szComando,szComando1,strlen(szComando))==0))	
		{
		    GetNivelStrXML(xml,"RUTA",szAux,sizeof(szAux),i);
	            sprintf(szRuta,"%s",szAux);
		    return 1;
		}
	}
	
        WriteLog(0,szComando);
	//Si viene un .. me estan tratando de hackear
	if (strstr(szComando,".."))
	{
        	WriteLog(0,"INTENTO DE HACKEO");
		sprintf(szRuta,"/home/switch/paginas_web/index.htm");
	}
	else
	{
		//27-03-2009 cambio para operar como servidor web tradicional
		//si no esta la pagina en la tabla paginas enviamos como si fuera el archivo directo
		sprintf(szRuta,"/home/switch/paginas_web/%s",szComando);
        	WriteLog(0,szRuta);
	}
	
	return 1;
}

int BuscaFormatoSms(int id,Tabla_FormatoSms *p)
{
	Tipo_XML *xml=NULL;
	int i,sts;
	char szAux[1024];
	if (global.xml_formatosms==NULL)
	{
		char szSql[1024];
		sprintf(szSql,"select * from sms_formato_msg");
		global.xml_formatosms=GetRecords(id,szSql,&global.nTotalFormatoSms,global.xml_formatosms,&sts);
		if (!sts)
		{
			WriteLog(id,"No puede leer tabla tablas");
			printf("Falla leer tablas");
			exit(0);
		}
	}
	
	xml=global.xml_formatosms;
	for(i=0;i<global.nTotalFormatoSms;i++)
	{
		char szCliente[5];
		char szTmp[100];
		char chTipoTx,chProtocolo;
		GetNivelStrXML(xml,"CLIENTE",szAux,sizeof(szAux),i);
		sprintf(szCliente,"%s",szAux);
		GetNivelStrXML(xml,"TIPO_MSG",szAux,sizeof(szAux),i);
		chTipoTx=szAux[0];
		GetNivelStrXML(xml,"PROTOCOLO",szAux,sizeof(szAux),i);
		chProtocolo=szAux[0];
		//sprintf(szTmp,"PROTO=%c CLIENTE=%s TX=%c",chProtocolo,szCliente,chTipoTx);
		//WriteLog(id,szTmp);
            	if ((memcmp(szCliente,p->szCliente,strlen(szCliente))==0) &&
		    (chTipoTx==p->chTipoTx) &&
		    (chProtocolo==p->chProtocolo))
		{
		    GetNivelIntXML(xml,"FORMATO_ENTRADA",&p->nFormatoIn,i);
		    GetNivelIntXML(xml,"FORMATO_SALIDA",&p->nFormatoOut,i);
		    GetNivelIntXML(xml,"FORMATO_SALIDA_TEXTO",&p->nFormatoOutTexto,i);
		    GetNivelIntXML(xml,"FORMATO_IN_TRANS",&p->nFormatoInTrans,i);
		    GetNivelIntXML(xml,"FORMATO_OUT_TRANS",&p->nFormatoOutTrans,i);
		    GetNivelIntXML(xml,"POSICION_DATOS",&p->nPosicionDatos,i);
		    GetNivelStrXML(xml,"TX_BACKOFFICE",szAux,sizeof(szAux),i);
		    sprintf(p->szTxBack,"%s",szAux);
		    return 1;
		}
	}
	return 0;
}

int BuscaTabla(int id,int nTx,Tipo_Tabla *p)
{
	Tipo_XML *xml=NULL;
	int i,sts;
	char szAux[512];
	if (global.xml_tablas==NULL)
	{
		char szSql[1024];
		sprintf(szSql,"select * from tablas");
		global.xml_tablas=GetRecords(id,szSql,&global.nTotalTablas,global.xml_tablas,&sts);
		if (!sts)
		{
			WriteLog(id,"No puede leer tabla tablas");
			printf("Falla leer tablas");
			exit(0);
		}
	}
	
	for(i=0;i<global.nTotalTablas;i++)
	{
		xml=global.xml_tablas;
		GetNivelIntXML(xml,"TX",&p->nTx,i);
            	if (p->nTx==nTx)
		{
		    GetNivelStrXML(xml,"QUERY",szAux,sizeof(szAux),i);
	            sprintf(p->szQuery,"%s",szAux);
		    GetNivelStrXML(xml,"LIMITE",szAux,sizeof(szAux),i);
	            p->nLimit=atoi(szAux);
		    GetNivelStrXML(xml,"TITULO",szAux,sizeof(szAux),i);
	            sprintf(p->szTitulo,"%s",szAux);
		    GetNivelIntXML(xml,"BASEDATOS",&p->nBaseDatos,i);
		    return 1;
		}
	}
	return 0;
}

int LeeTablaXML(int id,char szSql[],Tipo_Tabla_XML *p)
{
	int sts;
	WriteLog(id,"Lock Proceso");
	pthread_mutex_lock(&p->mutex);
	if (p->xml!=NULL) goto fin;
	p->xml=GetRecords(id,szSql,&p->nTotal,p->xml,&sts);
	if (sts==0)
	{
		WriteLog(id,"Falla lectura de tabla");
		WriteLog(id,szSql);
		exit(1);
		//Si falla la lectura de la tabla dejo el puntero en nulo para que se vuelva a leer
		p->xml=CierraXML(p->xml);
		sts=-1;
	}
fin:
	WriteLog(id,"UnLock Proceso");
	pthread_mutex_unlock(&p->mutex);
	return sts;
}


Tipo_XML *BuscaTablaXml(int id,Tipo_Tabla_XML *p,char szCampo[],char szData[],int nTipo,int *nNivel)
{
	int bState;
	int i;
	int sts;
	*nNivel=-1;
	if (p->xml==NULL)
	{
	   LeeTablaXML(id,p->szSql,p);
	}
	for(i=0;i<p->nTotal;i++)
	{
		char szAux[MAX_BUFFER];
		int nData=(-1);
		bState=0;
		switch(nTipo)
		{
		case INTEGER:
			GetNivelIntXML(p->xml,szCampo,&nData,i);
			if (atoi(szData)==nData) bState=1;
			break;
		case STRING:
			GetNivelStrXML(p->xml,szCampo,szAux,sizeof(szAux),i);
			if ((strlen(szAux)==strlen(szData)) &&
		    	    (memcmp(szAux,szData,strlen(szData))==0)) bState=1;
			break;
		case STRSTR:
			sts=GetNivelStrXML(p->xml,szCampo,szAux,sizeof(szAux),i);
			if (strstr(szData,szAux)>0 && strlen(szAux)>0) 
			{
				bState=1;
			}
			break;
		case LONG:
			GetNivelStrXML(p->xml,szCampo,szAux,sizeof(szAux),i);
			if (atol(szData)==atol(szAux)) bState=1;
			break;
		default:
			bState=0;
		}
		if (bState) 
		{
			*nNivel=i;
			return GetNivelXML(p->xml,i);
		}
	}
	return NULL;
}


int BuscaServicio(int id,Tipo_Servicio *p,int nTipo)
{
	Tipo_XML *xml=NULL;
	char szAux[500];
	char szCampo[100];
	int i,nNivel;
	if (nTipo==BUSCA_TX)
	{
		//Busca si el servicio ya esta asignado
		for(i=0;i<global.nIndiceServicio;i++)
		{
			if (Tipo_Hash_servicio[i].nTx==p->nTx)
			{
				memcpy(p,&Tipo_Hash_servicio[i],sizeof(Tipo_Servicio));
				return 1;
			}
		}
		sprintf(szAux,"%i",p->nTx);
		//i=BuscaNivelTablaXml(id,&global.xml_servicios,"TX",szAux,INTEGER);
		ImprimeMemoria(id,"Ante de BuscaTablaXml");
		xml=BuscaTablaXml(id,&global.xml_servicios,"TX",szAux,INTEGER,&nNivel);
		ImprimeMemoria(id,"Despues de BuscaTablaXml");
	}
	else if (nTipo==BUSCA_URL)
	{
		//i=BuscaNivelTablaXml(id,&global.xml_servicios,"URL",p->szUrl,STRING);
		xml=BuscaTablaXml(id,&global.xml_servicios,"URL",p->szUrl,STRSTR,&nNivel);
	}
	if (xml==NULL) return 0;

	sprintf(szCampo,"IP[%i]",nNivel);
	GetStrXML(xml,szCampo,szAux,sizeof(szAux));
	sprintf(p->szIp,"%s",szAux);
	sprintf(szCampo,"PORT[%i]",nNivel);
	GetIntXML(xml,szCampo,&p->nPort);

	sprintf(szCampo,"TX[%i]",nNivel);
	GetIntXML(xml,szCampo,&p->nTx);
	sprintf(szCampo,"DESCRIPCION[%i]",nNivel);
	GetStrXML(xml,szCampo,szAux,sizeof(szAux));
	sprintf(p->szDescripcion,"%s",szAux);

	sprintf(szCampo,"TAG_PAGINA[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szPagina,sizeof(p->szPagina));
	sprintf(szCampo,"TAG_IMAGEN[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szImagen,sizeof(p->szImagen));
	sprintf(szCampo,"URL[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szUrl,sizeof(p->szUrl));

	p->nTimeout=10;
	sprintf(szCampo,"TIMEOUT[%i]",nNivel);
	GetIntXML(xml,szCampo,&p->nTimeout);
	p->nTipoRespuesta=0;
	sprintf(szCampo,"TIPO_RESPUESTA[%i]",nNivel);
	GetIntXML(xml,szCampo,&p->nTipoRespuesta);
	p->nLenMinimo=0;
	sprintf(szCampo,"LARGO_MINIMO_RESPUESTA[%i]",nNivel);
	GetIntXML(xml,szCampo,&p->nLenMinimo);
	p->nLlaveQuery=0;
	sprintf(szCampo,"LLAVE_QUERY[%i]",nNivel);
	WriteLog(0,szCampo);
	GetIntXML(xml,szCampo,&p->nLlaveQuery);
	p->nTimeoutRafaga=300;
	sprintf(szCampo,"TIMEOUT_RAFAGA[%i]",nNivel);
	GetIntXML(xml,szCampo,&p->nTimeoutRafaga);
	sprintf(p->szPatronFinal,"");
	sprintf(szCampo,"PATRON_FINAL[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szPatronFinal,sizeof(p->szPatronFinal));
	sprintf(p->szTipoConexion,"CON");
	sprintf(szCampo,"TIPO_CONEXION[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szTipoConexion,sizeof(p->szTipoConexion));
	sprintf(szCampo,"USA_DOS_IP[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szUsaDosIP,sizeof(p->szUsaDosIP));
	sprintf(szCampo,"IP1[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szIp1,sizeof(p->szIp1));
	sprintf(szCampo,"PORT1[%i]",nNivel);
	GetIntXML(xml,szCampo,&p->nPort1);
	sprintf(szCampo,"SSL[%i]",nNivel);
	GetStrXML(xml,szCampo,szAux,sizeof(szAux));
	if (memcmp(szAux,"SSL",3)==0) p->ssl=1;
	else p->ssl=0;
	sprintf(szCampo,"LISTA_IP[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szListaIP,sizeof(p->szListaIP));
	//WriteLog(0,p->szListaIP);
	sprintf(szCampo,"ESCRIBE_FILE[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szEscribeFile,sizeof(p->szEscribeFile));
	WriteLog(0,p->szEscribeFile);
	sprintf(szCampo,"RUTA_FILE[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szRutaFile,sizeof(p->szRutaFile));
	//WriteLog(0,p->szRutaFile);
	sprintf(szCampo,"DATA_RESPUESTA[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szDataRespuesta,sizeof(p->szDataRespuesta));
	sprintf(szCampo,"DATA_HEADER[%i]",nNivel);
	GetStrXML(xml,szCampo,p->szDataHeader,sizeof(p->szDataHeader));
	//WriteLog(0,p->szDataRespuesta);
	

	//ImprimeXML1(xml);
	//Solo use el Hash cuando vengan con TX por ahora
	if (nTipo==BUSCA_TX)
	{
		//Copio el registro a la tabla hash
		sprintf(szAux,"Asigno Hash Servicio %i Total=%i",p->nTx,global.nIndiceServicio);
		WriteLog(id,szAux);
	
		memcpy(&Tipo_Hash_servicio[global.nIndiceServicio],p,sizeof(Tipo_Servicio));
		if (global.nIndiceServicio==MAX_SERVICIOS)
		{
			WriteLog(id,"Alcanza Maximo Servicios en Hash");
		}
		else global.nIndiceServicio++;
		//xml=CierraXML(xml);
		ImprimeMemoria(id,"Sale de BuscaServicio");
	}
	return 1;
}

int BuscaTablaNombre(char szTabla[],Tipo_Tabla *pTabla)
{
    int i;
    for(i=0;i<LEN_TABLAS;i++)
    {
            if (stTablas[i].nValido==0) return 0;
            if (memcmp(szTabla,stTablas[i].szTabla,strlen(stTablas[i].szTabla))==0)
            {
		    sprintf(pTabla->szTabla,"%s",stTablas[i].szTabla);
		    pTabla->nTx=stTablas[i].nTx;
		    sprintf(pTabla->szOrden,"%s",stTablas[i].szOrden);
		    pTabla->nLimit = stTablas[i].nLimit;
		    sprintf(pTabla->szTitulo,"%s",stTablas[i].szTitulo);
	            return 1;
	    }
    }
    return 0;
}


int GetDatosCliente(int id,int nCliente,char szImagen[],char szPag[])
{
	char szSql[300];
	char szAux[100];
	Tipo_XML *xml=NULL;
	int sts;
	sprintf(szSql,"select tag_imagen,pagina_servicio from clientes where codigo=%i",nCliente);
	if (!QueryDatabase(id,szSql)) goto close;

	xml=MoveNext(id,&sts); 

	if (sts!=DATOS_OK) 
	{
		printf("El codigo %i, no existe en la tabla de clientes\n\r",nCliente);
		return 0;
	}
	CloseDatabase(id);
	GetStrXML(xml,"TAG_IMAGEN",szAux,sizeof(szAux));
	sprintf(szImagen,"%s",szAux);
	GetStrXML(xml,"PAGINA_SERVICIO",szAux,sizeof(szAux));
	sprintf(szPag,"%s",szAux);
	CierraXML(xml);
	return 1;
close:
	CloseDatabase(id);
	CierraXML(xml);
	return 0;
}



//Sube el diccionario de campos a memoria..
int InicializaEstructuraCampos(int id)
{
        char szSql[1024];
	Tipo_XML *xml=NULL;
	int i,sts;
	char szAux[10];

	for(i=0;i<LEN_CAMPOS;i++)  stCampos[i].nValido=0;
			        
        sprintf(szSql,"select * from campos");
	if (!QueryDatabase(id,szSql)) goto fin;
	i=0;
	do
	{
	    xml=MoveNext(id,&sts);
	    if (sts!=DATOS_OK) break;
	   GetStrXML(xml,"NOMBRE",stCampos[i].szNombre,sizeof(stCampos[i].szNombre)); 
	   GetIntXML(xml,"LARGO",&stCampos[i].nLen);
	   GetStrXML(xml,"TIPO",stCampos[i].szTipo,sizeof(stCampos[i].szTipo));
	   
           stCampos[i].nValido=1;
	   i++;
	}while(1);
        CloseDatabase(id);
	CierraXML(xml);
	return 1;
fin:
        CloseDatabase(id);
     	CierraXML(xml);
       return 0;

}

int BuscaCampo(char szNombre[],Tipo_Campo *pCampo)
{
    int i;

    for(i=0;i<LEN_CAMPOS;i++)
    {
            if (stCampos[i].nValido==0) return 0;
	    //printf("Campo=%s %i Base=%s %i\n\r",szNombre,strlen(szNombre),stCampos[i].szNombre,strlen(stCampos[i].szNombre));
            if ((strlen(stCampos[i].szNombre)==strlen(szNombre)) &&
               (memcmp(stCampos[i].szNombre,szNombre,strlen(szNombre))==0))
            {
		    pCampo->nLen = stCampos[i].nLen;
	            sprintf(pCampo->szNombre,"%s",stCampos[i].szNombre);
	            sprintf(pCampo->szTipo,"%s",stCampos[i].szTipo);
	            return 1;
	    }
    }
    return 0;
}

Tipo_NombreCampos *LeeNombreCampos(int id,char szTabla[])
{
       char szSql[300];
       int sts,i;
       char szTmp[50];
       char szAux[120];
       Tipo_XML *xml1=NULL;
       Tipo_NombreCampos *pName=NULL,*pAux,*pNameCampo=NULL;
       xml1=GetCamposDatabase(id,&sts,szTabla);
       if (sts==ERROR_BASE) {printf("Error en la Base\n\r"); xml1=CierraXML(xml1); return NULL;}
       if (sts==NO_HAY_DATOS) {printf("No hay datos\n\r"); xml1=CierraXML(xml1); return NULL;}

       i=0;
       while (1)
       {
       	   sprintf(szTmp,"CAMPO%i",i);
	   if (GetStrXML(xml1,szTmp,szAux,sizeof(szAux)))
	   {
		 pName=(Tipo_NombreCampos *)malloc(sizeof(Tipo_NombreCampos));
		 pName->pNext=NULL;
       		 Upper(szAux);
		 sprintf(pName->szNombre,"%s",szAux);
           	 i++;
           	 sprintf(szTmp,"CAMPO%i",i);
		 if (pNameCampo==NULL)
		 {
			 pNameCampo=pName;
			 pAux = pName;
		 }
		 else
		 {
			 pAux->pNext=pName;
			 pAux = pName;
		 }
	   }
	   else break;
       }
       CloseDatabase(id);
       xml1=CierraXML(xml1);
       return pNameCampo;
}
					
int GetTx(Tipo_XML *xml)
{
	int nTx;
	if (GetIntXML(xml,"TX",&nTx))
	{
		return nTx;
	}
	else return -1;
}
	


Tipo_Data *LeeArchivo(char szPagina[])
{
	char *data_file,nLeidos;
	int len_file;
	FILE *f;
	char szData[100];
	Tipo_Data *pData;

	f = fopen(szPagina,"r");
	if (f==NULL) return NULL;
	sprintf(szData,"Abre Archivo %s",szPagina);
	WriteLog(0,szData);
	
	pData = (Tipo_Data *)malloc(sizeof(Tipo_Data));
	if (pData==NULL) {printf("Falla malloc\n\r"); return NULL;}
	fseek(f,0L,SEEK_END);
	pData->nLenData=ftell(f);
	fseek(f,0L,SEEK_SET);
	sprintf(szData,"Largo Data %i",pData->nLenData);
	WriteLog(0,szData);
	if (pData->nLenData==0) 
	{
		free(pData);
		fclose(f);
		return NULL;
	}
	pData->data = (char *)malloc(pData->nLenData+10);
	nLeidos=fread(pData->data, sizeof(char),pData->nLenData,f);
	pData->data[pData->nLenData]=0;
	fclose(f);
	return pData;
}

void LimpiaIpBackoffices(Tipo_IpBackoffices *pFormato)
{
	Tipo_IpBackoffices *pAux=pFormato,*pAux1;
	while(pAux!=NULL) 
	{
		pAux1=pAux->pNext;
		free(pAux);
		pAux=pAux1;
	}
}

int BuscaArchivosDirectorio(int id,char szPath[],char szFile[])
{
	struct dirent *dirent=NULL;
	off_t i;
	DIR *dir =Conexion[id].directorio;

	if (dir==NULL) 
	{
		//printf("Opendir\n\r");
		dir = opendir(szPath);
	}
	if (!dir)
	{
		printf("Directorio invalido\n\r");
		dir=NULL;
		Conexion[id].directorio=dir;
		return -1;
	}
	else
	{
		//printf("read dir\n\r");
		dirent=readdir(dir);
		if (!dirent) 
		{
			//printf("close dir\n\r");
			closedir(dir);
			dir=NULL;
			Conexion[id].directorio=dir;
			return -1;
		}	
		//Si son archivos especiales...
		//printf("%s\n\r",dirent->d_name);
		if ((memcmp(dirent->d_name,".",1)==0) ||
		   (memcmp(dirent->d_name,"..",2)==0))
		{
			seekdir(dir,telldir(dir));
			Conexion[id].directorio=dir;
			return -1;
		}

		seekdir(dir,telldir(dir));
		Conexion[id].directorio=dir;
		sprintf(szFile,"%s/%s",szPath,dirent->d_name);
		printf("File %s\n\r",szFile);
		return 1;
	}
}

int BuscaArchivosPatron(int id,char szDirec[],char szPatron[],char szFile[])
{
	struct dirent **namelist;
        int n,sts=0,j;
	char szAux[1024];


	j = scandir(szDirec, &namelist, 0, alphasort);
	n=j;
	if (n < 0)
	{
	      char szAux[200];
	      sprintf(szAux,"Directorio %s no encontrado, se baja proceso",szDirec);
	      perror("scandir");
	      printf("%s\n\r",szAux);
	      WriteLog(id,szAux);
	      Conexion[id].nEstado=C_TERMINAR;
	      sprintf(szAux,"TErmina Conexion[%i].nEstado=%i",id,Conexion[id].nEstado);
	      WriteLog(id,szAux);
	}
	else 
	{
	    while(n--) 
	    {
		   if (fnmatch(szPatron,namelist[n]->d_name,FNM_PATHNAME)==0)
		   {
			sprintf(szFile,"%s%s",szDirec,namelist[n]->d_name);
			sts=1;
			break;
		   }
	    }
	    n=j;
	    while(n--) free(namelist[n]);
	    free(namelist);
        }
        return sts;
}

Tipo_Data *InsertaDataFile(int id,Tipo_Data *pData,Tipo_XML *xml1,Tipo_Formatos *pForSalida,Tipo_XML *xml)
{
	char szTmp[MAX_BUFFER];
	Tipo_XML *xml2=NULL;
	int nLen;

	//Junta la entrada y la salida..
	xml2=StrcpyXML(xml1,xml);
	//ImprimeXML(xml2);
	memset(szTmp,0,sizeof(szTmp));
	AplicaFormatoSalida(id,szTmp,xml2,pForSalida,&nLen);
	printf("LINEA FILE =%s\n\r",szTmp);
	pData = InsertaData(szTmp,pData);
	CierraXML(xml2);
	return pData;
}

int QueryAck(int id,Tipo_XML *xmlresp,char szQueryAck[])
{
	//Si hay una respuesta y un query de ack
	if ((xmlresp) && (strlen(szQueryAck)>0))
	{
		char szSql[MAX_BUFFER];
		ReemplazaTagsStr(xmlresp,szQueryAck,szSql);
		printf("SQL Ack=%s\n\r",szSql);
		WriteLog(id,szSql);
		SendDatabase(id,szSql);
	}
	else 
	{
		char szTmp[100];
		sprintf(szTmp,"Query ACK MAL %x",xmlresp);
		WriteLog(id,szTmp);
		WriteLog(id,szQueryAck);
		
	}
}


Tipo_Data *CierraDataFile(int id,Tipo_XML *xml,Tipo_Data *pData)
{
	if (pData)
	{
	char szRuta[512],szRuta1[1024];
	char szFile[100],szFile1[100];
	char szTmp[1024];
	char szAux[1024];
	char szLinea[MAX_BUFFER];
	char szArchivo[1024];
	DIR *dir;
	FILE *f;
	Tipo_Formatos *pFormatoHeader=NULL,*pFormato=NULL;
	int nFormato,nFormatoHeader,nLen;

	GetStrXML(xml,"RUTA_SALIDA",szRuta,sizeof(szRuta));
	GetStrXML(xml,"FILE_SALIDA",szFile,sizeof(szFile));
	GetIntXML(xml,"FORMATO_HEADER_SALIDA",&nFormatoHeader);

	pFormatoHeader = LeeFormato(id,nFormatoHeader);
	
	//printf("FILE=%s RUTA=%s\n\r",szFile,szRuta);

	if ((strlen(szRuta)>0) && (strlen(szFile)>0))
	{
		//ImprimeXML(xml);
		ReemplazaTagsStr(xml,szRuta,szRuta1);
		dir=opendir(szRuta1);
		//si el directorio no existe,,
		if (!dir)
		{
		     sprintf(szAux,"mkdir -p %s",szRuta1);
		     system(szAux);
		     usleep(500);
		}
		else closedir(dir);
		//ImprimeXML(xml);
		sprintf(szTmp,"File=%s/%s\n\r",szRuta1,szFile);
		printf("%s\n\r",szTmp);
		ReemplazaTagsStr(xml,szFile,szFile1);
		sprintf(szTmp,"File=%s/%s\n\r",szRuta1,szFile1);
		printf("%s\n\r",szTmp);
		WriteLog(id,szTmp);
		//Verificamos la ruta y si podemos crear el archivo..
		sprintf(szArchivo,"%s%s",szRuta1,szFile1);
		printf("File = %s\n\r",szArchivo);
		f= fopen(szArchivo,"w+");
		if (!f)
		{
        		printf("Archivo %s no puede ser creado, verifique directorio y nombre\n\r",szTmp);
			pData=LiberaData(pData);
			return NULL;
		}

		memset(szLinea,0,sizeof(szLinea));
		AplicaFormatoSalida(id,szLinea,xml,pFormatoHeader,&nLen);
		if (strlen(szLinea)>0) fwrite(szLinea,sizeof(char),strlen(szLinea),f);
		if (pData) fwrite(pData->data,sizeof(char),pData->nLenData,f);
		fclose(f);
		pData=LiberaData(pData);

	}
	}

}

int ImprimeMemoria(int id,char szData[])
{
	/*
	char szAux[1024];
	char szTmp[MAX_BUFFER];
	GetMemoria(id,szAux);
	sprintf(szTmp,"Memoria=%s - %s",szAux,szData);
	WriteError(id,szTmp);
	return 1;
	*/
	return 1;
}

int GetMemoria(int id,char szMem[])
{
	int nLeidos;
	char szFile[512];
	char szData[2048];
	char szAux[1024];
	FILE *f;

	sprintf(szFile,"/proc/%i/status",getpid());
	f = fopen(szFile,"r");
	if (f==NULL) return 0;

	memset(szData,0,sizeof(szData));
	nLeidos=fread(szData,sizeof(char),500,f);
	if (nLeidos)
	{
		char *dta,*dta1;
		dta=(char *)strstr(szData,"VmRSS:");
		if (dta) 
		{
			dta+=6;
			dta1=(char *)strchr(dta,'\n');
			if (dta1)
			{
				memcpy(szAux,dta,dta1-dta);
				szAux[dta1-dta]=0;
				sprintf(szMem,"%s",szAux);
			}
		}
	}

	fclose(f);

	//Tabien lee el load average del sistema y lo reporta
	sprintf(szFile,"/proc/loadavg");
	f = fopen(szFile,"r");
	if (f==NULL) return 0;
	memset(szData,0,sizeof(szData));
	nLeidos=fread(szData,sizeof(char),500,f);
	if (nLeidos)
	{
		sprintf(szMem,"%s %s",szAux,szData);
	}
	fclose(f);
	return 1;
}



void WriteHex(int id,char *szMessage,int nLen)
{
    //local data
    FILE *f;
    char szFile[100];
    struct timeb sTimeb;
    struct tm thoy;
    int i,j;
    char szBuffer[100];
    char szBufferHex[100];
    char szTmp[20];


    if (!LOG(id)) return;
    ftime(&sTimeb);
    localtime_r(&sTimeb.time,&thoy);

    // open the file
    sprintf(szFile,"%04i%02i%02d%02i_%s.LOG",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,global.szPrefijoLog);
    f = fopen(szFile,"a");

    //if the log file did not open then fail
   if(!f) return;

   fprintf(f,"%02i%02i%02i%03i <%02i> Leidos=%i\n",thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id,nLen);

   j=0;
   while(j<nLen)
   {
	   memset(szBufferHex,0,sizeof(szBufferHex));
	   memset(szBuffer,0,sizeof(szBuffer));

	   for(i=0;i<16;i++)
	   {
		if (j>nLen) sprintf(szTmp,"   ");
		else sprintf(szTmp,"%02x ",szMessage[j] & 0377);
	        strcat(szBufferHex,szTmp);
		if (szMessage[j]<30) strcat(szBuffer,"."); 
		else strncat(szBuffer,&szMessage[j],1);
		j++;
	  }
	  fprintf(f,"%s  %s\n",szBufferHex,szBuffer);
   }
   // close the file
   fclose(f);
}


void WriteData(int id,char szMessage[],int nLen)
{
	int i;
	if (global.nDisplayAscii==1) WriteLog(id,szMessage);
	else if (global.nDisplayAscii==2) WriteHex(id,szMessage,nLen);
	else
	{
	   for(i=0;i<nLen;i++) 
		if (szMessage[i]<30) 
		{
			WriteHex(id,szMessage,nLen);
			return;
		}
	   WriteLog(id,szMessage);
	}
	return;
}


int EnviaSms(int id,char szMensaje[],char szFono[])
{
	Tipo_Socket stSocketServicio;
	char szAux[200];
	char szData[200];
	int sts;
	struct tm thoy;

       InicializaSocket(&stSocketServicio,"Socket Servicio");
       if (!ConectaCliente(id,3610,"200.29.71.228",&stSocketServicio))
       {
            sprintf(szAux,"Falla Conexion a Transteln\n\r");
            printf("Falla Conexion Transtel\n\r");
            WriteLog(id,szAux);
            return 0;
       }
       sprintf(szAux,"SMS_SENDISYS_SMS_GENERICO   %s Info %s-%s",szFono,global.szProceso,szMensaje);
       if ((sts=send(stSocketServicio.m_socket,szAux,strlen(szAux),0))<0)
       {
            WriteLog(id,"Falla envio");
            printf("Falla Envio Transtel\n\r");
            return 0;
       }

       printf("Envia %s\n\r",szAux);
       WriteLog(0,szAux);

       LeeData(id,stSocketServicio.m_socket,szData,10);
       WriteLog(0,szData);
       close(stSocketServicio.m_socket);
}



