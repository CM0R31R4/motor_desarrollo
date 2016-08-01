#include <xml.h>
Tipo_Data *NewDataLen(char szData[],int nLen);

Tipo_Data *ConcatenaData(char szData[],Tipo_Data *pData,int nLeido)
{
	if (pData==NULL) 
	{
		pData = CreaData();
	}
	if (pData->data == NULL)
	{
		pData->data = (char *)malloc(nLeido+1);
		memcpy(pData->data,szData,nLeido);
		pData->data[nLeido]=0;
		pData->nLenData =nLeido;
 	}
	else
	{
		pData->data = (char *)realloc(pData->data,nLeido+pData->nLenData+10);
		memcpy(&pData->data[pData->nLenData],szData,nLeido);
		pData->nLenData += nLeido;
		pData->data[pData->nLenData]=0;
	
	}
	return pData;
}

Tipo_Data *InsertaData(char szData[],Tipo_Data *pData)
{
	if (pData==NULL) 
	{
		pData = NewData(szData);
		return pData;
	}
	pData->data = (char *)realloc(pData->data,strlen(szData)+pData->nLenData+10);
	memcpy(&pData->data[pData->nLenData],szData,strlen(szData));
	pData->nLenData +=strlen(szData);
	pData->data[pData->nLenData]=0;
	return pData;
}
Tipo_Data *InsertaDataLen(char szData[],int nLen,Tipo_Data *pData)
{
	if (pData==NULL) 
	{
		pData = NewDataLen(szData,nLen);
		return pData;
	}
	if (pData->data==NULL)
	{
		pData->data = (char *)malloc(nLen+1);
		memcpy(pData->data,szData,nLen);
		pData->data[nLen]=0;
		pData->nLenData =nLen;
	}
	else
	{
		/*
		Tipo_Data *pData1;
		pData1=(Tipo_Data *)malloc(sizeof(Tipo_Data));
		if (!pData1) return NULL;
		pData1->data=(char *)malloc(nLen+pData->nLenData+1);
		if (!pData1->data) return NULL;
		memcpy(pData1->data,pData->data,pData->nLenData);
		memcpy(&pData1->data[pData->nLenData],szData,nLen);
		pData1->nLenData=pData->nLenData+nLen;
		pData1->data[pData1->nLenData]=0;

		LiberaData(pData);
		return pData1;
		*/
		pData->data = (char *)realloc(pData->data,nLen+pData->nLenData+10);
		memcpy(&pData->data[pData->nLenData],szData,nLen);
		pData->nLenData +=nLen;
		pData->data[pData->nLenData]=0;	
	}
	return pData;
}

Tipo_Data *CreaData()
{
	Tipo_Data *pData;
	pData=(Tipo_Data *)malloc(sizeof(Tipo_Data));
	pData->data=NULL;
	pData->nLenData=0;
	return pData;
}

Tipo_Data *NewDataLen(char szData[],int nLen)
{
	Tipo_Data *pData;
	pData=(Tipo_Data *)malloc(sizeof(Tipo_Data));
	if (!pData) return NULL;
	pData->data=(char *)malloc(nLen+1);
	if (!pData->data) return NULL;
	memcpy(pData->data,szData,nLen);
	pData->data[nLen]=0;
	pData->nLenData = nLen;
	return pData;
}
Tipo_Data *NewData(char szData[])
{
	return NewDataLen(szData,strlen(szData));
}

/*
Tipo_Data *NewData(char szData[])
{
	Tipo_Data *pData;
	pData=(Tipo_Data *)malloc(sizeof(Tipo_Data));
	if (!pData) return NULL;
	pData->data=(char *)malloc(strlen(szData)+1);
	if (!pData->data) return NULL;
	memcpy(pData->data,szData,strlen(szData));
	pData->data[strlen(szData)]=0;
	pData->nLenData = strlen(szData);
	return pData;
}
*/
Tipo_Data *NewString(Tipo_Data *pData,char szData[])
{
	if (!pData) return NULL;
	pData->data=(char *)malloc(strlen(szData)+1);
	if (!pData->data) return NULL;
	memcpy(pData->data,szData,strlen(szData));
	pData->data[strlen(szData)]=0;
	pData->nLenData = strlen(szData);
	return pData;
}

