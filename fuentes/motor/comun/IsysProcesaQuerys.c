#include <stdio.h>
#include <stdlib.h>
#include<sys/types.h>
#include<dirent.h>
#include <sys/stat.h>
#include <xml.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

//extern pthread_mutex_t mut_proc;
/* Need dlfcn.h for the routines to dynamically load libraries */
#include <dlfcn.h>



Tipo_XML *AplicaServicioTipo11(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
	Tipo_Formatos *pForIn;
	Tipo_XML *xml2=NULL;
	char szAux[100];
	char szFile[1024];
	char szError[1024];
	char szComando[512];
	Tipo_Data *pFile=NULL;
	Tipo_Data *pSql=NULL;
	int nLen;
	FILE *f;
	time_t t1,t2;
	int nTimeout;
	
	//Solo por si viene como parametros
	*nProxSec=pQuerys->nSecError;
	pSql=ReemplazaTagsStr1(xml,pQuerys->szQuery);
	xml2=ProcesaInputXML1(xml2,pSql->data);
	pSql=LiberaData(pSql);
	pForIn=LeeFormato(id,pQuerys->nForSalida);
	if (!pForIn)
	{
		sprintf(szError,"No existe formato %i para leer archivos tipo %s",pQuerys->nForSalida,szFile);
		printf("%s\n\r",szError);
		WriteLog(id,szError);
		return xml;
	}
	GetStrXML(xml2,"FILE",szFile,sizeof(szFile));
	GetStrXML(xml2,"COMANDO",szComando,sizeof(szComando));
	GetIntXML(xml2,"TIMEOUT",&nTimeout);
	xml2=CierraXML(xml2);
	if (memcmp(szComando,"DELETE",6)==0)
	{
		remove(szFile);
		sprintf(szError,"Borra File %s",szFile);
		WriteLog(id,szError);
		return xml;
	}
	else
	{
	   time(&t1);
	   //Espera a que este abierto el archivo
	   do
	   {
		f=fopen(szFile,"r");
		if (f!=NULL) 
		{
			fclose(f);
			break;
		}
		time(&t2);
		usleep(100);
	   }while(t2-t1<nTimeout);

	   pFile=LeeArchivo(szFile);
	   if (!pFile)
	   {
		sprintf(szError,"El Archivo %s no puede ser leido",szFile);
		WriteLog(id,szError);
		printf("%s\n\r",szError);
		return xml;
	   }
	   xml=AplicaFormatoEntrada(id,xml,pFile->data,pForIn,pFile->nLenData);	
	   pFile=LiberaData(pFile);
	   *nProxSec=pQuerys->nSecOk;
	}
	return xml;
}

//Cierra Socket tipo NO_CLOSE
Tipo_XML *CierraSocketTipo12(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
		char szAux[256];
		int nSocket;
		
		//Si existe el TAG
		if (GetStrXML(xml,"__SOCKETOPEN__",szAux,sizeof(szAux)))
                {
			nSocket=atol(szAux);
			close(nSocket);
			sprintf(szAux,"Cierre socket NO_CLOSE=%i",nSocket);
			WriteLog(id,szAux);
			*nProxSec=pQuerys->nSecOk;
                }
		else
		{	
			WriteLog(id,"No existe tag __SOCKETOPEN__");
			*nProxSec=pQuerys->nSecError;
		}
		return xml;
}

//Hace un system contra el sistema..
Tipo_XML *AplicaServicioTipo10(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
		//char szSystem[4096];
		Tipo_Data *pSystem=NULL;
		FILE *fp;
		char path[1024];
		Tipo_Data *pData=NULL;
		pSystem=ReemplazaTagsStr1(xml,pQuerys->szQuery);
		//ReemplazaTagsStr(xml,pQuerys->szQuery,szSystem);
		WriteLog(id,"SYSTEM COMMAND");
		WriteLog(id,pSystem->data);
		WriteMensajeApp(id,pSystem->data);
		fp=popen(pSystem->data,"r");
	        //int fd = fileno(fp);
		//fcntl(fd, F_SETFL, O_NONBLOCK);
		if (fp==NULL) 
		{
			WriteLog(id,"Falla Comando Sistemas");
			WriteMensajeApp(id,"Falla system command");
			*nProxSec=pQuerys->nSecError;
		}
		else 
		{
			/*
			//Controla el Timeout para el script
			fd_set selectset;
			struct timeval timeout = {15,0}; //timeout of 10 secs.
			int ret;
			FD_ZERO(&selectset);
			FD_SET(fd,&selectset);
			ret =  select(fd+1,&selectset,NULL,NULL,&timeout);
			if(ret == 0)
			{
			  //timeout
				xml=InsertaDataXML(xml,"RESPUESTA_SYSTEM","TIMEOUT");
				WriteLog(id,"Timeout en script (system)");
				WriteMensajeApp(id,"Timeout en script (system)");
			}
			else if(ret == -1)
			{
			  //error
				xml=InsertaDataXML(xml,"RESPUESTA_SYSTEM","ERROR");
				WriteLog(id,"Error en script (system)");
				WriteMensajeApp(id,"Error en script (system)");
			}
			else 
			{
			   // stdin has data, read it
			   // (we know stdin is readable, since we only asked for read events
			   //and stdin is the only fd in our select set.
			}
  		*/	
		        
				
			char szAux[10024];	
			sprintf(szAux,"Size fgets %i",sizeof(path)-1);
			WriteMensajeApp(id,szAux);
			WriteLog(id,szAux);
			char *sts1=NULL;
			sts1=fgets(path, sizeof(path)-1, fp);
			sprintf(szAux,"STS fgets %i",sts1);
                        WriteMensajeApp(id,szAux);
                        WriteLog(id,szAux);
			sprintf(szAux,"Error %s",strerror(errno));
			WriteMensajeApp(id,szAux);

			//while (fgets(path, sizeof(path)-1, fp) != NULL) 
			while (sts1 != NULL) 
			{
				sprintf(szAux,"Lee fgets %i",strlen(path));
				WriteMensajeApp(id,szAux);
				WriteLog(id,szAux);
				pData=ConcatenaData(path,pData,strlen(path));
				memset(path,0,sizeof(path));
				sts1=fgets(path, sizeof(path)-1, fp);
				sprintf(szAux,"Error %s",strerror(errno));
				WriteMensajeApp(id,szAux);
  			}
			if (pData)
			{
					WriteMensajeApp(id,pData->data);
					xml=InsertaDataXML(xml,"RESPUESTA_SYSTEM",pData->data);
					pData=LiberaData(pData);
			}
			*nProxSec=pQuerys->nSecOk;
			pclose(fp);
		}
		return xml;
}

