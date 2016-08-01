#include <stdio.h>
#include <stdlib.h>
#include <xml.h>
#include <tipos.h>
#include <tiposocket.h>
#include <IsysSocket.h>
#include <time.h>
#include <const.h>
#include <asm/ioctls.h>
#include <sys/socket.h>
#include <sys/timeb.h>
#include <netinet/in.h>
#include <errno.h>
#include <fcntl.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <json/json.h>



Tipo_XML *QueryDatabasePersistente1(int id,char szSql[],char szCampo[],char szError[],Tipo_XML *xml,int *nStatus);
Tipo_XML *GetRecord1(int id,char szSql[],Tipo_XML *xml,int *nStatus,char *szTipoRecord);
void WriteLogEst(int id,char *szMessage);
void WriteMensajeApp(int id,char *data);
void WriteError(int id,char *szMessage);
int GetNombreCampo(char szCampo[],char szCampoOut[])
{
	char *ini;
	ini=(char *)strchr(szCampo,'[');
	if (ini==NULL) goto fin;
	if (strlen(szCampo)-strlen(ini)<0) goto fin;
	memcpy(szCampoOut,szCampo,strlen(szCampo)-strlen(ini));
	szCampoOut[strlen(szCampo)-strlen(ini)]=0;
	return 1;
fin:
	sprintf(szCampoOut,"%s",szCampo);
	return 1;
}

int UpperLen(char szData[],int len)
{
        int i;
        for(i=0;i<len;i++)
        if ((szData[i]>=97) && (szData[i]<=122)) szData[i]-=32;
		return 1;
}
int Upper(char szData[])
{
	return UpperLen(szData,strlen(szData));
}

int WriteXML(int id,Tipo_XML *xml)
{
	while(xml!=NULL)
	{
		WriteLog(id,xml->szCampo);
		WriteLog(id,xml->pData);
		xml=xml->pNext;
	}
}

int ImprimeXML1(Tipo_XML *xml,int id)
{
	Tipo_XML *xml1=xml;
	Tipo_XML *xml2;
	char szAux[200];
	WriteError(id,"ImprimeXML");
	printf("ImprimeXML\n\r");
	if (xml==NULL) 
	{
		WriteError(id,"ImprimeXML Nulo");
		printf("XML Nulo\n\r");
		return;
	}
	do
	{
		sprintf(szAux,"NIVEL %i",xml1->nNivel);
		printf("%s\n\r",szAux);
		WriteError(id,szAux);
		xml2=xml1->pNextNivel;
		while(xml1!=NULL)
		{
			printf("%s[%i]=%s\n\r",xml1->szCampo,xml1->nNivel,xml1->pData);
			WriteError(id,xml1->szCampo);
			WriteError(id,xml1->pData);
			xml1=xml1->pNext;
		}
		xml1=xml2;
	}while(xml1!=NULL);
	WriteError(id,"Fin ImprimeXM");
	printf("Fin XML\n\r");
}

int SerializaStdout(Tipo_XML *xml)
{
	Tipo_XML *xml1=xml;
	Tipo_XML *xml2;
	char szAux[2048];
	if (xml==NULL) 
	{
		return;
	}
	do
	{
		xml2=xml1->pNextNivel;
		while(xml1!=NULL)
		{
			fprintf(stdout,"%s[%i]=%s###",xml1->szCampo,strlen(xml1->pData),xml1->pData);
			xml1=xml1->pNext;
		}
		xml1=xml2;
	}while(xml1!=NULL);
}


int ImprimeXML(Tipo_XML *xml)
{
	Tipo_XML *xml1=xml;
	Tipo_XML *xml2;
	char szAux[2048];
	WriteLog(0,"ImprimeXML");
	printf("****ImprimeXML****** %x\n\r",xml);
	if (xml==NULL) 
	{
		WriteLog(0,"ImprimeXML Nulo");
		printf("****ImprimeXML NULO******\n\r");
		return;
	}
	do
	{
		printf("Paso 1\n\r");
		sprintf(szAux,"NIVEL %i",xml1->nNivel);
		WriteLog(0,szAux);
		printf("%s\n\r",szAux);
		xml2=xml1->pNextNivel;
		printf("Paso 2\n\r");
		while(xml1!=NULL)
		{
			sprintf(szAux,"Campo=%s Largo=%i",xml1->szCampo,strlen(xml1->pData));
			WriteLog(0,szAux);
			WriteLog(0,xml1->pData);
			printf("CAMPO=%s DATA=%s",xml1->szCampo,xml1->pData);
			xml1=xml1->pNext;
		}
		xml1=xml2;
		printf("Paso 3\n\r");
	}while(xml1!=NULL);
	printf("****FIN ImprimeXML******\n\r");
}

//Genera un nuevo XML copiando los otros 2
Tipo_XML *StrcpyXML(Tipo_XML *xml1,Tipo_XML *xml2)
{
	Tipo_XML *xml=NULL;
	
	while(xml1!=NULL) 
	{
		xml=InsertaDataXML(xml,xml1->szCampo,xml1->pData);
		xml1=xml1->pNext;
	}
	while(xml2!=NULL) 
	{
		xml=InsertaDataXML(xml,xml2->szCampo,xml2->pData);
		xml2=xml2->pNext;
	}
	return xml;
}

int IsNumber1(char chAux)
{
	if ((chAux>='0') && (chAux<='9')) return 1;
	else return 0;
}

int IsNumber(char szAux[])
{
	int i;
	int len1;
	len1=strlen(szAux);
	for(i=0;i<len1;i++)
	{
		if ((szAux[i]<'0') || (szAux[i]>'9')) return 0;
	}
	return 1;
}

int strrev(char szAux[])
{
	int i,j;
	char szTmp[1024];
	int len1;
	j=0;
	len1=strlen(szAux)-1;
	for(i=len1;i>=0;i--)
	{
		szTmp[j++]=szAux[i];
	}
	szTmp[j]=0;
	sprintf(szAux,"%s",szTmp);
	return 1;
}

//Obtiene un solo nivel de los datos obtenidos por GetRecords
//2006-09-01 no devuelve un XML nuevo
//solo devuelve el punterno al nivel que corresponde
Tipo_XML *GetNivelXML(Tipo_XML *xml,int nNivel)
{
	return BuscaNivel(xml,nNivel);
}

Tipo_XML *StrcatXML(Tipo_XML *xml,Tipo_XML *xml2)
{
	//char szCampo[MAX_BUFFER];
	//char szAux[MAX_BUFFER];
	Tipo_XML *xml_ori=NULL;
	if ((xml==NULL) && (xml2==NULL)) return NULL;
	if (xml2==NULL) return xml;
	else if (xml==NULL) {return xml2;}
	xml_ori=xml;
	while(xml->pNext!=NULL) xml=xml->pNext;

	xml->pNext=xml2;
	return xml_ori;
}


Tipo_XML *UpdateXML(Tipo_XML *xml,Tipo_XML *xml2)
{
	Tipo_XML *xml_next;
	if (xml2!=NULL) xml_next=xml2->pNextNivel;
	while(xml2!=NULL)
	{
		//printf("UpdateXML %i %s %s\n\r",xml2->nNivel,xml2->szCampo,xml2->pData);
		xml=InsertaDataXML(xml,xml2->szCampo,xml2->pData);
		xml2=xml2->pNext;
		if (xml2==NULL) 
		{
			xml2=xml_next;
			if (xml2!=NULL) xml_next=xml2->pNextNivel;
		}
	}
	return xml;
}

/*
Esta funcion hace el update de los procesos que terminan en el envio masivo a los
emisores, el problema era que al leer antes un dato en nulo el update siempre lo dejaba nulo al final
sin importar la respuesta de 1 de los hilos, por eso solo se traspasan al xml padre los valores mayores que cero*/
Tipo_XML *UpdateXMLSinNulo(Tipo_XML *xml,Tipo_XML *xml2)
{
	Tipo_XML *xml_next;
	if (xml2!=NULL) xml_next=xml2->pNextNivel;
	while(xml2!=NULL)
	{
		//printf("UpdateXML %i %s %s\n\r",xml2->nNivel,xml2->szCampo,xml2->pData);
		//Solo valores no nulos
		if (strlen(xml2->pData)>0) xml=InsertaDataXML(xml,xml2->szCampo,xml2->pData);
		xml2=xml2->pNext;
		if (xml2==NULL) 
		{
			xml2=xml_next;
			if (xml2!=NULL) xml_next=xml2->pNextNivel;
		}
	}
	return xml;
}
/*
Tipo_XML *UpdateXML(Tipo_XML *xml,Tipo_XML *xml2)
{
	char szCampo[MAX_BUFFER];
	char szAux[MAX_BUFFER];
	Tipo_XML *xml2_rec=NULL;
	if ((xml==NULL) && (xml2==NULL)) return NULL;
	if (xml2==NULL) return xml;
	else if (xml==NULL) xml=StrcpyXML(xml2,NULL);
	else
	{
	   while(xml2!=NULL)
	   {
		//si existe el campo en el xml original..
		if (GetStrXML(xml,xml2->szCampo,szAux,sizeof(szAux)))
		{
			//Si el nuevo valor tiene largo cero lo borra
			if (strlen(xml2->pData)>0)
			{
				//updatea el campo al nuevo valor..
				SetValorXML(xml,xml2->szCampo,xml2->pData);
			}
			else 
			{
				xml=BorraCampoXML(xml,xml2->szCampo);
			}
		}
		else InsertaDataXML(xml,xml2->szCampo,xml2->pData);
		xml2=xml2->pNext;
	   }
	}
	return xml;
}
*/
int InsertaXMLResponse(char *response,Tipo_XML *xml)
{
	//char szCampo[MAX_BUFFER];
	//char szAux[MAX_BUFFER];
	if (xml==NULL) return 1;
	while(xml!=NULL)
	{
		if (memcmp(xml->szCampo,"STATUS",6)!=0)
		{
			InsertaCampoXML(response,xml->szCampo,xml->pData);
		}
		xml = xml->pNext;
	}
	return 1;
}

int InsertaCampoLongXML(char *response,char szCampo[],long nData)
{
        char szData[20];
        strcat(response,"<");
        strcat(response,szCampo);
        strcat(response,">");
        sprintf(szData,"%ld",nData);
        strcat(response,szData);
        strcat(response,"</");
        strcat(response,szCampo);
        strcat(response,">");
        return 1;
}  

int InsertaCampoIntXML(char *response,char szCampo[],int nData)
{
	char szData[20];
	strcat(response,"<");
	strcat(response,szCampo);
	strcat(response,">");
	sprintf(szData,"%i",nData);
	strcat(response,szData);
	strcat(response,"</");
	strcat(response,szCampo);
	strcat(response,">");
	return 1;
}

int nNivelCampo(char szCampo[])
{
	char *ini,*fin;
	int i,j;
	int nNivel=-1;
	char szAux[MAX_LEN_CAMPO];

	ini=(char *)strchr(szCampo,'[');
	if (ini==NULL) 
	{
		int len1;
		j=0;
		len1=strlen(szCampo)-1;
		for(i=len1;i>=0;i--)
		{
			if (IsNumber1(szCampo[i]))
				szAux[j++]=szCampo[i];
			else break;
		}
		if (j==0)  return -1;
		szAux[j++]=0;
		strrev(szAux);
		//WriteLog(0,szAux);
		return atoi(szAux);
	}
	else
	{
		ini++;
		fin=(char *)strchr(ini,']');
		if (fin==NULL) return -1;
		memcpy(szAux,ini,fin-ini); 
		szAux[fin-ini]=0;
		//WriteLog(0,szAux);
		return atoi(szAux);
	}
}

Tipo_XML *NivelCampo(Tipo_XML *xml2)
{
	char *ini,*fin;
	int i,j;
	char szAux[MAX_LEN_CAMPO];
		
	xml2->nNivel=-1;
	xml2->nTipoCampo=1;
	ini=(char *)strchr(xml2->szCampo,'[');
	if (ini==NULL) 
	{
		int len1;
		j=0;
		len1=strlen(xml2->szCampo)-1;	
		for(i=len1;i>=0;i--)
		{
			//char szR[20];
			//sprintf(szR,"Letra[%i]=%c",i,szCampo[i]);
			//WriteLog(0,szR);
			if (IsNumber1(xml2->szCampo[i]))
				szAux[j++]=xml2->szCampo[i];
			else break;
		}
		if (j==0) 
		{
			//WriteLog(0,"No es numero");
			return xml2;
		}
		szAux[j++]=0;
		strrev(szAux);
		//WriteLog(0,szAux);
		xml2->nNivel=atoi(szAux);
		xml2->nTipoCampo=2;
		return xml2;
	}
	else
	{
		ini++;
		fin=(char *)strchr(ini,']');
		if (fin==NULL) 
		{
			return xml2;
		}
		memcpy(szAux,ini,fin-ini); 
		szAux[fin-ini]=0;
		xml2->nNivel=atoi(szAux);
		xml2->nTipoCampo=3;
		return xml2;
	}
}
/*2006-09-01 Se agrega matriz para guardar con nivel*/
Tipo_XML *InsertaDataLenXML1(Tipo_XML *xml,char szCampo[],char szData[],int nTipoCampo,int nLenData,int mayusculas)
{
	Tipo_XML *xml1=xml;
	Tipo_XML *xml2=NULL;
	Tipo_XML *xml_up;
	Tipo_XML *xml_ant;
	char szTmp[200];

	//Si no viene data en szData (Puntero nulo)..
	if (!szData) 
	{	
		WriteLog(0,szCampo);
		WriteLog(0,"Data Nula");
		return xml1;
	}
	if (nLenData<0) nLenData=0;

	//Upper(szCampo);
	xml2=IniciaXML();
	xml2->pData = (char *)malloc(nLenData+10);
	if (xml2->pData)
	{	
		xml2->nLenData=nLenData;
		memcpy(xml2->pData,szData,nLenData);
		xml2->pData[nLenData]=0;
		sprintf(xml2->szCampo,"%s",szCampo);
		xml2->nLenCampo=strlen(szCampo);
		if (mayusculas)
		{
			UpperLen(xml2->szCampo,xml2->nLenCampo);
		}
		xml2=NivelCampo(xml2);
		//printf("Largo Data=%i Largo_Campo=%i",nLenData,xml2->nLenCampo);
		//printf("%s",xml2->pData);
	}
	/*
		WriteLog(0,"1)---------------");
		sprintf(szTmp,"Puntero %p",xml2);
		WriteLog(0,szTmp);
		sprintf(szTmp,"nLenData=%i",nLenData,szData);
		WriteLog(0,szTmp);
		WriteLog(0,xml2->szCampo);
		WriteLog(0,xml2->pData);
		WriteLog(0,"2)---------------");
	*/

	xml_up=NULL;
	xml_ant=NULL;
	
	if (xml!=NULL)
	{	
		//char szTmp[1024];
		/*Si no es nivel 0 buscamos el nivel donde insertar*/
		while (xml1->nNivel!=xml2->nNivel) 
		{
			/*Si no hay siguiente nivel lo asigno*/
			if (xml1->pNextNivel==NULL) 
			{
				xml1->pNextNivel=xml2;
				return xml;
			}
			xml_up=xml1;
			xml1=xml1->pNextNivel;
		}

		/*inserto al final de la lista*/
		//A no ser que encuentre el campo, entonces hago update o lo borro si viene vacio
		do
		{
			//Si los campos son iguales
			//Hace un update nunca borra
			if ((xml1->nLenCampo==xml2->nLenCampo) &&
		    	    (memcmp(xml1->szCampo,xml2->szCampo,xml1->nLenCampo)==0))
			//if ((strlen(xml1->szCampo)==strlen(xml2->szCampo)) &&
		    	//    (memcmp(xml1->szCampo,xml2->szCampo,strlen(xml1->szCampo))==0))
			{
				//Si es igual la data.
				if ((xml1->nLenData==xml2->nLenData) &&
	                            (memcmp(xml1->pData,xml2->pData,xml1->nLenData)==0))
				//if ((strlen(xml1->pData)==strlen(xml2->pData)) &&
	                        //    (memcmp(xml1->pData,xml2->pData,strlen(xml1->pData))==0))
				{
					xml2=CierraXML(xml2);
					return xml;
				}
				//Update a la data
				if (xml1->pData!=NULL) free(xml1->pData);
				xml1->pData=(char *)malloc(xml2->nLenData+1);
				memcpy(xml1->pData,xml2->pData,xml2->nLenData);
				xml1->pData[strlen(xml2->pData)]=0;
				xml1->nLenData=xml2->nLenData;
				xml1->nTipoCampo=nTipoCampo;
				xml2=CierraXML(xml2);
				return xml;
			}
			xml_ant=xml1;
			//si no hay siguiente...
			if (xml1->pNext==NULL) break;
			else xml1=xml1->pNext;
		} while(1);
		xml1->pNext=xml2;
		return xml;
	}
	else 
	{
		return xml2;
	}
}
Tipo_XML *InsertaDataLenXML(Tipo_XML *xml,char szCampo[],char szData[],int nLenData)
{
	//Mayusculas
	return InsertaDataLenXML1(xml,szCampo,szData,0,nLenData,1);
}

//Los json no suben a mayusculas las llaves
Tipo_XML *InsertaDataLenXMLJson(Tipo_XML *xml,char szCampo[],char szData[],int nLenData)
{
	//Sin mayusculas
	return InsertaDataLenXML1(xml,szCampo,szData,0,nLenData,0);
}


/*2006-09-01 Se agrega matriz para guardar con nivel*/
/*
Tipo_XML *InsertaDataXML1(Tipo_XML *xml,char szCampo[],char szData[],int nTipoCampo)
{
	Tipo_XML *xml1=xml;
	Tipo_XML *xml2=NULL;
	Tipo_XML *xml_up;
	Tipo_XML *xml_ant;
	char szTmp[200];

	//Si no viene data en szData (Puntero nulo)..
	if (!szData) 
	{	
		WriteLog(0,szCampo);
		WriteLog(0,"Data Nula");
		return xml1;
	}

	Upper(szCampo);
	xml2=IniciaXML();
	xml2->pData = (char *)malloc(strlen(szData)+1);
	if (xml2->pData)
	{	
		xml2->nLenData=strlen(szData);
		xml2->nLenCampo=strlen(szCampo);
		memcpy(xml2->pData,szData,xml2->nLenData);
		xml2->pData[xml2->nLenData]=0;
		memcpy(xml2->szCampo,szCampo,xml2->nLenCampo);
		xml2->szCampo[xml2->nLenCampo]=0;
		//sprintf(xml2->pData,"%s",szData);
		//sprintf(xml2->szCampo,"%s",szCampo);
		xml2=NivelCampo(xml2);
	}

	xml_up=NULL;
	xml_ant=NULL;
	
	if (xml!=NULL)
	{	
		//char szTmp[1024];
		//Si no es nivel 0 buscamos el nivel donde insertar
		while (xml1->nNivel!=xml2->nNivel) 
		{
			//Si no hay siguiente nivel lo asigno
			if (xml1->pNextNivel==NULL) 
			{
				xml1->pNextNivel=xml2;
				return xml;
			}
			xml_up=xml1;
			xml1=xml1->pNextNivel;
		}

		//inserto al final de la lista
		//A no ser que encuentre el campo, entonces hago update o lo borro si viene vacio
		do
		{
			//Si los campos son iguales
			//Hace un update nunca borra
			if ((xml1->nLenCampo==xml2->nLenCampo) &&
		    	    (memcmp(xml1->szCampo,xml2->szCampo,xml1->nLenCampo)==0))
			{
				//Si es igual la data.
				if ((xml1->nLenData==xml2->nLenData) &&
	                            (memcmp(xml1->pData,xml2->pData,xml1->nLenData)==0))
				//if ((strlen(xml1->pData)==strlen(xml2->pData)) &&
	                        //    (memcmp(xml1->pData,xml2->pData,strlen(xml1->pData))==0))
				{
					xml2=CierraXML(xml2);
					return xml;
				}
				//Update a la data
				if (xml1->pData!=NULL) free(xml1->pData);
				xml1->pData=(char *)malloc(xml2->nLenData+1);
				memcpy(xml1->pData,xml2->pData,xml2->nLenData);
				xml1->pData[xml2->nLenData]=0;
				xml1->nTipoCampo=nTipoCampo;
				xml2=CierraXML(xml2);
				return xml;
			}
			xml_ant=xml1;
			//si no hay siguiente...
			if (xml1->pNext==NULL) break;
			else xml1=xml1->pNext;
		} while(1);
		xml1->pNext=xml2;
		return xml;
	}
	else return xml2;
}
*/


Tipo_XML *InsertaDataXML(Tipo_XML *xml,char szCampo[],char szData[])
{
	//Mayusculas
	return InsertaDataLenXML1(xml,szCampo,szData,0,strlen(szData),1);
}
Tipo_XML *InsertaDataXMLJson(Tipo_XML *xml,char szCampo[],char szData[])
{
	//No mayusculas
	return InsertaDataLenXML1(xml,szCampo,szData,0,strlen(szData),0);
}

Tipo_XML *InsertaDataLongXML(Tipo_XML *xml,char szCampo[],long nData)
{
	char szData[100];
	sprintf(szData,"%ld",nData);
	return InsertaDataXML(xml,szCampo,szData);
}

Tipo_XML *InsertaDataIntXML(Tipo_XML *xml,char szCampo[],int nData)
{
	char szData[100];
	sprintf(szData,"%i",nData);
	return InsertaDataXML(xml,szCampo,szData);
}

int InsertaCampoXMLpData(char *response,char szCampo[],char szData[])
{
	/*
	int nLen=strlen(response)+strlen(szCampo)+strlen(szData);
	strcat(response,"<");
	strcat(response,szCampo);
	strcat(response,">");
	strcat(response,szData);
	strcat(response,"</");
	strcat(response,szCampo);
	strcat(response,">");
	return 1;
	*/
	int nPos=strlen(response),nLenCampo=strlen(szCampo),nLenData=strlen(szData);

	memcpy(&response[nPos],"<",1); nPos++;
	memcpy(&response[nPos],szCampo,nLenCampo); nPos+=nLenCampo;
	memcpy(&response[nPos],">",1); nPos++;
	memcpy(&response[nPos],szData,nLenData); nPos+=nLenData;
	memcpy(&response[nPos],"</",2); nPos+=2;
	memcpy(&response[nPos],szCampo,nLenCampo); nPos+=nLenCampo;
	memcpy(&response[nPos],">",1); nPos++;
	response[nPos]=0;
	return 1;
}


