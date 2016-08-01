#include <xml.h>
#include <tipos.h>
#include <pthread.h>
#include <ebcdic.h>


Tipo_Data *AplicaFuncionesVar(int id,char szAux[],Tipo_Formatos *pFor,int nLen);
int AplicaFunciones(int id,Tipo_Formatos *p,unsigned char szAux[],int nLenOri);
int AplicaFunciones1(int id,Tipo_Formatos *pFor,unsigned char szAux[],int nLenOriginal);
int IdentaData(int id,char szAux[],char szAux1[],Tipo_Formatos *pFor);
void mc_substring(char strOrig[], int ini, int fin, char strDest[]);
				
int AplicaOperacionMath(int nLen,char szPar[])
{
        switch(szPar[0])
	{
		case '+': return (nLen+atoi(&szPar[1]));
		case '-': return (nLen-atoi(&szPar[1]));
		case '*': return (nLen*atoi(&szPar[1]));
		case '/': 
			  if (atoi(&szPar[1])>0) return nLen/atoi(&szPar[1]);
			  else return 0;
		default: return nLen;
	}
}

Tipo_Lista_Formatos *AgregaListaFormato(Tipo_Formatos *pForm,int nFormato)
{
    Tipo_Lista_Formatos *pLFor=NULL;
    Tipo_Lista_Formatos *pLFormAux=global.pGListaFormatos;

    pthread_mutex_lock(&global.mutex_formatos);

    pLFor = (Tipo_Lista_Formatos *)malloc((size_t)sizeof(Tipo_Lista_Formatos));
    pLFor->nFormato=nFormato;
    pLFor->pFormato=pForm;
    pLFor->pNext=NULL;

    if (global.pGListaFormatos==NULL)
    {
	    global.pGListaFormatos=pLFor;
            pthread_mutex_unlock(&global.mutex_formatos);
	    return global.pGListaFormatos;
    }

    //Busca el final de la lista..
    while(pLFormAux->pNext!=NULL) 
    {
	    //si ya fue agregado sale
	    if (pLFormAux->nFormato==nFormato) goto fin;
	    pLFormAux = pLFormAux->pNext;
    }

    //Asigna el ultimo, registro
    pLFormAux->pNext = pLFor;
fin:
    pthread_mutex_unlock(&global.mutex_formatos);

    return pLFormAux;
}



int LargoFormato(Tipo_Formatos *p)
{
	int i=0;
	while(p!=NULL) 
	{
		i+=p->nLargo;
		p=p->pNext;
	}
	return i;
}

Tipo_Formatos *BuscaFormato(int nFormato)
{
    	Tipo_Lista_Formatos *pLFormAux=global.pGListaFormatos;

    	pthread_mutex_lock(&global.mutex_formatos);
	while(pLFormAux!=NULL)
	{
		if (pLFormAux->nFormato==nFormato)
		{
    			pthread_mutex_unlock(&global.mutex_formatos);
			return pLFormAux->pFormato;
		}
		pLFormAux=pLFormAux->pNext;
	}
    	pthread_mutex_unlock(&global.mutex_formatos);
	return NULL;
}

Tipo_Formatos *LeeFormato(int id,int nFormato)
{
	Tipo_Formatos *pForm;
	char szAux[100];
	if (nFormato==0) return NULL;
	//sprintf(szAux,"Puntero %x",global.pGListaFormatos);
	//WriteLog(id,szAux);
	if (global.pGListaFormatos==NULL)
	{
		//sprintf(szAux,"Lee Formato Base 1 %i",nFormato);
		//WriteLog(id,szAux);
		pForm=LeeFormatoBase(id,nFormato);
	        AgregaListaFormato(pForm,nFormato);
		return pForm;
	}
	else 
	{
		//sprintf(szAux,"Busca Formato Base 1 %i",nFormato);
		//WriteLog(id,szAux);
		pForm=BuscaFormato(nFormato);
		if (pForm==NULL) 
		{
			//sprintf(szAux,"Busca Formato Base 2 %i",nFormato);
			//WriteLog(id,szAux);
			pForm=LeeFormatoBase(id,nFormato);
	        	AgregaListaFormato(pForm,nFormato);
			return pForm;
		}
		//sprintf(szAux,"Busca Formato Base 3 %i",nFormato);
		//WriteLog(id,szAux);
		return pForm;
	}
}




Tipo_Formatos *LeeFormatoBase(int id,int nFormato)
{
      char szAux[200];
      char szSql[512];
      int nLinea=0,i;
      char szData[512];
      char szTmp[50];
      int nTotal=0,sts;
      Tipo_XML *xml1=NULL;
      Tipo_Formatos *pFormato=NULL,*pFor=NULL;
      Tipo_Formatos *pFormAux;

      sprintf(szSql,"select * from formatos where formato=%i order by secuencia",nFormato);
      xml1=GetRecords(id,szSql,&nTotal,xml1,&sts);
      //ImprimeXML(xml1);
      printf("TOTAL = %i\n\r",nTotal);
      for(i=0;i<nTotal;i++)
      {
	    pFor = (Tipo_Formatos *)malloc(sizeof(Tipo_Formatos));
            GetNivelStrXML(xml1,"CAMPO",pFor->szCampo,sizeof(pFor->szCampo),i);
            GetNivelStrXML(xml1,"TIPO_CAMPO",pFor->szTipoCampo,sizeof(pFor->szTipoCampo),i);
            GetNivelIntXML(xml1,"CARACTER",&pFor->nCaracter,i);
            GetNivelIntXML(xml1,"LARGO",&pFor->nLargo,i);
            GetNivelIntXML(xml1,"SECUENCIA",&pFor->nSecuencia,i);
            GetNivelStrXML(xml1,"IDENTACION",pFor->szIdent,sizeof(pFor->szIdent),i);
            GetNivelStrXML(xml1,"CARACTER_LLENADO",szAux,sizeof(szAux),i);
            GetNivelStrXML(xml1,"TEXTO",pFor->szTexto,sizeof(pFor->szTexto),i);
            GetNivelStrXML(xml1,"TIPO",pFor->szTipo,sizeof(pFor->szTipo),i);
            GetNivelStrXML(xml1,"FUNCION",pFor->szFuncion,sizeof(pFor->szFuncion),i);
	    pFor->nFormato=nFormato;
            pFor->chLlenado=szAux[0];
	    pFor->pNext=NULL;
	    if (pFormato==NULL)
	    {
		    pFormato = pFor;
		    pFormAux = pFormato;
	    }
	    else
	    {
		    pFormAux->pNext =pFor;
		    pFormAux = pFor;
	    }
      } 
      xml1=CierraXML(xml1);
      return pFormato;
}

void CierraListaFormatos()
{
	Tipo_Lista_Formatos *pAux=global.pGListaFormatos,*pAux1;
	if (pAux==NULL) return;
    	pthread_mutex_lock(&global.mutex_formatos);
	while(pAux!=NULL) 
	{
		pAux1=pAux->pNext;
		free(pAux);
		pAux=pAux1;
	}
	global.pGListaFormatos=NULL;
    	pthread_mutex_unlock(&global.mutex_formatos);
	WriteLog(0,"Limpia Lista Formatos");
}