Tipo_Data *ReemplazaTags1(Tipo_Data *pData,Tipo_XML *xml,char szPatron[])
{
	long len_file,len_file1,nLenPos;
	long nLenDataAux;
	char *data_file,nLeidos;
	char *dta,*ini,*fin;
	char *dta_ori;
	char szAux[MAX_BUFFER];
	char szValor[MAX_BUFFER];
	Tipo_Data *pDataAux=NULL;

	pDataAux = (Tipo_Data *)malloc(sizeof(Tipo_Data));
	nLenDataAux = pData->nLenData+MAX_BUFFER*3;
	pDataAux->data = (char *)malloc(nLenDataAux);
	memset(pDataAux->data,0,nLenDataAux);
	pDataAux->nLenData=0;
	nLenPos=0;
	
	ini=pData->data;
	len_file1=pData->nLenData;

	while(dta=(char *)strstr(ini,szPatron))
	{
		//Envia la parte anterior
		//printf("nLePos = %i dta=%s\n\r",nLenPos,dta);
		memcpy(&pDataAux->data[nLenPos],ini,dta-ini);
		nLenPos+=dta-ini;
		dta_ori = dta;
		dta+=strlen(szPatron);
		fin=(char *)strstr(dta,szPatron);
		if (fin)
		{
			memcpy(szAux,dta,fin-dta);
			szAux[fin-dta]=0;
			len_file1-=(fin-dta)+(2*strlen(szPatron));
			//printf("CAMPO %s%s%s\n\r",szPatron,szAux,szPatron);
			if (GetStrXML(xml,szAux,szValor,sizeof(szValor)))
			{
				//printf("REMPLAZA @@%s@@ por %s\n\r",szAux,szValor);
				//printf("nLenPos=%i nLenPos+strlen(szValor)=%i nLenDataAux=%i\n\r",nLenPos,nLenPos+strlen(szValor),nLenDataAux);
				if (nLenPos+strlen(szValor)>=nLenDataAux)
				{
					printf("Llega a MAXIMO\n\r");
					WriteLog(0,"Llega A MAXIMO");
				}
				else memcpy(&pDataAux->data[nLenPos],szValor,strlen(szValor));
				//WriteLog(0,"Paso2");
				//WriteLog(0,szValor);
				nLenPos+=strlen(szValor);
			}
			//Si no encuentra el valor, lo deja en igual..
			else
			{
				//printf("nLenPos=%i nLenPos+strlen(szValor)=%i nLenDataAux=%i\n\r",nLenPos,nLenPos+strlen(szValor),nLenDataAux);
				if (nLenPos+strlen(szValor)>=nLenDataAux)
				{
					printf("Llega a MAXIMO\n\r");
					WriteLog(0,"Llega A MAXIMO");
				}
				sprintf(szValor,"%s%s%s",szPatron,szAux,szPatron);
				memcpy(&pDataAux->data[nLenPos],szValor,strlen(szValor));
				nLenPos+=strlen(szValor);
				//printf("Deja igual valor %s\n\r",szValor);
			}
			ini=fin+strlen(szPatron);
		}
		else
		{
			printf("Patron no encontrado\n\r"); 
			sprintf(szValor,"%s",szPatron);
			memcpy(&pDataAux->data[nLenPos],szValor,strlen(szValor));
			nLenPos+=strlen(szValor);
			ini=dta_ori+strlen(szPatron);
		}
	}
	//WriteLog(0,"Paso5");
	memcpy(&pDataAux->data[nLenPos],ini,strlen(ini));
	nLenPos+=strlen(ini);
	pDataAux->nLenData = nLenPos;
	
	pData=LiberaData(pData);
	return pDataAux;
}

Tipo_Data *LiberaData(Tipo_Data *pData)
{
	if (pData)
	{
		if (pData->data) free(pData->data);
		pData->data=NULL;
		free(pData);
		pData=NULL;
	}
	return NULL;
}