int InsertaCampoXML(char *response,char szCampo[],char szData[])
{
	int nLen=strlen(response)+strlen(szCampo)+strlen(szData);
	if (nLen>=MAX_BUFFER)
	{
		char szError[200];
		sprintf(szError,"BUFFER Corto!!! MAX_BUFFER=%i Actual%i",MAX_BUFFER,nLen);
		WriteLog(0,szError);
		WriteLog(0,response);
		printf("Buffer Corto %s MAX_BUFFER=%i nLen=%i\n\r",szCampo,MAX_BUFFER,nLen);
		return 1;
	}
	strcat(response,"<");
	strcat(response,szCampo);
	strcat(response,">");
	strcat(response,szData);
	strcat(response,"</");
	strcat(response,szCampo);
	strcat(response,">");
	return 1;
}

Tipo_XML *LimpiaXML(Tipo_XML *xml)
{
	Tipo_XML *xml1=xml->pNext;
	if (xml->pData!=NULL) free(xml->pData);
	if (xml!=NULL) free(xml);
	xml=NULL;
	return xml1;
}

Tipo_XML *CierraXML(Tipo_XML *xml)
{
	Tipo_XML *xml_aux;
	if (xml==NULL) return NULL;
	xml_aux=xml->pNextNivel;
	//Limpia Primer Nivel
	while((xml=LimpiaXML(xml))!=NULL);
	//Si hay mas niveles
	while(xml_aux!=NULL)
	{
		xml=xml_aux;
		xml_aux=xml_aux->pNextNivel;
		while((xml=LimpiaXML(xml))!=NULL);
	}
	return NULL;
}

Tipo_XML *IniciaXML()
{
	Tipo_XML *xml=NULL;
	xml=(Tipo_XML *)malloc(sizeof(Tipo_XML));
	if (xml==NULL)
	{
		printf("Error en malloc..\n\r");
		return NULL;
	}
	xml->pNext=NULL;
	xml->nLenData=0;
	xml->nLenCampo=0;
	xml->pNextNivel=NULL;
	xml->pData=NULL;
	xml->nNivel=-1;
	xml->nTipoCampo=0;
	memset(xml->szCampo,0,sizeof(xml->szCampo));
	return xml;
}

Tipo_XML *BuscaNivel(Tipo_XML *xml,int nNivel)
{
	Tipo_XML *xml_aux=xml;
	if (xml==NULL) return NULL;
	if (nNivel==-1) return xml_aux;
	//Buscamos el nivel
	while(xml_aux->nNivel!=nNivel)
	{
		xml_aux=xml_aux->pNextNivel;
		if (xml_aux==NULL) break;
	}
	return xml_aux;
}

int GetNivelStrXML(Tipo_XML *xml,char szCampo[],char szValor[],int size,int n)
{
	char szCampo1[MAX_LEN_CAMPO];
	sprintf(szCampo1,"%s[%i]",szCampo,n);
	return GetStrXML(BuscaNivel(xml,n),szCampo1,szValor,size);
}

int GetNivelIntXML(Tipo_XML *xml,char szCampo[],int *nValor,int nNivel)
{
	char szCampo1[MAX_LEN_CAMPO];
	sprintf(szCampo1,"%s[%i]",szCampo,nNivel);
	return GetIntXML(BuscaNivel(xml,nNivel),szCampo1,nValor);
}

Tipo_XML *GetStrXMLData(Tipo_XML *xml2,char szCampo[])
{
	Tipo_XML *xml=NULL;
	char szTmp[200];
	int nlencampo;
	//WriteLog(0,szCampo);
	//sprintf(szTmp,"Nivel=%i",nNivelCampo(szCampo));
	//WriteLog(0,szTmp);
	//ImprimeMemoria(0,"BuscaNivel");
	//WriteError(0,szCampo);
	xml=BuscaNivel(xml2,nNivelCampo(szCampo));
	//ImprimeMemoria(0,"Despues BuscaNivel");

	nlencampo=strlen(szCampo);
	while(xml!=NULL)
	{
	   if ((xml->nLenCampo==nlencampo) &&
	       (memcmp(xml->szCampo,szCampo,xml->nLenCampo)==0))
	   //if ((strlen(xml->szCampo)==nlencampo) &&
	   //    (memcmp(xml->szCampo,szCampo,strlen(xml->szCampo))==0))
		{
			if (xml->pData==NULL) return NULL;
			if (xml->nLenData==0) return NULL;
		 	return xml;
		}
		xml=xml->pNext;
	}
	return NULL;
}
/************/

int GetStrXML_Aux(Tipo_XML *xml,char szCampo[],char szValor[],int size)
{
	int nlencampo;
	memset(szValor,0,size);
	nlencampo=strlen(szCampo);
	while(xml!=NULL)
	{
	   //if ((strlen(xml->szCampo)==nlencampo) &&
	   //    (memcmp(xml->szCampo,szCampo,strlen(xml->szCampo))==0))
	   if ((xml->nLenCampo==nlencampo) &&
	       (memcmp(xml->szCampo,szCampo,xml->nLenCampo)==0))
		{
			if (xml->pData==NULL) return 0;
			if (sizeof(szValor)<=0) return 0;
			//if (strlen(xml->pData)==0) 
			if (xml->nLenData==0) 
			{
				sprintf(szValor,"");
				return 1;
			}
			//printf("sizeof(szValor)-1=%i strlen(stXML[i].szData)=%i\n\r",size-1,strlen(stXML[i].szData));
			//if ((size-1)<=strlen(xml->pData))
			if ((size-1)<=xml->nLenData)
			{
			     memcpy(szValor,xml->pData,size-1);
			     szValor[size-1]=0;
			}
			else sprintf(szValor,"%s",xml->pData);
			//printf("Asigna %s Len=%i\n\r",szValor,strlen(szValor));
			return 1;
		}
		xml=xml->pNext;
	}
	return 0;
}

int GetStrXML(Tipo_XML *xml,char szCampo[],char szValor[],int size)
{
	//return GetStrXML_Aux(BuscaNivel(xml,nNivelCampo(szCampo)),szCampo,szValor,size);
	return GetStrXML_Aux(BuscaNivel(xml,nNivelCampo(szCampo)),szCampo,szValor,size);
}


Tipo_XML *xml_aux_global;
int GetFirstNameCampo(Tipo_XML *xml,char szCampo[])
{
	if (xml!=NULL)
	{
		sprintf(szCampo,"%s",xml->szCampo);
		xml_aux_global = xml->pNext;
		if (memcmp(szCampo,"STATUS",6)!=0) return 1;
		else return GetNextNameCampo(szCampo);
	}
	return 0;
}

int GetNextNameCampo(char szCampo[])
{
	if (xml_aux_global!=NULL)
	{
		sprintf(szCampo,"%s",xml_aux_global->szCampo);
		xml_aux_global = xml_aux_global->pNext;
		if (memcmp(szCampo,"STATUS",6)!=0) return 1;
		else return GetNextNameCampo(szCampo);
	}
	return 0;
}

Tipo_XML *BorraCampoXML(Tipo_XML *xml1,char szCampo[])
{
	Tipo_XML *xml=xml1;
	Tipo_XML *xml_or=xml1;
	Tipo_XML *xml2=xml1;
	while(xml!=NULL)
	{
		if ((strlen(xml->szCampo)==strlen(szCampo)) &&
		    (memcmp(xml->szCampo,szCampo,strlen(szCampo))==0))
		{
		        Tipo_XML *xml1=xml->pNext;
			if (xml==xml_or)
			{
				if (xml_or->pData!=NULL) free(xml_or->pData);
                        	if (xml_or!=NULL) free(xml_or);
				//no hay anterior
				return xml1;
			}
			if (xml->pData!=NULL) free(xml->pData);
                       	if (xml!=NULL) free(xml);
			//Cambia el anterior al siguiente
			xml2->pNext=xml1;
			return xml_or;
		}
		//almancena el anterior
		xml2=xml;
		//pasa al siguiente
		xml=xml->pNext;
	}
	return xml_or;
}


int SetValorXML(Tipo_XML *xml1,char szCampo[],char szValor[])
{
	Tipo_XML *xml=xml1;
	char szTmp[1024];
	while(xml!=NULL)
	{
		//sprintf(szTmp,"Campo1(%i) %s,Campo2(%i) %s",strlen(xml->szCampo),xml->szCampo,strlen(szCampo),szCampo);
		//WriteLog(0,szTmp);
		if ((strlen(xml->szCampo)==strlen(szCampo)) &&
		    (memcmp(xml->szCampo,szCampo,strlen(szCampo))==0))
		{
			if (xml->pData!=NULL) free(xml->pData);
			xml->pData=(char *)malloc(strlen(szValor)+1);
			sprintf(xml->pData,"%s",szValor);
			//WriteLog(0,"UPDATE");
			//WriteLog(0,xml->szCampo);
			//WriteLog(0,xml->pData);
			return 1;
		}
		xml=xml->pNext;
	}
	return 1;
}
Tipo_XML *SetValorIntXML(Tipo_XML *xml1,char szCampo[],int nValor)
{
	Tipo_XML *xml=xml1;
	while(xml!=NULL)
	{
		if (!strcmp(xml->szCampo,szCampo))
		{
			if (xml->pData==NULL) return xml1;
			if (strlen(xml->pData)==0) return xml1;
			sprintf(xml->pData,"%i",nValor);
			return xml1;
		}
		xml=xml->pNext;
	}
	return xml1;
}

int GetIntXML_Aux(Tipo_XML *xml,char szCampo[],int *l)
{
	//El valor por defecto es 0, en caso de no existir
	*l=0;
	while(xml!=NULL)
	{
		if (!strcmp(xml->szCampo,szCampo))
		{
			if (xml->pData==NULL) return 0;
			if (strlen(xml->pData)==0) return 0;
			*l = atoi(xml->pData);
			//printf("GetInt %s=%i\n\r",szCampo,*l);
			return 1;
		}
		xml=xml->pNext;
	}
	return 0;
}
int GetIntXML(Tipo_XML *xml,char szCampo[],int *l)
{
	return GetIntXML_Aux(BuscaNivel(xml,nNivelCampo(szCampo)),szCampo,l);
}

//OBtiene una estructura XML desde una Raiz 
Tipo_XML *GetXMLRaiz(char szRaiz[],Tipo_XML *xml)
{
	Tipo_XML *xml1=NULL;
	while(xml!=NULL)
	{
		//si es la raiz Buscada, procesamos la data..
		if (memcmp(xml->szCampo,szRaiz,strlen(szRaiz))==0)
		{
			xml1=ProcesaInputXML1(xml,xml->pData);
			return xml1;
		}
		xml=xml->pNext;
	}
	return NULL;
}	

//Llena una estructura con datos de entrada que deben ser llenados
//con las funciones para asignar los datos a las estructuras especificas
//El input es del tipo CAMPO[LEN]=DATA###CAMPO2[LEN2]=DATA2###
Tipo_XML *DeserializaXML(Tipo_XML *xml,char szInput[])
{
    	char *dta=szInput;
	//char szAux[8192];
    	char *ini,*igual,*data,*aux1,*fin;
	char szCampo[MAX_LEN_CAMPO];
	int i=0;
	char *achTmp;

	do
        {
		if (dta==NULL)
		{printf("DTA es NULO\n");
		 break;}
		//printf ("dta=%s\n\n\n$$$$$\n",dta);
		
        	if (strlen(dta)<2)
		{ printf("Largo DTA menor 2 [%s]\n",dta); break;}
        	fin=(char *)strstr(dta,"###");
        	if (fin==NULL){ printf("Fin es NULO [%s]\n",dta); break;}
		
		//Obtiene el nombre del campo
		//memcpy(szAux,dta,fin-dta); 
        	//szAux[fin-dta]=0;
	        //printf("dta=%s\n",dta);
	        //printf("fin=%s\n",fin);
	        //printf("len=%i\n",fin-dta);
	        //printf("szAux=%s\n",szAux);
	        //printf("szAux=%s\n",szAux);
		
		//Busco donde termina el nombre del campo
		aux1=strchr(dta,'[');
		if (!aux1) {  printf("No encontre [ [%s]\n",dta); break;}

		//Si largo de campo 0 pasamos al siguiente
		if ((aux1-dta)==0)
		{
			//Nos saltamos los gatos ###
			dta=fin+3;
			continue;
		}
		//Validamos el largo del nombre del campo
		if ((aux1-dta)>MAX_LEN_CAMPO)
		{
			WriteLog(0,"Nombre de Campo excede largo MAX_LEN_CAMPO");
			break;
		}
		memcpy(szCampo,dta,aux1-dta);
		szCampo[aux1-dta]=0;
		//WriteLog(0,szCampo);
	        //printf("Campo=%s\n",szCampo);
	
		
		//Busco donde empieza la data
		ini=strchr(dta,'=');
		if (!ini)  {  printf("No encontre = [%s]\n",dta); break;}
		ini++;
		//printf("ini=%s\n",ini);
		//printf("fin=%s\n",fin);
		//printf("largo_data=%i\n",fin-ini);
		achTmp=NULL;

		//Si el campo es __XML__ me lo salto para evitar referencias cruzadas
		//Se borra al final del llamado de esta funcion
		if (memcmp(szCampo,"__XML__",7)!=0)
		{
			//Solo si largo de szCampo es mayor que 0
			if (fin-ini==0) 
			{	
				ImprimeMemoria(0,"Antes de 0");
				//WriteLog(0,"Inserta Nada");
				xml=InsertaDataXML(xml,szCampo,"");
			}
			else
			{
				ImprimeMemoria(0,"Antes de 1");
				//WriteLog(0,"Inserta Data");
				xml=InsertaDataLenXML(xml,szCampo,ini,fin-ini);
				/*
				achTmp = (char *)malloc(fin-ini+1);
				if (achTmp)
				{
					memcpy(achTmp,ini,fin-ini); 
					achTmp[fin-ini]=0;
					xml=InsertaDataXML(xml,szCampo,achTmp);
					free(achTmp);
					achTmp=NULL;
				}
				*/
			}
		}
		//Nos saltamos los gatos ###
		dta=fin+3;
   	}while(1);
   return xml;
} 


//Esta funcion recibe un Tipo_Data y aplica las funciones para reemplazar desde un buffer entrante las funciones que requiere Ejemnplo:###SUBTRING(''filename="'',''"'')###
Tipo_Data *AplicaFuncionesData(Tipo_Data *pData,char szBuffer[])
{
	Tipo_Data *pNewData=NULL;
	Tipo_Data *pPar1=NULL;
	Tipo_Data *pPar2=NULL;
	char *buf=pData->data;
	char *ini;
	WriteLog(0,"AplicaFuncionesData");
	//WriteLog(0,buf);
	//Busco si hay alguna funcion
	while (ini=(char *)strstr(buf,"###"))
	{
		//WriteLog(0,"LOOP");
		//WriteLog(0,ini);
		//Inserta la parte anterior
		pNewData=InsertaDataLen(buf,ini-buf,pNewData);
		//WriteLog(0,pNewData->data);
		//Nos saltamos el ###
		ini+=3;
		buf=ini;
		//Si hay que sacar un substring del buffer..
		if (memcmp(buf,"SUBTRING(",9)==0) 
		{
			char *ini,*fin,*buf_ini,*buf_fin;
			buf_ini=buf;
			buf+=10; //Se salta la '
			ini=buf;
			fin=strstr(buf,"','");
			if (!fin)
			{
				WriteLog(0,"Funcion SUBTRING requiere separador ',' para el 1 parametro");
				buf=strstr(buf,"###");
				continue;
			}
			pPar1=InsertaDataLen(ini,fin-ini,pPar1);
			//WriteLog(0,"Parametro1");
			//WriteLog(0,pPar1->data);
			//buf se salta el parametro1
			buf+=strlen(pPar1->data);
			//Buscamos parametro 2, nos saltamos ','
			ini=fin+3;
			buf+=3; 
			fin=strstr(buf,"')###");
			if (!fin)
			{
				WriteLog(0,"Funcion SUBTRING requiere separador '### para el 2 parametro");
				buf=strstr(buf,"###");
				pPar1=LiberaData(pPar1);
				continue;
			}
			pPar2=InsertaDataLen(ini,fin-ini,pPar2);
			buf+=strlen(pPar2->data);
			buf+=5; //Se saldo el ')###

			//WriteLog(0,"Parametro2");
			//WriteLog(0,pPar2->data);

			//Saca el subtring del buffer entrante
			ini=strstr(szBuffer,pPar1->data);
			if (!ini)
			{
				WriteLog(0,"no se encuentra patron 1 en en buffer entrante");
				//WriteLog(0,pPar1->data);
				pPar2=LiberaData(pPar2);
				pPar1=LiberaData(pPar1);
				continue;
			}
			//WriteLog(0,ini);
			//Avanzo el patron encontrado
			ini+=strlen(pPar1->data);
			fin=strstr(ini,pPar2->data);
			if (!fin)
			{
				WriteLog(0,"no se encuentra pratron 2  en en buffer entrante");
				//WriteLog(0,pPar2->data);
				pPar2=LiberaData(pPar2);
				pPar1=LiberaData(pPar1);
				continue;
			}
			//WriteLog(0,fin);
			//Reemplazo en Buffer
			pNewData=InsertaDataLen(ini,fin-ini,pNewData);
			//WriteLog(0,pNewData->data);
			pPar2=LiberaData(pPar2);
			pPar1=LiberaData(pPar1);
		}
		//WriteLog(0,"BUF");
		//WriteLog(0,buf);
	}
	//Si no encuentro nada mas.. agrego el final
	pNewData=InsertaDataLen(buf,strlen(buf),pNewData);
	//Libero el buffer anterior
	pData=LiberaData(pData);
	return pNewData;
}

//Llena una estructura con datos de entrada que deben ser llenados
//con las funciones para asignar los datos a las estructuras especificas
//El input es del tipo <campo*>data</campo>
Tipo_XML *ProcesaInputXML2(Tipo_XML *xml,char szInput[])
{
    	char *dta=szInput;
	//char szAux[1024];
    	char *ini,*igual,*data,*igual1;
	//char szCampo[MAX_LEN_CAMPO];
	//char szCampo1[MAX_LEN_CAMPO];
	Tipo_Data *pCampo=NULL;
	Tipo_Data *pCampo1=NULL;
	Tipo_Data *pAux=NULL;
	int i=0;
	char *achTmp;

	//SET_LOG(0,0);
	WriteLog(0,"ProcesaInputXML2");
	do
        {
	if (dta==NULL) break;
	//printf("DATA = %s\n\r",dta);
	//WriteLog(0,"dta");
        if (strlen(dta)<2) break;

	//memset(szAux,0,sizeof(szAux));
	//memcpy(szAux,dta,200);
	//WriteLog(0,szAux);

        ini=(char *)strchr(dta,'<');
        if (ini==NULL) break;
	
	//WriteLog(0,"ini");
	//memset(szAux,0,sizeof(szAux));
	//memcpy(szAux,ini,200);
	//WriteLog(0,szAux);
	
	//si es un final busca otro tag
	if (ini[1]=='/') 
	{
		dta=ini+1;
		continue;
	}
	//si es un identificador...busca otro tag
	if (ini[1]=='?') 
	{
		dta=ini+1;
		continue;
	}

	//El nombre del campo termina en > o en un espacio
        igual=(char *)strchr(ini,'>');
        igual1=(char *)strchr(ini,' ');

	//WriteLog(0,"Espacio");
	//WriteLog(0,igual1);
	//WriteLog(0,"Busca >");
	//WriteLog(0,igual);
	//WriteLog(0,"igual");

	//Si no viene el cierre esta mal formado y no es un XML
        if (igual==NULL) break;
	
	//memset(szAux,0,sizeof(szAux));
	//memcpy(szAux,igual,200);
	//WriteLog(0,szAux);

        ini++;
        igual++;
	
	//Obtiene el nombre del campo
	//WriteLog(0,ini);
	pCampo=InsertaDataLen(ini,igual-ini-1,pCampo);
	//WriteLog(0,"Obtiene Nombre Campo");
	//memcpy(szCampo,ini,igual-ini-1); 
        //szCampo[igual-ini-1]=0;

	//WriteLog(0,pCampo->data);
	//El campo a buscar es lo mas corto, un > o un espacio, solo si igual1 no es nulo
	if (igual1!=NULL)
	{
		//WriteLog(0,"igual1 no nulo");
		//Obtiene el nombre del campo
		pCampo1=InsertaDataLen(ini,igual1-ini,pCampo1);
		//WriteLog(0,pCampo1->data);
		//memcpy(szCampo1,ini,igual1-ini); 
        	//szCampo1[igual1-ini]=0;
		if (strlen(pCampo->data)>strlen(pCampo1->data))
		{
			//sprintf(szCampo,"%s",szCampo1);
			pCampo=LiberaData(pCampo);
			pCampo=InsertaData(pCampo1->data,pCampo);
			//WriteLog(0,"Asigno Campo1");
		}
		pCampo1=LiberaData(pCampo1);
	}
	//WriteLog(0,pCampo->data);

	
	//WriteLog(0,"CAMPO");
	//WriteLog(0,szCampo);

	//printf("CAMPO = %s\n\r",xml->szCampo);
	pAux=InsertaData("</",pAux);
	pAux=InsertaData(pCampo->data,pAux);
	pAux=InsertaData(">",pAux);
	//WriteLog(0,"Asigno pAux");
	//WriteLog(0,pAux->data);
	//sprintf(szAux,"</%s",szCampo);
	data=(char *)strstr(dta,pAux->data);
	pAux=LiberaData(pAux);
	//printf("data = %s\n\r",data);
       	if (data==NULL) 
	{
		//WriteLog(0,"No cerrado");
		//Si el campo no esta cerrado...sigo
		dta=ini+2;
		pCampo=LiberaData(pCampo);
		continue;
	}
	
	xml=InsertaDataLenXML(xml,pCampo->data,igual,data-igual);
	/*
	achTmp=NULL;
	achTmp = (char *)malloc(data-igual+1);
	if (achTmp)
	{
		memcpy(achTmp,igual,data-igual); 
		achTmp[data-igual]=0;
		//WriteLog(0,szCampo);
		//sprintf(szAux,"Puntero XML=%x",xml);
		//WriteLog(0,szAux);
		//printf("InsertaDataXML %s %s\n\r",szCampo,achTmp);
		xml=InsertaDataXML(xml,pCampo->data,achTmp);
		//WriteLog(0,szCampo);
		//WriteLog(0,achTmp);
		//WriteLog(0,"Inserta Campo");
		//WriteLog(0,pCampo->data);
		//sprintf(szAux,"*Puntero XML=%x",xml);
		//WriteLog(0,szAux);
		free(achTmp);
		achTmp=NULL;
	}
	*/
	//Nos saltamos la data..
	//Avanzamos para mirar la data dentro del TAG
	dta=ini+1;
	pCampo=LiberaData(pCampo);
	//dta=data+strlen(szCampo)+2;
	//WriteLog(0,dta);
	//printf("DATA1 = %s\n\r",dta);
   }while(1);
   //SET_LOG(0,1);
   return xml;
} 