//Hace una evaluacion del dato y determina hacia donde seguir sin ir a la BD
Tipo_XML *AplicaServicioTipo14(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
		Tipo_XML *xml1=NULL;
		char szData[4096];
		char szCadena1[MAX_BUFFER];
		char szCadena2[MAX_BUFFER];
		char szEval[MAX_BUFFER];
		int sts1=0;
		ReemplazaTagsStr(xml,pQuerys->szQuery,szData);
		xml1=ProcesaInputXML1(xml1,szData);
		GetStrXML(xml1,"EVALUADOR",szEval,sizeof(szEval));
		GetStrXML(xml1,"CADENA_DOS",szCadena2,sizeof(szCadena2));
		WriteLog(id,szData);
		//Solo permite el largo al principio
		if (GetStrXML(xml1,"LARGO",szCadena1,sizeof(szCadena1))>0)
		{
			if (memcmp(szEval,"MAYOR",5)==0)
			{
				if (strlen(szCadena1)>atoi(szCadena2)) sts1=1;
			}
			else if (memcmp(szEval,"MENOR",5)==0)
			{
				if (strlen(szCadena1)<atoi(szCadena2)) sts1=1;
			}
			else if (memcmp(szEval,"IGUAL",5)==0)
			{
				if (strlen(szCadena1)==atol(szCadena2)) sts1=1;
			}
		}
		else if (GetStrXML(xml1,"INSERTA",szCadena1,sizeof(szCadena1))>0)
		{
			//Inserta la data al XML
			xml=ProcesaInputXML1(xml,szCadena1);
			sts1=1;
		}
		else
		{
			GetStrXML(xml1,"CADENA_UNO",szCadena1,sizeof(szCadena1));
			if (memcmp(szEval,"IGUAL",5)==0)
			{
				if (memcmp(szCadena1,szCadena2,strlen(szCadena2))==0) sts1=1;
			}
			else if (memcmp(szEval,"CONTENGA",8)==0)
			{
				if (strstr(szCadena2,szCadena1)>0)
				{
					WriteLog(id,"OK");
					 sts1=1;
				}
			}
		}

		if (sts1==1) *nProxSec=pQuerys->nSecOk;
		else *nProxSec=pQuerys->nSecError;
		return xml;
}


//Borra desde el XML un campo que viene en el query
Tipo_XML *AplicaServicioTipo15(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
		xml=InsertaDataXML(xml,pQuerys->szQuery,"");
		*nProxSec=pQuerys->nSecOk;
		return xml;
}

//Abre una libreria so y la ejecuta
//Sirve para integrar gsoap con los WS
Tipo_XML *AplicaServicioTipo13(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
                Tipo_XML *(*ptr_funcion)(int,Tipo_XML *);
                char szServicio[1024];
                char szFuncion[1024];
                char szAux[4096];
                const char *error;
                void *module;

                ReemplazaTagsStr(xml,pQuerys->szQuery,szServicio);

                //La Libreria a levantar viene en pQuerys->szQuery
                /* Load dynamically loaded library */
                module = dlopen(szServicio, RTLD_LAZY);
                 if (!module) {
                        sprintf(szAux,"Falla Abrir Libreria %s: %s\n",szServicio,dlerror());
                        WriteLog(id,szAux);
                        xml=InsertaDataXML(xml,"ERROR",szAux);
                        xml=InsertaDataXML(xml,"COD_RESP","2");
                        *nProxSec=pQuerys->nSecError;
                 }
                else
                {
                        /* Get symbol */
                         dlerror();

                         GetStrXML(xml,"ID_WS_FUNCION",szFuncion,sizeof(szFuncion));
                         ptr_funcion = dlsym(module, szFuncion);
                         if ((error = dlerror()))
                        {
                                sprintf(szAux,"No encuentra funcion %s: %s\n",szFuncion,dlerror());
                                WriteLog(id,szAux);
                                xml=InsertaDataXML(xml,"ERROR",szAux);
                                xml=InsertaDataXML(xml,"COD_RESP","2");
                                *nProxSec=pQuerys->nSecError;
                        }
                        else
                        {
                                /* Now call the function in the DL library */
                                 xml=(*ptr_funcion)(id,xml);
                                 dlclose(module);
                                *nProxSec=pQuerys->nSecOk;
                        }
                }
                return xml;
}


