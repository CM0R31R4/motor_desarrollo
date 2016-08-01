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


void WriteMensajeApp(int id,char *data);


//Llena una estructura con datos de entrada que deben ser llenados
//con las funciones para asignar los datos a las estructuras especificas
//El input es del tipo json  { "CAMPO":"DATA","CAMPO2":"DATA2" }

Tipo_XML *DeserializaJSON(int id,Tipo_XML *xml,char szInput[])
{
        char *dta=NULL;
	json_object * jobj=NULL;
	char *key; 
	struct json_object *val; 
	struct lh_entry *entry=NULL;

	jobj = json_tokener_parse(szInput);

	if (!jobj)
	{
		printf("Json Malo\n");
		WriteLog(id,"JSON INCORRECTO");
		WriteLog(id,szInput);
		WriteMensajeApp(id,"Json formato Incorrecto");
		return xml;
	}

	entry=json_object_get_object(jobj)->head;
	for(entry; ({ if(entry) { key = (char*)entry->k; val = (struct json_object*)entry->v; } ; entry; }); entry = entry->next )
   	{
		if (val) 
        		xml=InsertaDataXMLJson(xml,key,(char *)json_object_get_string(val));
		else
			xml=InsertaDataXMLJson(xml,key,"");
	}
	json_object_put(jobj);
	return xml;
}

Tipo_Data *SerializaJSON(Tipo_XML *xml,Tipo_Data *pDataAux)
{
	Tipo_XML *xml2=NULL;
        Tipo_XML *xml1=xml;
	json_object * jobj=NULL;
	json_object *jData=NULL;
	enum json_type type;
	Tipo_Data *pData=NULL;
	int i;
	
	if (xml==NULL)
	{
		//json nulo
        	pDataAux=InsertaDataLen("{},",2,pDataAux);
		return pDataAux;	
	}

	//Inicializa json
	jobj = json_object_new_object();
	do
	{
		xml2=xml1->pNextNivel;
		while(xml1!=NULL)
		{
		
			//Si el campo es INPUT y dentro viene un json, lo junto con el xml
			if (memcmp(xml1->szCampo,"INPUT",xml1->nLenCampo)==0)
			{
				struct json_object *val; 
				struct lh_entry *entry=NULL;
				char *key; 
				//Lo convierto a ascii
				pData = CreaData();
				pData->data = (char *)malloc((xml1->nLenData/2)+10);
				//Remplaza el chr 39 por el 254 para evitar las caidas con el '
			 	readhex_39to5(xml1->pData, pData->data);
				pData->data[(xml1->nLenData/2)+1]=0;	
				pData->nLenData=(xml1->nLenData/2);
				printf("Json INPUT=%s\n",pData->data);
				//Veo si es un json
				jData=json_tokener_parse(pData->data);
				pData = LiberaData (pData);
				//Si no es un json lo genero como un string
				if (!jData) 
				{
					printf("Agrega String\n");
					jData=json_object_new_string(xml1->pData);
					printf("Agrega String1\n");
					json_object_object_add(jobj,xml1->szCampo,jData);
					printf("Agrega String2\n");
				}
				else
				{
					printf("Recorre Json=%x",jData);
					//Si es un json, lo recorro y lo agrego
					entry=json_object_get_object(jData)->head;
					for(entry; ({ if(entry) { key = (char*)entry->k; val = (struct json_object*)entry->v; } ; entry; }); entry = entry->next )
				   	{			
						printf("AgregaInput %s %s %x\n",key,json_object_to_json_string_ext(val,JSON_C_TO_STRING_PLAIN),jData);
						//Todas las llaves se agregan en Mayusculas
						//UpperLen(key,strlen(key));
						if (val) json_object_object_add(jobj,key,val);
					}
					//json_object_put(jobj);
				}
	
			}
			
			else
			{
				//Se remplazan los ' por el caracter 254
				for (i=0;i<xml1->nLenData;i++)
				{
					if (xml1->pData[i]==39) xml1->pData[i]=5;
					if (xml1->pData[i]==59) xml1->pData[i]=6;
				}
				
				jData=json_tokener_parse(xml1->pData);
				//si jData is nulo y hay data, entoces es un string
				if (!jData && xml1->nLenData>0)
				{
					jData=json_object_new_string(xml1->pData);
					printf("AgregaStr %s %s %s %x\n",xml1->szCampo,xml1->pData,json_object_to_json_string_ext(jData,JSON_C_TO_STRING_PLAIN),jData);
				}
				else
				{
					type = json_object_get_type(jData);
					//Solo en los tipos objeto uso algo distinto a un string
					switch (type) 
					{
						case json_type_object:
							printf("AgregaObj %s %s %s %x\n",xml1->szCampo,xml1->pData,json_object_to_json_string_ext(jData,JSON_C_TO_STRING_PLAIN),jData);
							break;
						default:
							printf("AgregaStr %s %s %s %x\n",xml1->szCampo,xml1->pData,json_object_to_json_string_ext(jData,JSON_C_TO_STRING_PLAIN),jData);
							json_object_put(jData);
							jData=json_object_new_string(xml1->pData);
					}
							
				}
				json_object_object_add(jobj,xml1->szCampo,jData);
			}
			//json_object_put(jData);
			//jData=NULL;
			xml1=xml1->pNext;
		}
		xml1=xml2;
	} while (xml1!=NULL);
	
        pDataAux=InsertaData((char *)json_object_to_json_string_ext(jobj,JSON_C_TO_STRING_PLAIN),pDataAux);
	json_object_put(jobj);
	return pDataAux;
} 