int IdentaData(int id,char szAux[],char szAux1[],Tipo_Formatos *pFor)
{
	int nTmp,nLenCpy;
	int nLargo=pFor->nLargo;
	//char szXX[1024];
	//sprintf(szXX,"Formato %s Len=%i Input=%s",pFor->szCampo,nLargo,szAux1);
	//WriteLog(0,szXX);
	//printf("Identa Data =%s Largo=%i\n",szAux1,pFor->nLargo);
	//LCM AQUI SACA EL LARGO DE LA DATA DE SALIDA. ASI DEBERIA DE SER.
	if (pFor->nLargo==(-1)) nLargo=strlen(szAux1);

	if (pFor->chLlenado==0) memset(szAux,' ',nLargo);
	else memset(szAux,pFor->chLlenado,nLargo);

        if (memcmp(pFor->szIdent,"DER",3)==0)
         {
              if (strlen(szAux1)<nLargo)
              {
                   nTmp=strlen(szAux1);
                   memcpy(&szAux[nLargo-nTmp],szAux1,nTmp);
              }
              else
              {
                   nTmp=nLargo;
                   memcpy(szAux,&szAux1[strlen(szAux1)-nTmp],nTmp);
              }
	      //szAux[nTmp]=0;
	      //nLenCpy=AplicaFunciones(id,pFor,szAux,nTmp);
	      nLenCpy=AplicaFunciones(id,pFor,szAux,nLargo);
         }
	 else //if (memcmp(pFor->szIdent,"IZQ",3)==0)
         {
              if (strlen(szAux1)<nLargo) nTmp=strlen(szAux1);
              else nTmp=nLargo;
	      
              memcpy(szAux,szAux1,nTmp);
	      //szAux[nTmp]=0;
	      //printf("1nTmp=%i\n\r",nTmp);
	      //Modificacion En Formato de Salida 18-Ago-2006
	      //Se cambia nTmp que era el largo del campo de entrada por nLargo que era el largo
	      //del formato de salida ahora en los formatos de entrada la salida cambia ya veremos
	      //nLenCpy=AplicaFunciones(id,pFor,szAux,nTmp);
	      nLenCpy=AplicaFunciones(id,pFor,szAux,nLargo);
	      //sprintf(szXX,"FS: IdentaData={%s} LArgo1=%i Largo2=%i (%s)",szAux,nLargo,nLenCpy,szAux1);
	      //WriteLog(0,szXX);
	      //printf("2nLenCpy=%i\n\r",nTmp);
         }
	 szAux[nLenCpy]=0;
	 //sprintf(szXX,"Salida IdentaData=%s LArgo=%i",szAux,nLenCpy);
	 //WriteLog(0,szXX);
	 //printf("szAux=%s nLenCpy=%i pFor->nLargo=%i\n\r",szAux,nLenCpy,pFor->nLargo);
	 return nLenCpy;
}

Tipo_Data *AplicaFormatoSalidaVar(int id,Tipo_Data *pData,Tipo_XML *xml1,Tipo_Formatos *pFor,int *nLenLinea)
{
    int nPos;
    char szAux[MAX_BUFFER];
    char szAux1[MAX_BUFFER];

    Tipo_Data *pData2=NULL;
    int nLargoTotalHex=0;
    int nPosLargo=0;
    char szFuncionLargo[100];
    Tipo_Formatos stForLen;
    nPos=0;
    //printf("LINEA Ini=%s\n\r",szLinea);
    do
    {
       int nLenCpy=0,nTmp;
       //szLinea[nPos]=0;
       if (pFor==NULL)
       {
	       *nLenLinea=nPos;
	       if (nLargoTotalHex)
       	       {
		       char szFormato[100];
		       unsigned int l;
		       //Genera la salida
		       sprintf(szFormato,"%%0%ix",stForLen.nLargo*2);
		       printf("FORMATO = %s\n\r",szFormato);
		       memset(szAux,0,sizeof(szAux));
		       memset(szAux1,0,sizeof(szAux1));
		       sprintf(szAux,szFormato,nPos+atoi(stForLen.szFuncion));
		       printf("AUX LEN = %s\n\r",szAux);
		       readhex(szAux,szAux1);
		       printf("AUX1 LEN = %s\n\r",szAux1);
            	       //memcpy(&szLinea[nPosLargo],szAux1,stForLen.nLargo);
		       pData=ConcatenaData(szAux1,pData,stForLen.nLargo);
	       }
	       break;
       }
       memset(szAux,0,sizeof(szAux));
       if (memcmp(pFor->szTipoCampo,"CAMPO",5)==0)
       {
	  Tipo_XML *xml2=NULL;
	  //No aplica funciones y solo copia el campo
	  xml2=GetStrXMLData(xml1,pFor->szCampo);
	  if (xml2!=NULL)
	  {
		//nLenCpy=IdentaData(id,szAux,szAux1,pFor);
          	//memcpy(&szLinea[nPos],szAux,nLenCpy);
		//AplicaFunciones Sobre el buffer
		pData2=NULL;
		pData2=AplicaFuncionesVar(id,xml2->pData,pFor,xml2->nLenData);
		if (pData2)
		{
			pData=ConcatenaData(pData2->data,pData,pData2->nLenData);
          		nPos+=pData2->nLenData;
			pData2=LiberaData(pData2);
		}
		else 
		{
			pData=ConcatenaData(xml2->pData,pData,strlen(xml2->pData));
          		nPos+=strlen(xml2->pData);
		}
	  }
       }
       else if (memcmp(pFor->szTipoCampo,"CARACTER",8)==0)
       {
	  nLenCpy=pFor->nLargo;
          //memset(&szLinea[nPos],pFor->nCaracter,pFor->nLargo);
	  //pData=ConcatenaData(pFor->nCaracter,pData,nLenCpy);
          nPos+=pFor->nLargo;
       }
       else if (memcmp(pFor->szTipoCampo,"TEXTO",5)==0)
       {
	    nLenCpy=IdentaData(id,szAux,pFor->szTexto,pFor);
            //memcpy(&szLinea[nPos],szAux,nLenCpy);
	    pData=ConcatenaData(szAux,pData,nLenCpy);
            nPos+=nLenCpy;
       }
       else if (memcmp(pFor->szTipoCampo,"CAMPO_B80",9)==0)
       {
          if (!GetStrXML(xml1,pFor->szCampo,szAux1,sizeof(szAux1)))
          {
             //printf("Campo no existe en el query...%s\n\r",pFor->szCampo);
	     //sprintf(szAux,"<Campo %s no existe>",pFor->szCampo);
	     nLenCpy=strlen(szAux);
          }
          else 
	  {
		char szTmp[100];
		char szLen[6];
		if (memcmp(pFor->szTipo,"STR_",4)==0)
		{
			//El largo del string de salida viene _
			memcpy(szLen,&pFor->szTipo[4],strlen(&pFor->szTipo[4]));
			szLen[strlen(&pFor->szTipo[4])]=0;
		}
		else szLen[0]=0;
		nLenCpy=atoi(szLen);

		printf("Entra=%s Largo Sale=%i %s\n\r",szAux1,nLenCpy,pFor->szTipo);
		DecToBase80(szAux,szAux1,nLenCpy);
		printf("CAmpo_B80 = %s\n\r",szAux);
          	//memcpy(&szLinea[nPos],szAux,nLenCpy);
	   	pData=ConcatenaData(szAux,pData,nLenCpy);
          	nPos+=nLenCpy;
	  }
       }
       //Campo de tipo largo
       else if (memcmp(pFor->szTipoCampo,"LEN_TOTAL_HEX",13)==0)
       {
	       //Asumo largo 1 y guardo para reservar espacio..
	       //en szFuncion debe venir formato
	       memcpy((char *)&stForLen,pFor,sizeof(stForLen));
	       nPosLargo=nPos;
	       nLenCpy=pFor->nLargo;
               //memcpy(&szLinea[nPos],szAux,nLenCpy);
	       pData=ConcatenaData(szAux,pData,nLenCpy);
               nPos+=nLenCpy;
	       nLargoTotalHex=1;
       }
       //printf("Campo = %s Data Salida=%s %i\n\r",pFor->szCampo,szAux,nLenCpy);
       //sprintf(szAux1,"Campo = %s Data Salida=%s %i",pFor->szCampo,szAux,nLenCpy);
       //WriteLog(id,szAux1);

       pFor=pFor->pNext;
    } while(1);
    return pData;
}