//Llena una estructura con datos de entrada que deben ser llenados
//con las funciones para asignar los datos a las estructuras especificas
//El input es del tipo <campo>data</campo>
Tipo_XML *ProcesaInputXML1(Tipo_XML *xml,char szInput[])
{
    	char *dta=szInput;
	char szAux[1024];
    	char *ini,*igual,*data;
	char szCampo[MAX_LEN_CAMPO];
	int i=0;
	char *achTmp;

	do
        {
	if (dta==NULL) break;
	//printf("DATA = %s\n\r",dta);
        if (strlen(dta)<2) break;
        ini=(char *)strchr(dta,'<');
        if (ini==NULL) break;
        igual=(char *)strchr(ini,'>');
		//printf("ini = %s\n\r",ini);
		//printf("igual = %s\n\r",igual);

        if (igual==NULL) break;
	//si es un final busca otro tag
	if (ini[1]=='/') 
	{
		dta=ini+1;
		continue;
	}
	//si es un identificador...busca otro tag
	if (ini[1]=='?') 
	{
		dta=ini+1;
		continue;
	}
        ini++;
        igual++;

	//Obtiene el nombre del campo
	memcpy(szCampo,ini,igual-ini-1); 
        szCampo[igual-ini-1]=0;
	//printf("CAMPO = %s\n\r",xml->szCampo);
	sprintf(szAux,"</%s",szCampo);
	data=(char *)strstr(dta,szAux);
	//printf("data = %s\n\r",data);
       	if (data==NULL) break;
	
	achTmp=NULL;
	achTmp = (char *)malloc(data-igual+1);
	if (achTmp)
	{
		memcpy(achTmp,igual,data-igual); 
		achTmp[data-igual]=0;
		//WriteLog(0,szCampo);
		//sprintf(szAux,"Puntero XML=%x",xml);
		//WriteLog(0,szAux);
		//printf("InsertaDataXML %s %s\n\r",szCampo,achTmp);
		xml=InsertaDataXML(xml,szCampo,achTmp);
		//sprintf(szAux,"*Puntero XML=%x",xml);
		//WriteLog(0,szAux);
		free(achTmp);
		achTmp=NULL;
	}
	//Nos saltamos la data..
	dta=data+strlen(szCampo)+2;
	//WriteLog(0,dta);
	//printf("DATA1 = %s\n\r",dta);
   }while(1);
   return xml;
} 

extern int m_hWorldSocket;
int EsperaDataSocket(int id,int nSocket,int nTimeout)
{
        fd_set rfds;
        int retval;
        struct timeval tv;
        int l;
        unsigned long l1;
	char szError[512];
	int sts;
	//sprintf(szError,"Timeout=%i Socket=%i",nTimeout,nSocket);
	//WriteLog(id,szError);
	sts=ioctl(nSocket,FIONREAD,&l);
	if (sts<0)
	{
		sprintf(szError,"*Error %s",strerror(errno));
		WriteLog(id,szError);
		return CLOSE_SOCKET;
	}
        if (l>0)
	{
		//sprintf(szError,"Habia data en socket %i %i",l,nSocket);
		//WriteLog(id,szError);
		//return DATA_SOCKET;
		return l;
	}

       FD_ZERO(&rfds);
       FD_SET(nSocket,&rfds);
       tv.tv_sec = nTimeout;
       tv.tv_usec = 0;

       if (nTimeout==0)
       {
		printf("Espera Data infinito\n\r");
       		select(nSocket+1, &rfds, NULL, NULL,NULL);
       }
       else
       {
		//printf("Espera Data %i\n\r",nTimeout);
		//sprintf(szError,"Entra a select timeout=%i %i",nTimeout,nSocket);
		//WriteLog(id,szError);
       		retval = select(nSocket+1, &rfds, NULL, NULL,&tv);
		//sprintf(szError,"Sale select timeout=%i %i",nTimeout,nSocket);
		//WriteLog(id,szError);
		if (!retval) 
		{
			//printf("Timeous en select\n\r");
			sprintf(szError,"*Error %s",strerror(errno));
			WriteLog(id,szError);
			WriteLog(id,"Timeout en EsperaDataSocket");
			return TIMEOUT_SOCKET;
		}
       }
	//WriteLog(id,"Entra a select 3");
       ioctl(nSocket,FIONREAD,&l);
	//sprintf(szError,"bytes por leer l=%i socket=%i",l,nSocket);
	//WriteLog(id,szError);
       //printf("Pend =%i\n\r",l);
       if (l>0) 
	{
		//WriteLog(id,"hay data en socket");
		//return DATA_SOCKET;
		return l;
	}
       else 
       {
	       //printf("Socket cerrado por remoto\n\r");
	       WriteLog(id,"Socket cerrado por remoto");
	       return CLOSE_SOCKET;
       }
}

Tipo_XML *LeePaqueteSCGI(int id,int socket,int nTimeout,Tipo_XML *xml,int *nStatus)
{
    int sts;
    int nState=0;
    long nPos=0;
    char szLinea[MAX_BUFFER];
    int nLen;
    long lsts=1;
    time_t t1,t2;
    int j;
    char szAux[512];
    int bNext=0;
    char szCampo[MAX_LEN_CAMPO+1];
    char szLen[MAX_BUFFER];
    long lLenHeader;
    long lLenData;
    char *pHeader=NULL;
    Tipo_XML *xml_aux=NULL;	
    int pos1,pos2,posdata1,posdata2,i;
    Tipo_XML *xml2=NULL;
    long nLenDataTemp;
    json_object *jData=NULL;
    char *key;
    struct json_object *val;
    struct lh_entry *entry=NULL;
    char *szBuff=NULL;


    time(&t1);
    WriteLog(id,"LeePaqueteSCGI");

    //Lee Largo del header SCGI
    lLenHeader=LeeLargoSCGI(id,socket,szLinea,MAX_BUFFER,10);
    if (lLenHeader<=0) 
    {
	WriteLog(id,"Falla Lectura de largo LeeLargoSCGI");
	goto fin;
    }

     time(&t1);
    //Leo la data que viene en el header
    while (1)
    {
	if ((sts=EsperaDataSocket(id,socket,nTimeout))<0) 
	{
		WriteLog(id,"Falla en EsperaDataSocket scgi");
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		goto fin;
	}
        ioctl(socket,FIONREAD,&nLen);
        if (nLen<=0) 
	{ 
		WriteLog(id,"Falla Lectura header scgi");
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		goto fin;
	}
        time(&t2);
	if ((t2-t1)>nTimeout)
	{
		sprintf(szAux,"nLen=%i lLenHeader=%ld",nLen,lLenHeader);
		WriteLog(id,"Timeout Lectura header scgi");
		WriteLog(id,szAux);
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		goto fin;
	}
	//Mientras no llegue la data, espera
	if (nLen<lLenHeader) continue;
        
	break;
     }

     //Leo la data del header
     pHeader=(char *)malloc(lLenHeader+10);
     pHeader[0]=0;
     sts=recv(socket,pHeader,lLenHeader,0);
     if (sts<0)
     {
	sprintf(szAux,"Leido %i nLen=%i",sts,nLen);
	WriteLog(id,szAux);
	goto fin;
     }
     else if (sts==0) 
     {
	WriteLog(id,"Cierra Socket Remoto");
	xml=InsertaDataXML(xml,"STATUS","ERROR");
	goto fin;
     }
     pHeader[sts]=0;
     //WriteHex(id,pHeader,sts);
     //Primera posicion del nombre del campo
     pos1=0;
     nState=0;
     for(j=0;j<sts;j++)
     {
		switch(nState)
		{
			/*Empieza a leer el nombre del campo*/
			case 0:
				//Si se termina el nombre del campo
				if (pHeader[j]==0)
				{
					pos2=j;
					posdata1=j+1;
					nState=1;
				}
				break;
			//Busca el campo
			case 1:
				//Si termina la data	
				if (pHeader[j]==0)
				{
					//sprintf(szLen,"pos1=%i pos2=%i posdata1=%i posdata2=%i",pos1,pos2,posdata1,posdata2);
					//WriteLog(id,szLen);
					//Copia el nombre del campo a szLinea
					memcpy(szLinea,&pHeader[pos1],pos2-pos1);
					szLinea[pos2-pos1]=0;
					//WriteLog(id,szLinea);
					posdata2=j;
					xml=InsertaDataLenXML(xml,szLinea,&pHeader[posdata1],posdata2-posdata1);
					//Volvemos a empezar
					pos1=j+1;
					nState=0;
				}
				break;
		}
    }
    //ImprimeXML(xml);

    //En SCGI viene una , hay que leerla
    sts=recv(socket,szLinea,1,0);
    if (sts<0)
    {
	sprintf(szAux,"Leido %i nLen=%i",sts,nLen);
	WriteLog(id,szAux);
	goto fin;
    }
     else if (sts==0) 
     {
	WriteLog(id,"Cierra Socket Remoto");
	xml=InsertaDataXML(xml,"STATUS","ERROR");
	goto fin;
     }

     if (szLinea[0]!=',')
     {
	WriteLog(id,"Falla Lectura de , en SCGI");
	xml=InsertaDataXML(xml,"STATUS","ERROR");
	goto fin;
     }

    //Busco el campo CONTENT_LENGTH que especifica el largo de la data
    xml_aux=NULL;
    xml_aux=GetStrXMLData(xml,"CONTENT_LENGTH");
    //Si no existe el TAG ..
    if (!xml_aux)
    {
    	WriteLog(id,"Falla SCGI no viene CONTENT_LENGTH");
	goto fin;
    }
    //Obtengo el largo
    lLenData=atol(xml_aux->pData);
    sprintf(szAux,"Content Length=%ld",lLenData);
    WriteLog(id,szAux);
    //WriteLog(id,xml_aux->pData);

    if (lLenData==0)
    {
	WriteLog(id,"Content Length=0");
     	xml=InsertaDataXML(xml,"INPUT","");
     	xml=InsertaDataXML(xml,"STATUS","OK");
        *nStatus=1;
     	return xml;

    }
   
     xml2=IniciaXML();
     sprintf(xml2->szCampo,"INPUT");
     xml2->nLenCampo=5;
     //Se deja en hexa
     xml2->pData = (char *)malloc((lLenData*2)+10);
     //Se deja en ascii
     szBuff = (char *) malloc(lLenData+10);
     i=0;
     int w=0;
     nLenDataTemp=0;
    time(&t1);
    //Espero que llegue la data
    while (1)
    {
	if ((sts=EsperaDataSocket(id,socket,nTimeout))<0) 
	{
		WriteLog(id,"Falla en EsperaDataSocket scgi 2");
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		goto fin;
	}
        ioctl(socket,FIONREAD,&nLen);
       	if (nLen<=0) 
	{ 
		WriteLog(id,"Falla Lectura data scgi");
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		goto fin;
	}
        time(&t2);
	if ((t2-t1)>nTimeout)
	{
		sprintf(szAux,"nLenDataTemp=%i lLenData=%ld",nLenDataTemp,lLenData);
		WriteLog(id,"Timeout Lectura data scgi");
		WriteLog(id,szAux);
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		goto fin;
	}

	//Si hay data la procesamos
	if (nLen>0)
	{
     		for(j=0;j<nLen;j++)
	        { 
		     	sts=recv(socket,szLinea,1,0);
			if (sts<0)
     			{		
				sprintf(szAux,"Falla lectura de la data Leido %i nLen=%i",sts,nLen);
				WriteLog(id,szAux);
				goto fin;
			}
			else if (sts==0) 
		     	{
				WriteLog(id,"Cierra Socket Remoto");
				xml=InsertaDataXML(xml,"STATUS","ERROR");
				goto fin;
		     	}
		        sprintf(szAux,"%02x",szLinea[0]&0377);
		        xml2->pData[i]=szAux[0]; i++;
		        xml2->pData[i]=szAux[1]; i++;
			szBuff[w]=szLinea[0];
			w++;
	       }
	}
	nLenDataTemp+=nLen;
        sprintf(szAux,"lLenData=%ld nLenDataTemp=%ld",lLenData,nLenDataTemp);
        WriteLog(id,szAux);

	//Mientras no llegue la data, espera
	if (nLenDataTemp<lLenData) continue;
	break;
     }

     sprintf(szAux,"lLenData=%ld nLen==%ld",lLenData,nLenDataTemp);
     WriteLog(id,szAux);
     xml2->pData[i]=0;
     xml2->nLenData=i;
     szBuff[w]=0;

     //FAY-DAO 2016-04-14
     //Si la data entrante es un json, lo serialimos inmediatamente en el xml para que no lo haga en cada proceso
     WriteLog(id,szBuff);
     jData=json_tokener_parse(szBuff);
 
     if (!jData)
     {
        WriteLog(id,"Data no es un json");
     	xml=StrcatXML(xml,xml2);
     }
     else
     {
	enum json_type type;
     	//Si es un json 
        type = json_object_get_type(jData);
        if (type==json_type_object)
        {
       	     WriteLog(id,"Data si es un json");
	     //Si es un json, lo recorro y lo agrego
             entry=json_object_get_object(jData)->head;
             for(entry; ({ if(entry) { key = (char*)entry->k; val = (struct json_object*)entry->v; } ; entry; }); entry = entry->next )
             {
		      //Voy agregando los valores al xml
                      
                      if (val) xml=InsertaDataXMLJson(xml,key,(char *)json_object_get_string(val));
		      else xml=InsertaDataXMLJson(xml,key,"");
             }
	     //Libero el xml2
	     xml2=CierraXML(xml2);
	     json_object_put(jData);
        }
        else
        {
	        WriteLog(id,"Data no es un json");
	        xml=StrcatXML(xml,xml2);
        }

     }
     xml=InsertaDataXML(xml,"STATUS","OK");
     free(szBuff);
     *nStatus=1;
     return xml;
fin:
    *nStatus=-1;
    if (pHeader) free(pHeader);
    if (xml2) CierraXML(xml2);
    if (szBuff) free(szBuff);
    xml=InsertaDataXML(xml,"STATUS","ERROR");
    return xml;
}

Tipo_XML *LeePaqueteXML(int id,int socket,int nTimeout,Tipo_XML *xml,int *nStatus)
{
    int sts;
    int nState=0;
    long nPos=0;
    char szLinea[MAX_BUFFER];
    int nLen;
    long lsts=1;
    time_t t1,t2;
    int j;
    char szAux[100];
    int bNext=0;
    char szCampo[MAX_LEN_CAMPO+1];
    char szLen[MAX_BUFFER];
    Tipo_XML *xml2=NULL;
    long lLenLeer;


    time(&t1);
    WriteLog(id,"LeePaqueteXML");

    *nStatus=0;
    while (1)
    {
	if ((sts=EsperaDataSocket(id,socket,nTimeout))<0) 
	{
		WriteLog(id,"Falla en EsperaDataSocket");
		if (xml2) xml2=CierraXML(xml2);
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		return xml;
	}
        ioctl(socket,FIONREAD,&nLen);
        if (nLen<0) 
	{ 
		WriteLog(id,"Falla en LeePaquete");
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		if (xml2) xml2=CierraXML(xml2);
		return xml;
	}

	//Primero lee el largo del paquete ...
        //espera leer
	memset(szLinea,0,sizeof(szLinea));
	//if (nLeer>MAX_BUFFER) nLeer=MAX_BUFFER;
        sts=recv(socket,szLinea,sizeof(szLinea),0);
	if (sts<0)
	{
		sprintf(szAux,"Leido %i nLen=%i",sts,nLen);
		WriteLog(id,szAux);
		goto fin;
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		WriteLog(id,"Error al leer Socket");
		if (xml2) xml2=CierraXML(xml2);
		return xml;
	}
	else if (sts==0) 
	{
		WriteLog(id,"Cierra Socket Remoto");
		xml=InsertaDataXML(xml,"STATUS","ERROR");
		if (xml2) xml2=CierraXML(xml2);
		return xml;
	}
	//printf("Leido = %s\n\r",szLinea);
	//sprintf(szAux,"LArgo estado=%i sts=%i %ld %ld",nState,sts,t1,t2);
	//WriteLog(id,szAux);
	WriteLog(id,szLinea);
	for(j=0;j<sts;j++)
	{
		switch(nState)
		{
			/*Espera el STX */
			case 0:
			if (szLinea[j]==0x02) nState=1;
			break;
			//Empieza al leer un campo XML..
			case 1:
			//Abre campo
			if (szLinea[j]=='<')
			{
				nState=2;
				nPos=0;
			}
			//si es el fin...
			else if (szLinea[j]==0x03) goto fin; 
			break;

			//Termina de leer un campo
			case 2:
			if (szLinea[j]=='=')
			{
				//cierra el campo
				szCampo[nPos++]=0;
				//WriteLog(id,szCampo);
				nPos=0;
				nState=3;
			}
			else if (szLinea[j]==0x03) goto fin;
			else szCampo[nPos++]=szLinea[j];
			break;

			//Lee el largo de la data xml
			case 3:
			if (szLinea[j]=='>')
			{
				szLen[nPos++]=0;
				nPos=0;
				nState=4;
				//WriteLog(id,szLen);
				if (xml2) xml2=CierraXML(xml2);
				xml2=IniciaXML();
				//Upper(szCampo);
				xml2->nLenCampo=strlen(szCampo);
				memcpy(xml2->szCampo,szCampo,xml2->nLenCampo);
				xml2->szCampo[xml2->nLenCampo]=0;
				UpperLen(xml2->szCampo,xml2->nLenCampo);
				lLenLeer = atol(szLen);

				xml2->pData = (char *)malloc(lLenLeer+200);
				if (xml2->pData==NULL) 
				{
					WriteLog(id,"Falla MALLOC");
					xml=InsertaDataXML(xml,"STATUS","ERROR");
					if (xml2) xml2=CierraXML(xml2);
					return xml;
				}

				if (lLenLeer==0) 
				{
					xml2->pData[0]=0;
					//xml=InsertaDataXML(xml,xml2->szCampo,xml2->pData);
					xml2=CierraXML(xml2);
					nPos=0;
					nState=1;
				}
			}
			else if (szLinea[j]==0x03) goto fin;
			else szLen[nPos++]=szLinea[j];
			break;
			//Lee lLData
			case 4:
			xml2->pData[nPos++]=szLinea[j];
			if (nPos==lLenLeer)
			{
				xml2->pData[nPos++]=0;
				xml2->nLenData=nPos;
				//printf("xml2->szCampo=%s xml2->pData=%s",xml2->szCampo,xml2->pData);
				xml=InsertaDataXML(xml,xml2->szCampo,xml2->pData);
				xml2=CierraXML(xml2);
				nPos=0;
				nState=1;
			}
			else if (szLinea[j]==0x03) goto fin;
			break;
			
			default : nState=0;
		}
	}
    }

fin:
    *nStatus=1;
    if (xml2) xml2=CierraXML(xml2);
    xml=InsertaDataXML(xml,"STATUS","OK");
    return xml;
}