//Asigna threads y espera su ejecucion de manera simultanea.
Tipo_XML *AplicaServicioTipo9(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec)
{
	int bContesta=0;
	int sts;
	char szAux[200];
	Tipo_XML *xml2=NULL;
	int nServicio,i,j,nCont;
	time_t t1,t2;
	char szCampo[512];
	int nTimeout;
	int PROCESOS[100];
	int nProcesoAux;
	int n,n1;
	Tipo_Data *pSql;
	*nProxSec=pQuerys->nSecOk;
	nServicio=pQuerys->nServicio;
	n=0;

	for(j=0;j<100;j++) PROCESOS[j]=-1;

	//Solo por si viene como parametros
	pSql=ReemplazaTagsStr1(xml,pQuerys->szQuery);
	if (pSql) xml2=ProcesaInputXML1(xml2,pSql->data);
	pSql=LiberaData(pSql);

	WriteLog(id,"Asigna Procesos MultiProposito");
	//WriteError(id,"MultiProposito");
	//ImprimeMemoria(id);
	n1=0;
	//Ejecuta los procesos..
	while(1)
	{
		nServicio=0;
		//Obtengo el dato del servicio a ejecutar
		sprintf(szCampo,"EJECUTA%i",n1++);
		GetIntXML(xml2,szCampo,&nServicio);
		if (nServicio>0) 
		{
			int i;
			char szAux[50];
			//Busca una conexion libre
			sprintf(szAux,"Espera Libre Total Proc Multi=%i",global.nTotalProcesosMulti);
			WriteLog(id,szAux);
			i=EsperaConexionLibreMulti(id,global.nProcesos);
			sprintf(szAux,"Libre =%i",i);
			WriteLog(id,szAux);
			//Asigno que el proceso tiene padre
			Conexion[i].nIdPadre=id;
			Conexion[i].nTipoProceso = PROC_XML;
			//WriteLog(id,"CloseXML");
			Conexion[i].xml=CierraXML(Conexion[i].xml);
			//WriteLog(id,"StrCpy");
			Conexion[i].xml=StrcpyXML(xml,Conexion[i].xml);	
			//sprintf(szAux,"Abre Proceso %i %x",i,Conexion[i].xml);
			//WriteError(id,szAux);

			//WriteLog(id,"Inerta");
			//Asigno parametro de entrada
			Conexion[i].xml=InsertaDataIntXML(Conexion[i].xml,"SERVICIO",nServicio);

			//Asigna el proceso
			sprintf(szAux,"Activa Proceso %i %i",i,n);
			WriteLog(id,szAux);
			PROCESOS[n++]=i;
			DespiertaProcesoMulti(i);
			//sprintf(szAux,"Despierta PRoceso %i",i);
			//WriteError(id,szAux);
			//ImprimeMemoria(id);
		}
		else break;
		usleep(10);
	}
	nTimeout=10;
	GetIntXML(xml2,"TIMEOUT",&nTimeout);
	sprintf(szAux,"Timeout Procesos %i",nTimeout);
	WriteLog(id,szAux);
	//WriteError(id,"MultiProposito2");
	//ImprimeMemoria(id);

	//Setea Hora de inicio de timeout
	time(&t1);
	
	//Ejecuta los querys
	n1=0;
	do
	{
		char szQuery[1024];
		time(&t2);
		if (t2-t1>nTimeout) 
		{
			WriteLog(id,"Timeout Querys multiProceso");
			break;
		}
		//Obtengo el query ejecutar
		sprintf(szCampo,"QUERY%i",n1++);
		if (GetStrXML(xml2,szCampo,szQuery,sizeof(szQuery)))
		{
			Tipo_Data *pData;
			//Tipo_XML *xmlq=NULL;
			pData=ReemplazaTagsStr1(xml,szQuery);
			if (pData==NULL)
			{
			      WriteLog(0,"ERROR no hay query");
			      break;
			}
			xml=GetRecord(id,pData->data,xml,&sts);
			pData=LiberaData(pData);
		}
		else break;
	} while(1);

	xml2=CierraXML(xml2);
	//WriteError(id,"MultiProposito3");
	//ImprimeMemoria(id);
	//Espera que terminen 
	do
	{
	   nCont=0;
	   for(j=0;j<n;j++) 
	   {
		if (PROCESOS[j]==-1) nCont++;
		//Revisa si ha parado los procesos
		else if (Conexion[PROCESOS[j]].nEstado==C_ESPERA) 
		{
			nProcesoAux=PROCESOS[j];
			nCont++;
			//pthread_mutex_lock(&Conexion[nProcesoAux].mut_cierra_xml);
			if (Conexion[nProcesoAux].xml!=NULL)
			{
				sprintf(szAux,"Update Proceso %i %i",PROCESOS[j],j);
				WriteLog(id,szAux);
				//xml=UpdateXML(xml,Conexion[nProcesoAux].xml);
				xml=UpdateXMLSinNulo(xml,Conexion[nProcesoAux].xml);
				//sprintf(szAux,"Cierra Proceso %i %x",PROCESOS[j],Conexion[nProcesoAux].xml);
				//WriteError(id,szAux);
				Conexion[nProcesoAux].xml=CierraXML(Conexion[nProcesoAux].xml);
				//ImprimeMemoria(id);
			}
			else
			{
				sprintf(szAux,"Xml Nulo Proceso %i %i",PROCESOS[j],j);
				WriteLog(id,szAux);
			}
			//ImprimeXML(xml);
			//pthread_mutex_unlock(&Conexion[nProcesoAux].mut_cierra_xml);
			
			Conexion[nProcesoAux].nIdPadre=-1;
			PROCESOS[j]=-1;
			//pthread_mutex_lock(&mut_proc);
			Conexion[nProcesoAux].nEstado=C_LIBRE;
			//pthread_mutex_unlock(&mut_proc);
		}
	    }
	    if (nCont==n) break;
	    time(&t2);
	    if (t2-t1>nTimeout) 
	    {
			WriteLog(id,"Timeout MultiProceso");
			break;
    	    }
	    usleep(100);
	}while(1);
	//WriteError(id,"MultiProposito4");
	//ImprimeMemoria(id);

	//Concatenamos las respuesta positivas..
	for(j=0;j<n;j++)
	{
		//Si el proceso no termino...
		if (PROCESOS[j]!=-1) 
		{
			//Indico que el padre ya no necesita la respuesta
			Conexion[PROCESOS[j]].nIdPadre=-1;
			sprintf(szAux,"Proceso muerto %i",PROCESOS[j]);
			WriteLog(id,szAux);
			//Conexion[PROCESOS[j]].nTipoProceso=PROC_MUERTO;
		}
	}
	//WriteError(id,"MultiProposito5");
	//ImprimeMemoria(id);
	
	sprintf(szAux,"Fin Proceso Multi %i",n);
	WriteLog(id,szAux);
	//ImprimeXML(xml);
	if (xml!=NULL) *nProxSec=pQuerys->nSecOk;
	else *nProxSec=pQuerys->nSecError;
	return xml;
fin:
	*nProxSec=pQuerys->nSecError;
	xml2=CierraXML(xml2);
	return xml;
}

//Realiza una recusion llama a otro servicio de querys
Tipo_XML *AplicaServicioTipo8(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
	int bContesta=0;
	char szAux[200];
	int nServicio;
	int nStatus;
	Tipo_Data *pSql;
 	//WriteMensajeApp(id,"Entra a AplicaServicioTipo8");

	*nProxSec=pQuerys->nSecError;
	nServicio=pQuerys->nServicio;
	//si el servicio es 0, verificamos si viene de manera dinamica...
	if (nServicio==0)
	{
		Tipo_XML *xml2=NULL;
		//Solo por si viene como parametros
		pSql=ReemplazaTagsStr1(xml,pQuerys->szQuery);
		xml2=ProcesaInputXML1(xml2,pSql->data);
		pSql=LiberaData(pSql);

		//Obtengo el dato del servicio a ejecutar
		GetIntXML(xml2,"EJECUTA",&nServicio);
		xml2=CierraXML(xml2);
	}
	
	xml=AplicaQuerysServicio(id,xml,nServicio,&bContesta,&nStatus);
	if (!nStatus) 
	{
		sprintf(szAux,"Falla llamada a servicio %i",pQuerys->nServicio);
		WriteLog(id,szAux);
		return xml;
	}
	sprintf(szAux,"Fin Ejecucio servicio %i",pQuerys->nServicio);
	WriteLog(id,szAux);
 	//WriteMensajeApp(id,szAux);
	
	*nProxSec=pQuerys->nSecOk;
	return xml;
}

//Lee un archivo 
Tipo_XML *AplicaServicioTipo7(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
	Tipo_Formatos *pForIn;
	char szError[1024];
	Tipo_Data *pFile=NULL;
	Tipo_Data *pNombreFile=NULL;
	FILE *f;
		
	pNombreFile=ReemplazaTagsStr1(xml,pQuerys->szQuery);
	//ReemplazaTagsStr(xml,pQuerys->szQuery,szFile);
	*nProxSec=pQuerys->nSecError;
	pForIn=LeeFormato(id,pQuerys->nForSalida);
	if (!pForIn)
	{
		sprintf(szError,"No existe formato %i para leer archivos tipo %s",pQuerys->nForSalida,pNombreFile->data);
		pNombreFile=LiberaData(pNombreFile);
		WriteLog(id,szError);
		return xml;
	}

	pFile=LeeArchivo(pNombreFile->data);
	if (!pFile)
	{
		sprintf(szError,"El Archivo %s no puede ser leido",pNombreFile->data);
		WriteLog(id,szError);
		printf("%s\n\r",szError);
		pNombreFile=LiberaData(pNombreFile);
		return xml;
	}
	pNombreFile=LiberaData(pNombreFile);

	xml=AplicaFormatoEntrada(id,xml,pFile->data,pForIn,pFile->nLenData);	
	pFile=LiberaData(pFile);
	*nProxSec=pQuerys->nSecOk;
	return xml;
}