Tipo_Data *BorraTags(Tipo_Data *pData,char szPatron[])
{
	long len_file,len_file1,nLenPos;
	long nLenDataAux;
	char *data_file,nLeidos;
	char *dta,*ini,*fin;
	char szAux[MAX_BUFFER];
	Tipo_Data *pDataAux;

	pDataAux = (Tipo_Data *)malloc(sizeof(Tipo_Data));
	nLenDataAux = pData->nLenData+4096;
	pDataAux->data = (char *)malloc(nLenDataAux);
	memset(pDataAux->data,0,nLenDataAux);
	pDataAux->nLenData=0;
	nLenPos=0;
	
	ini=pData->data;
	len_file1=pData->nLenData;

	while(dta=(char *)strstr(ini,szPatron))
	{
		//Envia la parte anterior
		memcpy(&pDataAux->data[nLenPos],ini,dta-ini);
		nLenPos+=dta-ini;
		dta+=strlen(szPatron);
		fin=(char *)strstr(dta,szPatron);
		if (fin)
		{
			char szValor[500];
			memcpy(szAux,dta,fin-dta);
			szAux[fin-dta]=0;
			len_file1-=(fin-dta)+(2*strlen(szPatron));
			ini=fin+strlen(szPatron);
		}
		else
		{
			printf("Patron no encontrado\n\r"); 
			sprintf(szAux,"%s",szPatron);
			memcpy(&pDataAux->data[nLenPos],szAux,strlen(szAux));
			nLenPos+=strlen(szAux);
			ini=dta+strlen(szPatron);
		}
	}
	memcpy(&pDataAux->data[nLenPos],ini,strlen(ini));
	nLenPos+=strlen(ini);
	pDataAux->nLenData = nLenPos;
	
	pData=LiberaData(pData);
	return pDataAux;
}

Tipo_Data *ReemplazaComillasTags(Tipo_Data *pData,Tipo_XML *xml,char szPatron[])
{
	long len_file,len_file1,nLenPos;
	long nLenDataAux;
	char *data_file,nLeidos;
	char *dta,*ini,*fin;
	char szAux[MAX_BUFFER];
	char szValor[MAX_BUFFER];
	Tipo_Data *pDataAux;

	pDataAux = (Tipo_Data *)malloc(sizeof(Tipo_Data));
	nLenDataAux = pData->nLenData+4096;
	pDataAux->data = (char *)malloc(nLenDataAux);
	memset(pDataAux->data,0,nLenDataAux);
	pDataAux->nLenData=0;
	nLenPos=0;
	
	ini=pData->data;
	len_file1=pData->nLenData;

	while(dta=(char *)strstr(ini,szPatron))
	{
		//Envia la parte anterior
		//printf("nLePos = %i dta=%s\n\r",nLenPos,dta);
		memcpy(&pDataAux->data[nLenPos],ini,dta-ini);
		nLenPos+=dta-ini;
		dta+=strlen(szPatron);
		fin=(char *)strstr(dta,szPatron);
		if (fin)
		{
			memcpy(szAux,dta,fin-dta);
			szAux[fin-dta]=0;
			len_file1-=(fin-dta)+(2*strlen(szPatron));
			//printf("CAMPO %s%s%s\n\r",szPatron,szAux,szPatron);
			if (GetStrXML(xml,szAux,szValor,sizeof(szValor)))
			{
				//printf("REMPLAZA @@%s@@ por %s\n\r",szAux,szValor);
				memcpy(&pDataAux->data[nLenPos],"'",1);
				nLenPos++;
				memcpy(&pDataAux->data[nLenPos],szValor,strlen(szValor));
				nLenPos+=strlen(szValor);
				memcpy(&pDataAux->data[nLenPos],"'",1);
				nLenPos++;
			}
			//Si no encuentra el valor, lo deja en igual..
			else
			{
				//printf("Deja igual valor\n\r");
				sprintf(szValor,"%s%s%s",szPatron,szAux,szPatron);
				memcpy(&pDataAux->data[nLenPos],szValor,strlen(szValor));
				nLenPos+=strlen(szValor);
			}
			ini=fin+strlen(szPatron);
		}
		else
		{
			printf("Patron no encontrado\n\r"); 
			sprintf(szValor,"%s",szPatron);
			memcpy(&pDataAux->data[nLenPos],szValor,strlen(szValor));
			nLenPos+=strlen(szValor);
			ini=dta+strlen(szPatron);
		}
	}
	memcpy(&pDataAux->data[nLenPos],ini,strlen(ini));
	nLenPos+=strlen(ini);
	pDataAux->nLenData = nLenPos;
	
	pData=LiberaData(pData);
	return pDataAux;
}

int ReemplazaTagsStr(Tipo_XML *xml,char szDatain[],char szData[])
{
	Tipo_Data *pData;
        pData=NewData(szDatain);
        //pData=ReemplazaComillasTags(pData,xml,"##");
	//para hacer recursion
	pData=ReemplazaTags(pData,xml,"**");
	pData=ReemplazaTags(pData,xml,"$$");
	pData=BorraTags1(pData,"$$");
	pData=BorraTags1(pData,"##");
	//pData=BorraTags(pData,"**");
	memcpy(szData,pData->data,pData->nLenData);
        szData[pData->nLenData]=0;
	pData=LiberaData(pData);
	return 1;
}