int LeePaqueteBD(int id,int socket,char szData[],int nMaxLen,int nTimeout)
{
    int sts;
    int nState=0;
    int nPos=0;
    int nLen;
    long lsts=1;
    time_t t1,t2;
    int j;
    char szAux[100];
    char szTmp[100];
    int nLeer=6;
    char szLen[6];

    time(&t1);

    while (1)
    {
	//printf("Espera Data \n\r");
	if ((sts=EsperaDataSocket(id,socket,nTimeout))<0) 
	{
		return sts;
	}
	//sprintf(szAux,"Espera Data %i" ,sts);
	//WriteLog(id,szAux);
	//printf("ioctl %i\n\r",sts);
        ioctl(socket,FIONREAD,&nLen);
	//printf("Len %i nLeer=%i\n\r",nLen,nLeer);
        if (nLen<0) 
	{ 
		WriteLog(id,"Falla en LeePaquete");
		return CLOSE_SOCKET;
	}
	else if (nLen<nLeer) 
	{
    		time(&t2);
		if (t2-t1>10) return CLOSE_SOCKET;
		continue;
	}

	//Primero lee el largo del paquete ...
        //espera leer
	szData[0]=0;
	sprintf(szAux,"LArgo %i" ,nLeer);
	WriteLog(id,szAux);
        sts=recv(socket,szData,nLeer,0);
	if (sts<0)
	{
		sprintf(szAux,"Leido %i nLen=%i",sts,nLen);
		WriteLog(id,szAux);

		WriteLog(id,"Error al leer Socket");
		return CLOSE_SOCKET;
	}
	else if (sts==0)
	{
		WriteLog(id,"Socket Cerrado");
		return CLOSE_SOCKET;
	}

	//Lee el lago a leer que viene en el paquete
	memcpy(szAux,&szData[1],5);
	szAux[5]=0;
	nLeer=atoi(szAux);

	sprintf(szTmp,"Total Leer %i Data=%s" ,nLeer,szAux);
	WriteLog(id,szTmp);
	
	if (nLeer>MAX_BUFFER)
	{
			WriteLog(id,"Buffer MAs largo de los esperado MAX_BUFFER");
			send(socket,"BUFFER MUY LARGO",16,MSG_NOSIGNAL);
			return CLOSE_SOCKET;
	}
	szData[0]=0;
	j=0;
	while (1)
	{
		if ((sts=EsperaDataSocket(id,socket,nTimeout))<0)
		{
			return sts;
		}
		ioctl(socket,FIONREAD,&nLen);
		sprintf(szTmp,"Por Leer=%i",nLen);
		WriteLog(id,szTmp);
	        if (nLen<0) 
		{ 
			WriteLog(id,"Falla en LeePaquete");
			return CLOSE_SOCKET;
		}
		else if (nLen<nLeer) 
		{
			//FAY 16-09-2011 Para que lee datos parciales
                        if (nLen>0)
                        {
                                //Si hay data la leo
                                sts=recv(socket,&szData[j],nLen,0);
                                if (sts<0)
                                {
                                        sprintf(szAux,"Leido %i nLen=%i",sts,nLen);
                                        WriteLog(id,szAux);
                                        WriteLog(id,"Error al leer Socket1");
                                        return CLOSE_SOCKET;
                                }
                                else if (sts==0)
                                {
                                        WriteLog(id,"Socket Cerrado2");
                                        return CLOSE_SOCKET;
                                }
                                //Muevo el puntero de lo ya leido
                                j=j+sts;
                                //Le bajo lo que ya se leyo
                                nLeer=nLeer-sts;
                        }

	    		time(&t2);
			sprintf(szAux,"nLen=%i nLeer=%i",nLen,nLeer);
			WriteLog(id,szAux);
			if (t2-t1>10) return CLOSE_SOCKET;
		}
		//Si ya esta la data en el socket
		else
		{
			//sprintf(szTmp,"Por Leer..=%i",nLen);
			//WriteLog(id,szTmp);
        		sts=recv(socket,&szData[j],nLeer,0);
			if (sts<0)
			{
				sprintf(szAux,"Leido %i nLen=%i",sts,nLen);
				WriteLog(id,szAux);

				WriteLog(id,"Error al leer Socket1");
				return CLOSE_SOCKET;
			}
			else if (sts==0)
			{
				WriteLog(id,"Socket Cerrado1");
				return CLOSE_SOCKET;
			}
			j=j+sts;
			szData[j]=0;	
			WriteLog(id,szData);
			return j;
		}
	} //while lectura data
	
    } //while inicial
}


/*
int LeePaquete(int id,int socket,char szData[],int nMaxLen,int nTimeout)
{
    int sts;
    int nState=0;
    int nPos=0;
    char szLinea[MAX_BUFFER];
    int nLen;
    long lsts=1;
    time_t t1,t2;
    int j;
    char szAux[100];
    int nLeer=6;
    char szLen[6];

    time(&t1);

    while (1)
    {
	//printf("Espera Data \n\r");
	if ((sts=EsperaDataSocket(id,socket,nTimeout))<0) 
	{
		//Si falla en szData contestamos la categoria de FALLA para
		//ponerlo despues en el XML
		sprintf(szData,"ERR_TIMEOUT_SOCKET");
		return sts;
	}
	//sprintf(szAux,"Espera Data %i" ,sts);
	//WriteLog(id,szAux);
	//printf("ioctl %i\n\r",sts);
        ioctl(socket,FIONREAD,&nLen);
	//printf("Len %i nLeer=%i\n\r",nLen,nLeer);
        if (nLen<0) 
	{ 
		WriteLog(id,"Falla en LeePaquete");
		sprintf(szData,"ERR_SOCKET_CERRADO");
		return CLOSE_SOCKET;
	}
	else if (nLen<nLeer) 
	{
    		time(&t2);
		if (t2-t1>10) 
		{
			sprintf(szData,"ERR_TIMEOUT");
			return CLOSE_SOCKET;
		}
		continue;
	}

	//Primero lee el largo del paquete ...
        //espera leer
	memset(szLinea,0,sizeof(szLinea));
	//sprintf(szAux,"LArgo %i %i %i %i %ld %ld",nLeer,nState,sts,nMaxLen,t1,t2);
	//WriteLog(id,szAux);
        sts=recv(socket,szLinea,nLeer,0);
	if (sts<0)
	{
		sprintf(szAux,"Leido %i nLen=%i",sts,nLen);
		WriteLog(id,szAux);

		WriteLog(id,"Error al leer Socket");
		sprintf(szData,"ERR_RECV");
		return CLOSE_SOCKET;
	}
	else if (sts==0)
	{
		WriteLog(id,"Socket Cerrado");
		sprintf(szData,"ERR_SOCKET_CERRADO_REMOTO");
		return CLOSE_SOCKET;
	}
	//printf("Leido = %s\n\r",szLinea);
	//sprintf(szAux,"LArgo %i %i %i %ld %ld",nState,sts,nMaxLen,t1,t2);
	//WriteLog(id,szAux);
	//WriteLog(id,"Lectura Directa Socket");
	//WriteLog(id,szLinea);
	for(j=0;j<sts;j++)
	{
		switch(nState)
		{
			//Espera el STX
			case 0:
			if (szLinea[j]==0x02)
			{
				nState=1;
				//nLeer=4;
				//nPos=1;
				//szData[0]=0x02;
				nPos=0;
				//WriteLog(id,"Lectura STX");
			}
			break;
			case 1:
			if (nPos==4)
			{
				szLen[nPos++]=szLinea[j];
				szLen[nPos]=0;
				nLeer=atoi(szLen);
				//sprintf(szAux,"szLen=%s nLeer = %i\n\r",szLen,nLeer);
				nState=2;
				nPos=0;
				//WriteLog(id,szAux);
			}
			else szLen[nPos++]=szLinea[j];
			break;

			case 2:
			if (szLinea[j]==0x03)
			{
				szData[nPos]=0;
				//WriteLog(id,"Lectura ETX");
				WriteLog(id,szData);
				return nPos;
			}
			// Si sobrepasa el maximo buffer
			else if (nPos > nMaxLen) 
			{ 
				char szrr[300];
				printf("Buffer %s\n\r",szLinea);
				sprintf(szrr,"Excede LArgo MaxLen=%i nPos=%i",nMaxLen,nPos);
				WriteLog(id,szrr); 
				sprintf(szData,"ERR_EXCEDE_LARGO");
				return -1;
			}
			else if (nPos > MAX_BUFFER) 
			{ 
				char szTmp[50];
				sprintf(szTmp,"Excede MAX_BUFFER=%i nPos=%i",MAX_BUFFER,nPos);
				WriteLog(id,szTmp); 
				sprintf(szData,"ERR_MAX_BUFFER");
				return -1;
			}
			else szData[nPos++]=szLinea[j];
			break;

			default : nState=0;
		}
	}
    }
}
*/

//FAY 20121023 LeePaquete version2 si vienen 2 STX al principio es porque debe soportar cualquier largo
//En caso contrario soporta el largo standar de 5
//pData entra como puntero y retorna la data
int LeePaquete(int id,int socket,Tipo_Data *pData,int nTimeout)
{
    int sts;
    int nState=0;
    int nPos=0;
    char szLinea[MAX_BUFFER];
    int nLen;
    long lsts=1;
    time_t t1,t2;
    int j;
    char szAux[100];
    int nLeer=6;
    char szLen[26];

    time(&t1);

    WriteLog(id,"LeePaquete");

    while (1)
    {
	//printf("Espera Data \n\r");
	if ((sts=EsperaDataSocket(id,socket,nTimeout))<0) 
	{
		//Si falla en szData contestamos la categoria de FALLA para
		//ponerlo despues en el XML
		pData=NewString(pData,"ERR_TIMEOUT_SOCKET");
		return sts;
	}
	//sprintf(szAux,"Espera Data %i nLen=%i nLeer=%i" ,sts,nLen,nLeer);
	//WriteLog(id,szAux);
	//printf("ioctl %i\n\r",sts);
        ioctl(socket,FIONREAD,&nLen);
	//printf("Len %i nLeer=%i\n\r",nLen,nLeer);
        if (nLen<0) 
	{ 
		WriteLog(id,"Falla en LeePaquete");
		pData=NewString(pData,"ERR_SOCKET_CERRADO");
		return CLOSE_SOCKET;
	}
	else if (nLen<nLeer) 
	{
			
		//Si hay datos, lea
		//FAY 2012-10-24 Para que lee datos parciales
                 if (nLen>0)
                 {
                         //Si hay data la leo
			 memset(szLinea,0,sizeof(szLinea));
			 if (nLen>sizeof(szLinea))
	        		sts=recv(socket,szLinea,sizeof(szLinea),0);
			 else
	        		sts=recv(socket,szLinea,nLen,0);
                         if (sts<0)
                         {
                                 sprintf(szAux,"Leido %i nLen=%i",sts,nLen);
                                 WriteLog(id,szAux);
                                 WriteLog(id,"Error al leer Socket1");
				 pData=NewString(pData,"ERR_RECV");
                                 return CLOSE_SOCKET;
                         }
                         else if (sts==0)
                         {
                                 WriteLog(id,"Socket Cerrado2");
				 pData=NewString(pData,"ERR_SOCKET_CERRADO_REMOTO");
                                 return CLOSE_SOCKET;
                         }
		 	//WriteLog(id,"Paso2");
			//WriteLog(id,szLinea);
			//sprintf(szAux,"sts=%i nLeer=%i",sts,nLeer);
			//WriteLog(id,szAux);
                         //Muevo el puntero de lo ya leido
                         //j=j+sts;
                         //Le bajo lo que ya se leyo
                         nLeer=nLeer-sts;
			//sprintf(szAux,"sts=%i nLeer=%i",sts,nLeer);
			//WriteLog(id,szAux);
                }
		else
		{
    			time(&t2);
			if (t2-t1>10) 
			{
				pData=NewString(pData,"ERR_TIMEOUT");
				return CLOSE_SOCKET;
			}
			continue;
		}
	}
	else
	{
		//Primero lee el largo del paquete ...
	        //espera leer
		memset(szLinea,0,sizeof(szLinea));
		//sprintf(szAux,"LArgo %i %i %i %i %ld %ld",nLeer,nState,sts,nMaxLen,t1,t2);
		//WriteLog(id,szAux);
		if (nLeer>sizeof(szLinea))
	        	sts=recv(socket,szLinea,sizeof(szLinea),0);
		else
	        	sts=recv(socket,szLinea,nLeer,0);

		if (sts<0)
		{
			sprintf(szAux,"Leido %i nLen=%i",sts,nLen);
			WriteLog(id,szAux);

			WriteLog(id,"Error al leer Socket");
			pData=NewString(pData,"ERR_RECV");
			return CLOSE_SOCKET;
		}
		else if (sts==0)
		{
			WriteLog(id,"Socket Cerrado");
			pData=NewString(pData,"ERR_SOCKET_CERRADO_REMOTO");
			return CLOSE_SOCKET;
		}
		 //WriteLog(id,"Paso1");
		 //WriteLog(id,szLinea);
		//printf("Leido = %s\n\r",szLinea);
		//sprintf(szAux,"LArgo %i %i %i %ld %ld",nState,sts,nMaxLen,t1,t2);
		//WriteLog(id,szAux);
		//WriteLog(id,"Lectura Directa Socket");
		//WriteLog(id,szLinea);
	}
	for(j=0;j<sts;j++)
	{
		switch(nState)
		{
			//Espera el STX
			case 0:
			if (szLinea[j]==0x02)
			{
				nState=1;
				//nLeer=4;
				//nPos=1;
				//szData[0]=0x02;
				nPos=0;
				//WriteLog(id,"Lectura STX");
			}
			break;
			case 1:
			//Si viene otro STX es la nueva version
			if (szLinea[j]==0x02)
			{
				nState=10;	
				nPos=0;
				nLeer=20; //Para alcanzar a leer el largo
				Conexion[id].nVersion=2;
				WriteLog(id,"Lee Version2");
			}
			else if (nPos==4)
			{
				Conexion[id].nVersion=1;
				WriteLog(id,"Lee Version1");
				szLen[nPos++]=szLinea[j];
				szLen[nPos]=0;
				nLeer=atoi(szLen);
				//sprintf(szAux,"szLen=%s nLeer = %i\n\r",szLen,nLeer);
			//sprintf(szAux,"1)sts=%i nLeer=%i",sts,nLeer);
			//WriteLog(id,szAux);
				pData->data=(char *)malloc(nLeer+1);
				pData->nLenData=nLeer;
				nState=2;
				nPos=0;
				//WriteLog(id,szAux);
			}
			else szLen[nPos++]=szLinea[j];
			break;

			case 2:
			if (szLinea[j]==0x03)
			{
				pData->data[nPos]=0;
				//WriteLog(id,"Lectura ETX");
				WriteLog(id,pData->data);
				return nPos;
			}
			// Si sobrepasa el maximo buffer
			else if (nPos > pData->nLenData) 
			{ 
				char szrr[300];
				printf("Buffer %s\n\r",szLinea);
				sprintf(szrr,"Excede LArgo MaxLen=%i nPos=%i",nLeer,nPos);
				WriteLog(id,szrr); 
				return -1;
			}
			else pData->data[nPos++]=szLinea[j];
	
			//Si ya procese todo el buffer leido, ahora me falta por leer
			nLeer=pData->nLenData-nPos;
			//sprintf(szAux,"2)sts=%i nLeer=%i",sts,nLeer);
			//WriteLog(id,szAux);
			break;

			//Lee largo ilimitado hasta un ;
			case 10:
			if (szLinea[j]==';')
			{
                                szLen[nPos]=0;
				nLeer=atoi(szLen);
				//Alloca memoria para guardar el buffer entrante
				pData->data=(char *)malloc(nLeer+1);
                                pData->nLenData=nLeer;
				//Setea de cuanto tiene que leer el buffer del socket (30K)
				if (pData->nLenData>30720)
				{
					//Lea solo 30K maximos
					nLeer=30720;
				}	
				else
				{
					//Lee todo el buffer del socket
					nLeer=pData->nLenData;
				}
                                //sprintf(szAux,"szLen=%s nLeer = %i\n\r",szLen,nLeer);
				//WriteLog(id,szAux);
                                nState=2;
                                nPos=0;
			}
			else szLen[nPos++]=szLinea[j];
			break;
			

			default : nState=0;
                } //switch
        } //for

    }
}



Tipo_XML *MoveNext100(int id,Tipo_XML *xml,int *sts,char szTipo[])
{
	char szData[1024];
        char *szMen;
        char szAux[100];
	int nLen;
	Tipo_Data *pData=NULL;
	*sts=ERROR_BASE; 
	if (!Conexion[id].stSocketDatabase.nConectado)
	{
		sprintf(szAux,"Error, socket no conectado a la Base");
		WriteLog(id,szAux);
		return xml;
	}

	memset(szData,0,sizeof(szData));
	InsertaCampoXML(szData,szTipo," ");
        nLen=SendSocket(id,Conexion[id].stSocketDatabase.m_socket,szData,strlen(szData));
	if (nLen<=0)
	{
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_SEND");
		sprintf(szAux,"Falla envio a BD");
		WriteLog(id,szAux);
		return xml;
	}
	//memset(szMen,0,sizeof(szMen));
	pData=CreaData();
	//if (!LeePaquete(id,Conexion[id].stSocketDatabase.m_socket,szMen,sizeof(szMen),10)) 
	if (LeePaquete(id,Conexion[id].stSocketDatabase.m_socket,pData,10)<0) 
	{
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		goto error;
	}
	szMen=pData->data;
	//ImprimeMemoria(id);
        xml=ProcesaInputXML1(xml,szMen);
	//WriteLog(id,szMen);
	if (strstr(szMen,"<STATUS>FIN</STATUS>")!=0)
	{
		sprintf(szAux,"Fin de Query");
		WriteLog(id,szAux);
		*sts=NO_HAY_DATOS;
		WriteLog(id,"FIN");
		goto error;
       	}
	else if (strstr(szMen,"<STATUS>OK</STATUS>")==0) 
        {
		memset(szAux,0,sizeof(szAux));
                GetStrXML(xml,"DESCRIPCION",szAux,sizeof(szAux));
                printf("Error = %s\n\r",szAux);
		WriteLog(id,szAux);
		WriteMensajeApp(id,szAux);
                goto error;
        }
	*sts=DATOS_OK;
	//WriteLog(id,"Memoria 4,1");
	//ImprimeMemoria(id);
	pData=LiberaData(pData);
        return xml;
error:
	//xml=CierraXML(xml);
        //CierraSocket(&Conexion[id].stSocketDatabase);
	//CloseDatabase(id);
	//WriteLog(id,"Memoria 4,2");
	//ImprimeMemoria(id);
	pData=LiberaData(pData);
        return xml;
}

Tipo_XML *MoveNext(int id,int *sts)
{
	char szData[1024];
        char *szMen;
	Tipo_XML *xml=NULL;
        char szAux[100];
	int nLen;
	int nLog=LOG(id);
	Tipo_Data *pData=NULL;
	*sts=ERROR_BASE; 
	if (!Conexion[id].stSocketDatabase.nConectado)
	{
		sprintf(szAux,"Error, socket no conectado a la Base");
		WriteLog(id,szAux);
		return xml;
	}
	SET_LOG(id,0);

	memset(szData,0,sizeof(szData));
	InsertaCampoXML(szData,"MOVE_NEXT"," ");
        nLen=SendSocket(id,Conexion[id].stSocketDatabase.m_socket,szData,strlen(szData));
	if (nLen<=0)
	{
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_SEND");
		sprintf(szAux,"Falla envio a BD");
		WriteLog(id,szAux);
		return xml;
	}
	pData=CreaData();
	if (LeePaquete(id,Conexion[id].stSocketDatabase.m_socket,pData,10)<0) 
	{
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		goto error;
	}
	szMen=pData->data;
        xml=ProcesaInputXML1(xml,szMen);
	//xml=LeePaqueteXML(id,Conexion[id].stSocketDatabase.m_socket,20);
	//if (xml==NULL) goto error;

        if (!GetStrXML(xml,"STATUS",szAux,sizeof(szAux))) goto error;
        if (memcmp(szAux,"FIN",3)==0)
        {
		SET_LOG(id,nLog);
		sprintf(szAux,"Fin de Query");
		WriteLog(id,szAux);
		*sts=NO_HAY_DATOS;
		goto error;
        }
        if (memcmp(szAux,"OK",2)!=0)
        {
		SET_LOG(id,nLog);
                GetStrXML(xml,"DESCRIPCION",szAux,sizeof(szAux));
                printf("Error = %s\n\r",szAux);
		WriteLog(id,szAux);
		WriteMensajeApp(id,szAux);
                goto error;
        }
	*sts=DATOS_OK;
	SET_LOG(id,nLog);
	pData=LiberaData(pData);
        return xml;
error:
	SET_LOG(id,nLog);
        //CierraSocket(&Conexion[id].stSocketDatabase);
	if (!global.nFormaConexionBD) CloseDatabase(id);
	pData=LiberaData(pData);
        return xml;
}

int CloseDatabase(int id)
{
        char szData[1024];
	char szAux[100];
        int nLen;
	//Si la conexion es INTERNA, no cierro socket de la BD
	if (memcmp(global.szConexionBD,"INTERNA",7)==0)
        {
		//No hay socket que cerrar
		return 1;
	}

                
        //if (Conexion[id].stSocketDatabase.nConectado)
	if (1)
        {
		//Cierro Socket pero no envio CLOSE a la BD
		//19-01-2010 FAY
		/*memset(szData,0,sizeof(szData));
		InsertaCampoXML(szData,"CLOSE"," ");
        	SendSocket(id,Conexion[id].stSocketDatabase.m_socket,szData,strlen(szData));
		*/
		//sprintf(szAux,"Cierra Conexion BD");
		//WriteLog(id,szAux);
                CierraSocket(&Conexion[id].stSocketDatabase);
        }
	else
	{
		//sprintf(szAux,"Conexion BD ya cerrado");
		//WriteLog(id,szAux);
	}
	global.nConexionesBD--;
	sprintf(szAux,"Conexiones BD = %i",global.nConexionesBD);
	//WriteLogEst(id,szAux);
        return 1;
}
      



Tipo_XML *GetCamposDatabase(int id,int *sts,char szTabla[])
{
	char szError[200];
	int nStatus;
	Tipo_XML *xml=NULL;
	xml=QueryDatabase1(id,szTabla,"CAMPOS",szError,xml,&nStatus);
	if (nStatus) {*sts=DATOS_OK; return xml;}
	else {*sts=NO_HAY_DATOS; xml=CierraXML(xml); return NULL;}
}

int SendDatabase(int id,char szSql[])
{
	Tipo_XML *xml=NULL;
	char szError[200];
	int nStatus;
	
	if (memcmp(global.szConexionBD,"INTERNA",7)==0)
	{
		int nTotal;
		WriteLog(id,"Conexion INTERNA");
#ifdef FLAG_POSTGRES
		xml=ExecuteSql1(id,szSql,&nTotal,0,xml,&nStatus);
#else
		WriteLog(id,"Falta definir FLAG_POSTGRES");
#endif
	}
	else 
	{
		WriteLog(id,"Conexion EXTERNA");
		xml=QueryDatabase1(id,szSql,"SQL",szError,xml,&nStatus);
	}
	xml=CierraXML(xml);

	if (nStatus) {return 1;}
	else 
	{
		if (strlen(szError)<sizeof(Conexion[id].szError)) sprintf(Conexion[id].szError,"%s",szError);
		else
		{
			memcpy(Conexion[id].szError,szError,sizeof(Conexion[id].szError)-1);
			Conexion[id].szError,szError[sizeof(Conexion[id].szError)]=0;
		}
		global.nError=1;
		return 0;
	}
}