int AplicaFormatoSalida(int id,char szLinea[],Tipo_XML *xml1,Tipo_Formatos *pFor,int *nLenLinea)
{
    int nPos;
    char szAux[MAX_BUFFER];
    char szAux1[MAX_BUFFER];
    int nLargoTotalHex=0;
    int nPosLargo=0;
    char szFuncionLargo[100];
    Tipo_Formatos stForLen;
    nPos=0;
    //printf("LINEA Ini=%s\n\r",szLinea);
    //WriteLog(id,"Formato Salida");
    do
    {
       int nLenCpy=0,nTmp;
       szLinea[nPos]=0;
       if (pFor==NULL)
       {
	       *nLenLinea=nPos;
	       if (nLargoTotalHex)
       	       {
		       char szFormato[100];
		       unsigned int l;
		       //Genera la salida
		       sprintf(szFormato,"%%0%ix",stForLen.nLargo*2);
		       printf("FORMATO = %s\n\r",szFormato);
		       memset(szAux,0,sizeof(szAux));
		       memset(szAux1,0,sizeof(szAux1));
		       sprintf(szAux,szFormato,nPos+atoi(stForLen.szFuncion));
		       printf("AUX LEN = %s\n\r",szAux);
		       readhex(szAux,szAux1);
		       printf("AUX1 LEN = %s\n\r",szAux1);
            	       memcpy(&szLinea[nPosLargo],szAux1,stForLen.nLargo);
	       }
	       break;
       }
       memset(szAux,0,sizeof(szAux));
       if (memcmp(pFor->szTipoCampo,"CAMPO",5)==0)
       {
          if (!GetStrXML(xml1,pFor->szCampo,szAux1,sizeof(szAux1)))
          {
	  	if ((pFor->nLargo>0) || (pFor->nLargo=-1))
		{
		   nLenCpy=IdentaData(id,szAux,szAux1,pFor);
          	   memcpy(&szLinea[nPos],szAux,nLenCpy);
	           printf("LINEA[%s] (%i) =%s\n\r",pFor->szCampo,strlen(szLinea),szLinea);
          	   nPos+=nLenCpy;
		}
          }
          else 
	  {
		nLenCpy=IdentaData(id,szAux,szAux1,pFor);
          	memcpy(&szLinea[nPos],szAux,nLenCpy);
          	nPos+=nLenCpy;
	  }
       }
       else if (memcmp(pFor->szTipoCampo,"CARACTER",8)==0)
       {
	  nLenCpy=pFor->nLargo;
          memset(&szLinea[nPos],pFor->nCaracter,pFor->nLargo);
          nPos+=pFor->nLargo;
       }
       else if (memcmp(pFor->szTipoCampo,"TEXTO",5)==0)
       {
	    nLenCpy=IdentaData(id,szAux,pFor->szTexto,pFor);
            memcpy(&szLinea[nPos],szAux,nLenCpy);
            nPos+=nLenCpy;
       }
       else if (memcmp(pFor->szTipoCampo,"CAMPO_B80",9)==0)
       {
          if (!GetStrXML(xml1,pFor->szCampo,szAux1,sizeof(szAux1)))
          {
             //printf("Campo no existe en el query...%s\n\r",pFor->szCampo);
	     //sprintf(szAux,"<Campo %s no existe>",pFor->szCampo);
	     nLenCpy=strlen(szAux);
          }
          else 
	  {
		char szTmp[100];
		char szLen[6];
		if (memcmp(pFor->szTipo,"STR_",4)==0)
		{
			//El largo del string de salida viene _
			memcpy(szLen,&pFor->szTipo[4],strlen(&pFor->szTipo[4]));
			szLen[strlen(&pFor->szTipo[4])]=0;
		}
		else szLen[0]=0;
		nLenCpy=atoi(szLen);

		printf("Entra=%s Largo Sale=%i %s\n\r",szAux1,nLenCpy,pFor->szTipo);
		DecToBase80(szAux,szAux1,nLenCpy);
		printf("CAmpo_B80 = %s\n\r",szAux);
          	memcpy(&szLinea[nPos],szAux,nLenCpy);
          	nPos+=nLenCpy;
	  }
       }
       //Campo de tipo largo
       else if (memcmp(pFor->szTipoCampo,"LEN_TOTAL_HEX",13)==0)
       {
	       //Asumo largo 1 y guardo para reservar espacio..
	       //en szFuncion debe venir formato
	       memcpy((char *)&stForLen,pFor,sizeof(stForLen));
	       nPosLargo=nPos;
	       nLenCpy=pFor->nLargo;
               memcpy(&szLinea[nPos],szAux,nLenCpy);
               nPos+=nLenCpy;
	       nLargoTotalHex=1;
       }
       //printf("Campo = %s Data Salida=%s %i\n\r",pFor->szCampo,szAux,nLenCpy);
       //sprintf(szAux1,"Campo = %s Data Salida=%s %i",pFor->szCampo,szAux,nLenCpy);
       //WriteLog(id,szAux1);

       pFor=pFor->pNext;
    } while(1);
}


Tipo_XML *LlenaXMlFormato(int id,Tipo_XML *xml3,Tipo_XML *xml,Tipo_Formatos *pFor)
{
	Tipo_XML *xml2=NULL;
	while(pFor!=NULL)
	{
		if (memcmp(pFor->szTipoCampo,"CAMPO",5)==0)
		{
			xml2=GetStrXMLData(xml3,pFor->szCampo);
		        if (xml2!=NULL)
          		{
				xml=InsertaDataXML(xml,pFor->szCampo,xml2->pData);
                	}
		}
        	pFor=pFor->pNext;
	}	
	return xml;
}


int GetParametros3(char szFuncion[],char szPar1[],char szPar2[],char szPar3[])
{
	unsigned int i,j;
	char *ini,*fin;
	int ch;

	sprintf(szPar1,"");
	sprintf(szPar2,"");
	sprintf(szPar3,"");
	printf("Funcion = %s\n\r",szFuncion);

	ini=(char *)strchr(szFuncion,'(');
	if (ini==NULL) goto fin;
	ini++;
		
	//Encontramos el caracter a reemplazar
	fin=(char *)strchr(ini,',');
	if (fin==NULL) 
	{
		fin=(char *)strchr(ini,')');
		if (fin==NULL) goto fin;
		fin++;
		memcpy(szPar1,ini,fin-ini-1); szPar1[fin-ini-1]=0;
		goto fin;
	}
	fin++;
	memcpy(szPar1,ini,fin-ini-1); szPar1[fin-ini-1]=0;


	ini=(char *)strchr(fin,',');
	if (ini==NULL) 
	{
		ini=(char *)strchr(fin,')');
		if (ini==NULL) goto fin;
	}
	memcpy(szPar2,fin,ini-fin); szPar2[ini-fin]=0;
	ini++;
	
	fin=(char *)strchr(ini,',');
	if (fin==NULL) 
	{
		fin=(char *)strchr(ini,')');
		if (fin==NULL) goto fin;
		fin++;
		memcpy(szPar3,ini,fin-ini-1); szPar3[fin-ini-1]=0;
		goto fin;
	}
	fin++;
	memcpy(szPar3,ini,fin-ini-1); szPar3[fin-ini-1]=0;

fin:
	printf("szPar1=%s\n\r",szPar1);
	printf("szPar2=%s\n\r",szPar2);
	printf("szPar3=%s\n\r",szPar3);
	return 1;
}


int GetParametros(char szFuncion[],char szPar1[],char szPar2[])
{
	char szPar3[1024];
	return GetParametros3(szFuncion,szPar1,szPar2,szPar3);
}

Tipo_Data *AplicaFuncionesVar(int id,char szAux[],Tipo_Formatos *pFor,int nLenData)
{
	Tipo_Data *pData=NULL;
	if (strlen(pFor->szFuncion)==0) return NULL;
        else if (memcmp(pFor->szFuncion,"HEX2ASC",7)==0)
        {
                char *szAux1;
                int nLen;
                long l;
		pData = CreaData();
                //nLen=strlen(szAux)/2;
                nLen=nLenData/2;
		pData->data = (char *)malloc(nLen+10);
                readhex(szAux, pData->data);
		pData->data[nLen+1]=0;
		//pData->nLenData = strlen(pData->data);
		pData->nLenData = nLen;
                //WriteLog(0,szAux1);
                //printf("Data Entrante = %s\n\r",szAux);
                //WriteLog(0,szAux);
                return pData;
        }
        else if (memcmp(pFor->szFuncion,"ASC2HEX",7)==0)
        {
                char *szAux1;
                int nLen;
                long l;
		printf("CreaData\n\r");
		pData = CreaData();
                //nLen=strlen(szAux)*2;
                nLen=nLenData*2;
		printf("len\n\r");
		pData->data = (char *)malloc(nLen+10);
		printf("writenhex\n\r");
		writenhex(szAux,pData->data,nLenData);
		pData->nLenData = strlen(pData->data);
                //WriteLog(0,szAux1);
                //printf("Data Entrante = %s\n\r",szAux);
                //WriteLog(0,szAux);
                return pData;
        }
	else
	{
		return NULL;
	}
}

