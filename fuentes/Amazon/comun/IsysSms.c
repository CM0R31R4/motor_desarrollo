#include <stdio.h>
#include <xml.h>
#include <time.h>
#include <tx.h>

Tipo_XML *TransformaDataEntranteNivelXML(int id,Tipo_XML *xml,Tipo_XML *xmlin,int nNivel)
{
	Tipo_Formatos *pFormatoIn,*pFormatoOut,*pFormatoOutTexto;
	Tipo_Formatos *pFormatoInTrans,*pFormatoOutTrans;
	char szData[MAX_BUFFER];
	Tipo_XML *xml2=NULL;
	int nFormatoIn,nFormatoInTrans,nFormatoOutTrans,nFormatoOut,nFormatoOutTexto;
	int nLen;
	char szCampoTexto[100];

	GetNivelIntXML(xml,"FORMATO_ENTRADA",&nFormatoIn,nNivel);
	GetNivelIntXML(xml,"FORMATO_IN_TRANS",&nFormatoInTrans,nNivel);
	GetNivelIntXML(xml,"FORMATO_OUT_TRANS",&nFormatoOutTrans,nNivel);
	GetNivelIntXML(xml,"FORMATO_SALIDA",&nFormatoOut,nNivel);
	GetNivelIntXML(xml,"FORMATO_SALIDA_TEXTO",&nFormatoOutTexto,nNivel);
	GetNivelStrXML(xml,"NOMBRE_CAMPO_TEXTO",szCampoTexto,sizeof(szCampoTexto),nNivel);

	//Lee los formatos que corresponden a este paquete
	pFormatoIn=LeeFormato(id,nFormatoIn);
	pFormatoInTrans=LeeFormato(id,nFormatoInTrans);
	pFormatoOutTrans=LeeFormato(id,nFormatoOutTrans);
	pFormatoOut=LeeFormato(id,nFormatoOut);
	pFormatoOutTexto=LeeFormato(id,nFormatoOutTexto);

        //Si existe formato de entrada...
	if (pFormatoIn)
	{
	      char szMemo[200];
	      memset(szData,0,sizeof(szData));
	      AplicaFormatoSalida(id,szData,xmlin,pFormatoIn,&nLen);
	      printf("LINEA Formato Entrada=%s\n\r",szData);
	      xmlin=CierraXML(xmlin);
	}

	
	//Aplica formatos de Transformacion para cambiar el orden
	if (pFormatoInTrans)
	{
		printf("APlica Formato T1= %i\n\r",nFormatoInTrans);
		xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoInTrans,strlen(szData));
		//ImprimeXML(xmlin);
		printf("APlica Formato T2= %i\n\r",nFormatoOutTrans);
		AplicaFormatoSalida(id,szData,xmlin,pFormatoOutTrans,&nLen);
		printf("LINEA Formato T2=%s\n\r",szData);
		xmlin=CierraXML(xmlin);
	}

	if (!pFormatoOut)
	{
		WriteLog(id,"No existe formato del salida en isys_tx_formato2");
		return NULL;
	}
		
	printf("APlica Formato Salida= %i\n\r",nFormatoOut);
	xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoOut,strlen(szData));
	xml2=StrcpyXML(xmlin,xml);
	xmlin=CierraXML(xmlin);

	if (pFormatoOutTexto)
	{
		printf("APlica Formato Texto Out= %i\n\r",nFormatoOutTexto);
		memset(szData,0,sizeof(szData));
		AplicaFormatoSalida(id,szData,xml2,pFormatoOutTexto,&nLen);
		printf("LINEA (%i)=%s\n\r",strlen(szData),szData);
		xml2=InsertaDataXML(xml2,szCampoTexto,szData);
	}
	return xml2;

}
Tipo_XML *TransformaDataEntranteXML(int id,Tipo_XML *xml,Tipo_XML *xmlin)
{
	Tipo_Formatos *pFormatoIn,*pFormatoOut,*pFormatoOutTexto;
	Tipo_Formatos *pFormatoInTrans,*pFormatoOutTrans;
	char szData[MAX_BUFFER];
	Tipo_XML *xml2=NULL;
	int nFormatoIn,nFormatoInTrans,nFormatoOutTrans,nFormatoOut,nFormatoOutTexto;
	int nLen;
	char szCampoTexto[100];

	GetIntXML(xml,"FORMATO_ENTRADA",&nFormatoIn);
	GetIntXML(xml,"FORMATO_IN_TRANS",&nFormatoInTrans);
	GetIntXML(xml,"FORMATO_OUT_TRANS",&nFormatoOutTrans);
	GetIntXML(xml,"FORMATO_SALIDA",&nFormatoOut);
	GetIntXML(xml,"FORMATO_SALIDA_TEXTO",&nFormatoOutTexto);
	GetStrXML(xml,"NOMBRE_CAMPO_TEXTO",szCampoTexto,sizeof(szCampoTexto));

	//Lee los formatos que corresponden a este paquete
	pFormatoIn=LeeFormato(id,nFormatoIn);
	pFormatoInTrans=LeeFormato(id,nFormatoInTrans);
	pFormatoOutTrans=LeeFormato(id,nFormatoOutTrans);
	pFormatoOut=LeeFormato(id,nFormatoOut);
	pFormatoOutTexto=LeeFormato(id,nFormatoOutTexto);

        //Si existe formato de entrada...
	if (pFormatoIn)
	{
	      char szMemo[200];
	      memset(szData,0,sizeof(szData));
	      AplicaFormatoSalida(id,szData,xmlin,pFormatoIn,&nLen);
	      printf("LINEA Formato Entrada=%s\n\r",szData);
	      xmlin=CierraXML(xmlin);
	}

	
	//Aplica formatos de Transformacion para cambiar el orden
	if (pFormatoInTrans)
	{
		printf("APlica Formato T1= %i\n\r",nFormatoInTrans);
		xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoInTrans,strlen(szData));
		//ImprimeXML(xmlin);
		printf("APlica Formato T2= %i\n\r",nFormatoOutTrans);
		AplicaFormatoSalida(id,szData,xmlin,pFormatoOutTrans,&nLen);
		printf("LINEA Formato T2=%s\n\r",szData);
		xmlin=CierraXML(xmlin);
	}

	if (!pFormatoOut)
	{
		WriteLog(id,"No existe formato del salida en isys_tx_formato3");
		return NULL;
	}
		
	printf("APlica Formato Salida= %i\n\r",nFormatoOut);
	xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoOut,strlen(szData));
	xml2=StrcpyXML(xmlin,xml);
	xmlin=CierraXML(xmlin);

	if (pFormatoOutTexto)
	{
		printf("APlica Formato Texto Out= %i\n\r",nFormatoOutTexto);
		memset(szData,0,sizeof(szData));
		AplicaFormatoSalida(id,szData,xml2,pFormatoOutTexto,&nLen);
		printf("LINEA (%i)=%s\n\r",strlen(szData),szData);
		xml2=InsertaDataXML(xml2,szCampoTexto,szData);
	}
	return xml2;

}