int GetNameCampo(int nNivel,Tipo_XML *xml,char szCampo[],int nLen)
{
	char szTmp[20];
	if (xml==NULL) return 0;
	sprintf(szTmp,"CAMPO[%i]",nNivel);
	GetStrXML(xml,szTmp,szCampo,nLen);
	Upper(szCampo);
	return 1;
}

Tipo_XML *GetRecords1(int id,char szSql[],int *nTotal,Tipo_XML *xml,int *nStatus)
{
	char szError[200];
	int sts,i;
	char szAux[MAX_BUFFER];
	char szCampo[MAX_LEN_CAMPO],szCampo1[200];
	int nLog=LOG(id);
	char szTmp[200];

	if (memcmp(global.szConexionBD,"INTERNA",7)==0)
	{
#ifdef FLAG_POSTGRES
		return ExecuteSql1(id,szSql,nTotal,3,xml,nStatus);
#else
		WriteLog(id,"Falta definir FLAG_POSTGRES");
		*nStatus=0;
		return xml;
#endif
	}

	xml=QueryDatabase1(id,szSql,"QUERY",szError,xml,&sts);
	if (sts==0) 
	{
		WriteLog(id,"1)Error en la base :");
		WriteLog(id,szError);
		WriteLog(id,szSql);
		WriteMensajeApp(id,"1)Error en la base :");
		WriteMensajeApp(id,szError);
		WriteMensajeApp(id,szSql);
		xml=InsertaDataXML(xml,"ERROR",szError);
		goto close;
	}
	i=0;
	SET_LOG(id,0);
	//xml1=CierraXML(xml1);
	do
	{
		xml=MoveNext100(id,xml,&sts,"MOVE_NEXT_100");
		//xml=MoveNext100(id,&sts,"MOVE_NEXT_NIVEL_100");
		if (sts==ERROR_BASE)
		{
			WriteLog(id,"Falla Move Next:");
			WriteLog(id,szSql);
			printf("Error en base :%s\n\r",szSql);
			sprintf(szSql,"%s",szError);
			goto close;
		}
		else if (sts==NO_HAY_DATOS)
		{
		//printf("paso 4\n\r");
			GetStrXML(xml,"TOTAL_REGISTROS",szAux,sizeof(szAux));
			*nTotal=atoi(szAux);
			//WriteLog(id,"Cierra 2");
			//xml=CierraXML(xml);
			break;
		}
		/*
		//Cambia el nombre de los campos de 1 a n..
		xml2=xml;
		do
		{
			xml2=GetCampoXML(xml2,szCampo);
			GetStrXML(xml,szCampo,szAux,sizeof(szAux));
			if (memcmp(szCampo,"STATUS",6)!=0)
			{
		        	xml1=InsertaDataXML(xml1,szCampo,szAux);
			}
			if (xml2==NULL) break;
		} while(1);
		//WriteLog(id,"Cierra 1");
		xml=CierraXML(xml);
		*/
		i++;
	} while(1);
	//printf("paso 7\n\r");
	SET_LOG(id,nLog);
	if (!global.nFormaConexionBD) CloseDatabase(id);
	//Conexion[id].stSocketDatabase.nConectado=0;
	*nStatus=1;
	return xml;
close:
	//xml=CierraXML(xml);
	if (!global.nFormaConexionBD) CloseDatabase(id);
	*nTotal=0;
	*nStatus=0;
	SET_LOG(id,nLog);
	return xml;
}

Tipo_XML *GetRecords(int id,char szSql[],int *nTotal,Tipo_XML *xml,int *nStatus)
{
	char szError[200];
	int sts,i;
	char szAux[MAX_BUFFER];
	char szCampo[MAX_LEN_CAMPO],szCampo1[200];
	int nLog=LOG(id);
	char szTmp[200];

	WriteLog(id,"Entra GetRecords");

	if (memcmp(global.szConexionBD,"INTERNA",7)==0)
	{
#ifdef FLAG_POSTGRES
		return ExecuteSql1(id,szSql,nTotal,2,xml,nStatus);
#else
		WriteLog(id,"Falta definir FLAG_POSTGRES");
		*nStatus=0;
		return xml;
#endif
	}
	
	xml=QueryDatabase1(id,szSql,"QUERY",szError,xml,&sts);
	if (sts==0) 
	{
		WriteLog(id,"2)Error en la base :");
		WriteLog(id,szError);
		WriteLog(id,szSql);
		WriteMensajeApp(id,"2)Error en la base :");
		WriteMensajeApp(id,szError);
		WriteMensajeApp(id,szSql);
		xml=InsertaDataXML(xml,"ERROR",szError);
		goto close;
	}
	i=0;
	SET_LOG(id,0);
	//xml1=CierraXML(xml1);
	do
	{
		//sprintf(szTmp,"xml=%x",xml);
		//WriteLog(id,szTmp);
		xml=MoveNext100(id,xml,&sts,"MOVE_NEXT_NIVEL_100");
		//sprintf(szTmp,"*xml=%x",xml);
		//WriteLog(id,szTmp);
		if (sts==ERROR_BASE)
		{
			WriteLog(id,"Falla Move Next:");
			WriteLog(id,szSql);
			printf("Error en base :%s\n\r",szSql);
			sprintf(szSql,"%s",szError);
			goto close;
		}
		if (sts==NO_HAY_DATOS)
		{
		//printf("paso 4\n\r");
			GetStrXML(xml,"TOTAL_REGISTROS",szAux,sizeof(szAux));
			*nTotal=atoi(szAux);
			WriteLog(id,"NO_HAY_DATOS");
			//xml=CierraXML(xml);
			break;
		}
		i++;
	} while(1);
	//printf("paso 7\n\r");
	SET_LOG(id,nLog);
	if (!global.nFormaConexionBD) CloseDatabase(id);
	//Conexion[id].stSocketDatabase.nConectado=0;
	//WriteXML(id,xml1);
	//ImprimeXML(xml);


	*nStatus=1;
	WriteLog(id,"Sale GetRecords");
	return xml;
close:
	WriteLog(id,"Falla GetRecords");
	//xml=CierraXML(xml);
	if (!global.nFormaConexionBD) CloseDatabase(id);
	*nTotal=0;
	*nStatus=0;
	SET_LOG(id,nLog);
	return xml;
}

Tipo_XML *GetRecordMulti(int id,char szSql[],Tipo_XML *xml,int *nStatus)
{
	return GetRecord1(id,szSql,xml,nStatus,"GET_RECORD_MULTI");
/*
	char szError[200];
	int sts;
	
	if (memcmp(global.szConexionBD,"INTERNA",7)==0)
	{
		int nTotal;
#ifdef FLAG_POSTGRES
		//WriteLog(id,"PAso1");
		//ImprimeXML(xml);
		xml=ExecuteSql1(id,szSql,&nTotal,1,xml,nStatus);
		//WriteLog(id,"PAso2");
		//ImprimeXML(xml);
		return xml;
#else
		WriteLog(id,"Falta definir FLAG_POSTGRES");
		*nStatus=0;
		return xml;
#endif
	}
	         
	xml=QueryDatabase1(id,szSql,"GET_RECORD_MULTI",szError,xml,&sts);
	if (sts==0) 
	{
		if (strlen(szError)>0)
		{
			WriteLog(id,"Error en la base :");
			WriteLog(id,szError);
			sprintf(global.szError,"%s",szError);
			global.nError=1;
		}
		*nStatus=0;
		return xml;
	}
	*nStatus=1;
	return xml;
*/
}


Tipo_XML *GetRecord1(int id,char szSql[],Tipo_XML *xml,int *nStatus,char *szTipoRecord)
{
	char szError[10192];
	int sts;
	Tipo_XML *xml_aux=NULL;
	char szTag[100];
	int nSocket;
	
	if (memcmp(global.szConexionBD,"INTERNA",7)==0)
	{
		int nTotal;
#ifdef FLAG_POSTGRES
		//WriteLog(id,"PAso1");
		//ImprimeXML(xml);
		xml=ExecuteSql1(id,szSql,&nTotal,1,xml,nStatus);
		//WriteLog(id,"PAso2");
		//ImprimeXML(xml);
		return xml;
#else
		WriteLog(id,"Falta definir FLAG_POSTGRES");
		*nStatus=0;
		return xml;
#endif
	}

	//Si viene el TAG __BD_PERSISTENTE__ entonces usa una funcion que guarda el socket en el TAG
	//Si el dato viene OPEN, abre el socket, si viene CLOSE cierra la conexion
	xml_aux=GetStrXMLData(xml,"__CONTROL_BD_PERSISTENTE__");
	if ((xml_aux) &&  (xml_aux->nLenData>0))
	{
		Tipo_XML *xml_aux1=NULL;
		xml_aux1=GetStrXMLData(xml,"__ID_BD_PERSISTENTE__");
		if (xml_aux1)
		{
			//Saco el ID de Base que quiero mantener persistente
			if (Conexion[id].nDatabase==atoi(xml_aux1->pData))
			{
				
				sprintf(szError,"BD Persistente ID=%s",xml_aux1->pData);
				WriteLog(id,szError);
				sprintf(szTag,"%s_PERSISTENTE",szTipoRecord);
				xml=QueryDatabasePersistente1(id,szSql,szTag,szError,xml,&sts);
				//Hay que cerrar la BD
				if (memcmp(xml_aux->pData,"CLOSE",5)==0)
			 	{
					Tipo_XML *xml_aux2=NULL;
					sprintf(szError,"Close BD Persistente ID=%s",xml_aux1->pData);
					WriteLog(id,szError);
					xml_aux2=GetStrXMLData(xml,"__SOCKET_BD_PERSISTENTE__");
					if (xml_aux2) 
					{
						Tipo_Socket stSocketDatabase;
				                stSocketDatabase.m_socket=atoi(xml_aux2->pData);
						sprintf(szError,"Cierra BD Persistente Socket=%s ID=%s",xml_aux2->pData,xml_aux1->pData);
						WriteLog(id,szError);
				                CierraSocket(&stSocketDatabase);
					}
				}
			}		
			else
			{
				//Vamos a la base Normal
				xml=QueryDatabase1(id,szSql,szTipoRecord,szError,xml,&sts);
			}
		}
		//Si no existe el TAG, es la primera vez y lo guardo
		else
		{
			char szTmp1[20];
			sprintf(szTmp1,"%i",Conexion[id].nDatabase);
			sprintf(szError,"BD Persistente 1a vez ID=%s",szTmp1);
			WriteLog(id,szError);
			xml=InsertaDataXML(xml,"__ID_BD_PERSISTENTE__",szTmp1);
			//Ejecuto
			sprintf(szTag,"%s_PERSISTENTE",szTipoRecord);
			xml=QueryDatabasePersistente1(id,szSql,szTag,szError,xml,&sts);
		}
	}
	else xml=QueryDatabase1(id,szSql,szTipoRecord,szError,xml,&sts);

	if (sts==0) 
	{
		if (strlen(szError)>0)
		{
			WriteLog(id,"3)Error en la base :");
			WriteLog(id,szError);
			WriteMensajeApp(id,"3)Error en la base :");
			WriteMensajeApp(id,szError);
			xml=InsertaDataXML(xml,"ERROR",szError);
		}
		*nStatus=0;
		return xml;
	}
	*nStatus=1;
	return xml;
}

Tipo_XML *GetRecord(int id,char szSql[],Tipo_XML *xml,int *nStatus)
{
	return GetRecord1(id,szSql,xml,nStatus,"GET_RECORD");
}


//Solo inserta no actualiza
Tipo_XML *InsertaDataXMLNivel(Tipo_XML *xml,char szCampo[],char szData[],int nNivel)
{
        Tipo_XML *xml1=xml;
        Tipo_XML *xml2=NULL;
        Tipo_XML *xml_up;
        Tipo_XML *xml_ant;
        char szTmp[200];

        //Si no viene data en szData (Puntero nulo)..
        if (!szData)
        {
                WriteLog(0,szCampo);
                WriteLog(0,"Data Nula");
                return xml1;
        }

        Upper(szCampo);
        xml2=IniciaXML();
        xml2->pData = (char *)malloc(strlen(szData)+1);
        if (xml2->pData)
        {
                sprintf(xml2->pData,"%s",szData);
                sprintf(xml2->szCampo,"%s",szCampo);
		xml2->nLenData=strlen(szData);
		xml2->nLenCampo=strlen(szCampo);
                xml2->nNivel=nNivel;
        }

        xml_up=NULL;
        xml_ant=NULL;

        if (xml!=NULL)
        {
                //char szTmp[1024];
                /*Si no es nivel 0 buscamos el nivel donde insertar*/
                while (xml1->nNivel!=xml2->nNivel)
                {
                        /*Si no hay siguiente nivel lo asigno*/
                        if (xml1->pNextNivel==NULL)
                        {
                                xml1->pNextNivel=xml2;
                                return xml;
                        }
                        xml_up=xml1;
                        xml1=xml1->pNextNivel;
                }

                /*inserto al final de la lista*/
                //A no ser que encuentre el campo, entonces hago update o lo borro si viene vacio
                do
                {
                        //Si los campos son iguales
                        //Hace un update nunca borra y es el nivel -1
                        if ((xml1->nLenCampo==xml2->nLenCampo) &&
                            (memcmp(xml1->szCampo,xml2->szCampo,xml1->nLenCampo)==0) &&
                            (xml2->nNivel==-1))
                        //if ((strlen(xml1->szCampo)==strlen(xml2->szCampo)) &&
                        //    (memcmp(xml1->szCampo,xml2->szCampo,strlen(xml1->szCampo))==0) &&
                        //     (xml2->nNivel==-1))
                        {
                                //Si es igual la data.
                                if ((xml1->nLenData==xml2->nLenData)&&
                                    (memcmp(xml1->pData,xml2->pData,xml1->nLenData)==0))
                                //if ((strlen(xml1->pData)==strlen(xml2->pData)) &&
                                //    (memcmp(xml1->pData,xml2->pData,strlen(xml1->pData))==0))
                                {
                                        xml2=CierraXML(xml2);
                                        return xml;
                                }
                                //Update a la data
                                if (xml1->pData!=NULL) free(xml1->pData);
                                xml1->pData=(char *)malloc(xml2->nLenData+1);
                                memcpy(xml1->pData,xml2->pData,xml2->nLenData);
                                xml1->pData[xml2->nLenData]=0;
                                xml1->nTipoCampo=0;
                                xml1->nLenData=xml2->nLenData;
                                xml1->nTipoCampo=0;
                                xml2=CierraXML(xml2);
                                return xml;
                        }

                        xml_ant=xml1;
                        //si no hay siguiente...
                        if (xml1->pNext==NULL) break;
                        else xml1=xml1->pNext;
                } while(1);
                xml1->pNext=xml2;
                return xml;
        }
        else return xml2;
}

int GetStrXMLNivel(Tipo_XML *xml,char szCampo[],char szValor[],int size,int nNivel)
{
        Tipo_XML *xml1=xml;

        while (xml1!=NULL)
        {
                if (xml1->nNivel=nNivel)
                        return GetStrXML_Aux(xml1,szCampo,szValor,size);
                else
                        xml1=xml1->pNextNivel;
        }
        return 0;
}



//Solo inserta no actualiza
Tipo_XML *InsertaDataXMLNivelMasivo(Tipo_XML *xml,char szCampo[],char szData[],int nNivel,int id,int nLargoSzData)
{
        Tipo_XML *xml1=xml;
        Tipo_XML *xml2=NULL;
        Tipo_XML *xml_up;
        Tipo_XML *xml_ant;
        char szTmp[200];

        //Si no viene data en szData (Puntero nulo)..
        if (!szData)
        {
                WriteLog(0,szCampo);
                WriteLog(0,"Data Nula");
                return xml1;
        }

        Upper(szCampo);
        xml2=IniciaXML();
        xml2->pData = (char *)malloc(nLargoSzData+1);
        if (xml2->pData)
        {
		xml2->nLenData=nLargoSzData;
		memcpy(xml2->pData,szData,nLargoSzData);
		xml2->pData[nLargoSzData]=0;
                //sprintf(xml2->pData,"%s",szData);
                sprintf(xml2->szCampo,"%s",szCampo);
		xml2->nLenCampo=strlen(szCampo);
                xml2->nNivel=nNivel;
        }

	WriteLog(id,"****InsertaDataXMLNivelMasivo*******");
	ImprimeXML(xml2);

        xml_up=NULL;
        xml_ant=NULL;

        //Si se setea el ultimo nivel usado, partimos desde aca
        //Con esto solo recorremos un espacio de 1 para insertar
        if (Conexion[id].ultimo_xml!=NULL) xml1=Conexion[id].ultimo_xml;

        if (xml!=NULL)
        {

                //char szTmp[1024];
                /*Si no es nivel 0 buscamos el nivel donde insertar*/
                while (xml1->nNivel!=xml2->nNivel)
                {
                        /*Si no hay siguiente nivel lo asigno*/
                        if (xml1->pNextNivel==NULL)
                        {
                                xml1->pNextNivel=xml2;
                                //Seteamos el ultimo nivel con el puntero nuevo
                                Conexion[id].ultimo_xml=xml1;
                                //WriteLog(id,"ULtimo Nivel");
                                return xml;
                        }
                        xml_up=xml1;
                        xml1=xml1->pNextNivel;
                }
                //Seteamos el ultimo nivel con el puntero nuevo
                Conexion[id].ultimo_xml=xml1;
                //WriteLog(id,"ULtimo Nivel");

                /*inserto al final de la lista*/
                //A no ser que encuentre el campo, entonces hago update o lo borro si viene vacio
                do
                {
                        xml_ant=xml1;
                        //si no hay siguiente...
                        if (xml1->pNext==NULL) break;
                        else xml1=xml1->pNext;
                } while(1);
                xml1->pNext=xml2;
                return xml;
        }
        else return xml2;
}




//<STATUS>CAMPOS</STATUS>tx,descripcion,port,ip,tag_pagina,tag_imag                                 en,timeout,tipo_respuesta,largo_minimo_respuesta,llave_query,url,patron_final,ti                                 po_conexion,usa_dos_ip,ip1,port1,ssl,lista_ip,
Tipo_XML *ProcesaCamposRespuestaMultiple(int id,Tipo_XML *xml,char szData[])
{
        char *str;
        char s2[4]=",";
        char *ptr;
        int i=0;
        char szCampo[1024];
        str=&szData[23];
        WriteLog(id,str);
        //Separo por token
        ptr = strtok( str, s2 );
        if (ptr==NULL)
        {
                WriteLog(id,"No vienen Campos");
                return NULL;
        }
        sprintf(szCampo,"NOMBRE_CAMPO_%i",i++);
        //xml=InsertaDataXML(xml,szCampo,ptr);
        Upper(ptr);
        xml=InsertaDataXMLNivel(xml,szCampo,ptr,-1);
        while( (ptr = strtok( NULL, s2 )) != NULL )    // Posteriores llamadas
        {
                //sprintf(szCampo,"CAMPO%i",i++);
                sprintf(szCampo,"NOMBRE_CAMPO_%i",i++);
                //xml=InsertaDataXML(xml,szCampo,ptr);
                Upper(ptr);
                xml=InsertaDataXMLNivel(xml,szCampo,ptr,-1);
        }

        //ImprimeXML(xml);
        return xml;
}

//<STATUS>DATA</STATUS>0,0,4,70010,1,15,Procesador 10.60,2,4,201
Tipo_XML *ProcesaDataRespuestaMultiple(int id,Tipo_XML *xml,char szData[])
{
        char *str;
        int nState=0;
        char szAux[1024];
        char szCampo[128];
        char szCampoAux[200];
        int nColumna=0;
        int i;
        int j=0;
        int nLen;
        int nRegistro=0;
        int nCampoActual=0;
        int nLenData=0;
        //str=&szData[21];
        //WriteLog(id,szData);
        nLenData=strlen(szData);
        for(i=21;i<nLenData;i++)
        {
                //sprintf(szCampoAux,"i=%i nState=%i",i,nState);
                //WriteLog(id,szCampoAux);
                switch (nState)
                {
                        //Lee la columna
                        case 0:
                                if (szData[i]==',')
                                {
                                        szAux[j++]=0;
                                        nState++;
                                        j=0;
                                        //WriteLog(id,"szAux");
                                        //WriteLog(id,szAux);
                                        //Si el campo actual es distinto
                                        if (nRegistro!=atoi(szAux)) nCampoActual=0;
                                        nRegistro=atoi(szAux);
                                        //sprintf(szCampoAux,"NOMBRE_CAMPO",atoi(szAux));
                                        //GetStrXML(xml,szCampoAux,szCampo,sizeof(szCampo));
                                        //sprintf(szCampoAux,"%s[%i]",szCampo,nRegistros);
                                        sprintf(szCampo,"%i",nCampoActual++);
                                        //WriteLog(id,"Campo");
                                        //WriteLog(id,szCampo);
                                }
                                else szAux[j++]=szData[i];
                                break;
                        //Viene el largo
                        case 1:
                                if (szData[i]==',')
                                {
                                        szAux[j++]=0;
                                        nState++;
                                        nLen=atoi(szAux);
                                        //sprintf(szCampoAux,"Largo=%i",nLen);
                                        //WriteLog(id,szCampoAux);
                                        if (nLen==0)
                                        {
                                                //Inserto vacio
                                                xml=InsertaDataXMLNivelMasivo(xml,szCampo,"",nRegistro,id,0);
                                                nState=0;
                                                j=0;
                                        }

                                }
                                else szAux[j++]=szData[i];
                                break;
                        //Lee la Data
                        case 2:
                                //Avanzo la lectura
                                //memcpy(szAux,&szData[i],nLen);
                                //szAux[nLen]=0;
				//Si no llego toda la data...
                                if (nLen>strlen(&szData[i]))
                                {
                                        char *szBuff;
					Tipo_Data *pDataRec=NULL;;
                                        int nLeidos=strlen(&szData[i]);
					Tipo_Data	*pData=NULL;

                                        //Guardo lo leido en pData
                                        pData=(Tipo_Data *)malloc(sizeof(Tipo_Data));
                                        pData->data=(char *)malloc(nLen+1);
                                        pData->nLenData=nLen;
                                        //Copio la 1a parte del buffer
                                        memcpy(pData->data,&szData[i],nLeidos);
					pData->data[nLeidos]=0;
					//WriteLog(id,"LEIDOS=");
					//WriteLog(id,pData->data);
                                        //Leo hasta que llegue toda la informacion
                                        while (nLen>nLeidos)
                                        {
                                                //memset(szBuff,0,sizeof(szBuff));
						pDataRec=CreaData();
                                                if (LeePaquete(id,Conexion[id].stSocketDatabase.m_socket,pDataRec,Conexion[id].nTimeoutBaseDatos)<0)
                                                {
                                                        WriteLog(id,"Error en leer Paquete Multiple");
							pDataRec=LiberaData(pDataRec);
                                                        return xml;
                                                }
						szBuff=pDataRec->data;
                                                memcpy(&pData->data[nLeidos],szBuff,strlen(szBuff));
                                                nLeidos+=strlen(szBuff);
						pData->data[nLeidos]=0;
						pDataRec=LiberaData(pDataRec);
						//WriteLog(id,"LEIDOS=");
						//WriteLog(id,pData->data);
						//WriteData(id,pData->data,2048);
                                        }
                                        pData->data[nLeidos]=0;
                                        WriteLog(id,"Termino 1");
                                        //WriteLog(id,pData->data);
                                        xml=InsertaDataXMLNivelMasivo(xml,szCampo,pData->data,nRegistro,id,nLen);
                                        pData=LiberaData(pData);
					return xml;
                                }
                                else
                                {
                                        xml=InsertaDataXMLNivelMasivo(xml,szCampo,&szData[i],nRegistro,id,nLen);
                                        i+=nLen-1;
                                }
		



                                //WriteLog(id,"CAMPO");
                                //WriteLog(id,szCampo);
                                //WriteLog(id,"Data");
                                //WriteLog(id,szAux);
                                nState=0;
                                j=0;
                                break;
                }
        }
        //sprintf(szCampoAux,"%i",nRegistros);
        //xml=InsertaDataXML(xml,"TOTAL_REGISTROS",szCampoAux);
        //ImprimeXML(xml);
        //ImprimeStatXML(id,xml);
        return xml;
}