//Reemplazo el buffer
int AplicaFunciones1(int id,Tipo_Formatos *pFor,unsigned char szAux[],int nLenOriginal)
{
#ifdef _RSA_
	if (strlen(pFor->szFuncion)==0) return nLenOriginal;
	else if (memcmp(pFor->szFuncion,"RSA_IN",6)==0)
	{
		char szDirectorio[50];
		char szLlave[20];
		char szAux1[2048];
		int nLen;
		memset(szAux1,0,sizeof(szAux1));
		if(rsa_private_encrypt(szAux1,&nLen,szAux,strlen(szAux)))
	        {
		       WriteLog(id,"Falla RSA_IN");
		       WriteLog(id,szAux1);
		       szAux[0]=0;
		       return 0;
	        }
		memcpy(szAux,szAux1,nLen);
		szAux[nLen]=0;
		return nLen;
	}
	else if (memcmp(pFor->szFuncion,"RSA_OUT",7)==0)
	{
		char szDirectorio[50];
		char szLlave[20];
		char szAux1[2048];
		int nLen;
		if(rsa_private_decrypt(szAux1,&nLen,szAux,strlen(szAux)))
	        {
		       char szTmp[1024];
		       WriteLog(id,"Falla RSA_OUT");
		       sprintf(szTmp,"Largo=%i Buffer=%s",strlen(szAux),szAux);
		       WriteLog(id,szTmp);
		       szAux[0]=0;
		       return 0;
	        }
		memcpy(szAux,szAux1,nLen);
		szAux[nLen]=0;
		WriteLog(id,szAux);
		return nLen;
	}
	else if (memcmp(pFor->szFuncion,"LEN_ETX",7)==0)
#else
	if (memcmp(pFor->szFuncion,"LEN_ETX",7)==0)
#endif 
	{
		int i;
		char szTmp[200];
		for(i=0;i<nLenOriginal;i++) 
		{
			if (szAux[i]==3)
			{
				WriteLog(id,"OK ETX");
				szAux[i]=0;
				break;
			}
		}
		szAux[i]=0;
		return i;
	}
	//printf("Len Aplica %i\n\r",nLenOriginal);
	//Hace que la salida sea del tipo xx
	//Funcion que entrega la fecha con sus distintos formatos..
	
	else if (memcmp(pFor->szFuncion,"DATE",4)==0)
	{
		time_t t1;
		struct tm local;
		char szTmp[240],szPar2[10];
		char szTmp1[20];
		char *ini,*fin;
		int n;
		time(&t1);
		localtime_r(&t1,&local);
		GetParametros(pFor->szFuncion,szTmp,szPar2);
		fin=szTmp;
		ini=(char *)strstr(szTmp,"AAAA");
		if (ini!=NULL)
		{
			sprintf(szTmp1,"%04i",local.tm_year+1900);
			n=ini-fin;
			memcpy(&szTmp[n],szTmp1,4);
		}
		ini=(char *)strstr(szTmp,"AA");
		if (ini!=NULL)
		{
			sprintf(szTmp1,"%02i",local.tm_year-100);
			n=ini-fin;
			memcpy(&szTmp[n],szTmp1,2);
		}
		ini=(char *)strstr(szTmp,"MM");
		if (ini!=NULL)
		{
			sprintf(szTmp1,"%02i",local.tm_mon+1);
			n=ini-fin;
			memcpy(&szTmp[n],szTmp1,2);
		}
		ini=(char *)strstr(szTmp,"DD");
		if (ini!=NULL)
		{
			sprintf(szTmp1,"%02i",local.tm_mday);
			n=ini-fin;
			memcpy(&szTmp[n],szTmp1,2);
		}
		ini=(char *)strstr(szTmp,"HH");
		if (ini!=NULL)
		{
			sprintf(szTmp1,"%02i",local.tm_hour);
			n=ini-fin;
			memcpy(&szTmp[n],szTmp1,2);
		}
		ini=(char *)strstr(szTmp,"MI");
		if (ini!=NULL)
		{
			sprintf(szTmp1,"%02i",local.tm_min);
			n=ini-fin;
			memcpy(&szTmp[n],szTmp1,2);
		}
		ini=(char *)strstr(szTmp,"SS");
		if (ini!=NULL)
		{
			sprintf(szTmp1,"%02i",local.tm_sec);
			n=ini-fin;
			memcpy(&szTmp[n],szTmp1,2);
		}
		memcpy(szAux,szTmp,strlen(szTmp));
		szAux[strlen(szTmp)]=0;
		return strlen(szAux);
	}
	else if (memcmp(pFor->szFuncion,"SALIDA_B81",10)==0)
	{
		char *ini,*fin;
		char szTmp[20];
		char szPar2[20];
		char szAux1[1024];
		int nLen;
		GetParametros(pFor->szFuncion,szTmp,szPar2);
		nLen=atoi(szTmp);
		if (nLen<0) nLen=0;
		printf("nLen %i szAux=%s\n\r",nLen,szAux);

		DecToBase81(szAux1,szAux,nLen);
		memcpy(szAux,szAux1,nLen);
		szAux[nLen]=0;
		printf("CAmpo_B81 Salida = %s\n\r",szAux);
          	return nLen;
	}
	else if (memcmp(pFor->szFuncion,"SALIDA_B80",10)==0)
	{
		char *ini,*fin;
		char szTmp[20];
		char szPar2[20];
		char szAux1[1024];
		int nLen;
		GetParametros(pFor->szFuncion,szTmp,szPar2);
		nLen=atoi(szTmp);
		if (nLen<0) nLen=0;
		printf("nLen %i szAux=%s\n\r",nLen,szAux);

		DecToBase80(szAux1,szAux,nLen);
		memcpy(szAux,szAux1,nLen);
		szAux[nLen]=0;
		printf("CAmpo_B80 Salida = %s\n\r",szAux);
          	return nLen;
	}
	else if (memcmp(pFor->szFuncion,"INPUT_B80",9)==0)
	{
		char szPar1[20];
		char szPar2[20];
		char szAux1[1024];
		char szFor[30];
		unsigned long l;
		int nLen;
		GetParametros(pFor->szFuncion,szPar1,szPar2);
		nLen=atoi(szPar1);
		if (nLen<0) nLen=0;
		printf("nLen %i szAux=%s nLenOri=%i nLenAux=%i\n\r",nLen,szAux,pFor->nLargo,strlen(szAux));
	
		l=Base80ToDec(szAux);
		sprintf(szFor,"%%0%iu",nLen);
		sprintf(szAux,szFor,l);
		printf("Input Base80 Input Form=%s Data = %s\n\r",szFor,szAux);
          	return strlen(szAux);
	}
	else if (memcmp(pFor->szFuncion,"INPUT_B81",9)==0)
	{
		char szPar1[20];
		char szPar2[20];
		char szAux1[1024];
		char szFor[30];
		unsigned long l;
		int nLen;
		GetParametros(pFor->szFuncion,szPar1,szPar2);
		nLen=atoi(szPar1);
		if (nLen<0) nLen=0;
		printf("nLen %i szAux=%s nLenOri=%i nLenAux=%i\n\r",nLen,szAux,pFor->nLargo,strlen(szAux));
	
		l=Base81ToDec(szAux);
		sprintf(szFor,"%%0%iu",nLen);
		sprintf(szAux,szFor,l);
		printf("Input Base81 Input Form=%s Data = %s\n\r",szFor,szAux);
          	return strlen(szAux);
	}
	else if (memcmp(pFor->szFuncion,"ASC2HEX",7)==0)
	{
		char szAux1[MAX_BUFFER];
		int nLen=pFor->nLargo,i;
		char szTmp[20];
		int j_aux=0;
		printf("nLenOri = %i\n\r",nLen);

		memset(szAux1,0,sizeof(szAux1));
		for(i=0;i<nLen;i++) 
		{
			sprintf(szTmp,"%02x",szAux[i]& 0377);
			//strcat(szAux1,szTmp);
			szAux1[j_aux]=szTmp[0]; j_aux++;
			szAux1[j_aux]=szTmp[1]; j_aux++;
		}
		szAux1[j_aux]=0;
		nLen*=2;
		memcpy(szAux,szAux1,nLen);
		szAux[nLen]=0;
		printf("Asc2Hex Salida = %s\n\r",szAux);
          	return nLen;
	}
	else if (memcmp(pFor->szFuncion,"HEX2INT",7)==0)
	{
		char szPar1[20],szPar2[20];
		char szAux1[1024];
		int nLen;
		long l;

		GetParametros(pFor->szFuncion,szPar1,szPar2);
		nLen=atoi(szPar1);
		if (nLen<0) nLen=0;
		//printf("nLen %i szAux=%s\n\r",nLen,szAux);
		l=hex2long(szAux);
		sprintf(szAux,szPar1,l);
		nLen=strlen(szAux);
		printf("Hex2Int Salida = %s\n\r",szAux);
          	return nLen;
	}
	else if (memcmp(pFor->szFuncion,"HEX2ASC",7)==0)
	{
		char *szAux1;
		int nLen;
		long l;
		szAux1=(char *)malloc(strlen(szAux)*2+1);
		//WriteLog(0,szAux1);
		//printf("Data Entrante = %s\n\r",szAux);
		readhex(szAux,szAux1);
		//WriteLog(0,szAux);
		nLen=strlen(szAux)/2;
		memcpy(szAux,szAux1,nLen);
		szAux[nLen]=0;
		free(szAux1);
		//printf("Hex2Asc Salida(len %i) = %s\n\r",nLen,szAux);
		//WriteHex(0,szAux,nLen);
          	return nLen;
	}
	else if (memcmp(pFor->szFuncion,"ASC2EBCDIC",10)==0)
	{
		char szTmp[20];
		char szAux1[1024];
		int nLen,i;
		nLen=strlen(szAux);
		for(i=0;i<nLen;i++) szAux1[i]=a2ebcdic(szAux[i]); 

		memcpy(szAux,szAux1,nLen);
		szAux[nLen]=0;
		WriteLog(id,"Campo EBCDIC");
		WriteHex(id,szAux,nLen);
		printf("CAmpo ASC2EBCDIC nLen=%i\n\r",nLen);
          	return nLen;

	}
	else if (memcmp(pFor->szFuncion,"EBCDIC2ASC",10)==0)
	{
		char szTmp[20];
		char szAux1[1024];
		//int nLen=strlen(szAux);
		//FAY 2012-04-10 EL largo del EBCDIC puede venir con un caracter 0x00
		int nLen=nLenOriginal;
		int i;
		
		printf("Data EBCDIC=%s LARGO=%i\n\r",szAux,nLen);
		for(i=0;i<nLen;i++)
          	{
                        //Si vienen caracteres raros los cambio por espacio
                        if ((szAux[i]==39) || (szAux[i]<30))
                        {
                                szAux1[i]=' ';
                        }
                        else
                        {
                                szAux1[i]=ebcdic2a(szAux[i]);
                        }
		}


		memcpy(szAux,szAux1,nLen);
		szAux[nLen]=0;
		printf("CAmpo EBCDIC2ASC %s nLen=%i\n\r",szAux,nLen);
          	return nLen;

	}
	else if (memcmp(pFor->szFuncion,"SALIDA_HEX",10)==0)
	{
		char szTmp[20];
		char szAux1[MAX_BUFFER];
		int nLen;
		printf("Len Original=%i\n\r",nLenOriginal);
		writenhex(szAux,szAux1,nLenOriginal);
		nLen=strlen(szAux1);
		memcpy(szAux,szAux1,nLen);
		szAux[nLen]=0;
		printf("CAmpo_HEX Salida = %s\n\r",szAux);
          	return nLen;
	}

        else if (memcmp(pFor->szFuncion,"SALIDA_FMT_PRESTO",17)==0)
        {
                char szTmp[20];
                char szAux1[MAX_BUFFER];
		char szBM1[MAX_BUFFER];
		char szBM2[MAX_BUFFER];
		char szData[MAX_BUFFER];
		char szAux2[2];

                int nLen;
		int nPosIniConv;
		int nPosFinConv;
		int i;

                printf("Len Original=%i\n\r",nLenOriginal);

		//-- Los 8 primeros bytes son Hexadecimales por definicion...
		mc_substring(szAux,16,31,szBM1);
		writenhex(szAux,szBM1,8);
		nLen=8;
		printf("CAmpo BITMAP 1 %s nLen=%i\n\r",szBM1,strlen(szBM1));
		nPosIniConv = 8;

		//szBM1[32]=0;
		//-- aca se inspecciona valor del primer byte hexadecimal
		
		szAux2[0]=szBM1[0];
		szAux2[1]=szBM1[1];
		szAux2[2]=0;

		if ((strcmp(szAux2,"F2")==0) || (strcmp(szAux2,"f2")==0)) {
			//-- de ser asi viene bitmap secundario....
			//printf("CAmpo EBCDIC2ASC 1.5 %s nLen=%i\n\r",szBM1,nLen);
			mc_substring(szAux,32,46,szBM1);
			writenhex(szAux,szBM1,16);
			nPosIniConv = 16;
			nLen=16;
			printf("CAmpo BITMAP 2 %s nLen=%i\n\r",szBM1,strlen(szBM1));

		}
		 
		szAux1[0]=0;

		for(i=0;i<strlen(szBM1);i++) szAux1[i]=szBM1[i];

		for(i=strlen(szBM1);i<nLenOriginal+nPosIniConv;i++){ 
			szAux1[i]=ebcdic2a(szAux[i-nPosIniConv]);
		}

		nLen=1;
		memcpy(szAux,szAux1,i);
		//memcpy(szAux,szData,i+1);

                szAux[i+1]=0;
		//szData[i+1]=0;
                printf("CAmpo EBCDIC2ASC 3 %s nLen=%i\n\r",szAux,nLen);
		
                return nLen;
        }

	else if (memcmp(pFor->szFuncion,"CURRENT_YEAR_YY",14)==0)
	{
		time_t t1;
		struct tm local;
		time(&t1);
		localtime_r(&t1,&local);
		sprintf(szAux,"%02i",local.tm_year-100);
		return strlen(szAux);
		
	}
	else if (memcmp(pFor->szFuncion,"CURRENT_YEAR",12)==0)
	{
		time_t t1;
		struct tm local;
		time(&t1);
		localtime_r(&t1,&local);
		sprintf(szAux,"%04i",local.tm_year+1900);
		return strlen(szAux);
		
	}
	else if (memcmp(pFor->szFuncion,"XML",3)==0)
	{
		char szBuffer[MAX_BUFFER];
		sprintf(szBuffer,"<%s>%s</%s>",pFor->szCampo,szAux,pFor->szCampo);
		sprintf(szAux,"%s",szBuffer);
		printf("Buffer Reemplazado = %s\n\r",szAux);
		return strlen(szAux);
	}
	else if (memcmp(pFor->szFuncion,"INPUT_WEB",9)==0)
	{
		ConvierteCaracteresWeb(szAux);
		return strlen(szAux);
	}
	else if (memcmp(pFor->szFuncion,"SALIDA_WEB",10)==0)
	{
		unsigned int i,j;
		char szBuffer[MAX_BUFFER];
		char szTmp[20];
		//Reemplazo el buffer
		j=0;
		for(i=0;i<strlen(szAux);i++)
		{
			sprintf(szTmp,"%%%02x",szAux[i]);
			//printf("Data a insertar %s %i\n\r",szTmp,szAux[i]);
			memcpy(&szBuffer[j],szTmp,strlen(szTmp));
			j+=strlen(szTmp);
		}
		printf("Buffer WEB=%s\n\r",szBuffer);
		szBuffer[j]=0;
		sprintf(szAux,"%s",szBuffer);
		printf("Buffer Reemplazado2 %i %i = %s\n\r",i,j,szAux);
		return strlen(szAux);
	}
	//Obtiene un Substring
	else if (memcmp(pFor->szFuncion,"SUBSTRING",9)==0)
	{
		unsigned int i,j;
		unsigned int ch;
		char szBuffer[MAX_BUFFER];
		unsigned int nPosIni,nLenTotal;
		char szPar1[10],szPar2[20];
		GetParametros(pFor->szFuncion,szPar1,szPar2);

		nPosIni=atoi(szPar1);
		nLenTotal=atoi(szPar2);

		if (nPosIni<0) nPosIni=0;
		if (nLenTotal<0) nLenTotal=0;
		if (nPosIni>strlen(szAux)) nPosIni=strlen(szAux);
		if (nLenTotal+nPosIni>strlen(szAux)) nLenTotal=strlen(szAux)-nPosIni;

		//Reemplazo el buffer
		memcpy(szBuffer,&szAux[nPosIni],nLenTotal);
		szBuffer[nLenTotal]=0;
		sprintf(szAux,"%s",szBuffer);
		printf("Substring = %s\n\r",szAux);
		return strlen(szAux);
	}
	//Reemplaza Strings
	else if (memcmp(pFor->szFuncion,"REPLACE_STR",11)==0)
	{
		unsigned int i,j;
		char *ini,*fin;
		char *ch;
		char szBuffer[MAX_BUFFER];
		char szTmp[1024];
		char szTmp1[1024];

		GetParametros(pFor->szFuncion,szTmp,szTmp1);
		printf("String Buscado=%s\n\r",szTmp);
		printf("String A Remplazar=%s\n\r",szTmp1);
		printf("String %s\n\r",szAux);

		//Reemplazo el buffer
		j=0;
		ch=szAux;
		do
		{
			ini=(char *)strstr(ch,szTmp);
			if (ini==NULL)
			{
				memcpy(&szBuffer[j],ch,strlen(ch));
				j+=strlen(ch);
				break;
			}
			else 
			{
				memcpy(&szBuffer[j],ch,ini-ch);
				j+=(ini-ch);
				//printf("ini=%s ch=%s ini-ch=%i j=%i\n\r",ini,ch,ini-ch,j);
				memcpy(&szBuffer[j],szTmp1,strlen(szTmp1));
				j+=strlen(szTmp1);
				//printf("Buffer=%s\n\r",szBuffer);
				ch=ini+strlen(szTmp);
				//printf("ch=%s\n\r",ch);
			}
		} while (1);
		szBuffer[j]=0;
		//printf("Buffer Reemplazado1 %i %i = %s\n\r",i,j,szBuffer);
		sprintf(szAux,"%s",szBuffer);
		printf("Buffer Reemplazado_str %i %i = %s\n\r",i,j,szAux);
		return strlen(szAux);
	}
	//input de caracter, salida de hexadecimal
	else if (memcmp(pFor->szFuncion,"REPLACE_HEX2HEX",15)==0)
	{
		unsigned int i,j;
		char *ini,*fin;
		char *ch;
		char szBuffer[MAX_BUFFER];
		char szTmp[1024];
		char szTmp1[1024];
		char szHex1[512],szHex2[512];

		memset(szTmp,0,sizeof(szTmp));
		memset(szTmp1,0,sizeof(szTmp1));
		memset(szHex1,0,sizeof(szHex1));
		memset(szHex2,0,sizeof(szHex2));
		memset(szBuffer,0,sizeof(szBuffer));

		GetParametros(pFor->szFuncion,szHex1,szHex2);
		printf("String Buscado Hex=%s\n\r",szHex1);
		printf("String A Remplazar Hex=%s\n\r",szHex2);
		printf("String %s\n\r",szAux);
		readhex(szHex1,szTmp);
		readhex(szHex2,szTmp1);

		//Reemplazo el buffer
		j=0;
		ch=szAux;
		do
		{
			ini=(char *)strstr(ch,szTmp);
			if (ini==NULL)
			{
				memcpy(&szBuffer[j],ch,strlen(ch));
				j+=strlen(ch);
				break;
			}
			else 
			{
				memcpy(&szBuffer[j],ch,ini-ch);
				j+=(ini-ch);
				//printf("ini=%s ch=%s ini-ch=%i j=%i\n\r",ini,ch,ini-ch,j);
				memcpy(&szBuffer[j],szTmp1,strlen(szTmp1));
				j+=strlen(szTmp1);
				//printf("Buffer=%s\n\r",szBuffer);
				ch=ini+strlen(szTmp);
				//printf("ch=%s\n\r",ch);
			}
		} while (1);
		szBuffer[j]=0;
		//printf("Buffer Reemplazado1 %i %i = %s\n\r",i,j,szBuffer);
		sprintf(szAux,"%s",szBuffer);
		printf("Buffer Reemplazado_hex2hex %i %i = %s\n\r",i,j,szAux);
		return strlen(szAux);
	}
	//printf("2)Len Aplica %i\n\r",nLenOriginal);
	//Reemplaza caracteres
	else if (memcmp(pFor->szFuncion,"REPLACE_CHR",11)==0)
	{
		unsigned int i,j;
		char *ini,*fin;
		int ch;
		char szBuffer[MAX_BUFFER];
		char szTmp[1024];
		char szTmp1[20];
		GetParametros(pFor->szFuncion,szTmp1,szTmp);
		ch=atoi(szTmp1);
		printf("szTmp=%s\n\r",szTmp);
		printf("szAux=%s\n\r",szAux);

		//Reemplazo el buffer
		j=0;
		for(i=0;i<strlen(szAux);i++)
		{
			//printf("szAux[%i]=%i ch=%i %c\n\r",i,szAux[i],ch,szAux[i]);
			if (szAux[i]==ch)
			{
				memcpy(&szBuffer[j],szTmp,strlen(szTmp));
				j+=strlen(szTmp);
				//printf("Buffer=%s\n\r",szBuffer);
			}
			else szBuffer[j++]=szAux[i];
		}
		szBuffer[j]=0;
		printf("Buffer Reemplazado1 %i %i = %s\n\r",i,j,szBuffer);
		sprintf(szAux,"%s",szBuffer);
		printf("Buffer Reemplazado2 %i %i = %s\n\r",i,j,szAux);
		return strlen(szAux);
	}
	else if (memcmp(pFor->szFuncion,"LTRIM_REPLACE_HEX",17)==0)
	{
		char szHex1[20];
		char szHex2[20];
		char szTmp1[20];
		char szTmp2[20];
		char szBuffer[MAX_BUFFER];
		int  i;
		memset(szTmp1,0,sizeof(szTmp1));
		memset(szTmp2,0,sizeof(szTmp2));

		GetParametros(pFor->szFuncion,szHex1,szHex2);
		readhex(szHex1,szTmp1);
		readhex(szHex2,szTmp2);
		//Revisa hasta donde se puede correr
		for(i=0;i<nLenOriginal;i++)
		{
			if (szAux[i]==szTmp1[0]) szAux[i]=szTmp2[0];
		}
		return nLenOriginal;
	}
	else if (memcmp(pFor->szFuncion,"MODULO11",8)==0)
	{
		char szPar1[40];
		char szPar2[40];
		long l;
		GetParametros(pFor->szFuncion,szPar1,szPar2);
		l=atol(szPar1);
		sprintf(szAux,"%c",Modulo11(l));
		return strlen(szAux);
	}
	else if (memcmp(pFor->szFuncion,"OPERACION",9)==0)
	{
		char szPar1[20];
		char szPar2[20];
		char szPar3[20];
		int l;
		GetParametros3(pFor->szFuncion,szPar1,szPar2,szPar3);
		printf("Valor Ori=%s\n\r",szAux);
		if (!IsNumber(szAux)) return nLenOriginal;
		l=atoi(szAux);
		printf("Valor=%i\n\r",l);
		l=AplicaOperacionMath(l,szPar1);
		printf("Valor1=%i\n\r",l);
		l=AplicaOperacionMath(l,szPar2);
		printf("Valor2=%i\n\r",l);
		l=AplicaOperacionMath(l,szPar3);
		printf("Valor3=%i\n\r",l);
		sprintf(szAux,"%i",l);
		return strlen(szAux);
	}
		
	//printf("2)Len Aplica %i\n\r",nLenOriginal);
	return nLenOriginal;
}

