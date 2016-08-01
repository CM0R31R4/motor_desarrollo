#include <stdio.h>
#include <stdlib.h>
#include<sys/types.h>
#include<dirent.h>
#include <xml.h>

Tipo_XML *AsignaDatosInicio(int id,Tipo_XML *xml)
{
        char szAux[256];
        //05-01-2011 FAY
        //Para todas las tx envia datos de donde se proceso esta tx
        xml=InsertaDataXML(xml,"__PROCESOXML__",global.szProceso);
        GetStrXML(global.xml,"IPLOCAL",szAux,sizeof(szAux));
        xml=InsertaDataXML(xml,"__IPLOCAL__",szAux);
	sprintf(szAux,"%i",id);
        xml=InsertaDataXML(xml,"__IDPROC__",szAux);
}

int TransactionThread(int id)
{
	int nSocket;
	int nLenLlave=0,nPosLlave=0,nHttp=0;
	char szTmp[200];
	int nLeidos;
	Tipo_XML *xml=NULL;
	int bContesta,nTx;
	int sts;
	Tipo_Servicio stServ;
	Tipo_XML *xml_aux=NULL;

	//Solo para din y ABC
	if (global.rsa_ok)
	{
		rsa_initialise();
		//rsa_read_private_key("llaves","iswitch");
	}
       while(1)
       {
	   //WriteError(id,"EsperaActivacion2");
	   //ImprimeMemoria(id);
	   EsperaActivacion2(id,&Conexion[id]);

	   xml=AsignaDatosInicio(id,xml);
	   //Si esta activado el protocolo SCGI desde el apache
           if (global.scgi==1) 
	   {
volver_scgi:
		nSocket=Conexion[id].nSocket;
		xml=LeePaqueteSCGI(id,nSocket,10,xml,&sts);
		if (sts>0)
		{
			//ImprimeXML(xml);
			//Buscamos en la tabla de servicios por la URL
			xml_aux=NULL;
			xml_aux=GetStrXMLData(xml,"REQUEST_URI");
			WriteLog(id,xml_aux->pData);
			if (xml_aux)
			{
				sprintf(stServ.szUrl,"%s",xml_aux->pData);
				bContesta=0;
				if (!BuscaServicio(id,&stServ,BUSCA_URL))
				{
					WriteLog(id,"REQUEST_URI no definida en tabla de servicios");
					WriteMensajeApp(id,"REQUEST_URI no definida en tabla de servicios");
					close(nSocket);
					xml=CierraXML(xml);
					goto fin;
				}
				else
				{
					sprintf(szTmp,"%i",stServ.nTx);
					nTx=stServ.nTx;
					xml=InsertaDataXML(xml,"TX",szTmp);
				}
			}
			else WriteLog(id,"No viene TAG REQUEST_URI, tx no identificada");

		}
		//Si no lee el paquete...
		else 
		{
			close(nSocket);
			xml=CierraXML(xml);
			goto fin;
		}
           }
	   //Si es de tipo socket...
	   else if (Conexion[id].nTipoProceso==PROC_SOCKET)
 	   {
		nSocket=Conexion[id].nSocket;
		//sprintf(szTmp,"XML1=%x",xml);
		//WriteError(id,szTmp);
		xml=LeePaqueteXML(id,nSocket,10,xml,&sts);
		//sprintf(szTmp,"XML2=%x",xml);
		//WriteError(id,szTmp);
		if (sts)
		{
			//ImprimeXML(xml);
			bContesta=0;
			nTx=0;
			/*xml=ProcesaInputXML1(szData);*/
			nTx=GetTx(xml);
		}
		//Si no lee el paquete...
		else 
		{
			close(nSocket);
			xml=CierraXML(xml);
			goto fin;
		}
	   }
	   else if (Conexion[id].nTipoProceso==PROC_XML)
	   {
		   xml=Conexion[id].xml;
		   GetIntXML(xml,"SERVICIO",&nTx);
		   bContesta=0;
	   }
		   
	   //Eejcuta...
	   xml=AplicaQuerysServicio(id,xml,nTx,&bContesta,&sts);
		//sprintf(szTmp,"XML3=%x",xml);
		//WriteError(id,szTmp);
	   if (!sts) 
	   {
		char szTmp[200];
		sprintf(szTmp,"Ningun Query funciona para tx=%i",nTx);
                xml=InsertaDataXML(xml,"STATUS","ERROR");
                xml=InsertaDataXML(xml,"DESCRIPCION",szTmp);
	   }
	//Cierra Socket NoClose, en caso de estar abierto
	   /*
	if (Conexion[id].stSocket.nConectado)
	{
		Conexion[id].stSocket.nConectado=0;
		close(Conexion[id].stSocket.m_socket);
		WriteLog(id,"Cierra Socket NoClose");
	}
	*/
		//sprintf(szTmp,"XML4=%x",xml);
		//WriteError(id,szTmp);
        xml=InsertaDataXML(xml,"STATUS","OK");
	//ImprimeXML1(xml,id);
	//Si esta activado el scgi, solo responde tag RESPUESTA
        if (global.scgi==1) 
	{
		//Si existe TAG RESPUESTA respondemos eso
		xml_aux=NULL;
		xml_aux=GetStrXMLData(xml,"RESPUESTA");
		if (xml_aux)
		{
			sts=send(nSocket,xml_aux->pData,xml_aux->nLenData,0);
			if (sts<0) WriteLog(id,"Falla Escritura Respuesta");
		}
		else
		{
			xml_aux=GetStrXMLData(xml,"RESPUESTA_HEX");
			if (xml_aux)
			{
                                char *data;
                                data=(char *)malloc((xml_aux->nLenData/2)+1);
                                readhex(xml_aux->pData,data);
				sts=send(nSocket,data,xml_aux->nLenData/2,0);
				if (sts<0) WriteLog(id,"Falla Escritura Respuesta Hex");
				free(data);
			}
			else 
			{
				WriteLog(id,"No viene TAG RESPUESTA ni RESPUESTA_HEX");
				WriteMensajeApp(id,"No viene TAG RESPUESTA ni RESPUESTA_HEX");
			}
		}
			
		close(nSocket);
		xml=CierraXML(xml);
		//Volvemos a leer por si el apache o nginx manda otro requerimiento
		//goto volver_scgi;
		
	}
	else if (Conexion[id].nTipoProceso==PROC_SOCKET)
 	{
		//sprintf(szTmp,"XML5=%x",xml);
		//WriteError(id,szTmp);
                //Si aun no contesta
		if (!bContesta)
		{
			//ImprimeXML1(xml,id);
	     		SendSocketXML1(id,nSocket,xml);
		//sprintf(szTmp,"XML6=%x",xml);
		//WriteError(id,szTmp);
		}
		//WriteLog(id,"Cierra Socket");
		close(nSocket);
		xml=CierraXML(xml);
	}
	else if (Conexion[id].nTipoProceso==PROC_XML)
	{
		Conexion[id].xml=xml;
		xml=NULL;
	}
	/*
	//Si entra en este estado es que se acabo el timeout del PROC_XML
	//Entonces debo poner en NULL el Conexion[id].xml
	else if (Conexion[id].nTipoProceso==PROC_MUERTO)
	{
		xml=CierraXML(xml);
		Conexion[id].xml=NULL;
	}
	*/
fin:
	//WriteError(id,"DesactivaProceso2");
	//ImprimeMemoria(id);
	DesactivaProceso2(id);
       }
}
int Thread_Exit(int id)
{
}

extern Tipo_XML *DeserializaXML(Tipo_XML *xml,char *);

int main(int argc,char *argv[])
{
	char szTmp[256];
	Tipo_Proceso stProceso;

	//mtrace();
	/*
	if (mcheck(NULL) != 0) {
               fprintf(stderr, "mcheck() failed\n");

               exit(EXIT_FAILURE);
           }

	*/
	INIT_GLOBAL();
	

	//ptmalloc_init();
	ProcesaArgumentos(argc,argv);
	DatosProceso(0,&stProceso,global.szProceso);
	sprintf(szTmp,"Inicia Procesador %s Puerto=%i Hilos=%i",global.szProceso,stProceso.nPort,stProceso.nCantidad);
	WriteMensajeApp(0,szTmp);
	LeeTablaXML(0,global.xml_servicios.szSql,&global.xml_servicios);
	InicializaServerSocket(stProceso.nPort);
	CreaConexiones(argv[2],stProceso.nCantidad);
	return 1;
}