Tipo_XML *QueryDatabase2(int id,char szSql[],char szCampo[],char szError[],Tipo_XML *xml,int *nStatus)
{
        char *szData;
        char szAux[100];
        int nLen;
        char szIp[200];
        int nPort=Conexion[id].nPortDatabase;
        char szTotal[100];
        time_t t1,t2;
	Tipo_Data *pData=NULL;

        *nStatus=0;
        szError[0]=0;
        sprintf(szIp,"%s",Conexion[id].szIpDatabase);
        //sprintf(szAux,"BD %s:%i",szIp,nPort);
        //WriteLog(id,szAux);
        xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","");
        time(&t1);

        //Siempre se desconecta de la BD
        if (!global.nFormaConexionBD)
        {
                //printf("Forma Desconexion\n\r");
                //WriteLog(id,"Desconexion");
                if (Conexion[id].stSocketDatabase.nConectado) CloseDatabase(id);

                global.nConexionesBD++;
                InicializaSocket(&Conexion[id].stSocketDatabase,"Database");

                ConectaCliente(id,nPort,szIp,&Conexion[id].stSocketDatabase);
                //WriteLog(id,"Conecta Cliente BD");
        }
        //Mantiene la Conexion
        else
        {
                //WriteLog(id,"Mantiene Desconexion");
                //printf("Forma Mantiene Conexion\n\r");
                if (!Conexion[id].stSocketDatabase.nConectado)
                {
                        global.nConexionesBD++;
                        InicializaSocket(&Conexion[id].stSocketDatabase,"Database");
                        ConectaCliente(id,nPort,szIp,&Conexion[id].stSocketDatabase);
                }
        }
        //sprintf(szAux,"Conecta BD");
        //WriteLog(id,szAux);

	pData=CreaData();
	pData->data=(char *)malloc(strlen(szCampo)+strlen(szSql)+512);	
	memset(pData->data,0,strlen(szCampo)+strlen(szSql)+512);
	InsertaCampoXMLpData(pData->data,szCampo,szSql);
        //memset(szData,0,sizeof(szData));
        //InsertaCampoXML(szData,szCampo,szSql);
        nLen=SendSocket(id,Conexion[id].stSocketDatabase.m_socket,pData->data,strlen(pData->data));
        if (nLen<=0)
        {
                Conexion[id].stSocketDatabase.nConectado=0;
                sprintf(szAux,"Re-Conecta BD");
                WriteLog(id,szAux);
                ConectaCliente(id,nPort,szIp,&Conexion[id].stSocketDatabase);
                nLen=SendSocket(id,Conexion[id].stSocketDatabase.m_socket,pData->data,strlen(pData->data));
                if (nLen<=0)
                {
                    sprintf(szAux,"Falla envio datos a BD");
                    WriteLog(id,szAux);
                    CloseDatabase(id);
                    //Se le agrega status de el tipo de falla
                    xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_SEND_API_BD");
		    pData=LiberaData(pData); 
                    return xml;
                }
        }

        *nStatus=0;

        //Lea mientras la base contest
        while (1)
        {
                //Primero Lee la cabecera con los campos y luego solo la data
                //memset(szData,0,sizeof(szData));
		if (pData)
		{
			pData=LiberaData(pData);
			pData=CreaData();
		}
                if (LeePaquete(id,Conexion[id].stSocketDatabase.m_socket,pData,Conexion[id].nTimeoutBaseDatos)<0) 
		{
			break;
		}
		szData=pData->data;
                WriteLog(id,"Sale LeePaquete");
                //WriteLog(id,szData);

                if (strstr(szData,"STATUS>CAMPOS</STATUS>")>0)
                {
                        WriteLog(id,"ProcesaCampos");
                        xml=ProcesaCamposRespuestaMultiple(id,xml,szData);
                        WriteLog(id,"Sale ProcesaCampos");
                }
                else if (strstr(szData,"STATUS>DATA</STATUS>")>0)
                {
                        //Si viene un OK aca viene la data en este formato:
                        WriteLog(id,"ProcesaRespuesta");
                        xml=ProcesaDataRespuestaMultiple(id,xml,szData);
                        WriteLog(id,"Sale ProcesaRespuesta");
			ImprimeXML(xml);
                        WriteLog(id,"***************");

                        *nStatus=1;
                }
                else if (strstr(szData,"STATUS>FIN</STATUS>")>0)
                {
                        char szTmp[100];
                        sprintf(szAux,"Fin Query");
                        WriteLog(id,szAux);
                        memset(szTmp,0,sizeof(szTmp));
                        memcpy(szTmp,&szData[20],strlen(&szData[20]));
                        xml=InsertaDataXMLNivel(xml,"TOTAL_REGISTROS",szTmp,-1);
                        WriteLog(id,szTmp);
                        xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_SIN_DATA");
                        break;
                }
                else if (strstr(szData,"STATUS>SIN_DATA</STATUS>")>0)
                {
                        szError[0]=0;
                        //xml=CierraXML(xml);
                        CierraSocket(&Conexion[id].stSocketDatabase);
                        global.nConexionesBD--;
                        xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_SIN_DATA");
                        break;
                }
                else
                {
                        xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","OK");
                        break;
                }
        }
        //Fin Lectura
        time(&t2);
        //ImprimeXML(xml);
        GetStrXMLNivel(xml,"TOTAL_REGISTROS",szTotal,sizeof(szTotal),-1);
        sprintf(szAux,"Tiempo Lectura Segundos=%i Total_Registros=%s",t2-t2,szTotal);
        WriteLog(id,szAux);

        //xml=CierraXML(xml);
        //La base se cierra sola
        //if (!global.nFormaConexionBD) CloseDatabase(id);
        //xml=InsertaDataXML(xml,"__STS_ERROR_PXML__",szData);
	pData=LiberaData(pData);
        return xml;
}



Tipo_XML *GetMultiple(int id,char szSql[],int *nTotal,Tipo_XML *xml,int *nStatus)
{
        char szError[200];
        int sts;

        if (memcmp(global.szConexionBD,"INTERNA",7)==0)
        {
                int nTotal;
#ifdef FLAG_POSTGRES
                //WriteLog(id,"PAso1");
                //ImprimeXML(xml);
                xml=ExecuteSql1(id,szSql,&nTotal,1,xml,nStatus);
                //WriteLog(id,"PAso2");
                //ImprimeXML(xml);
                return xml;
#else
                WriteLog(id,"Falta definir FLAG_POSTGRES");
                *nStatus=0;
                return xml;
#endif
        }

        //WriteLog(id,"Antes de QueryDatabase2");
	//ImprimeXML(xml);
	xml=QueryDatabase2(id,szSql,"GET_MULTIPLE",szError,xml,&sts);
      
	//WriteLog(id,"Despues de QueryDatabase2");
	//ImprimeXML(xml);
	
	if (sts==0)
        {
                if (strlen(szError)>0)
                {
                        WriteLog(id,"4)Error en la base :");
                        WriteLog(id,szError);
                        WriteMensajeApp(id,"4)Error en la base :");
                        WriteMensajeApp(id,szError);
			xml=InsertaDataXML(xml,"ERROR",szError);
                }
                *nStatus=0;
                return xml;
        }

        //ImprimeXML(xml);
        if (!GetIntXML(xml,"TOTAL_REGISTROS",nTotal))
        {
                WriteLog(id,"NO hay TOTAL_REGISTROS");
                *nStatus=0;
                return xml;
        }
        WriteLog(id,"EXITO");
        *nStatus=1;
        return xml;
}





int QueryDatabase(int id,char szSql[])
{
	Tipo_XML *xml=NULL;
	int sts;
	char szError[200];
	xml=QueryDatabase1(id,szSql,"QUERY",szError,xml,&sts);
	xml=CierraXML(xml); 
	if (sts>0) return 1;
	else { return 0; }
}

Tipo_XML *QueryDatabasePersistente1(int id,char szSql[],char szCampo[],char szError[],Tipo_XML *xml,int *nStatus)
{
        char *szData;
        char szData1[200];
        char szAux[100];
        int nLen;
        char szIp[200];
        int nPort=Conexion[id].nPortDatabase;
	Tipo_Socket stSocketDatabase;
        Tipo_Data *pData=NULL;
	Tipo_XML *xml_aux=NULL;

        *nStatus=0;
        szError[0]=0;
        sprintf(szIp,"%s",Conexion[id].szIpDatabase);
        //sprintf(szAux,"BD %s:%i",szIp,nPort);
        //WriteLog(id,szAux);
        xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","");
	
	//Saco 
	
	//Saca el numero de socket para enviar requerimiento
	xml_aux=GetStrXMLData(xml,"__SOCKET_BD_PERSISTENTE__");
	if (xml_aux)
	{
		sprintf(szAux,"Socket BD Persistente %s",xml_aux->pData);
		WriteLog(id,szAux);
		stSocketDatabase.m_socket=atoi(xml_aux->pData);
	}
	//Si no esta conectado
	else
	{
		char szError[200];
		global.nConexionesBD++;
		InicializaSocket(&stSocketDatabase,"Database");
		
		if (!ConectaCliente(id,nPort,szIp,&stSocketDatabase))
		{
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_CONEXION_BD");
			return xml;
		}
		//Guardo el socket a la BD y el ID de la base de datos
		sprintf(szAux,"%i",stSocketDatabase.m_socket);
        	xml=InsertaDataXML(xml,"__SOCKET_BD_PERSISTENTE__",szAux);
		sprintf(szError,"Guardo Socket BD Persistente %s",szAux);
		WriteLog(id,szError);
	}
        xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","");

	pData=InsertaDataLen("<",1,pData);
        pData=InsertaDataLen(szCampo,strlen(szCampo),pData);
        pData=InsertaDataLen(">",1,pData);
        pData=InsertaDataLen(szSql,strlen(szSql),pData);
        pData=InsertaDataLen("</",2,pData);
        pData=InsertaDataLen(szCampo,strlen(szCampo),pData);
        pData=InsertaDataLen(">",1,pData);

        nLen=SendSocket(id,stSocketDatabase.m_socket,pData->data,pData->nLenData);
        if (nLen<=0)
        {
                xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_SEND_BD");
		goto error;
	}
	pData=LiberaData(pData);

        pData=CreaData();
        if (LeePaquete(id,stSocketDatabase.m_socket,pData,Conexion[id].nTimeoutBaseDatos)<0)
        {
                xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE_BD");
                goto error;
        }
        szData=pData->data;
        xml=ProcesaInputXML1(xml,szData);

        if (strstr(szData,"STATUS>FIN</STATUS>")>0)
        {
		xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_FIN");
                goto error;
        }
        else if (strstr(szData,"STATUS>SIN_DATA</STATUS>")>0)
        {
                szError[0]=0;
                //xml=CierraXML(xml);
               	//ierraSocket(&stSocketDatabase);
		xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_SIN_DATA");
                goto error;
        }
        else if (strstr(szData,"STATUS>OK</STATUS>")==0)
        {
                GetStrXML(xml,"DESCRIPCION",szAux,sizeof(szAux));
                sprintf(szError,"%s",szAux);
                WriteLog(id,szAux);
		xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_NK");
                goto error;
        }
        else
        {
                xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","OK");
                xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","OK");
        }

        *nStatus=1;
        //WriteLog(id,"OK");
        pData=LiberaData(pData);
        return xml;


error:
	CierraSocket(&stSocketDatabase);
	//xml=InsertaDataXML(xml,"__STS_ERROR_PXML__",szData1);
	*nStatus=0;
	pData=LiberaData(pData);
	return xml;
}


Tipo_XML *QueryDatabase1(int id,char szSql[],char szCampo[],char szError[],Tipo_XML *xml,int *nStatus)
{
        char *szData;
	char szData1[200];
        char szAux[1024];
        int nLen;
	char szIp[200];
	int nPort=Conexion[id].nPortDatabase;
	Tipo_Data *pData=NULL;
	Tipo_XML *pXml=NULL;

	*nStatus=0;
	szError[0]=0;
	sprintf(szIp,"%s",Conexion[id].szIpDatabase);
	//sprintf(szAux,"BD %s:%i",szIp,nPort);
	//WriteLog(id,szAux);
	xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","");
	
	//Siempre se desconecta de la BD
	if (!global.nFormaConexionBD)
	{
		//printf("Forma Desconexion\n\r");
		//WriteLog(id,"Desconexion");
		if (Conexion[id].stSocketDatabase.nConectado) CloseDatabase(id);

		global.nConexionesBD++;
		InicializaSocket(&Conexion[id].stSocketDatabase,"Database");
		
		if (!ConectaCliente(id,nPort,szIp,&Conexion[id].stSocketDatabase))
		{
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_CONEXION_BD");
			sprintf(szAux,"FALLA_CONEXION_BD %s:%i",szIp,nPort);
			WriteMensajeApp(id,szAux);
			WriteLog(id,szAux);
			goto error;
		}
		//WriteLog(id,"Conecta Cliente BD");
	}
	//Mantiene la Conexion
	else
	{
		//WriteLog(id,"Mantiene Desconexion");
		//printf("Forma Mantiene Conexion\n\r");
		if (!Conexion[id].stSocketDatabase.nConectado)
		{
			global.nConexionesBD++;
			InicializaSocket(&Conexion[id].stSocketDatabase,"Database");
			if (!ConectaCliente(id,nPort,szIp,&Conexion[id].stSocketDatabase))
			{
				xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_CONEXION_BD");
				sprintf(szAux,"FALLA_CONEXION_BD %s:%i",szIp,nPort);
				WriteMensajeApp(id,szAux);
				WriteLog(id,szAux);
				goto error;
			}
		}
	}
	//sprintf(szAux,"Conecta BD");
	//WriteLog(id,szAux);

	pData=InsertaDataLen("<",1,pData);
	pData=InsertaDataLen(szCampo,strlen(szCampo),pData);
	pData=InsertaDataLen(">",1,pData);
	pData=InsertaDataLen(szSql,strlen(szSql),pData);
	pData=InsertaDataLen("</",2,pData);
	pData=InsertaDataLen(szCampo,strlen(szCampo),pData);
	pData=InsertaDataLen(">",1,pData);
	
	//pData=CreaData();
	//pData->data=(char *)malloc(strlen(szCampo)+strlen(szSql)+512);
	//memset(pData->data,0,strlen(szCampo)+strlen(szSql)+512);
	//InsertaCampoXMLpData(pData->data,szCampo,szSql);
        nLen=SendSocket(id,Conexion[id].stSocketDatabase.m_socket,pData->data,pData->nLenData);
        if (nLen<=0)
        {
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_SEND_BD");
		sprintf(szAux,"FALLA_SEND_BD %s:%i LenData=%i",szIp,nPort,pData->nLenData);
		WriteMensajeApp(id,szAux);
		WriteLog(id,szAux);
                
		Conexion[id].stSocketDatabase.nConectado=0;
		sprintf(szAux,"Re-Conecta BD");
		WriteLog(id,szAux);
	        if (!ConectaCliente(id,nPort,szIp,&Conexion[id].stSocketDatabase))
                {
                     xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_CONEXION_BD");
		     sprintf(szAux,"FALLA_CONEXION_BD-3 %s:%i",szIp,nPort);
		     WriteMensajeApp(id,szAux);
		     WriteLog(id,szAux);
		     goto error;
                }

        	nLen=SendSocket(id,Conexion[id].stSocketDatabase.m_socket,pData->data,pData->nLenData);
		if (nLen<=0)
		{
		    sprintf(szAux,"Falla envio datos a BD");
		    WriteLog(id,szAux);
		    WriteMensajeApp(id,szAux);
		    CloseDatabase(id);
		    //Se le agrega status de el tipo de falla
		    xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_SEND_API_BD");
		    pData=LiberaData(pData);
		    return xml;
		}
        }
	pData=LiberaData(pData);
	
	pData=CreaData();
        if (LeePaquete(id,Conexion[id].stSocketDatabase.m_socket,pData,Conexion[id].nTimeoutBaseDatos)<0) 
	{
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE_BD");
		xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","SOCKET_NO_RESPONSE_BD");
		sprintf(szAux,"API %s:%i no responde",szIp,nPort);
		WriteMensajeApp(id,szAux);
		goto error;
	}
	szData=pData->data;
        xml=ProcesaInputXML1(xml,szData);
	//ImprimeXML(xml);

	if (strstr(szData,"STATUS>FIN</STATUS>")>0)
	{
		//sprintf(szAux,"Fin Query");
		//WriteLog(id,szAux);
		 xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_FIN");
		goto error;
        }
	else if (strstr(szData,"STATUS>SIN_DATA</STATUS>")>0)
	{
		szError[0]=0;
        	//xml=CierraXML(xml);
		CierraSocket(&Conexion[id].stSocketDatabase);
	        global.nConexionesBD--;
		 xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_SIN_DATA");
		goto error;
	}
	else if (strstr(szData,"STATUS>FALLA_TIMEOUT_QUERY_CANCELADO</STATUS>")>0)
	{
		 WriteLog(id,"Query Cancelado por Timeout");	
		 WriteMensajeApp(id,"Query Cancelado por Timeout");	
		 WriteLog(id,szSql);
		 WriteMensajeApp(id,szSql);
		 xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","TIMEOUT");
		goto error;
	}
	else if (strstr(szData,"STATUS>OK</STATUS>")==0)
        {
		//Sacamos el error
		pXml=GetStrXMLData(xml,"DESCRIPCION");
                //Si existe el TAG ..
                if (pXml)
                {
                        if (strlen(pXml->pData)>0)
                        {
				WriteLog(id,pXml->pData);
				WriteMensajeApp(id,pXml->pData);
			}
		}
		xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","ERR_NK");
		goto error;
        }
	else
	{
		xml=InsertaDataXML(xml,"__STS_ERROR_PXML__","OK");
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","OK");
	}

	//CierraXML(xml);
	*nStatus=1;
	//WriteLog(id,"OK");
	pData=LiberaData(pData);
        return xml;
error:
	//xml=CierraXML(xml);
	if (!global.nFormaConexionBD) CloseDatabase(id);
	//xml=InsertaDataXML(xml,"__STS_ERROR_PXML__",szData1);
	*nStatus=0;
	pData=LiberaData(pData);
	return xml;
}
//Conecta por la IP indicadas en lista_ip
//prueba desde la primera hasta la ultima
//donde conecta se va
int ConectaClienteCascada(int id,Tipo_Socket *pSocketServ,Tipo_Servicio *pServ)
{
        int i;
        Tipo_XML *xml1=NULL;
        char szAux[512];
        char szIp[256];
        int nPort;

        xml1=ProcesaInputXML1(xml1,pServ->szListaIP);
        if (xml1!=NULL)
        {
                for(i=0;i<100;i++)
                {
                        memset(szIp,0,sizeof(szIp));
                        nPort=0;
                        sprintf(szAux,"IP%i",i);
                        if (!GetStrXML(xml1,szAux,szIp,sizeof(szIp)))
                        {
                                return 0;
                        }
                        sprintf(szAux,"PORT%i",i);
                        if (!GetIntXML(xml1,szAux,&nPort))
                        {
                                return 0;
                        }
                        sprintf(szAux,"Conectando Cascada %s:%i",szIp,nPort);
                        WriteLog(id,szAux);
                        //Prueba la conexion
                        if (!ConectaCliente(id,nPort,szIp,pSocketServ))
                        {
                            sprintf(szAux,"Falla Conexion a %s:%i..\n\r",szIp,nPort);
                            WriteLog(id,szAux);
                        }
                        else
                        {
                                //si conecta ok
                                return 1;
                        }
                }
        }
        else
        {
                WriteLog(id,"No hay IP en la lista ConectaClienteCascada");
                return 0;
        }
}



