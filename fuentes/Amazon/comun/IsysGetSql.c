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

#ifdef _INCRUSTA_POSTGRES_
Tipo_XML *QueryDatabase1(int id,char szSql[],char szCampo[],char szError[])
{
	if (Conexion[id].nAbierta==0)
	{
		if (!Conexion[id].nAbierta)
	        {
	            WriteLog(id,"Abre Conexion BD");
	            Conexion[id].conn=OpenDatabase(id,Conexion[id].nSocket,szBaseDatos,global.szIpBd);
	        }
		if (Conexion[id].conn==NULL)
		{
			printf("(%02i) Falla Conexion a BD",id);
			WriteLog(id,"Falla Conexion a BD");
			goto fin;
		}
		Conexion[id].nAbierta=1;
	}

		   



Tipo_XML *GetRecords(int id,char szSql[],int *nTotal)
{
	Tipo_XML *xml=NULL,*xml1=NULL,*xml2=NULL;
	char szError[200];
	int sts,i;
	char szAux[MAX_BUFFER];
	char szCampo[MAX_LEN_CAMPO],szCampo1[200];
	int nLog=LOG(id);
	char szTmp[200];

	WriteLog(id,"QueryDatabase1**");

	xml1=QueryDatabase1(id,szSql,"QUERY",szError);
	if (xml1==NULL) 
	{
		WriteLog(id,"Error en la base :");
		WriteLog(id,szError);
		WriteLog(id,szSql);
		sprintf(szSql,"%s",szError);
		goto close;
	}
	i=0;
	SET_LOG(id,0);
	//xml1=CierraXML(xml1);
	do
	{
		//xml=MoveNext100(id,&sts,"MOVE_NEXT_100");
		xml=MoveNext100(id,&sts,"MOVE_NEXT_NIVEL_100");
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
			//WriteLog(id,"Cierra 2");
			xml=CierraXML(xml);
			break;
		}
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
		i++;
	} while(1);
	//printf("paso 7\n\r");
	SET_LOG(id,nLog);
	if (!global.nFormaConexionBD) CloseDatabase(id);
	//Conexion[id].stSocketDatabase.nConectado=0;
	return xml1;
close:
	xml=CierraXML(xml);
	xml1=CierraXML(xml1);
	if (!global.nFormaConexionBD) CloseDatabase(id);
	*nTotal=0;
	SET_LOG(id,nLog);
	return NULL;
}
#endif






