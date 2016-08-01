#include <xml.h>
#include <tipos.h>
#include <pthread.h>

Tipo_Querys *LeeQueryBase(int id,char szLlave[]);

//Tipo_Lista_Querys *AgregaListaQuery(Tipo_Querys *pForm,char szLlave[])
//Ya esta en la region critica del mutex
int AgregaListaQuery(Tipo_Querys *pForm,char szLlave[])
{
    Tipo_Lista_Querys *pLFor=NULL;
    Tipo_Lista_Querys *pLFormAux=NULL;

    //pthread_mutex_lock(&global.mutex_querys);
    pLFormAux=global.pGListaQuerys;

    pLFor = (Tipo_Lista_Querys *)malloc(sizeof(Tipo_Lista_Querys));
    sprintf(pLFor->szLlave,"%s",szLlave);
    pLFor->pQuery=pForm;
    pLFor->pNext=NULL;

    if (global.pGListaQuerys==NULL)
    {
	    global.pGListaQuerys=pLFor;
            //pthread_mutex_unlock(&global.mutex_querys);
	    //return global.pGListaQuerys;
	    return 1;
    }

    //Busca el final de la lista..
    while(pLFormAux->pNext!=NULL) pLFormAux = pLFormAux->pNext;

    //Asigna el ultimo, registro
    pLFormAux->pNext = pLFor;
    //pthread_mutex_unlock(&global.mutex_querys);

    return 1;
}

Tipo_Querys *BuscaQuery(char szLlave[])
{
    	Tipo_Lista_Querys *pLFormAux=global.pGListaQuerys;

	/*
    	pthread_mutex_lock(&global.mutex_querys);
	while(pLFormAux!=NULL)
	{
		if ((strlen(pLFormAux->szLlave)==strlen(szLlave)) &&
		    (memcmp(pLFormAux->szLlave,szLlave,strlen(szLlave))==0))
		{
    			pthread_mutex_unlock(&global.mutex_querys);
			return pLFormAux->pQuery;
		}
		pLFormAux=pLFormAux->pNext;
	}
    	pthread_mutex_unlock(&global.mutex_querys);
	return NULL;
	*/
	//Se saca el mutex para no serializar todas las tx en regimen
	while(pLFormAux!=NULL)
	{
		if ((strlen(pLFormAux->szLlave)==strlen(szLlave)) &&
		    (memcmp(pLFormAux->szLlave,szLlave,strlen(szLlave))==0))
		{
			return pLFormAux->pQuery;
		}
		pLFormAux=pLFormAux->pNext;
	}
	//Si llegan 2 o mas nuevas, podria leerse mas de 1 vez
	return NULL;
}

Tipo_Querys *LeeQuery(int id,int nTx)
{
	Tipo_Querys *pForm;
	char szLlave[10];
	sprintf(szLlave,"%i",nTx);
	if (strlen(szLlave)==0) return NULL;
	/*
	if (global.pGListaQuerys==NULL)
	{
		pForm=LeeQueryBase(id,szLlave);
	        AgregaListaQuery(pForm,szLlave);
		return pForm;
	}
	else 
	{
	*/
		ImprimeMemoria(id,"Antes de BuscaQuery1");
		pForm=BuscaQuery(szLlave);
		ImprimeMemoria(id,"Despues de BuscaQuery1");
		if (pForm==NULL) 
		{
			pthread_mutex_lock(&global.mutex_querys);
			ImprimeMemoria(id,"Antes de BuscaQuery2");
			//Solo por si alguien lo encontro antes que yo
			pForm=BuscaQuery(szLlave);
			ImprimeMemoria(id,"Despues de BuscaQuery2");
			if (pForm==NULL)
			{
				ImprimeMemoria(id,"Antes de LeeQueryBase");
				pForm=LeeQueryBase(id,szLlave);
				ImprimeMemoria(id,"Despues de LeeQueryBase");
		        	AgregaListaQuery(pForm,szLlave);
				ImprimeMemoria(id,"Despues de AgregaListaQuery");
			}
			pthread_mutex_unlock(&global.mutex_querys);
			return pForm;
		}
		return pForm;
	//}
}




Tipo_Querys *LeeQueryBase(int id,char szLlave[])
{
      char szAux[200];
      char szSql[512];
      int nLinea=0,i,sts;
      char szData[512];
      char szTmp[50];
      Tipo_XML *xml1=NULL;
      Tipo_Querys *pQuery=NULL,*pFor=NULL;
      Tipo_Querys *pFormAux;
      int nTotal;

      sprintf(szSql,"select * from isys_querys_tx where llave='%s' order by secuencia",szLlave);
      xml1=GetRecords(id,szSql,&nTotal,xml1,&sts);
      for(i=0;i<nTotal;i++)
      {
	    pFor = (Tipo_Querys *)malloc(sizeof(Tipo_Querys));
            GetNivelStrXML(xml1,"LLAVE",pFor->szLlave,sizeof(pFor->szLlave),i);
            GetNivelIntXML(xml1,"SECUENCIA",&pFor->nSecuencia,i);
            GetNivelIntXML(xml1,"TIPO_12",&pFor->nTipo,i);
            GetNivelStrXML(xml1,"QUERY_1",pFor->szQuery,sizeof(pFor->szQuery),i);
            GetNivelIntXML(xml1,"BASE_QUERY_1",&pFor->nBaseQuery,i);
            GetNivelIntXML(xml1,"VALIDA_OUTPUT_1",&pFor->nValidaOutput,i);
            GetNivelIntXML(xml1,"ESPERA_OUTPUT_1",&pFor->nEsperaOutput,i);
            GetNivelIntXML(xml1,"SERVICIO_2",&pFor->nServicio,i);
            GetNivelIntXML(xml1,"FORMATO_SALIDA_2",&pFor->nForSalida,i);
            GetNivelIntXML(xml1,"FORMATO_ACK_2",&pFor->nForAck,i);
            GetNivelIntXML(xml1,"SECUENCIA_OK",&pFor->nSecOk,i);
            GetNivelIntXML(xml1,"SECUENCIA_ERROR",&pFor->nSecError,i);
	    pFor->pNext=NULL;
	    if (pQuery==NULL)
	    {
		    pQuery = pFor;
		    pFormAux = pQuery;
	    }
	    else
	    {
		    pFormAux->pNext =pFor;
		    pFormAux = pFor;
	    }
      }
      xml1=CierraXML(xml1);
      return pQuery;
}

void CierraListaQuerys()
{
	Tipo_Lista_Querys *pAux=global.pGListaQuerys,*pAux1;
	if (pAux==NULL) return;
    	pthread_mutex_lock(&global.mutex_querys);
	while(pAux!=NULL) 
	{
		pAux1=pAux->pNext;
		free(pAux);
		pAux=pAux1;
	}
	global.pGListaQuerys=NULL;
    	pthread_mutex_unlock(&global.mutex_querys);
	printf("Limpia Lista Querys\n\r");
}