Tipo_XML *TransformaPaquete(int id,Tipo_XML *xml,char szMsg[],char szData[])
{ 
	Tabla_FormatoSms        stFormatoSms;
	Tipo_Formatos *pFormatoIn,*pFormatoOut,*pFormatoOutTexto;
	Tipo_Formatos *pFormatoInTrans,*pFormatoOutTrans;
	char szTmp[MAX_BUFFER];
	Tipo_XML *xmlin=NULL;
	Tipo_XML *xml2=NULL;
	int nLen;

	stFormatoSms.chTipoTx= szMsg[0];
	stFormatoSms.chProtocolo=szMsg[1];
        memcpy(stFormatoSms.szCliente,&szMsg[2],3); stFormatoSms.szCliente[3]=0;


	//Busca los formatos que aplicar para este mensaje
	if (!BuscaFormatoSms(id,&stFormatoSms))
	{
            WriteLog(id,szMsg);
	    sprintf(szTmp,"No existe formato de salida en sms_formato_sms para Tipo_Tx=%c Cliente=%s",stFormatoSms.chTipoTx,stFormatoSms.szCliente);
	      WriteLog(id,szTmp);
	      return 0;
	}

	//Lee los formatos que corresponden a este paquete
	pFormatoIn=LeeFormato(id,stFormatoSms.nFormatoIn);
	pFormatoInTrans=LeeFormato(id,stFormatoSms.nFormatoInTrans);
	pFormatoOutTrans=LeeFormato(id,stFormatoSms.nFormatoOutTrans);
	pFormatoOut=LeeFormato(id,stFormatoSms.nFormatoOut);
	pFormatoOutTexto=LeeFormato(id,stFormatoSms.nFormatoOutTexto);

	sprintf(szData,"%s",szMsg);

        //Si existe formato de entrada...
	if (pFormatoIn)
	{
	      char szMemo[200];
	      printf("APlica Formato Entrada= %i\n\r",stFormatoSms.nFormatoIn);
	      xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoIn,strlen(szData));
	      GetStrXML(xmlin,"MEMO",szMemo,sizeof(szMemo));
	      //ImprimeXML(xmlin);
	      memset(szData,0,sizeof(szData));
	      AplicaFormatoSalida(id,szData,xmlin,pFormatoIn,&nLen);
	      printf("LINEA Formato Entrada=%s\n\r",szData);
	      xmlin=CierraXML(xmlin);
	}

	
	//Aplica formatos de Transformacion para cambiar el orden
	if (pFormatoInTrans)
	{
		printf("APlica Formato T1= %i\n\r",stFormatoSms.nFormatoInTrans);
		xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoInTrans,strlen(szData));
		//ImprimeXML(xmlin);
		printf("APlica Formato T2= %i\n\r",stFormatoSms.nFormatoOutTrans);
		AplicaFormatoSalida(id,szData,xmlin,pFormatoOutTrans,&nLen);
		printf("LINEA Formato T2=%s\n\r",szData);
		xmlin=CierraXML(xmlin);
	}

	if (!pFormatoOut)
	{
		WriteLog(id,"No existe formato del salida en sms_formato_sms");
		return NULL;
	}
		
	printf("APlica Formato Salida= %i\n\r",stFormatoSms.nFormatoOut);
	xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoOut,strlen(szData));
	xml2=StrcpyXML(xmlin,xml);
	xmlin=CierraXML(xmlin);

	if (pFormatoOutTexto)
	{
		printf("APlica Formato Texto Out= %i\n\r",stFormatoSms.nFormatoOutTexto);
		memset(szData,0,sizeof(szData));
		AplicaFormatoSalida(id,szData,xml2,pFormatoOutTexto,&nLen);
		printf("LINEA (%i)=%s\n\r",strlen(szData),szData);
	}
	else
	{
		//xmlin=InsertaDataXML(xmlin,"TX",stFormatoSms.szTxBack);
		//memset(szData,0,sizeof(szData));
		//InsertaXMLResponse(szData,xmlin);
	}
	
	memcpy(szTmp,&szData[stFormatoSms.nPosicionDatos],strlen(&szData[stFormatoSms.nPosicionDatos])); szTmp[strlen(&szData[stFormatoSms.nPosicionDatos])]=0;
	memset(szData,0,sizeof(szData));
	memcpy(szData,szTmp,strlen(szTmp));
	printf("LINEA FIN=%s\n\r",szData);
	WriteLog(id,"DATA3");
	WriteLog(id,szData);
	return xml2;
}