//Escribe un archivo 
Tipo_XML *AplicaServicioTipo4(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts,char szOpenFile[])
{
	Tipo_Formatos *pForIn;
	char szAux[100];
	struct stat buf_stat;
	char szError[1024];
	char szDirectorio[4196];
	char szLinea[4196];
	Tipo_Data *pData=NULL;
	int sts1;
	int nLen,i;
	FILE *f;
	Tipo_Data *pFile=NULL;
       	    FILE *fp;
		
	pFile=ReemplazaTagsStr1(xml,pQuerys->szQuery);
	*nProxSec=pQuerys->nSecError;
	if (!pFile) return xml;
	pForIn=LeeFormato(id,pQuerys->nForSalida);
	if (!pForIn)
	{
		sprintf(szError,"No existe formato %i para archivos tipo %s",pQuerys->nForSalida,pFile->data);
		printf("%s\n\r",szError);
		WriteLog(id,szError);
		WriteMensajeApp(id,szError);
		xml=InsertaDataXML(xml,"_STS_FILE_","NK-FORMATO");
		return xml;
	}
	WriteMensajeApp(id,pFile->data);
	//Obtengo el directorio y si no existe lo creo
	nLen=strlen(pFile->data);
	for(i=nLen;i>0;i--)
	{
		if (pFile->data[i]=='/') 
		{
			//Le Agrego el /
			i++;
			break;
		}
	}
	//Obtengo el directorio
	memcpy(szDirectorio,pFile->data,i);
	szDirectorio[i]=0;
	WriteLog(id,"Directorio");
	WriteLog(id,szDirectorio);
	//WriteMensajeApp(id,szDirectorio);

	//Siempre creo el directorio
        sprintf(szLinea,"mkdir -p %s",szDirectorio);
        //WriteMensajeApp(id,szLinea);
        fp = popen(szLinea, "r");
        if (fp == NULL)
        {
        	WriteMensajeApp(id,szLinea);
        	WriteLog(id,"Falla Ejecutar Comando");
                WriteMensajeApp(id,"Falla Ejecutar Comando");
        }
        else pclose(fp);

	/*
       //Verifico si existe el direcotrio
       stat(szDirectorio,&buf_stat);
       //Si no es un directorio
       if (!S_ISDIR(buf_stat.st_mode))
       {
       	    FILE *fp;
            WriteLog(id,"No existe el directorio");
            WriteLog(id,szDirectorio);
            WriteLog(id,"Se crea el directorio");
            sprintf(szLinea,"mkdir -p %s",szDirectorio);
	    WriteMensajeApp(id,szLinea);
            fp = popen(szLinea, "r");
            if (fp == NULL) 
	    {
		WriteLog(id,"Falla Ejecutar Comando");
		WriteMensajeApp(id,"Falla Ejecutar Comando");
	    }
            else pclose(fp);
            stat(szDirectorio,&buf_stat);
            //Verifico si esta creado
       	    if (!S_ISDIR(buf_stat.st_mode))
            {
                  WriteLog(id,"Falla Creacion del Directorio");
		  WriteMensajeApp(id,"Falla Creacion de Directorio");
		  xml=InsertaDataXML(xml,"_STS_FILE_","FALLA_CREAR_DIR");
		  pFile=LiberaData(pFile);
		  return xml;
            }
            else 
	    {
		WriteLog(id,"Dir Creado OK");
		WriteMensajeApp(id,"Dir Creado OK");
	    }
	}
	else WriteLog(id,"Dir OK");
	*/

	//Crea Archivo o AbreArchivo
	f= fopen(pFile->data,szOpenFile);
	if (!f)
        {
		//struct stat fileStat;
		sprintf(szError,"El Archivo %s no puede ser creado",pFile->data);
		WriteLog(id,szError);
		WriteMensajeApp(id,szError);
		printf("%s\n\r",szError);
		//Verificamos si esta el archivo
		f= fopen(pFile->data,"r");
                if (!f) 
	        {
			WriteLog(id,"Probablemente no tengo permiso de escritura");
		        WriteMensajeApp(id,"Probablemente no tengo permiso de escritura");
			xml=InsertaDataXML(xml,"_STS_FILE_","FALLA_CREACION_FILE");
			pFile=LiberaData(pFile);
			return xml;
		}

		/*
		if (fstat((int)f,&fileStat) < 0)
		{
			WriteLog(id,"Falla fstat");
			xml=InsertaDataXML(xml,"_STS_FILE_","FALLA_CREACION_FILE");
			fclose(f);
			pFile=LiberaData(pFile);
			return xml;
		}
		*/
			
		//El file ya existe y no lo puede sobreescribir
		WriteLog(id,"File ya existia");
		WriteMensajeApp(id,"File ya existia");
		xml=InsertaDataXML(xml,"_STS_FILE_","FILE_YA_EXISTE");
		//sprintf(szAux,"%d",fileStat.st_size);
		//xml=InsertaDataXML(xml,"_STS_FILE_BYTES_",szAux);
		fclose(f);
		*sts=2;
		*nProxSec=pQuerys->nSecOk;
		pFile=LiberaData(pFile);
                return xml;
	}

	//memset(szLinea,0,sizeof(szLinea));
	//AplicaFormatoSalida(id,szLinea,xml,pForIn,&nLen);
	pData=CreaData();
	pData=AplicaFormatoSalidaVar(id,pData,xml,pForIn,&nLen);
	if (nLen>0)
	{
		nLen=fwrite(pData->data,sizeof(char),pData->nLenData,f);
		sprintf(szError,"Bytes Escritos %ld Largo data %ld",nLen,pData->nLenData);
		WriteLog(id,szError);
		WriteMensajeApp(id,szError);
		//Si el numero de bytes escritos es distinto a lo que se requeria escribir, borra el archivo
		if (nLen!=pData->nLenData)
		{
			fclose(f);
			//Borro el archivo
			sts1=remove(pFile->data);
			if (sts1<0)
			{
				WriteMensajeApp(id,"Falla Borrar Archivo");	
				xml=InsertaDataXML(xml,"_STS_FILE_","FALLA_BORRAR");
			}
			else
			{
				WriteMensajeApp(id,"Borrado OK");
				xml=InsertaDataXML(xml,"_STS_FILE_","FALLA_ESCRITURA");
			}
		}
		else
		{
			sprintf(szError,"%i",nLen);
			xml=InsertaDataXML(xml,"_STS_FILE_BYTES_WRITTEN_",szError);
			fclose(f);
			xml=InsertaDataXML(xml,"_STS_FILE_","OK");
		}
	}
	*sts=2;
	xml=InsertaDataXML(xml,"FILE",pFile->data);
	pFile=LiberaData(pFile);
	pData=LiberaData(pData);
	*nProxSec=pQuerys->nSecOk;
	return xml;
}