//LCM AQUI PROCESA EL FORMATO DE ENTRADA.
Tipo_XML *AplicaFormatoEntrada(int id,Tipo_XML *xml,char data[],Tipo_Formatos *pFormato,int nLenData)
{
	Tipo_Formatos *pFor=pFormato;
	char szAux[MAX_BUFFER];
	char szData[MAX_BUFFER];
	char szError[500];
	int nPos;
	int nMaxLen=nLenData;
	int nLen,bFallaLargo,nDiferencia;
	int nNextSecuencia=0;
	Tipo_Data *pData2=NULL;
	Tipo_Data *pDataIn=NULL;
	
	//Dimensionamos el szAux como el largo maximo de la data
	//szAux=(char *)malloc(nLenData+10);
	//szData=(char *)malloc(nLenData+10);
	//memset(szAux,0,nLenData+10);

	nPos=0;
	//WriteLog(id,"Formato Entrada");
	//printf("Largo Entrada %i\n\r",nLenData);
	//printf("Data Entrada %s\n\r",data);
	while(pFor!=NULL)
        {
		//si debe verificar la secuencia..
		if (nNextSecuencia>0)
		{
			//si no corresponde..
			if (nNextSecuencia!=pFor->nSecuencia)
			{
				pFor=pFor->pNext;
				continue;
			}
			nNextSecuencia=0;
		}

		bFallaLargo=0;
		if (nPos+pFor->nLargo>nMaxLen+1) 
		{
			nDiferencia=nMaxLen-nPos;
			printf("No alcanza el largo de la data para generar formato de salida %i %i\n\r",nPos+pFor->nLargo,nMaxLen+1);
			bFallaLargo=1;
		}
		nLen=pFor->nLargo;
		printf("Largo Campo=%i\n\r",nLen);

		if (memcmp(pFor->szTipoCampo,"CARACTER",8)==0)
	        {
		       if (bFallaLargo) goto fin;
	               //si corresponde al formato..
	               if (memcmp(&data[nPos],szAux,pFor->nLargo)!=0)
	               {
	                  char szTmp[200],szTmp1[500],tt[20];
	                  int g;
			  memset(szTmp1,0,sizeof(szTmp1));
			  for(g=0;g<pFor->nLargo;g++)
		          {
			      sprintf(tt," %i",data[nPos+g]);
			      strcat(szTmp1,tt);
		      	  }	
			  sprintf(szError,"Formato #%i invalido tipo CARACTER %s, Leido ",pFor->nFormato,pFor->szCampo);
			  WriteLog(id,szError);
			  goto fin;
		       }
		}
		else if (memcmp(pFor->szTipoCampo,"TEXTO",5)==0)
		{
			int nLen;
	    		if (pFor->nLargo==-1) pFor->nLargo=strlen(pFor->szTexto);
	    		IdentaData(id,szAux,pFor->szTexto,pFor);
			printf("Campo %s, Data = %s Len(%i)\n\r",pFor->szCampo,szAux,strlen(szAux));
			xml=InsertaDataXML(xml,pFor->szCampo,szAux);
		}
		else if (memcmp(pFor->szTipoCampo,"CAMPO_B80",9)==0)
		{
			long l;
			char szFor[100];
			char szLen[10];
		        if (bFallaLargo) goto fin;
			memcpy(szAux,&data[nPos],pFor->nLargo);
			szAux[pFor->nLargo]=0;
			AplicaFunciones(id,pFor,szAux,0);
			l=Base80ToDec(szAux);
			if (memcmp(pFor->szTipo,"STR_",4)==0)
			{
				//El largo del string de salida viene 
				memcpy(szLen,&pFor->szTipo[4],strlen(&pFor->szTipo[4]));
				szLen[strlen(&pFor->szTipo[4])]=0;
			}
			else szLen[0]=0;
			sprintf(szFor,"%%0%ild",atoi(szLen));
			sprintf(szData,szFor,l);
			printf("CampoBase80 %s, In=%s Form=%s Data = %s\n\r",pFor->szCampo,szAux,szFor,szData);
			xml=InsertaDataXML(xml,pFor->szCampo,szData);
		}
		else if (memcmp(pFor->szTipoCampo,"CAMPO",5)==0)
		{
			//si lleva algun comando despues
			if (pFor->nLargo==(-1))
			{
				//LCM AQUI SACA EL LARGO DE LA DATA DE ENTRADA
				nLen=nLenData-nPos;
			}
		        else if (bFallaLargo)
		        {
			       if (nDiferencia>0)
			       {
					     nLen=strlen(&data[nPos]);
			       }
			       else goto fin;
		        }
			else nLen=pFor->nLargo;
		
		  printf("*Largo Campo=%i\n\r",nLen);

			//Verificamos si el largo es variable...
			//El largo viene especifica en un campo
			//Si viene largo asc, debe
			if (memcmp(pFor->szFuncion,"LEN_CMP",7)==0)
			{
				char szPar1[200],szPar2[20],szPar3[20];
				int nLenCampo;
				GetParametros3(pFor->szFuncion,szPar1,szPar2,szPar3);
				GetIntXML(xml,szPar1,&nLenCampo);
				nLen=AplicaOperacionMath(nLenCampo,szPar2);
				nLen=AplicaOperacionMath(nLen,szPar3);
				printf("Largo LEN_CMP=%i\n\r",nLen);
				if (nLen>=0)
				{
					memcpy(szAux,&data[nPos],nLen);
					szAux[nLen]=0;
				}
				else WriteLog(id,"Largo Menor que Cero");
			}
			//Copia hasta que encuentra el string del parametro
			//uno
			else if (memcmp(pFor->szFuncion,"LEN_VAR_HEX",11)==0)
			{
				char szPar1[200],szPar2[20];
				char *ini,*fin;
				char szTmp[200];
				GetParametros(pFor->szFuncion,szPar1,szPar2);
				fin=&data[nPos];
				memset(szTmp,0,sizeof(szTmp));
				readhex(szPar1,szTmp);
				ini=(char *)strstr(fin,szTmp);
				printf("fin=%s ini=%s nLen=%i\n\r",fin,ini,ini-fin);
				if (ini!=NULL) nLen=ini-fin;
				memcpy(szAux,&data[nPos],nLen);
				szAux[nLen]=0;
				//nLen+=strlen(szTmp);
			}
			else if (memcmp(pFor->szFuncion,"LEN_VAR",7)==0)
			{
				char szPar1[200],szPar2[20];
				char szE[256];
				char *ini,*fin;
				GetParametros(pFor->szFuncion,szPar1,szPar2);
				fin=&data[nPos];
				ini=(char *)strstr(fin,szPar1);
				printf("fin=%s ini=%s nLen=%i\n\r",fin,ini,ini-fin);
				if (ini!=NULL) nLen=ini-fin;
				memcpy(szAux,&data[nPos],nLen);
				szAux[nLen]=0;
				nLen+=strlen(szPar1);
			}
			//LEN_XML sirve para parsear XML
			else if (memcmp(pFor->szFuncion,"LEN_XML",7)==0)
			{
				char szPar1[200],szPar2[20];
				char szTmpXML[210];
				char szError[100];
				char *ini,*fin,*fin1;
				memset(szAux,0,sizeof(szAux));
				printf("Campo %s\n\r",pFor->szCampo);
				GetParametros(pFor->szFuncion,szPar1,szPar2);
				fin=&data[nPos];
				sprintf(szTmpXML,"<%s>",szPar1);
				printf("Busca XML=%s LARGO=%i DATA=%s \n\r",szTmpXML,strlen(fin),fin);
				//sprintf(szError,"BUSCA XML %s LEN=%i",szTmpXML,strlen(fin));
				//WriteLog(id,szError);
				ini=(char *)strstr(fin,szTmpXML);
				//si se encuentra el patron...
				if (ini!=NULL) 
				{
					char *ini1;
					ini1=ini+strlen(szTmpXML);
					//Buscamos el final...
					sprintf(szTmpXML,"</%s>",szPar1);
					fin1=(char *)strstr(ini1,szTmpXML);
					if (fin1!=NULL)
					{
					   nLen=fin1-ini1;
					   memcpy(szAux,ini1,nLen);
					   szAux[nLen]=0;
					}
					else nLen=0;
				}
				else nLen=0;
			}
			//Condicional, copia el largo establecido a no ser
			//que se encuentre con el patron en parametro uno
			//en caso de encontrar el patron, se pasa a la 
			//secuencia especificada en el parametro 2
			else if (memcmp(pFor->szFuncion,"LEN_COND",8)==0)
			{
				char szPar1[200],szPar2[20];
				char *ini,*fin;
				printf("Campo %s\n\r",pFor->szCampo);
				GetParametros(pFor->szFuncion,szPar1,szPar2);
				fin=&data[nPos];
				printf("fin=%s szPar1=%s\n\r",fin,szPar1);
				ini=(char *)strstr(fin,szPar1);
				//si se encuentra el patron...
				if (ini!=NULL) 
				{
					printf("nLen=%i ini-fin=%i\n\r",nLen,ini-fin);
					//si el patron se encuentra en el largo
					if (nLen>ini-fin) 
					{
						nLen=ini-fin;
						nNextSecuencia=atoi(szPar2);
						printf("Proxima Sec = %i\n\r",nNextSecuencia);
						goto fin;
					}
					else
					{
						memcpy(szAux,&data[nPos],nLen);
						szAux[nLen]=0;
					}
				}
				//Copia lo establecido
				else
				{
					memcpy(szAux,&data[nPos],nLen);
					szAux[nLen]=0;
				}
			}
			else
			{
				//memcpy(szAux,&data[nPos],nLen);
				//szAux[nLen]=0;
				pDataIn=InsertaDataLen(&data[nPos],nLen,pDataIn);
				//WriteMensajeApp(id,pDataIn->data);
			}
			if (pDataIn)
			{
				pData2=NULL;
				pData2=AplicaFuncionesVar(id,pDataIn->data,pFor,nLen);
			}
			else
			{	
				/*Modificacion 10-12-07 en vez de leer el largo como strlen lo cambio a 
				 largo binario del campo, el que se nLen*/
				//AplicaFunciones(id,pFor,szAux,strlen(szAux));
				printf("**Largo Campo=%i\n\r",nLen);
				//AplicaFunciones(id,pFor,szAux,nLen);
				pData2=NULL;
				pData2=AplicaFuncionesVar(id,szAux,pFor,nLen);
			}

			if (pData2!=NULL)
			{
				xml=InsertaDataXML(xml,pFor->szCampo,pData2->data);
				pData2=LiberaData(pData2);
			}
			//Si tiene pDataIn, ese es el valor sobre szAux
			else if (pDataIn)
			{
				int d;
				int len1=pDataIn->nLenData;
				for(d=0;d<len1;d++) 
				{
					if (pDataIn->data[d]==39) pDataIn->data[d]=' ';
					if (pDataIn->data[d]==2) pDataIn->data[d]=' ';
					if (pDataIn->data[d]==3) pDataIn->data[d]=' ';
					//if (szAux[d]<30) szAux[d]=' ';
				}
				SacaEspacios(pDataIn->data);
				xml=InsertaDataXML(xml,pFor->szCampo,pDataIn->data);
			}
			else
			{
				int d;
				int len1=strlen(szAux);
				for(d=0;d<len1;d++) 
				{
					if (szAux[d]==39) szAux[d]=' ';
					if (szAux[d]==2) szAux[d]=' ';
					if (szAux[d]==3) szAux[d]=' ';
					//if (szAux[d]<30) szAux[d]=' ';
				}
				SacaEspacios(szAux);
				xml=InsertaDataXML(xml,pFor->szCampo,szAux);
			}
			/*
			printf("Sale de AplicaFunciones");
			memset(szData,0,sizeof(szData));
			if (memcmp(pFor->szTipo,"INT",3)==0)
			{
				sprintf(szData,"%ld",atol(szAux));
			}
			else if (memcmp(pFor->szTipo,"CHAR",4)==0)
			{
				sprintf(szData,"%c",szAux[0]);
			}
			else if (memcmp(pFor->szTipo,"DOUBLE",6)==0)
			{
				int d;
				for(d=0;d<strlen(szAux);d++)
					if (szAux[d]==',') szAux[d]='.';
				//printf("Double %s\n\r",szAux);
				SacaEspacios(szAux);
				sprintf(szData,"%s",szAux);
			}
			else if (memcmp(pFor->szTipo,"DATE",4)==0)
			{
				sprintf(szData,"%s",szAux);
			}
			else if (memcmp(pFor->szTipo,"BIN",3)==0)
			{
				//SacaEspacios(szAux);
				sprintf(szData,"%s",szAux);
				//WriteLog(id,"Tipo BIN");
				//WriteLog(id,szData);
			}
			//else if (memcmp(pFor->szTipo,"STR",3)==0)
			else 
			{
				int d;
				int len1=strlen(szAux);
				for(d=0;d<len1;d++) 
				{
					if (szAux[d]==39) szAux[d]=' ';
					if (szAux[d]==2) szAux[d]=' ';
					if (szAux[d]==3) szAux[d]=' ';
					//if (szAux[d]<30) szAux[d]=' ';
				}
				SacaEspacios(szAux);
				sprintf(szData,"%s",szAux);
			}
			//printf("Campo %s, Data = %s LEn=%i\n\r",pFor->szCampo,szData,strlen(szData));
			//sprintf(szAux,"FE:Campo %s, Data=%s Len=%i",pFor->szCampo,szData,strlen(szData));
			//WriteLog(id,szAux);
			xml=InsertaDataXML(xml,pFor->szCampo,szData);
			*/
		}
fin:
		nPos+=nLen;
		pFor=pFor->pNext;
	}
	return xml;
}