int ConectaCliente(int id,int nPort,char szIp[],Tipo_Socket *pSocket)
{
    struct sockaddr_in sin1;
    int linger = 0;
    int optval = 1;
    unsigned long l=1;
    int flags,len,error;
    char szError[4192];
    fd_set			rset, wset;
    struct timeval	tval;
    int n;
    int nListaIp=0;
    int bName=0;
    struct hostent *tmp = 0;

reintenta_nombre:
    if ((pSocket->m_socket = socket(AF_INET,SOCK_STREAM,0)) == -1) 
    {
	    WriteLog(id,"Falla Creacion de Socket");
	    WriteMensajeApp(id,"Falla Creacion de Socket");
	    sprintf(szError,"%s",strerror(errno));
	    WriteLog(id,szError);
	    WriteMensajeApp(id,szError);
	    exit(1);
	    return 0;
    }
/*
    
    //Ponemos que el socket use keepalive
    if (setsockopt(pSocket->m_socket,SOL_SOCKET,SO_KEEPALIVE,(char*)&optval,sizeof(int)) <0)
    {
    	WriteLog(id,"Falla Activar SO_KEEPALIVE");
    }
*/
    //Ponemos el socket non blocking
    if(((flags = fcntl(pSocket->m_socket,F_GETFL,0))<0) || (fcntl(pSocket->m_socket,F_SETFL,flags|O_NONBLOCK)<0))
    {
	    WriteLog(id,"Falla Seteo Socket Non Blocking");
	    WriteMensajeApp(id,"Falla Seteo Socket Non Blocking");
	    sprintf(szError,"%s",strerror(errno));
	    WriteLog(id,szError);
	    WriteMensajeApp(id,szError);
	    return 0;
    }


    //07-10-2010
    sprintf(pSocket->szIp,"%s",szIp);
    pSocket->nPort=nPort;

    sin1.sin_family = AF_INET;
    sin1.sin_port = htons((u_short)nPort);
    sin1.sin_addr.s_addr = inet_addr(szIp);
    
    //FAY 2014-07-01
    //Verificamos si la IP entrante es un nombre y conectamos a la lista de IP que devuelva el DNS
    //Si es -1 puede ser un nombre
    if ((sin1.sin_addr.s_addr==-1) && (bName==0))
    {
	WriteLog(id,"Se verifica si es nombre");
	tmp = gethostbyname(szIp);
	if (!tmp) 
	{
		WriteLog(id,"Falla Verificacion por nombre");
    	}
	else bName=1;	
    }

    //Si es un nombre
    if (bName)
    {
	if (tmp->h_addr_list[nListaIp] != NULL)
	{

	        sprintf(szError,"Nombre=%s IP=%s:%i",szIp,inet_ntoa( (struct in_addr) *((struct in_addr *) tmp->h_addr_list[nListaIp])),nPort);
		WriteLog(id,szError);
		WriteMensajeApp(id,szError);
    		sin1.sin_addr.s_addr = inet_addr(inet_ntoa( (struct in_addr) *((struct in_addr *) tmp->h_addr_list[nListaIp])));
	}
	else 
	{
		WriteLog(id,"Falla Conexion por Nombre");
		return 0;
	}
	nListaIp++;
   }


    n=connect(pSocket->m_socket, (struct sockaddr *)&sin1,sizeof(sin1));
    if (n<0)
    {
	    if (errno != EINPROGRESS)
    	    {
		sprintf(szError,"Error en connect=%i",errno);
		WriteLog(id,szError);
		WriteMensajeApp(id,szError);
		WriteLog(id,"EINPROGRESS");
		close(pSocket->m_socket);
		if (bName) goto reintenta_nombre;
		return 0;
	    }
    }
    //La conexion esta lista..
    if (n==0) goto ok; 
    else
    {
	    FD_ZERO(&rset);
	    FD_SET(pSocket->m_socket, &rset);
	    wset = rset;
	    tval.tv_sec = 5;
	    tval.tv_usec = 0;
	    if ((n=select(pSocket->m_socket+1, &rset, &wset, NULL,&tval)) == 0) 
	    {
			close(pSocket->m_socket);
			WriteLog(id,"TIMEOUT CONEXION");
			WriteMensajeApp(id,"Timeout Conexion");
			if (bName) goto reintenta_nombre;
			return(0);
	    }

	    if (FD_ISSET(pSocket->m_socket,&rset)||FD_ISSET(pSocket->m_socket,&wset)) 
	   {
		   len = sizeof(error);
		   if (getsockopt(pSocket->m_socket,SOL_SOCKET, SO_ERROR, &error, &len) < 0)
		   {
			close(pSocket->m_socket);
			WriteLog(id,"ERROR getsockopt");
			WriteMensajeApp(id,"Error getsockopt");
			if (bName) goto reintenta_nombre;
			return(0);
		   }
	   }
	   else
	   {
		   close(pSocket->m_socket);
		   WriteLog(id,"ERROR FD_ISSET");
	    	   WriteMensajeApp(id,"Error FD_ISSET");
		   if (bName) goto reintenta_nombre;
		   return(0);
	   }

	   //Pone flags igual que antes en socket
	   fcntl(pSocket->m_socket,F_SETFL, flags);
	   if (error)
	   {
		sprintf(szError,"FALLA SOCKET getsockopt=%i",error);
		close(pSocket->m_socket);
		WriteLog(id,szError);
		WriteMensajeApp(id,szError);
		if (bName) goto reintenta_nombre;
		return(0);
	   }
	   goto ok;
    }

ok:
    pSocket->nConectado=1;
    return 1;
}

void WriteLogEst(int id,char *szMessage)
{
	// local data
	FILE *f;
	char szFile[100];
	struct timeb sTimeb;
    	struct tm thoy;

	if (!LOG(id)) return;
    	ftime(&sTimeb);
    	localtime_r(&sTimeb.time,&thoy);
	
	// open the file
	sprintf(szFile,"%04i%02i%02d_%s.EST",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,global.szPrefijoLog);
	f = fopen(szFile,"a");

	// if the log file did not open then fail
	if(!f) return;

	// write the file
	fprintf(f,"%04i%02i%02i,%02i%02i%02i%03i <%02i> %s\n",thoy.tm_year,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id,szMessage);

	// close the file
	fclose(f);
}

void WriteError(int id,char *szMessage)
{
	// local data
	FILE *f;
	char szFile[100];
	struct timeb sTimeb;
    	struct tm thoy;

    	ftime(&sTimeb);
    	localtime_r(&sTimeb.time,&thoy);
	
	// open the file
	sprintf(szFile,"%04i%02i%02d_%s.ERR",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,global.szPrefijoLog);
	f = fopen(szFile,"a+");

	// if the log file did not open then fail
	if(!f) return;

	// write the file
	fprintf(f,"%04i%02i%02i,%02i%02i%02i%03i <%02i> %s\n",thoy.tm_year,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id,szMessage);

	// close the file
	fclose(f);

	WriteMensajeApp(id,szMessage);
}

void WritePid(char *szMessage)
{
	// local data
	FILE *f;
	char szFile[100];
	struct timeb sTimeb;
    	struct tm thoy;

    	ftime(&sTimeb);
    	localtime_r(&sTimeb.time,&thoy);
	
	// open the file
	sprintf(szFile,"%04i%02i%02d%02i_%s.LOG",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,global.szPrefijoLog);
	f = fopen(szFile,"a");

	// if the log file did not open then fail
	if(!f) return;

	// write the file
	//fprintf(f,"%04i%02i%02i,%02i%02i%02i%03i <%02i> %s\n",thoy.tm_year,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id,szMessage);
	fprintf(f,"%02i%02i%02i%03i PID<%i> %s\n",thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,getpid(),szMessage);

	// close the file
	fclose(f);
}

void WriteMensajeApp(int id,char *data)
{
        // local data
        FILE *f;
        char szFile[100];
        struct timeb sTimeb;
        struct tm thoy;
        Tipo_XML *xml_aux=NULL;

        ftime(&sTimeb);
        localtime_r(&sTimeb.time,&thoy);

        // open the file
        sprintf(szFile,"%04i%02i%02d%02i_%s_APP.LOG",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,global.szPrefijoLog);
        f = fopen(szFile,"a+");

        // if the log file did not open then fail
        if(!f) return;

        fprintf(f,"%02i%02i%02i%03i <%02i> [%s] %s\n",thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id,Conexion[id].szFlujoActual,data);

        // close the file
        fclose(f);
        return;
}

Tipo_XML *WriteLogApp(int id,Tipo_XML *xml)
{
	// local data
	FILE *f;
	char szFile[100];
	struct timeb sTimeb;
    	struct tm thoy;
	Tipo_XML *xml_aux=NULL;

    	ftime(&sTimeb);
    	localtime_r(&sTimeb.time,&thoy);
	
	// open the file
	sprintf(szFile,"%04i%02i%02d%02i_%s_APP.LOG",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,global.szPrefijoLog);
	f = fopen(szFile,"a+");

	// if the log file did not open then fail
	if(!f) return xml;

	//Solo si existe TAG _LOG_, imprime el texto
	xml_aux=GetStrXMLData(xml,"_LOG_");
	if (xml_aux)
	{
		fprintf(f,"%02i%02i%02i%03i <%02i> %s\n",thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id,xml_aux->pData);
		//Limpia TAG para que no se escriba nuevamente
		xml=InsertaDataXML(xml,"_LOG_","");
	}

	// close the file
	fclose(f);
	return xml;
}

void WriteLog(int id,char *szMessage)
{
	// local data
	FILE *f;
	char szFile[100];
	struct timeb sTimeb;
    	struct tm thoy;

	if (!LOG(id)) return;
    	ftime(&sTimeb);
    	localtime_r(&sTimeb.time,&thoy);
	
	// open the file
	sprintf(szFile,"%04i%02i%02d%02i_%s.LOG",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,global.szPrefijoLog);
	f = fopen(szFile,"a");

	// if the log file did not open then fail
	if(!f) return;


	if (global.nLargoLineaLog==-1)
	{
	// write the file
	//fprintf(f,"%04i%02i%02i,%02i%02i%02i%03i <%02i> %s\n",thoy.tm_year,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id,szMessage);
	fprintf(f,"%02i%02i%02i%03i <%02i> [%s] %s\n",thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id,Conexion[id].szFlujoActual,szMessage);
	}
	else
	{
		fprintf(f,"%02i%02i%02i%03i <%02i> [%s] ",thoy.tm_hour,thoy.tm_min,thoy.tm_sec,sTimeb.millitm,id,Conexion[id].szFlujoActual);
		if (strlen(szMessage)>global.nLargoLineaLog) 
			fwrite(szMessage,sizeof(char),global.nLargoLineaLog,f);
		else
			fwrite(szMessage,sizeof(char),strlen(szMessage),f);
		fprintf(f,"\n");
	}
	// close the file
	fclose(f);
}

int ErrorXML1(char *response,char szBuffer[])
{
	return ErrorXML(response,szBuffer,"");
}

int ErrorXML(char *response,char szBuffer[],char szGlosa[])
{
	response[0]=0;
	InsertaCampoXML(response,"STATUS","OK");
	InsertaCampoXML(response,"PAGINA","ERROR");
	InsertaCampoXML(response,"LINEA0",szBuffer);
	InsertaCampoXML(response,"LINEA1",szGlosa);
	InsertaCampoXML(response,"CODIGO_RESPUESTA","1");
	return 0;
}

int SendDataXML(int id,Tipo_XML *xml,int fin)
{
	Tipo_XML *xml1=xml;
	int nLen;
	int nSocket=Conexion[id].nSocket;
	char response[MAX_BUFFER];
	memset(response,0,sizeof(response));
	InsertaCampoXML(response,"STATUS","OK");
	InsertaCampoXML(response,"TIMEOUT","10");
	while(1)
	{
		if (xml1==NULL)
		{
			if (!fin) InsertaCampoXML(response,"NEXT"," ");
			SendSocket(id,nSocket,response,strlen(response));
			printf("RESP FIN=%s\n\r",response);
			return 1;
		}
	       nLen=strlen(response)+strlen(xml1->szCampo)+strlen(xml1->pData);
	       if ((nLen+70)>MAX_BUFFER)
		{
			InsertaCampoXML(response,"NEXT"," ");
			SendSocket(id,nSocket,response,strlen(response));
			printf("RESP=%s\n\r",response);

			memset(response,0,sizeof(response));
			InsertaCampoXML(response,"STATUS","OK");
			InsertaCampoXML(response,xml1->szCampo,xml1->pData);
		}
		else InsertaCampoXML(response,xml1->szCampo,xml1->pData);
		xml1=xml1->pNext;
	}
}
/*
Tipo_XML *GetCampoDataXML(Tipo_XML *xml,char szCampo[],char szData[])
{
	while(xml!=NULL)
	{
		sprintf(szCampo,"%s",xml->szCampo);
		sprintf(szData,"%s",xml->pData);
		return xml->pNext;
	}
	return NULL;
}
*/

Tipo_XML *GetCampoXML(Tipo_XML *xml,char szCampo[])
{
	while(xml!=NULL)
	{
		sprintf(szCampo,"%s",xml->szCampo);
		return xml->pNext;
	}
	return NULL;
}