Tipo_XML *TransformaDataEntranteNivel(int id,Tipo_XML *xml,char szMsg[],int nNivel)
{ 
	Tipo_Formatos *pFormatoIn,*pFormatoOut,*pFormatoOutTexto;
	Tipo_Formatos *pFormatoInTrans,*pFormatoOutTrans;
	char szData[MAX_BUFFER];
	Tipo_XML *xmlin=NULL;
	Tipo_XML *xml2=NULL;
	int nFormatoIn,nFormatoInTrans,nFormatoOutTrans,nFormatoOut,nFormatoOutTexto;
	int nLen;
	char szCampoTexto[100];

	GetNivelIntXML(xml,"FORMATO_ENTRADA",&nFormatoIn,nNivel);
	GetNivelIntXML(xml,"FORMATO_IN_TRANS",&nFormatoInTrans,nNivel);
	GetNivelIntXML(xml,"FORMATO_OUT_TRANS",&nFormatoOutTrans,nNivel);
	GetNivelIntXML(xml,"FORMATO_SALIDA",&nFormatoOut,nNivel);
	GetNivelIntXML(xml,"FORMATO_SALIDA_TEXTO",&nFormatoOutTexto,nNivel);
	GetNivelStrXML(xml,"NOMBRE_CAMPO_TEXTO",szCampoTexto,sizeof(szCampoTexto),nNivel);

	//Lee los formatos que corresponden a este paquete
	pFormatoIn=LeeFormato(id,nFormatoIn);
	pFormatoInTrans=LeeFormato(id,nFormatoInTrans);
	pFormatoOutTrans=LeeFormato(id,nFormatoOutTrans);
	pFormatoOut=LeeFormato(id,nFormatoOut);
	pFormatoOutTexto=LeeFormato(id,nFormatoOutTexto);

	sprintf(szData,"%s",szMsg);
	//WriteLog(id,szData);

        //Si existe formato de entrada...
	if (pFormatoIn)
	{
	      char szMemo[200];
	      printf("APlica Formato Entrada= %i\n\r",nFormatoIn);
	      xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoIn,strlen(szData));
	      memset(szData,0,sizeof(szData));
	      //AplicaFormatoSalida(szData,xmlin,pFormatoIn);
	      //printf("APlica Formato T1 Salida= %i\n\r",nFormatoInTrans);
	      AplicaFormatoSalida(id,szData,xmlin,pFormatoInTrans,&nLen);
	      printf("LINEA Formato Salida=%s\n\r",szData);
	      xmlin=CierraXML(xmlin);
	}
	//WriteLog(id,"PAso 1");
	//WriteLog(id,szData);

	
	//Aplica formatos de Transformacion para cambiar el orden
	if (pFormatoInTrans)
	{
		printf("*APlica Formato Entrada T1= %i\n\r",nFormatoInTrans);
		xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoInTrans,strlen(szData));
		//ImprimeXML(xmlin);
		printf("*APlica Formato Salida T2= %i\n\r",nFormatoOutTrans);
		AplicaFormatoSalida(id,szData,xmlin,pFormatoOutTrans,&nLen);
		printf("LINEA Formato T2=%s\n\r",szData);
		xmlin=CierraXML(xmlin);
	}

	if (!pFormatoOut)
	{
		WriteLog(id,"No existe formato del salida en isys_tx_formato4");
		return NULL;
	}
	//WriteLog(id,"PAso 2");
	//WriteLog(id,szData);
		
	printf("APlica Formato Salida= %i\n\r",nFormatoOut);
	xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoOut,strlen(szData));
	//xml2=StrcpyXML(xmlin,xml);
	//xmlin=CierraXML(xmlin);

	if (pFormatoOutTexto)
	{
		printf("APlica Formato Texto Out= %i\n\r",nFormatoOutTexto);
		memset(szData,0,sizeof(szData));
		AplicaFormatoSalida(id,szData,xmlin,pFormatoOutTexto,&nLen);
		printf("LINEA (%i)=%s\n\r",strlen(szData),szData);
		xmlin=InsertaDataXML(xmlin,szCampoTexto,szData);
	}
	//WriteLog(id,"PAso 3");
	//WriteLog(id,szData);
	return xmlin;

}



