#include <stdio.h>
#include <stdlib.h>
#include<sys/types.h>
#include<dirent.h>
#include <xml.h>
#include <tipos.h>
#ifdef _ISYS_SSL_
#include <openssl/ssl.h>
#include <openssl/bio.h>
#include <openssl/crypto.h>
#include <openssl/evp.h>
#include <openssl/x509.h>
#include <openssl/ssl.h>
#ifndef OPENSSL_NO_ENGINE
#include <openssl/engine.h>
#endif
#include <openssl/err.h>
#include <openssl/rand.h>
#endif

#include <sys/socket.h>
#include <netinet/in.h>

extern pthread_mutex_t mut_sockets_gprs;
Tipo_Tabla_XML stTablaTxForm;

int TransactionThread(int id)
{
}

int Thread_Exit(int id) {}


//Este proceso recibe una tabla como parametro y envia la data al socket pasado por parametro
int main(int argc,char *argv[])
{
	Tipo_Proceso stProceso;
	Tipo_Data *pSqlResp=NULL;
	Tipo_Data *pData=NULL;
	char szResp[2048];
	char szTmp[1024];
	char szQueryCola[2048];
	char szTx[20];
	int nTx,id;
	char szId[512];
	char szBorra[1024];
	int nPort,sts;
	char *data;
	int bContesta;
	int nTotal=0;
	int nEspera=0;
	char szReintentos[1024];
	char szId1[5];
	int i;
	char *ini,*fin;
	char szTablaMotor[512];
	PGresult *res=NULL;
	Tipo_XML *pXml=NULL;
	Tipo_Socket stSocket;
	Tipo_XML *xml1=NULL;
	INIT_GLOBAL();
	ProcesaArgumentos(argc,argv);
	SET_GLOBAL_DATABASE(0,1);

	sprintf(global.szProceso,"COLA_MOTOR");
	ImprimeXML(global.xml);
	if (!GetStrXML(global.xml,"ID",szId1,sizeof(szId1)))
	{
		printf("Falta parametro ID\n\r");
		exit(1);
	}
	printf("ID Log=%s\n\r",szId1);
	id=atoi(szId1);
	if (!GetStrXML(global.xml,"TABLA",szTablaMotor,sizeof(szTablaMotor)))
	{
		printf("Falta parametro TABLA\n\r");
		exit(1);
	}
	global.xml=InsertaDataXML(global.xml,"__IDPROC__",szTmp);
	/*
	if (!GetStrXML(global.xml,"SP_BORRA_REG_COLA",szBorra,sizeof(szBorra)))
	{
		printf("Falta datos entrada SP_BORRA_REG_COLA\n\r");
		exit(1);
	}
	if (!GetStrXML(global.xml,"SP_REINTENTOS_REG",szReintentos,sizeof(szReintentos)))
	{
		printf("Falta datos entrada SP_REINTENTOS_REG\n\r");
		exit(1);
	}
	*/
	if (!GetStrXML(global.xml,"SP_CONSUME_COLA",szQueryCola,sizeof(szQueryCola)))
	{
		printf("Falta datos entrada SP_CONSUME_COLA\n\r");
		exit(1);
	}
	nEspera=1;
	sleep(nEspera);
	//Mientras existan datos leo desde la tabla
	while(1)
	{

	//usleep(nEspera);
	//sprintf(szTmp,"Espera = %i",nEspera);
	//WriteMensajeApp(id,szTmp);
	
	//printf("ID=%i SQL=%s\n",id,szQueryCola);
	if (!EnviaQuery(id,szQueryCola))
	{
		printf("Falla envio Query\n\r");
		PQfinish(Conexion[id].conn);
		exit(1);
	}

	while ((res=EsperoResultados(id,&nTotal))!=NULL)
	{

		printf("Total Reg=%i\n",nTotal);
		sprintf(szTmp,"Registros %i id=%i",nTotal,id);
		WriteMensajeApp(id,szTmp);
		//Si hay resultados solo espero 1 milisegundo para seguir leyendo la cola
		nEspera=0;
		
		for(i=0;i<nTotal;i++)
		{
			printf("Busco Resp %i\n\r",i);
			pSqlResp=LiberaData(pSqlResp);
			pSqlResp=SacoResultados(id,res,i,pSqlResp);
			if (pSqlResp==NULL) break;
		

			//Saco el ID
			ini=strstr(pSqlResp->data,"id[]=");
			if (ini==NULL) 
			{
				printf("Falla Respuesta\n\r");
				break;
			}
			ini+=5;
			fin=strstr(ini,"###");
			if (fin==NULL) 
			{
				printf("Falla Respuesta1\n\r");
				break;
			}
			
			memcpy(szId,ini,fin-ini);
			szId[fin-ini]=0;
			printf("ID = %s\n\r",szId);
			

			//Saco la data
			data=strstr(pSqlResp->data,"###data[]=");
			if (data==NULL) 
			{
				printf("No encontrado patron ###data[]=\n\r");
				break;
			}
			data+=10;
			//LE saco los ultimo 3 caracteres
			data[strlen(data)-3]=0;
			//Parto con un xml limpio	
			xml1=CierraXML(xml1);
			xml1=DeserializaXML(xml1,data);
			xml1=InsertaDataIntXML(xml1,"__IDPROC__",id+1);
			xml1=InsertaDataXML(xml1,"__ID_DTE__",szId);
			xml1=InsertaDataXML(xml1,"__COLA_MOTOR__",szTablaMotor);

			GetStrXML(xml1,"TX",szTx,sizeof(szTx));
			nTx=atoi(szTx);
			//sprintf(global.szConexionBD,"EXTERNA");
			sprintf(global.szConexionBD,"INTERNA");
			xml1=AplicaQuerysServicio(id+1,xml1,nTx,&bContesta,&sts);
			sprintf(global.szConexionBD,"INTERNA");
			if (!sts)
		        {
                		char szTmp[200];
		                printf("Ningun Query funciona para tx=%i",nTx);
				continue;
		        }		
			//ImprimeXML(xml1);

		} //for
	    } //while (res)

           if (res) PQclear(res);

	   //Si he esperado mucho volvemos al ciclo
	   if (nEspera>5) nEspera=1;
	   //Si no hay datos aumento un poco el tiempo
	   else if (nEspera>0) 
	   {
		nEspera+=1;
		sleep(nEspera);
	   	//sprintf(szTmp,"Espera*=%i",nEspera);
	   	//WriteMensajeApp(id,szTmp);
	   }
	   else nEspera=1;

	} //While (1)
	if (Conexion[id].nAbierta) PQfinish(Conexion[id].conn);
	if (Conexion[id+1].nAbierta) PQfinish(Conexion[id+1].conn);
	printf("Fin");
	exit(1);
	return 1;
}