//pForSalida formato de envio
//pForAck formato de respuesta
Tipo_XML *AutorizaServicioXML(int id,Tipo_XML *xml,Tipo_Formatos *pForSalida,Tipo_Formatos *pForAck,Tipo_Servicio *pServ,int *nStatus)
{
	
	//char szPaquete[MAX_BUFFER];
	Tipo_Data *pPaquete=NULL;
	char szAux[200];
	int nLenForAck,sts;
	char szData[MAX_BUFFER];
	int nLen;
	char szIp[200];
	int nPort;
	int nTimeout;
	int bHostHost=0;
	int bAsincrona=0;
	int nCasillaHH=-1;
	int nIntentosHH=0;
	int sts1=0;
	int bNoClose=0;
	int bCascada=0;
	Tipo_Socket *pSocketServ;
	time_t t1,t2;
	Tipo_Data *pData=NULL;
	Tipo_XML *xml_aux=NULL;
	
	*nStatus=0;
	pSocketServ = &Conexion[id].stSocket;

	//Para medir el timeout del servicio
	time(&t1);
	
	sprintf(szIp,"%s",pServ->szIp);
	nPort=pServ->nPort;
	nTimeout=pServ->nTimeout;
	if (nTimeout==0) 
	{
		char szTmp[200];
		sprintf(szTmp,"Timeout no definido para serv=%i",pServ->nTx);
		WriteLog(id,szTmp);
		nTimeout=10;
	}
	xml_aux=GetStrXMLData(xml,"__TIMEOUT_SERV_PXML__");
        //Si existe el TAG ..
        if (xml_aux)
        {
                if (strlen(xml_aux->pData)>0)
                {
                        nTimeout=atoi(xml_aux->pData);
                        sprintf(szAux,"Cambia Timeout Serv a %i",nTimeout);
                        WriteLog(id,szAux);
                        xml=InsertaDataXML(xml,"__TIMEOUT_SERV_PXML__","");
                }
        }




	WriteLog(id,pServ->szTipoConexion);
	//Seleccionamos segun el tipo de conexion
	if (memcmp(pServ->szTipoConexion,"HOST",4)==0) bHostHost=1;
	//El Tipo NO_CLOSE se usa para no cerrar el socket y devuelve en el TAG __SOCKETOPEN__ el Socket por el cual
	//Se puede seguir enviando data para no perder el contexto del procesaxml
	else if (memcmp(pServ->szTipoConexion,"NO_CLOSE",8)==0) bNoClose=1;
	else if (memcmp(pServ->szTipoConexion,"CASCADA",7)==0) bCascada=1;
	else if (memcmp(pServ->szTipoConexion,"H2H_",4)==0) 
	{
		bAsincrona=1;
		WriteLog(id,"ASincrona");
	}


	//memset(szPaquete,0,sizeof(szPaquete));
	//printf("Entra a AutorizaServ\n\r");
	//Imprime2XML(xml);
	//AplicaFormatoSalida(id,szPaquete,xml,pForSalida,&nLen);	
	pPaquete=AplicaFormatoSalidaVar(id,pPaquete,xml,pForSalida,&nLen);
        
	if (bHostHost)
	{
otra_hh:
                nCasillaHH=GetSocketHostHost(id,pSocketServ,szIp,nPort);
                if (nCasillaHH<0)
                {
                    return xml;
                }
		sprintf(szAux,"Asigna Socket=%i Casilla H2H %i\n",pSocketServ->m_socket,nCasillaHH);
		WriteLog(id,szAux);
	}
	else if (bAsincrona)
	{
otra_hh_asin:
		WriteLog(id,"H2H ASincrona");
		nCasillaHH=GetSocketHostHostAsinc(id,pSocketServ,pServ);
		if (nCasillaHH<0) return xml;
	}
	else if (bNoClose)
	{
		//si viene el TAG del socket abierto usamos ese
		//Si no abrimos uno nuevo
		if (GetStrXML(xml,"__SOCKETOPEN__",szAux,sizeof(szAux)))
		{
			//Si viene el socket ya esta abierto
			//entonces usamos el que viene y no abrimos 
			pSocketServ->m_socket=atol(szAux);
			sprintf(szAux,"SOCKET NO_CLOSE uso socket=%i",pSocketServ->m_socket);
			WriteLog(id,szAux);
			
		}
		else
		{
			//Conecta socket
			sprintf(szAux,"Conectando %s:%i",szIp,nPort);
	        	WriteLog(id,szAux);
			printf("Conectando %s:%i..\n\r",szIp,nPort);
	        	InicializaSocket(pSocketServ,"Socket Servicio");
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","");
	        	if (!ConectaCliente(id,nPort,szIp,pSocketServ))
        		{
				xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_CONEXION");
	            		sprintf(szAux,"Falla Conexion a %s:%i..\n\r",szIp,nPort);
        	   	 	WriteLog(id,szAux);
	            		return xml;
	        	}
			sprintf(szAux,"%ld",pSocketServ->m_socket);
			xml=InsertaDataXML(xml,"__SOCKETOPEN__",szAux);
			sprintf(szAux,"NO_CLOSE:Socket Conectado %i",pSocketServ->m_socket);
	        	WriteLog(id,szAux);
		}

	}
        //Cascada es elije de lista_ip la primera  IP si conecta va por esa
        //si falla va por la segunda y asi consecutivamente
        else if (bCascada)
        {
                        InicializaSocket(pSocketServ,"Socket Servicio");
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","");
                        if (!ConectaClienteCascada(id,pSocketServ,pServ))
                        {
				xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_CONEXION");
                                sprintf(szAux,"Falla Conexion Cascada a %s\n\r",pServ->szDescripcion);
                                WriteLog(id,szAux);
                                return xml;
                        }
        }
	else
	{
		
		//Si es conexion NoClose, puede estar abierto..
		if ((bNoClose==0) || (pSocketServ->nConectado==1))
		{
			//Conecta socket
			sprintf(szAux,"Conectando %s:%i..\n\r",szIp,nPort);
	        	WriteLog(id,szAux);
			printf("Conectando %s:%i..\n\r",szIp,nPort);
	        	InicializaSocket(pSocketServ,"Socket Servicio");
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","");
	        	if (!ConectaCliente(id,nPort,szIp,pSocketServ))
        		{
				xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_CONEXION");
	            		sprintf(szAux,"Falla Conexion a %s:%i..\n\r",szIp,nPort);
        	   	 	WriteLog(id,szAux);
	            		return xml;
	        	}
			printf("Conectado  a %s:%i..\n\r",szIp,nPort);
		}
		else WriteLog(id,"Socket NoClose ya conectado");
	}
        
	//Envia Data al Servicio.
	sprintf(szAux,"H2H Envia Data %s:%i Estado[%i]=%i LargoData=%i Socket=%i",pSocketServ->szIp,pSocketServ->nPort,id,Conexion[id].nEstado,nLen,pSocketServ->m_socket);
	if (pPaquete) sprintf(szAux,"H2H Envia Data* %s:%i Estado[%i]=%i LargoData=%i Socket=%i",pSocketServ->szIp,pSocketServ->nPort,id,Conexion[id].nEstado,pPaquete->nLenData,pSocketServ->m_socket);
	WriteLog(id,szAux);
	if (pPaquete) WriteData(id,pPaquete->data,pPaquete->nLenData);
	//printf("Envia (%i) %s\n\r",nLen,szPaquete);

	//Si el socket es Asincronico H2H el send serializa la data si multiples threads estan enviando
	//de manera simultanea, por ende no es necesario un mutex o un control para el envio FAY 11-07-2010
	//Si la conexion es asincronica
	if (bAsincrona)
	{
		//Se pone esta region critica por si estuviera cerrando el socket
		//pthread_mutex_lock(&ServiciosAsincronos[nCasillaHH].mutex_serv_asinc);
        	//sts=send(pSocketServ->m_socket,szPaquete,nLen,0);
		if (pPaquete) sts=send(pSocketServ->m_socket,pPaquete->data,pPaquete->nLenData,MSG_NOSIGNAL);
		//pthread_mutex_unlock(&ServiciosAsincronos[nCasillaHH].mutex_serv_asinc);
	}
	else
	{	
        	//sts=send(pSocketServ->m_socket,szPaquete,nLen,0);
		if (pPaquete) sts=send(pSocketServ->m_socket,pPaquete->data,pPaquete->nLenData,MSG_NOSIGNAL);
	}
	
        if (sts<0)
        {
                WriteLog(id,"H2H Falla envio de datos");
		//Si falla envio de datos y es host to host...
		//entonces intente de nuevo
		if (bHostHost)
		{
			if (nIntentosHH++<2)
			{
				WriteLog(id,"Intenta de nuevo HH");
				printf("Cierra Socket H2H Casilla=%i\n",nCasillaHH);
				CierraSocketHostHost(id,nCasillaHH);
				goto otra_hh;
			}
		}
		else if (bAsincrona)
		{
			/*
			if (nIntentosHH++<1)
                        {
                                WriteLog(id,"Intenta de nuevo H2H Asinc");
                                //CierraSocketHostHostAsinc(id,nCasillaHH);
                                goto otra_hh_asin;
                        }
			*/
    
		}
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_SEND");
                goto fin;
		
        }
	sprintf(szAux,"H2H Bytes Escritos %i a %s:%i",sts,pSocketServ->szIp,pSocketServ->nPort);
	WriteLog(id,szAux);

	//Si es un socket asincrono libera inmediatamente el socket para que otro pueda escribir
	//if (bAsincrona) LiberaSocketH2H_Asinc(id,nCasillaHH);

	//Si existe un formato de respuesta, leemos la respuesta..
	if (pForAck)
	{
		int nSocket=pSocketServ->m_socket;
		int nLeidos;
		memset(szData,0,sizeof(szData));
		pData=CreaData();
		printf("pData=%x\n",pData);
		sprintf(szAux,"LeeData Socket=%i",nSocket);
		WriteLog(id,szAux);
		if (pServ->nTipoRespuesta==0) 
		{
			nLenForAck=LargoFormato(pForAck);
			printf("Espera Respuesta LeeNData %i\n\r",nLenForAck);
			//sprintf(szAux,"Puntero %x",pData);
			//WriteLog(id,szAux);
			//nLeidos=LeeNData(id,nSocket,nLenForAck,szData,nTimeout);
			pData=LeeNData(id,nSocket,nLenForAck,pData,nTimeout,&nLeidos);
			printf("nLeidos=%i\n",nLeidos);
			//sprintf(szAux,"Puntero1 %x",pData);
			//WriteLog(id,szAux);
			if (nLeidos<0) 
			{
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		   	sprintf(szAux,"H2H Servicio %s:%i no responde1",pSocketServ->szIp,pSocketServ->nPort);
        	   	WriteLog(id,szAux);
		   	goto fin;
			}
			//memcpy(szData,pData->data,nLeidos);
			//szData[nLeidos]=0;
			//pData=LiberaData(pData);
			//sprintf(szAux,"Puntero2 %x",pData);
			//WriteLog(id,szAux);
		}
		//Espera un largo minimo de respuesta
		else if (pServ->nTipoRespuesta==2) 
		{
			int nLen;
			int nLeidos1;
			nLen=pServ->nLenMinimo;
			//pData=CreaData();
			//nLeidos=LeeNData(id,nSocket,nLen,szData,nTimeout);
			pData=LeeNData(id,nSocket,nLen,pData,nTimeout,&nLeidos);
			if (nLeidos<0) 
			{
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		   	sprintf(szAux,"H2H Servicio %s:%i no responde2",pSocketServ->szIp,pSocketServ->nPort);
        	   	WriteLog(id,szAux);
		   	goto fin;
			}
			//memcpy(szData,pData->data,nLeidos);
			//szData[nLeidos]=0;
			//pData=LiberaData(pData);
			
		//	nLeidos1=LeeData(id,nSocket,&szData[nLeidos],sizeof(szData),nTimeout);
			//pData=CreaData();
			pData=LeeDataVariable(id,nSocket,pData,nTimeout,&nLeidos1);
			if (nLeidos1<0)
			{
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		   	sprintf(szAux,"H2H Servicio %s:%i no responde3",pSocketServ->szIp,pSocketServ->nPort);
        	   	WriteLog(id,szAux);
		   	goto fin;
			}
			//memcpy(&szData[nLeidos],pData->data,nLeidos1);
			nLeidos+=nLeidos1;
			//szData[nLeidos]=0;
			//pData=LiberaData(pData);

			

		}
		//Espera respuesta tipo rafaga con un largo variable
		else if (pServ->nTipoRespuesta==3)
		{
			printf("Espera Respuesta Rafaga\n\r");
			/*
			nLeidos=LeeDataRafaga(id,nSocket,szData,sizeof(szData),nTimeout,pServ->nTimeoutRafaga);
			if (nLeidos<0)
			{
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		   	sprintf(szAux,"Servicio %s:%i no responde4",pSocketServ->szIp,pSocketServ->nPort);
        	   	WriteLog(id,szAux);
		   	goto fin;
			}
			*/
		}
		//Lee Tipo HTTP buscand Content_Length
		else if (pServ->nTipoRespuesta==6)
		{
			//nLeidos=LeeDataPatronFinal(id,nSocket,szData,sizeof(szData),nTimeout,pServ->szPatronFinal);
			WriteMensajeApp(id,"Lectura por Respuesta HTTP");
			pData=LeeWebServer(id,nSocket,pData,nTimeout,&nLeidos);
			if (nLeidos<0)
			{
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		   	sprintf(szAux,"H2H Servicio %s:%i no responde6",pSocketServ->szIp,pSocketServ->nPort);
        	   	WriteLog(id,szAux);
		   	goto fin;
			}
			//if (pData) WriteMensajeApp(id,pData->data);
		}
		//Lee mientras no llegue el patron final
		else if (pServ->nTipoRespuesta==4)
		{
			//nLeidos=LeeDataPatronFinal(id,nSocket,szData,sizeof(szData),nTimeout,pServ->szPatronFinal);
			pData=LeeDataPatronFinalData(id,nSocket,pData,nTimeout,pServ->szPatronFinal,&nLeidos);
			if (nLeidos<0)
			{
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		   	sprintf(szAux,"H2H Servicio %s:%i no responde5",pSocketServ->szIp,pSocketServ->nPort);
        	   	WriteLog(id,szAux);
		   	goto fin;
			}
		}
		//El tipo 5 es de respuestas asincronas y se lee seguna la configuracion del servicio
		//en el campo patron_final se almacena los bytes a leer por cada respuesta y el tamaño del headeren XML
		//o ase <len_rsp>519</len_rsp><ini_header>2<ini_header><fin_header>80</fin_header>
		//se asume que el header indica si la respeusta es mia o la guardo en la cola de respuestas
		
		//Hay que setear <total_bytes_largo>4</toral_bytes_largo><tipo_largo>VARIABLE</tipo_largo>
		//Ademas se debe setear por cada tx el campo __LLAVE_TX__ para que el proceso identifique con la funciuon strstr
		//cual respuesta es la que corresponde encontrar
		else if (pServ->nTipoRespuesta==5 && bAsincrona)
		{
			char szLlaveAux[1024];
			char szLlaveEmisor[1024];
			GetStrXML(xml,"__LLAVE_TX__",szLlaveAux,sizeof(szLlaveAux));
			GetStrXML(xml,"__LLAVE_ASIN_EMISOR__",szLlaveEmisor,sizeof(szLlaveEmisor));

			if (strstr(szLlaveEmisor,"BINARIO")>0)
                        {
                                WriteLog(id,"szLlaveEmisor es BINARIO");
                                nLeidos=LeeRespuestaAsincronaBinaria(id,nCasillaHH,szData,sizeof(szData),szLlaveAux);
                                if (nLeidos<0)
                                {
					xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
                                        sprintf(szAux,"H2H Servicio %s:%i no responde6",pSocketServ->szIp,pSocketServ->nPort);
                                        WriteLog(id,szAux);
                                        goto fin;
                                }
                        } 
			else 
			{
                                WriteLog(id,"szLlaveEmisor NO es BINARIO");
                                nLeidos=LeeRespuestaAsincrona(id,nCasillaHH,szData,sizeof(szData),szLlaveAux);
                                if (nLeidos<0)
                                {
					xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
                                        sprintf(szAux,"H2H Servicio %s:%i no responde6",pSocketServ->szIp,pSocketServ->nPort);
                                        WriteLog(id,szAux);
                                        goto fin;
                                }
                        }
		}
		//FAY 2015-12-21 Tipo de Respuesta NAtivo del Motor
		else if (pServ->nTipoRespuesta==7)
		{
			Tipo_XML *xml3=NULL;
			WriteLog(id,"Entra a Leer nTipoRespuesta=7");
			xml3=LeePaqueteXML(id,pSocketServ->m_socket,nTimeout,xml3,&sts1);
			if (!sts1)
		        {
		            xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		   	    sprintf(szAux,"H2H Tipo=7 Servicio %s:%i no responde7",pSocketServ->szIp,pSocketServ->nPort);
            	   	    WriteLog(id,szAux);
		            WriteMensajeApp(id,szAux);
			    close(pSocketServ->m_socket);
			    return xml;
        		}
			time(&t2);
			sprintf(szAux,"Servicio Responde OK en %i segundos Servicio=%s:%i",t2-t1,pSocketServ->szIp,pSocketServ->nPort);
            	   	WriteLog(id,szAux);
		        WriteMensajeApp(id,szAux);
			xml=LlenaXMlFormato(id,xml3,xml,pForAck);
			CierraXML(xml3);
			close(pSocketServ->m_socket);
			pSocketServ->nConectado=0;
			return xml;
		}	
		else 
		{
			printf("Espera Respuesta Variable\n\r");
			nLeidos=LeeData(id,nSocket,szData,sizeof(szData),nTimeout);
			if (nLeidos<0)
			{
			xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		   	sprintf(szAux,"H2H Servicio %s:%i no responde7",pSocketServ->szIp,pSocketServ->nPort);
        	   	WriteLog(id,szAux);
		   	goto fin;
			}
		}

		time(&t2);
		//Si hay largo de respuesta, entonces responde OK
		if (nLeidos>0)
		{
		sprintf(szAux,"Servicio Responde OK en %i segundos Largo=%i Servicio=%s:%i",t2-t1,nLeidos,pSocketServ->szIp,pSocketServ->nPort);
		printf(szAux,"Servicio Responde OK en %i segundos Largo=%i Servicio=%s:%i",t2-t1,nLeidos,pSocketServ->szIp,pSocketServ->nPort);
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","OK");
		}
		else
		{
		sprintf(szAux,"Servicio NO Responde en %i segundos Largo=%i Servicio=%s:%i",t2-t1,nLeidos,pSocketServ->szIp,pSocketServ->nPort);
		printf(szAux,"Servicio NO Responde en %i segundos Largo=%i Servicio=%s:%i",t2-t1,nLeidos,pSocketServ->szIp,pSocketServ->nPort);
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
		}
        	WriteLog(id,szAux);
		WriteMensajeApp(id,szAux);
		
		//printf("pData1=%x\n",pData);
		if (pData==NULL || pData->data == NULL) 
		{
			printf("Libera1\n");
			pData=LiberaData(pData);
			if (strlen(szData)>0) pData=NewString(pData,szData);
		}
		if (pData && pData->data) 
		{
			WriteData(id,pData->data,nLeidos);
			//printf("LEido=%s\n",pData->data);
		}

		if (bNoClose) WriteLog(id,"Socket Servicio No Cerrado");
		else if (bHostHost) 
		{
			//Marca como socket liberado pero no lo cierra
			pSocketServ->nConectado=0;
			LiberaSocketHostHost(id,nCasillaHH);
			printf("Libera iSocket Casilla=%\n",nCasillaHH);
		}
		else if (bAsincrona)
		{
			//No hace nada con el socket
			//El socket ya esta liberado para que otro escriba
		}
		else
		{
			//Cierra Socket
			close(pSocketServ->m_socket);
			pSocketServ->nConectado=0;
			WriteLog(id,"Cierra Socket");
		}
		*nStatus=3;
		ImprimeMemoria(id,"Antes de AplicaFormatoEntrada");
		if (pData) xml=AplicaFormatoEntrada(id,xml,pData->data,pForAck,nLeidos);
		ImprimeMemoria(id,"Despues de AplicaFormatoEntrada");
		pData=LiberaData(pData);
		return xml;

	}
	//Si no tiene formato de respuesta
	else
	{
	}

fin:
	sprintf(szAux,"Falla Servicio %s:%i",pSocketServ->szIp,pSocketServ->nPort);
	WriteMensajeApp(id,szAux);
	WriteLog(id,szAux);
	if (pData) pData=LiberaData(pData);
	if (bHostHost)
	{
		
		if (nIntentosHH++<2)
		{
			WriteLog(id,"*Intenta de nuevo HH");
			CierraSocketHostHost(id,nCasillaHH);
			goto otra_hh;
		}
		else CierraSocketHostHost(id,nCasillaHH);
		
	}
	else if (bAsincrona)
	{
		/*
		if (nIntentosHH++<1)
		{
			WriteLog(id,"*Intenta de nuevo HH");
			//CierraSocketHostHostAsinc(id,nCasillaHH);
			goto otra_hh_asin;
		}
		*/
		//else CierraSocketHostHostAsinc(id,nCasillaHH);
	}
	else if (bNoClose)
	{
		close(pSocketServ->m_socket);
		pSocketServ->nConectado=0;
		xml=InsertaDataXML(xml,"__SOCKETOPEN__","-1");
	}
	else
	{
		close(pSocketServ->m_socket);
		pSocketServ->nConectado=0;
	}
	ImprimeMemoria(id,"Salida de AutorizaServicioXML");
	return xml;

}

pthread_mutex_t mut_dosip = PTHREAD_MUTEX_INITIALIZER;
Tipo_XML *AutorizaServicio1(int id,Tipo_XML *xml,Tipo_Servicio *pServ,int *sts)
{
	Tipo_Socket stSocketServicio;
	char szError[1000];
	char szComando[100];
	char szAux[512];
	Tipo_XML *xml_aux=NULL;
	int bNext;
	long lCodaut;
	//char szPaquete[MAX_BUFFER];
	char szIp[200];
	int nPort,nTimeout;
	int bHostHost=0;
	int nCasillaHH=-1;
	int sts1;

	*sts=0;
	if (memcmp(pServ->szUsaDosIP,"SI",2)==0)
	{
		int i,j;
		Tipo_XML *xml1=NULL;

		j=0;
		pthread_mutex_lock(&mut_dosip);
		for(i=0;i<MAX_INSTANCIAS;i++) 
			if (Instancias[i].nServicio==pServ->nTx) 
			{
				Instancias[i].nInstancia++;
				j=Instancias[i].nInstancia;
				break; 
			}
		if (i==MAX_INSTANCIAS) 
		{
			for(i=0;i<MAX_INSTANCIAS;i++) if (Instancias[i].nServicio==0) break;
			sprintf(szAux,"Asigna Casilla %i de instancias a servicio %i",i,pServ->nTx);
			WriteLog(id,szAux);
			Instancias[i].nServicio=pServ->nTx;
			Instancias[i].nInstancia=0;
			j=Instancias[i].nInstancia;
		}
		pthread_mutex_unlock(&mut_dosip);

		sprintf(szIp,"");
		nPort=0;

		xml1=ProcesaInputXML1(xml1,pServ->szListaIP);
		if (xml1!=NULL) 
		{
			sprintf(szAux,"IP%i",j);
			if (!GetStrXML(xml1,szAux,szIp,sizeof(szIp)))
        		{
			    sprintf(szError,"ERROR no viene Campo=%s en servicio=%i",szAux,pServ->nTx);
		            WriteLog(id,szError);

			    //Volvemos a la IP0
			    pthread_mutex_lock(&mut_dosip);
			    Instancias[i].nInstancia=0;
			    pthread_mutex_unlock(&mut_dosip);
			    j=0;
			    sprintf(szAux,"IP%i",j);	
                            GetStrXML(xml1,szAux,szIp,sizeof(szIp));
		        }
			
			sprintf(szAux,"PORT%i",j);
			if (!GetIntXML(xml1,szAux,&nPort))
			{
			    sprintf(szError,"ERROR no viene Campo=%s en servicio=%i",szAux,pServ->nTx);
		            WriteLog(id,szError);
			}
		}
		else WriteLog(id,"Lista de IP NULA");

		xml1=CierraXML(xml1);
 
		
		sprintf(szAux,"IP %s PORT %i IN %i",szIp,nPort,j);
		WriteLog(id,szAux);
	}
	else
	{
		sprintf(szIp,"%s",pServ->szIp);
		nPort=pServ->nPort;
	}

	nTimeout=pServ->nTimeout;
	if (nTimeout<=0) nTimeout=10;
	xml_aux=GetStrXMLData(xml,"__TIMEOUT_SERV_PXML__");
        //Si existe el TAG ..
        if (xml_aux)
        {
                if (strlen(xml_aux->pData)>0)
                {
                        nTimeout=atoi(xml_aux->pData);
                        sprintf(szAux,"Cambia Timeout Serv a %i",nTimeout);
                        WriteLog(id,szAux);
			xml=InsertaDataXML(xml,"__TIMEOUT_SERV_PXML__","");
                }
        }

	//Seleccionamos segun el tipo de conexion
	if (memcmp(pServ->szTipoConexion,"HOST",4)==0) bHostHost=1;

	if (!bHostHost)
	{
        	sprintf(szAux,"Conectando %s;%i..\n\r",szIp,nPort);
	        WriteLog(id,szAux);
	        InicializaSocket(&stSocketServicio,"Socket Servicio");
        	//sprintf(szAux,"Paso 1");
	        //WriteLog(id,szAux);
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","");
	        if (!ConectaCliente(id,nPort,szIp,&stSocketServicio))
        	{
		    xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_CONEXION");
	            sprintf(szAux,"Falla Conexion a %s;%i..\n\r",szIp,nPort);
        	    WriteLog(id,szAux);
	            return xml;
        	}
	}
	//Si es conexionb HostHost
	else 
	{
	        WriteLog(id,"Host Host");
		nCasillaHH=GetSocketHostHost(id,&stSocketServicio,szIp,nPort);
		if (nCasillaHH<0)
		{
		    xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SIN_CASILLAS_H2H");
	            return xml;
		}
	}
        //sprintf(szAux,"Paso 2");
        //WriteLog(id,szAux);
        if (SendSocketXML1(id,stSocketServicio.m_socket,xml)<0)
        {
		sprintf(szAux,"Falla envio de datos %s:%i",szIp,nPort);
		xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","FALLA_SEND");
                WriteLog(id,szAux);
                goto fin;
        }
        //sprintf(szAux,"Paso 3");
        //WriteLog(id,szAux);
        bNext=0;
        //memset(szPaquete,0,sizeof(szPaquete));
        //Espera la Respuesta
	xml=LeePaqueteXML(id,stSocketServicio.m_socket,nTimeout,xml,&sts1);	
        //if (LeePaquete(id,stSocketServicio.m_socket,szPaquete,sizeof(szPaquete),nTimeout)<=0)
	if (!sts1)
        {
	    xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
	    sprintf(szAux,"Servicio no responde %s:%i",szIp,nPort);
            WriteLog(id,szAux);
            goto fin;
        }
        //sprintf(szAux,"Paso 4");
        //WriteLog(id,szAux);

        //WriteLog(id,"Respuesta Servicio");
        //WriteLog(id,szPaquete);

        //Procesamos la respuesta del servicio..
        //xml=ProcesaInputXML1(szPaquete);
        if (!GetStrXML(xml,"STATUS",szAux,sizeof(szAux)))
        {
            WriteLog(id,"Error en respuesta de Servicio, no viene STATUS(1)");
            //WriteLog(id,szPaquete);
            goto fin;
        }
        if (memcmp(szAux,"ERROR",2)==0)
        {
            WriteLog(id,"A ocurrido un error en la ejecucion");
            //WriteLog(id,szPaquete);
            //if (GetStrXML(xml,"ERROR",szError,sizeof(szError))>0)
	//	sprintf(szPaquete,"%s",szError);
            goto fin;
        }
        else if (memcmp(szAux,"OK",2)!=0)
        {
            WriteLog(id,"No viene OK en STATUS");
            //WriteLog(id,szPaquete);
            goto fin;
        }

	//Si no viene pagina respondemos en forma literal..
        else
        {
	     *sts=1;
	     if (!bHostHost) CierraSocket(&stSocketServicio);
	     else LiberaSocketHostHost(id,nCasillaHH);
             return xml;
        }
fin:
	if (!bHostHost) CierraSocket(&stSocketServicio);
	else CierraSocketHostHost(id,nCasillaHH);
        //xml=CierraXML(xml);
        return xml;
}


int EnviaDataServicio(int id,Tipo_XML *xml1,char szIp[],int nPort,Tipo_Socket *pSocket)
{
	char szAux[100];

        sprintf(szAux,"Conectando %s;%i..\n\r",szIp,nPort);
        WriteLog(id,szAux);
        InicializaSocket(pSocket,"Socket Servicio");

        if (!ConectaCliente(id,nPort,szIp,pSocket))
        {		
            sprintf(szAux,"Falla Conexion a %s;%i..\n\r",szIp,nPort);
            WriteLog(id,szAux);
	    goto fin;
        }

        if (SendSocketXML1(id,pSocket->m_socket,xml1)<0)
        {
                WriteLog(id,"Falla envio de datos");
                goto fin;
        }
	return 1;
fin:
        CierraSocket(pSocket);
	return 0;
}

/*Funcion para IsysIEN*/
Tipo_XML *GetRespuestaServicio(int id,Tipo_Socket *pSocket,int nTimeout,Tipo_XML *xml,int *nStatus)
{
	char szError[1000];
	char szAux[100];
	char szPaquete[MAX_BUFFER];
	int sts;
        
	*nStatus=0;
	memset(szPaquete,0,sizeof(szPaquete));
	xml=LeePaqueteXML(id,pSocket->m_socket,nTimeout,xml,&sts);
	if (!sts)
        {
	    xml=InsertaDataXML(xml,"__STS_ERROR_SOCKET__","SOCKET_NO_RESPONSE");
            WriteLog(id,"Servicio no responde");
            goto fin;
        }
        if (!GetStrXML(xml,"STATUS",szAux,sizeof(szAux)))
        {
            WriteLog(id,"Error en respuesta de Servicio, no viene STATUS(2)");
            WriteLog(id,szPaquete);
            goto fin;
        }
        if (memcmp(szAux,"ERROR",2)==0)
        {
            WriteLog(id,"A ocurrido un error en la ejecucion");
            WriteLog(id,szPaquete);
            if (GetStrXML(xml,"ERROR",szError,sizeof(szError))>0)
		sprintf(szPaquete,"%s",szError);
            goto fin;
        }
        else if (memcmp(szAux,"OK",2)!=0)
        {
            WriteLog(id,"No viene OK en STATUS");
            WriteLog(id,szPaquete);
            goto fin;
        }

	//Si no viene pagina respondemos en forma literal..
        else
        {
             //CierraSocket(&stSocketServicio); 
	     *nStatus=1;
             return xml;
        }
fin:
        CierraSocket(pSocket);
        //xml=CierraXML(xml);
        //return NULL;
        return xml;
}