Tipo_XML *TransformaDataEntrante(int id,Tipo_XML *xml,char szMsg[])
{ 
	Tipo_Formatos *pFormatoIn,*pFormatoOut,*pFormatoOutTexto;
	Tipo_Formatos *pFormatoInTrans,*pFormatoOutTrans;
	char szData[MAX_BUFFER];
	Tipo_XML *xmlin=NULL;
	Tipo_XML *xml2=NULL;
	int nFormatoIn,nFormatoInTrans,nFormatoOutTrans,nFormatoOut,nFormatoOutTexto;
	int nLen;
	char szCampoTexto[100];

	GetIntXML(xml,"FORMATO_ENTRADA",&nFormatoIn);
	GetIntXML(xml,"FORMATO_IN_TRANS",&nFormatoInTrans);
	GetIntXML(xml,"FORMATO_OUT_TRANS",&nFormatoOutTrans);
	GetIntXML(xml,"FORMATO_SALIDA",&nFormatoOut);
	GetIntXML(xml,"FORMATO_SALIDA_TEXTO",&nFormatoOutTexto);
	GetStrXML(xml,"NOMBRE_CAMPO_TEXTO",szCampoTexto,sizeof(szCampoTexto));

	//Lee los formatos que corresponden a este paquete
	pFormatoIn=LeeFormato(id,nFormatoIn);
	pFormatoInTrans=LeeFormato(id,nFormatoInTrans);
	pFormatoOutTrans=LeeFormato(id,nFormatoOutTrans);
	pFormatoOut=LeeFormato(id,nFormatoOut);
	pFormatoOutTexto=LeeFormato(id,nFormatoOutTexto);

	sprintf(szData,"%s",szMsg);

        //Si existe formato de entrada...
	if (pFormatoIn)
	{
	      char szMemo[200];
	      printf("APlica Formato Entrada= %i\n\r",nFormatoIn);
	      xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoIn,strlen(szData));
	      memset(szData,0,sizeof(szData));
	      AplicaFormatoSalida(id,szData,xmlin,pFormatoIn,&nLen);
	      printf("LINEA Formato Entrada=%s\n\r",szData);
	      xmlin=CierraXML(xmlin);
	}

	
	//Aplica formatos de Transformacion para cambiar el orden
	if (pFormatoInTrans)
	{
		printf("APlica Formato T1= %i\n\r",nFormatoInTrans);
		xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoInTrans,strlen(szData));
		//ImprimeXML(xmlin);
		printf("APlica Formato T2= %i\n\r",nFormatoOutTrans);
		AplicaFormatoSalida(id,szData,xmlin,pFormatoOutTrans,&nLen);
		printf("LINEA Formato T2=%s\n\r",szData);
		xmlin=CierraXML(xmlin);
	}

	if (!pFormatoOut)
	{
		WriteLog(id,"No existe formato del salida en isys_tx_formato5");
		return NULL;
	}
		
	printf("APlica Formato Salida= %i\n\r",nFormatoOut);
	xmlin=AplicaFormatoEntrada(id,xml,szData,pFormatoOut,strlen(szData));
	//xml2=StrcpyXML(xmlin,xml);
	//xmlin=CierraXML(xmlin);

	if (pFormatoOutTexto)
	{
		printf("APlica Formato Texto Out= %i\n\r",nFormatoOutTexto);
		memset(szData,0,sizeof(szData));
		AplicaFormatoSalida(id,szData,xmlin,pFormatoOutTexto,&nLen);
		printf("LINEA (%i)=%s\n\r",strlen(szData),szData);
		xmlin=InsertaDataXML(xmlin,szCampoTexto,szData);
	}
	return xmlin;

}