Tipo_Data *ReemplazaTagsStr1(Tipo_XML *xml,char szDatain[])
{
	Tipo_Data *pData;
        pData=NewData(szDatain);
        //pData=ReemplazaComillasTags(pData,xml,"##");
	//para hacer recursion
	pData=ReemplazaTags(pData,xml,"**");
	pData=ReemplazaTags(pData,xml,"$$");
	if (global.nNivelTags>1) 
	{
		pData=ReemplazaTags(pData,xml,"$$");
	}
	pData=BorraTags1(pData,"$$");
	//pData=BorraTags1(pData,"##");
	return pData;
}

Tipo_Data *ReemplazaTags(Tipo_Data *pData,Tipo_XML *xml,char szPatron[])
{
	long len_file,nLenPos;
	long nLenDataAux;
	char *data_file,nLeidos;
	char *dta,*ini,*fin;
	char *dta_ori;
	char szAux[MAX_LEN_CAMPO+10];
	char szValor[MAX_LEN_CAMPO+256];
	int len_patron;
	Tipo_XML *pXml;
	Tipo_Data *pDataAux;
	int id;
	id=0;
	pDataAux = (Tipo_Data *)malloc(sizeof(Tipo_Data));
        pDataAux->data = NULL;
	pDataAux->nLenData=0;	
	
	ini=pData->data;
	len_patron=strlen(szPatron);

	while(dta=(char *)strstr(ini,szPatron))
	{
		//Envia la parte anterior
		//printf("nLePos = %i dta=%s\n\r",nLenPos,dta);
		pDataAux=InsertaDataLen(ini,dta-ini,pDataAux);
		dta_ori = dta;
		dta+=len_patron;
		fin=(char *)strstr(dta,szPatron);
		//Si encuentra fin, verifica que el campo sea menor a MAX_LEN_CAMPO, sino no es campo
		if ((fin) && (fin-dta<MAX_LEN_CAMPO))
		{
			memcpy(szAux,dta,fin-dta);
			szAux[fin-dta]=0;
			
			if (memcmp(szAux,"__JSONCOMPLETO__",16)==0)
			{
				pDataAux=SerializaJSON(xml,pDataAux);
			}
			//printf("CAMPO %s%s%s\n\r",szPatron,szAux,szPatron);
                        //Si el campo es $$__XMLCOMPLETO__$$ inserta el XML completo
                        else if (memcmp(szAux,"__XMLCOMPLETO__",15)==0)
                        {
                                Tipo_XML *xml2=NULL;
				Tipo_XML *xml_aux=NULL;
                                char szTmp[200];

                                xml2=xml;
				while (xml2!=NULL)
				{
				   //Guarda el nivel siguiente para el proximo ciclo
				   xml_aux=xml2->pNextNivel;
                                   while(xml2!=NULL)
                                   {
					//WriteLog(0,xml2->szCampo);
                                        //pDataAux=InsertaDataLen(xml2->szCampo,strlen(xml2->szCampo),pDataAux);
                                        pDataAux=InsertaDataLen(xml2->szCampo,xml2->nLenCampo,pDataAux);
                                        //sprintf(szTmp,"[%i]=",strlen(xml2->pData));
                                        sprintf(szTmp,"[%i]=",xml2->nLenData);
                                        pDataAux=InsertaDataLen(szTmp,strlen(szTmp),pDataAux);
                                        //Si tiene '' hay que cambiarlas por <C>
                                        if (strstr(xml2->pData,"'"))
                                        {
                                                Tipo_Data *pData2;
                                                int i,j;
                                                char ch;
						int len1;
                                                //WriteLog(id,"Tiene Comillas");
                                                j=0;
                                                pData2 = (Tipo_Data *)malloc(sizeof(Tipo_Data));
                                                pData2->data = (char *)malloc(strlen(xml2->pData)+1024);
                                                memset(pData2->data,0,strlen(xml2->pData)+1024);
                                                sprintf(pData2->data,"");
                                                pData2->nLenData=0;
						//len1=strlen(xml2->pData);
						len1=xml2->nLenData;
                                                for (i=0;i<len1;i++)
                                                {
                                                        ch=xml2->pData[i];
                                                        //sprintf(szTmp,"Caracter %c %i",ch,ch);
                                                        //WriteLog(id,szTmp);
                                                        if (ch==39) 
							{
								pData2->data[j]='<'; j++;
								pData2->data[j]='C'; j++;
								pData2->data[j]='>'; j++;
								// strcat(pData2->data,"<C>"); j+=3;
							}
                                                        else {pData2->data[j]=xml2->pData[i]; j++;}
                                                }
						//WriteLog(0,"Fin Campo Comillas");
                                                pData2->data[j]=0;
                                                pData2->nLenData=strlen(pData2->data);
                                                //pDataAux=InsertaDataLen(pData2->data,strlen(pData2->data),pDataAux);
                                                pDataAux=InsertaDataLen(pData2->data,pData2->nLenData,pDataAux);
                        	                pData2=LiberaData(pData2);
                                        }
                                        else
                                        {
                                                //pDataAux=InsertaDataLen(xml2->pData,strlen(xml2->pData),pDataAux);
                                                pDataAux=InsertaDataLen(xml2->pData,xml2->nLenData,pDataAux);
                                        }
                                        sprintf(szTmp,"###");
                                        pDataAux=InsertaDataLen(szTmp,strlen(szTmp),pDataAux);
                                        xml2=xml2->pNext;
                                   } //Fin while xl2=NULL
				   xml2=xml_aux;
				} //while (xml2!=NULL);
                        }
                        else
                        {
				//WriteLog(0,szAux);
				//printf("CAMPO %s%s%s\n\r",szPatron,szAux,szPatron);
				pXml=GetStrXMLData(xml,szAux);
				if (pXml)
				{
					//pDataAux=InsertaDataLen(pXml->pData,strlen(pXml->pData),pDataAux);
					pDataAux=InsertaDataLen(pXml->pData,pXml->nLenData,pDataAux);
					pXml=NULL;
				}
				//Si no encuentra el valor, lo deja en igual..
				else
				{	
					sprintf(szValor,"%s%s%s",szPatron,szAux,szPatron);
					pDataAux=InsertaDataLen(szValor,strlen(szValor),pDataAux);
				}
			}
			ini=fin+len_patron;
		}
		else
		{
			printf("Patron no encontrado\n\r"); 
			//WriteLog(0,"Patron no encontrado");
			sprintf(szValor,"%s",szPatron);
			pDataAux=InsertaDataLen(szValor,strlen(szValor),pDataAux);
			ini=dta_ori+len_patron;
		}
	}
	pDataAux=InsertaDataLen(ini,strlen(ini),pDataAux);
	pData=LiberaData(pData);
	return pDataAux;
}