//Autoriza Servicio
Tipo_XML *AplicaServicioTipo3(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
	Tipo_Servicio stServ;
	Tipo_Formatos *pForIn;
	Tipo_Formatos *pForOut;
        Tipo_XML *xml_aux=NULL;
	char szAux[100];
	int nSts;
	
	stServ.nTx=pQuerys->nServicio;

	*nProxSec=pQuerys->nSecError;
	if (!BuscaServicio(id,&stServ,BUSCA_TX))
	{
		sprintf(szAux,"No existe servicioi %i",pQuerys->nServicio);
		WriteLog(id,szAux);
		return xml;
	}

 	//Si la tx entrante tiene el TAG __IP_CONEXION_CLIENTE__, se cambia la IP de conexion del servicio
        xml_aux=GetStrXMLData(xml,"__IP_CONEXION_CLIENTE__");
        if (xml_aux)
        {
                if (xml_aux->nLenData>0)
                {
                        if (xml_aux->nLenData>sizeof(stServ.szIp))
                        {
                                memcpy(stServ.szIp,xml_aux->pData,sizeof(stServ.szIp));
                                stServ.szIp[sizeof(stServ.szIp)]=0;
                        }
                        else sprintf(stServ.szIp,"%s",xml_aux->pData);
                }
        }
        //Limpio la variable
        xml=InsertaDataXML(xml,"__IP_CONEXION_CLIENTE__","");

        //Si la tx entrante tiene el TAG __IP_PORT_CLIENTE__, se cambia el puerto de conexion del servicio
        xml_aux=GetStrXMLData(xml,"__IP_PORT_CLIENTE__");
        if (xml_aux)
        {
                if (xml_aux->nLenData>0)
                {
                        stServ.nPort=atoi(xml_aux->pData);
                }
        }
        //Limpio la variable
        xml=InsertaDataXML(xml,"__IP_PORT_CLIENTE__","");


	*sts=1;
	xml=AutorizaServicio1(id,xml,&stServ,&nSts);
	if (!nSts) *nProxSec=pQuerys->nSecError;
	else *nProxSec=pQuerys->nSecOk;
	return xml;
}

//Autoriza Servicio con 
Tipo_XML *AplicaServicioTipo2(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
	Tipo_Servicio stServ;
	Tipo_Formatos *pForIn;
	Tipo_Formatos *pForOut;
        Tipo_XML *xml_aux=NULL;
	char szAux[100];
	int sts1;
	
	stServ.nTx=pQuerys->nServicio;

	*nProxSec=pQuerys->nSecError;
	if (!BuscaServicio(id,&stServ,BUSCA_TX))
	{
		sprintf(szAux,"No existe servicioi %i",pQuerys->nServicio);
		WriteLog(id,szAux);
		return xml;
	}

	ImprimeMemoria(id,"Antes de LeeFormato1");
	pForIn=LeeFormato(id,pQuerys->nForSalida);
	ImprimeMemoria(id,"Antes de LeeFormato2");
	pForOut=LeeFormato(id,pQuerys->nForAck);
	ImprimeMemoria(id,"Despues de LeeFormato2");


        //Si la tx entrante tiene el TAG __IP_CONEXION_CLIENTE__, se cambia la IP de conexion del servicio
	xml_aux=GetStrXMLData(xml,"__IP_CONEXION_CLIENTE__");
	if (xml_aux)
	{
		if (xml_aux->nLenData>0)
		{
			if (xml_aux->nLenData>sizeof(stServ.szIp))
			{
				memcpy(stServ.szIp,xml_aux->pData,sizeof(stServ.szIp));
				stServ.szIp[sizeof(stServ.szIp)]=0;
			}
			else sprintf(stServ.szIp,"%s",xml_aux->pData);
		}
	}
	//Limpio la variable
	xml=InsertaDataXML(xml,"__IP_CONEXION_CLIENTE__","");
        
	//Si la tx entrante tiene el TAG __IP_PORT_CLIENTE__, se cambia el puerto de conexion del servicio
	xml_aux=GetStrXMLData(xml,"__IP_PORT_CLIENTE__");
	if (xml_aux)
	{
		if (xml_aux->nLenData>0)
		{
			stServ.nPort=atoi(xml_aux->pData);
		}
	}
	//Limpio la variable
	xml=InsertaDataXML(xml,"__IP_PORT_CLIENTE__","");

	*sts=1;
	xml=AutorizaServicioXML(id,xml,pForIn,pForOut,&stServ,&sts1);
	ImprimeMemoria(id,"Despues de AutorizaServicioXML");
	//ImprimeXML(xml1);
	if (!sts1) *nProxSec=pQuerys->nSecError;
	else *nProxSec=pQuerys->nSecOk;
	return xml;
}