int AplicaFunciones(int id,Tipo_Formatos *pFor,unsigned char szAux[],int nLenOriginal)
{
	char *ini,*fin;
	int nLen;
	char szTmp[1024];
	char szEE[1024];
	Tipo_Formatos *pForAux;
	printf("Aplica Funciones Funcion='%s'\n",pFor->szFuncion);
	if (strlen(pFor->szFuncion)==0) return nLenOriginal;
	//sprintf(szEE,"AplicaFunciones %s",pFor->szFuncion);
	//WriteLog(id,szEE);
	
	//if (strlen(pFor->szFuncion)>0)
	if (pFor->szFuncion[0]!='[') 
		return AplicaFunciones1(id,pFor,szAux,nLenOriginal);

	//Si va hacer una recursion, hay que generar un nuevo puntero
        pForAux = (Tipo_Formatos *)malloc(sizeof(Tipo_Formatos));
	snprintf(pForAux->szCampo,sizeof(pForAux->szCampo),"%s",pFor->szCampo);
	snprintf(pForAux->szTipoCampo,sizeof(pForAux->szTipoCampo),"%s",pFor->szTipoCampo);
	pForAux->nCaracter=pFor->nCaracter;
	pForAux->nLargo=pFor->nLargo;
	pForAux->nSecuencia=pFor->nSecuencia;
	snprintf(pForAux->szIdent,sizeof(pForAux->szIdent),"%s",pFor->szIdent);
	snprintf(pForAux->szTexto,sizeof(pForAux->szTexto),"%s",pFor->szTexto);
	snprintf(pForAux->szTipo,sizeof(pForAux->szTipo),"%s",pFor->szTipo);
	snprintf(pForAux->szFuncion,sizeof(pForAux->szFuncion),"%s",pFor->szFuncion);
	pForAux->nFormato=pFor->nFormato;
	pForAux->chLlenado=pFor->chLlenado;


	sprintf(szTmp,"%s",pForAux->szFuncion);
	ini=szTmp;
	nLen=nLenOriginal;

	WriteLog(0,ini);
	do
	{
		ini=(char *)strchr(ini,'[');
		if (ini==NULL) break;
		ini++;
		fin=(char *)strchr(ini,']');
		if (fin==NULL) 
		{
			WriteLog(0,"Falla Funcion2");
			WriteLog(0,ini);
			break;
		}
		memcpy(pForAux->szFuncion,ini,fin-ini);
		pForAux->szFuncion[fin-ini]=0;
		WriteLog(id,pForAux->szFuncion);
		nLen=AplicaFunciones1(id,pForAux,szAux,nLen);
	} while(1);
	//Libero puntero
	free(pForAux);
	return nLen;
}

void mc_substring(char strOrig[], int ini, int fin, char strDest[]) {
	int iStrDest = 0;
	int lenOrig = strlen(strOrig);

	if (lenOrig <= fin) {
		strDest[0] = 0;
		return;
	}
	
	while (ini <= fin) {
		strDest[iStrDest] = strOrig[ini];
		iStrDest++;
		ini++;
	}
	strDest[iStrDest] = '\0';
}