/*
Tipo_Data *ReemplazaTags(Tipo_Data *pData,Tipo_XML *xml,char szPatron[])
{
	long len_file,nLenPos;
	long nLenDataAux;
	char *data_file,nLeidos;
	char *dta,*ini,*fin;
	char *dta_ori;
	char szAux[MAX_CAMPO];
	char szValor[MAX_BUFFER];
	Tipo_XML *pXml;
	Tipo_Data *pDataAux;
	int id;
	id=0;
	pDataAux = (Tipo_Data *)malloc(sizeof(Tipo_Data));
        pDataAux->data = NULL;
	pDataAux->nLenData=0;	
	
	ini=pData->data;

	WriteLog(0,"ReemplazaTags");
	while(dta=(char *)strstr(ini,szPatron))
	{
		//Envia la parte anterior
		//printf("nLePos = %i dta=%s\n\r",nLenPos,dta);
		WriteLog(0,"ReemplazaTags");
		pDataAux=InsertaDataLen(ini,dta-ini,pDataAux);
		dta_ori = dta;
		dta+=strlen(szPatron);
		fin=(char *)strstr(dta,szPatron);
		if (fin)
		{
			memcpy(szAux,dta,fin-dta);
			szAux[fin-dta]=0;
			
			//printf("CAMPO %s%s%s\n\r",szPatron,szAux,szPatron);
                        //Si el campo es $$__XMLCOMPLETO__$$ inserta el XML completo
                        if (memcmp(szAux,"__XMLCOMPLETO__",15)==0)
                        {
                                Tipo_XML *xml2=NULL;
				Tipo_XML *xml_aux=NULL;
                                char szTmp[200];

                                xml2=xml;
				while (xml2!=NULL)
				{
				   //Guarda el nivel siguiente para el proximo ciclo
				   xml_aux=xml2->pNextNivel;
                                   while(xml2!=NULL)
                                   {
                                        pDataAux=InsertaDataLen(xml2->szCampo,strlen(xml2->szCampo),pDataAux);
                                        sprintf(szTmp,"[%i]=",strlen(xml2->pData));
                                        pDataAux=InsertaDataLen(szTmp,strlen(szTmp),pDataAux);
                                        //Si tiene '' hay que cambiarlas por <C>
                                        if (strstr(xml2->pData,"'"))
                                        {
                                                Tipo_Data *pData2;
                                                int i,j;
                                                char ch;
                                                //WriteLog(id,"Tiene Comillas");
                                                j=0;
                                                pData2 = (Tipo_Data *)malloc(sizeof(Tipo_Data));
                                                pData2->data = (char *)malloc(strlen(xml2->pData)+1024);
                                                memset(pData2->data,0,strlen(xml2->pData)+1024);
                                                sprintf(pData2->data,"");
                                                pData2->nLenData=0;

                                                for (i=0;i<strlen(xml2->pData);i++)
                                                {
                                                        ch=xml2->pData[i];
                                                        //sprintf(szTmp,"Caracter %c %i",ch,ch);
                                                        //WriteLog(id,szTmp);
                                                        if (ch==39) {strcat(pData2->data,"<C>"); j+=3;}
                                                        else {pData2->data[j]=xml2->pData[i]; j++;}
                                                }
                                                pData2->data[j]=0;
                                                pData2->nLenData=strlen(pData2->data);
                                                pDataAux=InsertaDataLen(pData2->data,strlen(pData2->data),pDataAux);
                        	                pData2=LiberaData(pData2);
                                        }
                                        else
                                        {
                                                pDataAux=InsertaDataLen(xml2->pData,strlen(xml2->pData),pDataAux);
                                        }
                                        sprintf(szTmp,"###");
                                        pDataAux=InsertaDataLen(szTmp,strlen(szTmp),pDataAux);
                                        xml2=xml2->pNext;
                                   } //Fin while xl2=NULL
				   xml2=xml_aux;
				} //while (xml2!=NULL);
                        }
                        else
                        {
				//WriteLog(0,szAux);
				//printf("CAMPO %s%s%s\n\r",szPatron,szAux,szPatron);
				pXml=GetStrXMLData(xml,szAux);
				if (pXml)
				{
					pDataAux=InsertaDataLen(pXml->pData,strlen(pXml->pData),pDataAux);
					pXml=NULL;
				}
				//Si no encuentra el valor, lo deja en igual..
				else
				{	
					sprintf(szValor,"%s%s%s",szPatron,szAux,szPatron);
					pDataAux=InsertaDataLen(szValor,strlen(szValor),pDataAux);
				}
			}
			ini=fin+strlen(szPatron);
		}
		else
		{
			printf("Patron no encontrado\n\r"); 
			sprintf(szValor,"%s",szPatron);
			pDataAux=InsertaDataLen(szValor,strlen(szValor),pDataAux);
			ini=dta_ori+strlen(szPatron);
		}
	}
	pDataAux=InsertaDataLen(ini,strlen(ini),pDataAux);
	pData=LiberaData(pData);
	return pDataAux;
}
*/
Tipo_Data *BorraTags1(Tipo_Data *pData,char szPatron[])
{
	long len_file,nLenPos;
	long nLenDataAux;
	char *data_file,nLeidos;
	char *dta,*ini,*fin;
	char *dta_ori;
	char szAux[MAX_BUFFER];
	char szValor[MAX_BUFFER];
	Tipo_Data *pDataAux;
	int id;
	id=0;
	pDataAux = (Tipo_Data *)malloc(sizeof(Tipo_Data));
        pDataAux->data = NULL;
	pDataAux->nLenData=0;	
	ini=pData->data;

	while(dta=(char *)strstr(ini,szPatron))
	{
		//Envia la parte anterior
		//printf("nLePos = %i dta=%s\n\r",nLenPos,dta);
		pDataAux=InsertaDataLen(ini,dta-ini,pDataAux);
		dta_ori = dta;
		dta+=strlen(szPatron);
		fin=(char *)strstr(dta,szPatron);
		if (fin)
		{
			memcpy(szAux,dta,fin-dta);
			szAux[fin-dta]=0;
			//WriteLog(0,szAux);
			ini=fin+strlen(szPatron);
		}
		else
		{
			printf("Patron no encontrado\n\r"); 
			sprintf(szValor,"%s",szPatron);
			pDataAux=InsertaDataLen(szValor,strlen(szValor),pDataAux);
			ini=dta_ori+strlen(szPatron);
		}
	}
	pDataAux=InsertaDataLen(ini,strlen(ini),pDataAux);
	pData=LiberaData(pData);
	return pDataAux;
}