//Ejecuta una Query
Tipo_XML *AplicaQueryTipo1(int id,Tipo_XML *xml,Tipo_Querys *pQuerys,int *nProxSec,int *sts)
{
	int nBaseTmp;
	int nTimeoutDBTmp;
	Tipo_Data *pData=NULL;
	Tipo_XML *pXml=NULL;
	Tipo_XML *xml_aux=NULL;
	int nSecOk;
	char szTmp[100];
	int sts1;

	*nProxSec=pQuerys->nSecError;
	//WriteLog(id,"ReemplazaTagsStr1");
	//WriteLog(id,pQuerys->szQuery);
	//ImprimeMemoria(id);
	//ImprimeXML1(xml);
	ImprimeMemoria(id,"ReemplazaTagsStr1");
	pData=ReemplazaTagsStr1(xml,pQuerys->szQuery);
	//WriteError(id,"ReemplazaTagsStr2");
	//ImprimeMemoria(id);
	if (pData==NULL)
	{
		WriteLog(0,"ERROR en ReemplazaTagsStr");
		return xml;
	}
	//Si tengo un TAG __TIMEOUT_SERV_PXML__ cambiamos el valor de el timeout de la conexion nTimeoutBaseDatos por el valor del TAG
	nTimeoutDBTmp=Conexion[id].nTimeoutBaseDatos;
	xml_aux=GetStrXMLData(xml,"__TIMEOUT_SERV_PXML__");
        //Si existe el TAG ..
        if (xml_aux)
        {
        	if (strlen(xml_aux->pData)>0)
                { 
			nTimeoutDBTmp=Conexion[id].nTimeoutBaseDatos;
			Conexion[id].nTimeoutBaseDatos=atoi(xml_aux->pData);	
			sprintf(szTmp,"Cambia Timeout BD de %i a %i",nTimeoutDBTmp,Conexion[id].nTimeoutBaseDatos);
			WriteLog(id,szTmp);
        		xml=InsertaDataXML(xml,"__TIMEOUT_SERV_PXML__","");
		}
	}

   	nBaseTmp=GET_DATABASE(id);
	SET_GLOBAL_DATABASE(id,pQuerys->nBaseQuery);
	nSecOk=pQuerys->nSecOk;
	if (pQuerys->nEsperaOutput==1 || pQuerys->nEsperaOutput==6)
	{
		//WriteError(id,"GetRecord");
		//ImprimeMemoria(id);
		//LA funcion GetRecordMulti envia a la base GET_RECORD_MULTI que permite leer muchos registros y los pone con numeros segun el numero de registro
		if (pQuerys->nEsperaOutput==6) xml=GetRecordMulti(id,pData->data,xml,&sts1);
		else xml=GetRecord(id,pData->data,xml,&sts1);
		pData=LiberaData(pData);
		ImprimeMemoria(id,"Despues ReemplazaTagsStr1");
		//WriteError(id,"GetRecord1");
		//ImprimeMemoria(id);
		if (pQuerys->nValidaOutput)
		{
		   ImprimeMemoria(id,"Despues ReemplazaTagsStr1-1");
		   if (sts1==0) goto fin;
		   
		   ImprimeMemoria(id,"Despues ReemplazaTagsStr1-2");
		   //Si existe TAG __XML__ entonces viene un XML serializado TMS[4]=0001####CAJA[3]=000###
		   //entonces lo subimos al XML
		   //pXml->pData="TMS[4]=0001####CAJA[3]=000###"
		   //Si viene un JSON..
		   pXml=GetStrXMLData(xml,"__JSON__");
		   if (pXml!=NULL)
                   {
			if (pXml->nLenData>0) 
			{
				xml=DeserializaJSON(id,xml,pXml->pData);
				xml=InsertaDataXML(xml,"__JSON__","");
			}
		   }
		   
		   //Si viene TAG __JSON_NUEVO__, considera solo este para procesar
		   pXml=GetStrXMLData(xml,"__JSON_NUEVO__");
		   if (pXml!=NULL)
                   {
			if (pXml->nLenData>0) 
			{
				Tipo_XML *xml1=NULL;
				xml1=DeserializaJSON(id,xml1,pXml->pData);
				xml=CierraXML(xml);
                                xml=xml1;
			}
		   }
			


		   ImprimeMemoria(id,"Antes de GetStrXMLData");
	           pXml=GetStrXMLData(xml,"__XML__");
		   ImprimeMemoria(id,"Despues de GetStrXMLData");
		   if (pXml!=NULL)
		   {
			if (strlen(pXml->pData)>0) 
			{
				ImprimeMemoria(id,"DeserializaXML");
				xml=DeserializaXML(xml,pXml->pData);
				ImprimeMemoria(id,"DeserializaXML Out");
		   		//WriteLog(id,"__________________________________________");
				//ImprimeXML(xml);
		   		//WriteLog(id,"__________________________________________");
				//Ahora Borrar el tag __XML__ para evitar que se vuelva a subir a memoria
				ImprimeMemoria(id,"Antes de Limpiar");
				xml=InsertaDataXML(xml,"__XML__","");
				ImprimeMemoria(id,"Despues de Limpiar");
			}
		   }
	           //Si viene XMLNUEVO entoces borra todo el xml anterior y solo 
		   //Consdera el XMLNUEVO como resultante
		   pXml=GetStrXMLData(xml,"__XML_NUEVO__");
		   if (pXml!=NULL)
		   {
			if (strlen(pXml->pData)>0) 
			{
				Tipo_XML *xml1=NULL;
				WriteLog(id,"Borra XML Actual");
				ImprimeMemoria(id,"DeserializaXML BorraXML");
				xml1=DeserializaXML(xml1,pXml->pData);
				ImprimeMemoria(id,"DeserializaXML BorraXML Out");
				xml=CierraXML(xml);
				xml=xml1;
			}
		   }
		   
		   //Si contiene un tag especial de retorno exitoso
		   //sigue a este TAG siempre que retorno exitoso sea menos uno
		   if (pQuerys->nSecOk==(-1))
		   {
			   GetIntXML(xml,"__SECUENCIAOK__",&nSecOk);
			   //Limpio para evitar problemas
			   xml=InsertaDataXML(xml,"__SECUENCIAOK__","0");
		   }

		}
	}
	else if (pQuerys->nEsperaOutput==2)
	{
		int nTotal;
   		xml=GetRecords(id,pData->data,&nTotal,xml,&sts1);
		pData=LiberaData(pData);
		if (pQuerys->nValidaOutput)
		{
		   if (sts1==0) goto fin;
		   else if (nTotal==0) goto fin;
		}
	}
	else if (pQuerys->nEsperaOutput==3)
	{
		int nTotal;
   		xml=GetRecords1(id,pData->data,&nTotal,xml,&sts1);
		pData=LiberaData(pData);
		if (pQuerys->nValidaOutput)
		{
		   if (sts1==0) goto fin;
		   else if (nTotal==0) goto fin;
		}
	}
	//Si viene tipo de output 4 entonces solo considera responder la salida de este query
        //Obviando lo que venia antes
        else if (pQuerys->nEsperaOutput==4)
        {
                xml=GetRecord(id,pData->data,xml,&sts1);
                pData=LiberaData(pData);

                if (pQuerys->nValidaOutput)
                {
                   if (sts1==0) goto fin;

                   //Si existe TAG __XML__ entonces viene un XML serializado TMS[4]=0001####CAJA[3]=000###
                   //entonces lo subimos al XML
                   //pXml->pData="TMS[4]=0001####CAJA[3]=000###"
                   pXml=GetStrXMLData(xml,"__XML__");

                   if (pXml!=NULL)
                   {
                        if (strlen(pXml->pData)>0)
                        {
                                Tipo_Data *pDataAux;
                                WriteLog(id,pXml->pData);
                                pDataAux=NewData(pXml->pData);

                                //xml=InsertaDataXML(xml,"__XML__","");
                                xml=CierraXML(xml);
                                xml=DeserializaXML(xml,pDataAux->data);
                                //WriteLog(id,"__________________________________________");
                                //ImprimeXML(xml);
                                //WriteLog(id,"__________________________________________");
                                pDataAux=LiberaData(pDataAux);
                        }
                   }

                   //Si contiene un tag especial de retorno exitoso
                   //sigue a este TAG siempre que retorno exitoso sea menos uno
                   if (pQuerys->nSecOk==(-1))
                   {
                           GetIntXML(xml,"__SECUENCIAOK__",&nSecOk);
			   //Limpio para evitar problemas
			   xml=InsertaDataXML(xml,"__SECUENCIAOK__","0");

                   }

                }
        }
        //Con multiple retorno
        else if (pQuerys->nEsperaOutput==5)
        {
                int nTotal;
		Tipo_XML *xml2=NULL;
		//sprintf(szTmp,"xml=%x",xml);
		//WriteLog(id,szTmp);
                xml2=GetMultiple(id,pData->data,&nTotal,xml2,&sts1);
		//sprintf(szTmp,"1xml=%x",xml2);
		//WriteLog(id,szTmp);
                ImprimeXML(xml);
                
		pData=LiberaData(pData);

		//Solo inserto el primer retorno el campo0 que viene un xml2
                //pXml->pData="TMS[4]=0001####CAJA[3]=000###"
                pXml=GetStrXMLData(xml2,"0");
                if (pXml!=NULL)
                {
                        if (strlen(pXml->pData)>0)
                        {
                                Tipo_Data *pDataAux;
                                //WriteLog(id,pXml->pData);
                                pDataAux=NewData(pXml->pData);

                                //xml=InsertaDataXML(xml,"__XML__","");
                                //xml=CierraXML(xml);
                                xml=DeserializaXML(xml,pDataAux->data);
                                //WriteLog(id,"__________________________________________");
                                //ImprimeXML(xml);
                                //WriteLog(id,"__________________________________________");
                                pDataAux=LiberaData(pDataAux);
                        }
                }

		xml2=CierraXML(xml2);

		
                if (pQuerys->nValidaOutput)
                {
                   if (sts1==0) goto fin;
                   else if (nTotal==0) goto fin;
                }
        }
	else 
	{
		sts1=SendDatabase(id,pData->data);
		pData=LiberaData(pData);
		if (pQuerys->nValidaOutput)
		{
			if (!sts1) goto fin;
			*sts=1;
		}
	}
	SET_GLOBAL_DATABASE(id,nBaseTmp);
	//Vuelo Timeout a la Normalidad
	Conexion[id].nTimeoutBaseDatos=nTimeoutDBTmp;			
	*nProxSec=nSecOk;
	return xml;
fin:
        ImprimeMemoria(id,"Fin Despues ReemplazaTagsStr1-2");
	SET_GLOBAL_DATABASE(id,nBaseTmp);
	//Vuelo Timeout a la Normalidad
	Conexion[id].nTimeoutBaseDatos=nTimeoutDBTmp;			
	return xml;
}