Tipo_XML *TransformaDataEntranteNivel1(int id,Tipo_XML *xml,char szMsg[],int nNivel,int nLenMsg)
{ 
	Tipo_Formatos *pFormatoIn,*pFormatoOut,*pFormatoOutTexto;
	Tipo_Formatos *pFormatoInTrans,*pFormatoOutTrans;
	char szData[MAX_BUFFER];
	//char *szData=NULL;
	Tipo_XML *xml1=NULL;
	//Tipo_XML *xmlin=NULL;
	//Tipo_XML *xml2=NULL;
	int nFormatoIn,nFormatoInTrans,nFormatoOutTrans,nFormatoOut,nFormatoOutTexto;
	int nLen;
	char szCampoTexto[100];


	GetNivelIntXML(xml,"FORMATO_ENTRADA",&nFormatoIn,nNivel);
	GetNivelIntXML(xml,"FORMATO_IN_TRANS",&nFormatoInTrans,nNivel);
	GetNivelIntXML(xml,"FORMATO_OUT_TRANS",&nFormatoOutTrans,nNivel);
	GetNivelIntXML(xml,"FORMATO_SALIDA",&nFormatoOut,nNivel);
	GetNivelIntXML(xml,"FORMATO_SALIDA_TEXTO",&nFormatoOutTexto,nNivel);
	GetNivelStrXML(xml,"NOMBRE_CAMPO_TEXTO",szCampoTexto,sizeof(szCampoTexto),nNivel);

	//Lee los formatos que corresponden a este paquete
	pFormatoIn=LeeFormato(id,nFormatoIn);
	pFormatoInTrans=LeeFormato(id,nFormatoInTrans);
	pFormatoOutTrans=LeeFormato(id,nFormatoOutTrans);
	pFormatoOut=LeeFormato(id,nFormatoOut);
	pFormatoOutTexto=LeeFormato(id,nFormatoOutTexto);

	memcpy(szData,szMsg,nLenMsg); szData[nLenMsg]=0;
	//WriteLog(id,szData);

        //Si existe formato de entrada...
	if (pFormatoIn)
	{
	      //printf("APlica Formato Entrada= %i\n\r",nFormatoIn);
	      //WriteLog(id,"Datos Entrada");
	      //WriteLog(id,szData);
	      xml1=AplicaFormatoEntrada(id,xml1,szData,pFormatoIn,nLenMsg);
	      //ImprimeXML(xmlin);
	      if (pFormatoInTrans)
	      {
	      	//AplicaFormatoSalida(szData,xmlin,pFormatoIn);
	      	//printf("APlica Formato T1 Salida= %i\n\r",nFormatoInTrans);
	        memset(szData,0,sizeof(szData));
	      	AplicaFormatoSalida(id,szData,xml1,pFormatoInTrans,&nLen);
	        //WriteLog(id,"Data Salida1");
	        //WriteLog(id,szData);
	      
		if (pFormatoOutTrans)
		{
	      		//xmlin=CierraXML(xmlin);
	      		//printf("APlica Formato Entrada T2= %i\n\r",nFormatoOutTrans);
	WriteLog(id,"Paso 4");
	      		xml1=AplicaFormatoEntrada(id,xml1,szData,pFormatoOutTrans,nLen);
		}
	      }
	      //ImprimeXML(xmlin);
	}
	else
	{
		WriteLog(id,"No existe formato del entrada para la tx1");
		return NULL;
	}

	if (pFormatoOut)
	{
		printf("APlica Formato Salida Out= %i\n\r",nFormatoOut);
        	AplicaFormatoSalida(id,szData,xml1,pFormatoOut,&nLen);
		printf("LINEA Formato Out=%s\n\r",szData);
			
		if (pFormatoOutTexto)
		{
			//xmlin=CierraXML(xmlin);
			printf("APlica Formato Entrada Final= %i\n\r",nFormatoOutTexto);
	WriteLog(id,"Paso 3");
			xml1=AplicaFormatoEntrada(id,xml1,szData,pFormatoOutTexto,strlen(szData));
		}
	}
	//WriteLog(id,"fin TransformaDataEntranteNivel1");
	//ImprimeXML1(xml1,id);
	//WriteLog(id,"fin TransformaDataEntranteNivel1*");
	return xml1;
}