Tipo_XML *AplicaQuerys(int id,int nSocket,Tipo_XML *xml,Tipo_Querys *pQueryOrg,int *sts,int *bContesta)
{
	int nProxSec=0;
	int nVerifica=0;
	Tipo_Querys *pQuerys=pQueryOrg;
	char szAux[1024];
	int bExisteQuery=0;
	int nMaxRecursion=global.nMaximaRecursion;
	//int bContestaAux=0;
	Tipo_XML *xml_aux;
	Tipo_XML *xml_aux1;
	sprintf(szAux,"AplicaQuerys Socket=%i",nSocket);	
	WriteLog(id,szAux);
	//xml1=StrcpyXML(xml,xml1);
	*bContesta=0;
	memset(Conexion[id].szError,0,sizeof(Conexion[id].szError));
	ImprimeMemoria(id,"AplicaQuerys");
	do
	{
		if (pQuerys==NULL) 
		{
			if (!nVerifica) break;
			ImprimeMemoria(id,"Recursion en Querys");
			sprintf(szAux,"Recursion en Querys Secuencia=%i Tx=%s",nProxSec,pQuerys->szLlave);
			WriteLog(id,szAux);
			//WriteMensajeApp(id,szAux);
			if (!bExisteQuery) 
			{
				ImprimeMemoria(id,"no existe query");
				sprintf(szAux,"No existe Query Sec %i:%s",nProxSec,pQuerys->szLlave);
				WriteLog(id,szAux);
				WriteMensajeApp(id,szAux);
				break;
			}
			//Si el parametro global.nMaximaRecursion es -1 no lo valida y seran infinitas recursiones
			if (nMaxRecursion!=(-1))
			{
				if (nMaxRecursion==0)
				{
					ImprimeMemoria(id,"maximo de recursion");
					WriteLog(id,"Alcanza maximo de recursion 20");
					WriteMensajeApp(id,szAux);
					break;
				}
				nMaxRecursion--;
			}
			pQuerys=pQueryOrg;
			continue;
		}
		//La primera vez no verifica la seuencia
		if (nVerifica)
		{
			//sprintf(szAux,"Proximo Query Sec=%i Actual=%i",nProxSec,pQuerys->nSecuencia);
			//WriteLog(id,szAux);
			if (pQuerys->nSecuencia!=nProxSec) goto fin;
		}
		printf("Aplica Querys Secuencia %i\n\r",nProxSec);
		sprintf(szAux,"Secuencia %i:%s TimeoutDb:%i",nProxSec,pQuerys->szLlave,Conexion[id].nTimeoutBaseDatos);
		//Escribe para el LOG que esta ejecutando
		WriteLog(id,szAux);
		sprintf(szAux,"F_%s:SEC_%i:BD_%i:",pQuerys->szLlave,pQuerys->nSecuencia,pQuerys->nBaseQuery);
		switch (pQuerys->nTipo)
		{	
			case 1:	
				strcat(szAux,"QUERY");
				break;
			case 2:
				strcat(szAux,"SERV");
				break;
			case 3:
				strcat(szAux,"SERV_PXML");
				break;
			case 4:
				strcat(szAux,"WRITE_FILE");
				break;
			case 5:
				strcat(szAux,"APPEND_FILE");
				break;
			case 6:
				strcat(szAux,"QUERY_RSP_CONTINUE");
				break;
			case 7:
				strcat(szAux,"READ_FILE");
				break;
			case 8:
				strcat(szAux,"FUNC");
				break;
			case 9:
				strcat(szAux,"MULTI_HILO");
				break;
			case 10:
				strcat(szAux,"SCRIPT");
				break;
			case 11:
				strcat(szAux,"WAIT_FILE");
				break;
			case 12:
				strcat(szAux,"CLOSE __SOCKETOPEN__");
				break;
			case 13:
				strcat(szAux,"CALL SO");
				break;
		}
		sprintf(Conexion[id].szFlujoActual,"%s",szAux);
		xml=InsertaDataXML(xml,"__FLUJO_ACTUAL__",szAux);
		//WriteMensajeApp(id,szAux);
		//ImprimeMemoria(id,szAux);

		//WriteError(id,szAux);
		//ImprimeMemoria(id);
		bExisteQuery=1;
		//Es solo un query
		if (pQuerys->nTipo==1) 
		{
			xml=AplicaQueryTipo1(id,xml,pQuerys,&nProxSec,sts);
		}
		//un servicio con formatos
		else if (pQuerys->nTipo==2) 
		{
			ImprimeMemoria(id,"Antes de AplicaQueryTipo2");
			xml=AplicaServicioTipo2(id,xml,pQuerys,&nProxSec,sts);
			ImprimeMemoria(id,"Despues de AplicaQueryTipo2");
		}
		//Aplica el servicio con data XML nativo
		else if (pQuerys->nTipo==3)
		{
			xml=AplicaServicioTipo3(id,xml,pQuerys,&nProxSec,sts);
		}
		//Genera un archivo
		else if (pQuerys->nTipo==4)
		{
			xml=AplicaServicioTipo4(id,xml,pQuerys,&nProxSec,sts,"w+");
			WriteLog(id,"Paso1");
		}
		//Append en un archivo
		else if (pQuerys->nTipo==5)
		{
			xml=AplicaServicioTipo4(id,xml,pQuerys,&nProxSec,sts,"a+");
		}
		//Aplica un query, contesta y luego sigue...
		else if (pQuerys->nTipo==6)
		{
			xml=AplicaQueryTipo1(id,xml,pQuerys,&nProxSec,sts);
			//bContestaAux=1;
			xml=InsertaDataXML(xml,"__SOCKET_RESPONSE__","__XMLCOMPLETO__");
			//*bContesta=1;
		}
		//Lee desde un archivo...
		else if (pQuerys->nTipo==7)
		{
			xml=AplicaServicioTipo7(id,xml,pQuerys,&nProxSec,sts);
		}
		//Realiza una llamada a otro servicio
		//hace una recursion
		else if (pQuerys->nTipo==8)
		{
			xml=AplicaServicioTipo8(id,xml,pQuerys,&nProxSec,sts);
		}
		//Crea procesos para antender de manera simultanea 
		//los servicio de entrada
		else if (pQuerys->nTipo==9)
		{
			xml=AplicaServicioTipo9(id,xml,pQuerys,&nProxSec);
		}
		//Realiza un system contra el sistema
		else if (pQuerys->nTipo==10)
		{
			xml=AplicaServicioTipo10(id,xml,pQuerys,&nProxSec,sts);
		}
		//Espera y lee un archivo
		//si no existe lo espera.....
		else if (pQuerys->nTipo==11)
		{
			xml=AplicaServicioTipo11(id,xml,pQuerys,&nProxSec,sts);
		}
		//Cierra Socket __SOCKETOPEN__ independiente que hilo lo abrio
		//busca en el XML el tag y cierra el socket
		else if (pQuerys->nTipo==12)
		{		
			xml=CierraSocketTipo12(id,xml,pQuerys,&nProxSec,sts);
		}
		//Ejecuta un so..
		else if (pQuerys->nTipo==13)
		{
			xml=AplicaServicioTipo13(id,xml,pQuerys,&nProxSec,sts);
		}
		//Evaluador de condiciones
		else if (pQuerys->nTipo==14)
		{
			xml=AplicaServicioTipo14(id,xml,pQuerys,&nProxSec,sts);
		}
		//Borra un campo en el XML de forma local (sin llamar a una BD)
		else if (pQuerys->nTipo==15)
		{
			xml=AplicaServicioTipo15(id,xml,pQuerys,&nProxSec,sts);
		}
		else
		{
			WriteLog(id,"Tipo Servicio NO DEFINIDO");
			WriteMensajeApp(id,"Tipo Servicio NO DEFINIDO");
			nProxSec=0;
		}
		ImprimeMemoria(id,"Antes de global.nError");
		/*
		//Si hay errror insertamos a xml1 un tag de error.
		if (global.nError)
		{
			xml=InsertaDataXML(xml,"ERROR",Conexion[id].szError);
			global.nError=0;
		}
		*/


		//Si viene el TAG __SOCKET_RESPONSE__ entonces contestamos inmediatamente
		//Si dentro del TAG viene __XMLCOMPLETO__ se responde todo el XML, sino
		//Se saca la respuesta y se contesta solo el campo que viene dentro
		ImprimeMemoria(id,"Antes de __SOCKET_RESPONSE__");
		xml_aux=NULL;
		xml_aux=GetStrXMLData(xml,"__SOCKET_RESPONSE__");
		//Si existe el TAG ..
		if (xml_aux)
		{
			if (strlen(xml_aux->pData)>0) 
			{
				//Verifico si viene __XMLCOMPLETO__
				if (memcmp(xml_aux->pData,"__XMLCOMPLETO__",15)==0)
				{
					WriteLog(id,"Responde Servicio XML Completo");
					WriteMensajeApp(id,"Responde a Servicio Xml Completo");
					SendSocketXML1(id,nSocket,xml);
					*bContesta=1;
				}
				else
				{
					//Obtengo solo el TAG que se quiere responder
					xml_aux1=NULL;
					xml_aux1=GetStrXMLData(xml,xml_aux->pData);
					if (xml_aux1)
					{
						Tipo_XML *xml_aux2=NULL;
						//Determinamos el tipo de respuesta que se requiere
						xml_aux2=GetStrXMLData(xml,"__TIPO_SOCKET_RESPONSE__");
						if (xml_aux2)
						{
							int sts;
							if (memcmp(xml_aux2->pData,"SCGI",4)==0)
							{
								
								sts=send(nSocket,xml_aux1->pData,xml_aux1->nLenData,0);
								if (sts<0)
								{
									sprintf(szAux,"Falla Respuesta Servicio SCGI (Plano) sts=%i",sts);
									WriteLog(id,szAux);
									WriteMensajeApp(id,szAux);
								}
								else
								{
									sprintf(szAux,"Respuesta OK Servicio SCGI (Plano) sts=%i",sts);
									WriteLog(id,szAux);
									WriteMensajeApp(id,szAux);
								}
								WriteLog(id,xml_aux1->pData);
								close(nSocket);
								//2015-12-15 KMS-FAY-DAO
								//Debo invalidar el socket para que no se uses de forma posterior
								Conexion[id].nSocket=-1;

							}
							*bContesta=1;
							
						}
						else
						{
							SendSocketXML2(id,nSocket,xml_aux1);	
							*bContesta=1;
						}
					}
					else 
					{
						WriteLog(id,"No se encutra TAG de __SOCKET_RESPONSE__");
						WriteLog(id,xml_aux->pData);
					}	
				}
			}
			//Cmabio el nombre de __SOCKET_RESPONSE__ para que no entre  de nuevo
			xml_aux->szCampo[0]='X';
		}
		ImprimeMemoria(id,"Despues de __SOCKET_RESPONSE__");
		//sprintf(szAux,"Proximo Query Sec %i",nProxSec);
		//WriteLog(id,szAux);
		//xml1=UpdateXML(xml1,xmlq);
		//xmlq=CierraXML(xmlq);
		/*
		if (bContestaAux)
		{
			WriteLog(id,"Responde Servicio");
			WriteMensajeApp(id,"Responde a Servicio");
			SendSocketXML1(id,nSocket,xml);
			bContestaAux=0;
		}
		*/
		//Escribe LOG de Aplicacion con el tag _LOG_
		xml=WriteLogApp(id,xml);
		ImprimeMemoria(id,"Despues de WriteLogApp");
fin:
		if (nProxSec==0) break;	
		pQuerys=pQuerys->pNext;
		nVerifica=1;
	}while(1);

	CloseDatabase(id);
	ImprimeMemoria(id,"CloseDatabase");
	return xml;
}

Tipo_XML *AplicaQuerysServicio(int id,Tipo_XML *xml,int nTx,int *bContesta,int *nStatus)
{
	Tipo_Querys *pQuerys;
	Tipo_Servicio stServ;
	int nSocket=Conexion[id].nSocket;
	char szTmp[200];
	int sts;
	int nLlave=0;
	int nTimeoutTemp;

	stServ.nTx=nTx;
	*nStatus=0;
	ImprimeMemoria(id,"Antes de BuscaServicio");
	//Identifica cual es la llave de query de ese servicio
	if (BuscaServicio(id,&stServ,BUSCA_TX)) nLlave=stServ.nLlaveQuery;
	if (nLlave==0) nLlave=nTx;
	

	ImprimeMemoria(id,"Antes de LeeQuery");
	pQuerys=LeeQuery(id,nLlave);
	if (pQuerys==NULL)
	{
		sprintf(szTmp,"No existen querys para el servicio [%i] en isys_querys_tx",nTx);
		printf("%s\n\r",szTmp);
		WriteLog(id,szTmp);
		WriteMensajeApp(id,szTmp);
		return xml;
	}
	xml=AplicaQuerys(id,nSocket,xml,pQuerys,&sts,bContesta);
	*nStatus=1;
	return xml;
}
