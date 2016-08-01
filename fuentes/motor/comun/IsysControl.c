#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <xml.h>
#include <netinet/in.h>

long GetMilliSeconds(struct timeb *t2,struct timeb *t1)
{
    double d;
    long milli;
    long l1;

    //siempre el tiempo 2 sera mayor al 1
    d = difftime(t2->time,t1->time);
    milli = (long)d*1000;   //los milisegundos transcurridos

    //no siempre sera mayor los milli segundos
    l1 = t2->millitm - t1->millitm;
   //el total es
    milli += l1;

    return milli;
}

int TransactionControlThread(int id)
{
	int nSocket;
	Tipo_Proceso stProcesoEstd;
	struct sockaddr_in sock;
	int nPort;
	char szIp[20];
	char response[MAX_BUFFER];

	char szTmp[MAX_BUFFER];
	char szTime1[100];
	char szTime2[40];
	char szData[100];
	char szCampo[100];
	char szMem[1024];
	int i;
	int nConexionesProceso;

	struct tm thoy;
	time_t t1;
	
	nPort=global.nPortControl;
	sprintf(szIp,"%s",global.szIpControl);

	sock.sin_family = AF_INET;
	sock.sin_port = htons(nPort);
	sock.sin_addr.s_addr = inet_addr(szIp);
		

	nSocket=CreateUdp(0);

	do
	{
		long l;
		ImprimeMemoria(199,"Hilo de Control");
		time(&t1);
		localtime_r(&t1,&thoy);
		sprintf(szTime1,"%04i/%02i/%02i %02i:%02i:%02i",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec);
	
		localtime_r(&global.time_inicio,&thoy);
		sprintf(szTime2,"%04i/%02i/%02i %02i:%02i:%02i",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec);

		//ImprimeMemoria(199,"Hilo de Control 1");
		memset(response,0,sizeof(response));
		InsertaCampoXML(response,"STATUS","OK");
		InsertaCampoXML(response,"TX","CONTROL");
		InsertaCampoXML(response,"PROCESO",global.szProceso);
		InsertaCampoXML(response,"TIME_INICIO",szTime2);
		InsertaCampoXML(response,"TIME_ACTUAL",szTime1);
		localtime_r(&global.lTiempoMaxCola,&thoy);
		sprintf(szTime2,"%04i/%02i/%02i %02i:%02i:%02i",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec);
		localtime_r(&global.lTiempoMaxColaMulti,&thoy);
		sprintf(szTime1,"%s-%04i/%02i/%02i %02i:%02i:%02i",szTime2,thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec);
		InsertaCampoXML(response,"TIME_MAX_COLA",szTime1);
		InsertaCampoXML(response,"IPDB",global.szIpBase);
		InsertaCampoIntXML(response,"PORTDB",global.nPortBase);
		//ImprimeMemoria(199,"Hilo de Control 2");

		nConexionesProceso=0;
		for (i=0;i<MAX_CONEXIONES;i++) 
		{
			if ((Conexion[i].nEstado==C_XXX)||(Conexion[i].nEstado==C_EJECUTAR))  nConexionesProceso++;
		}
		if (global.nMaxConexiones<nConexionesProceso)
 		{
                	global.nMaxConexiones=nConexionesProceso;
		        time(&global.lTiempoMaxCola);
		}

		//ImprimeMemoria(199,"Hilo de Control 3");
		
		sprintf(szTmp,"%i/%i",global.nProcesosActivos,global.nProcesosActivosMulti);
		InsertaCampoXML(response,"TOTAL_CON",szTmp);
		sprintf(szTmp,"%i/%i",nConexionesProceso,global.nConexionesProcesoMulti);
		InsertaCampoXML(response,"CON_ACT",szTmp);
		sprintf(szTmp,"%i/%i",global.nMaxConexiones,global.nMaxConexionesMulti);
		InsertaCampoXML(response,"MAX_CON",szTmp);
		InsertaCampoIntXML(response,"LOG",LOG(id));
		InsertaCampoIntXML(response,"PORT_SERVICIO",global.nPortServicio);

		sprintf(szTmp,"%ld/%ld",global.lConexionesTotales,global.lConexionesTotalesMulti);
		InsertaCampoXML(response,"CON_TOT",szTmp);
		GetMemoria(id,szMem);
		InsertaCampoXML(response,"MEMORIA",szMem);
		sprintf(szTmp,"%c%s%c",2,response,3);
		//WriteLog(id,response);
		//printf("Envia %s\n\r",szTmp);
		//ImprimeMemoria(199,"Hilo de Control 4");
		sendto(nSocket,szTmp,strlen(szTmp),0,(struct sockaddr*)&sock,sizeof(sock));
		//sleep(120);
		sleep(30);
		//ImprimeMemoria(199,"Hilo de Control 5");
			
		memset(response,0,sizeof(response));
		InsertaCampoXML(response,"STATUS","OK");
		InsertaCampoXML(response,"TX","TIEMPOS");
		InsertaCampoXML(response,"PROCESO",global.szProceso);
		InsertaCampoXML(response,"PEOR_TX",global.szTxPeorTiempo);
		sprintf(szData,"%ld",global.lTiempoPeorTx);
		InsertaCampoXML(response,"PEOR_TIEMPO",szData);
		/*

		//Genera informacion de los procesos activos 
		for(i=0;i<global.nProcesosActivos;i++)
		{
			if (strlen(Conexion[i].szTxActual)==0) continue;
			sprintf(szCampo,"N%i",i);
			sprintf(szData,"%i",i);
			InsertaCampoXML(response,szCampo,szData);
			sprintf(szCampo,"ESTADO%i",i);
			sprintf(szData,"%i",Conexion[i].nEstado);
			InsertaCampoXML(response,szCampo,szData);
			sprintf(szCampo,"TX%i",i);
			InsertaCampoXML(response,szCampo,Conexion[i].szTxActual);
			sprintf(szCampo,"HORA%i",i);
			InsertaCampoXML(response,szCampo,Conexion[i].szTime);
			sprintf(szCampo,"TIME%i",i);
			if ((Conexion[i].pTimeInicio.time>0) &&
			    (Conexion[i].pTimeFin.time>0))
			{
				sprintf(szData,"%ld",GetMilliSeconds(&Conexion[i].pTimeFin,&Conexion[i].pTimeInicio));
				InsertaCampoXML(response,szCampo,szData);
			}
			else 
			{
				InsertaCampoXML(response,szCampo,"---");
			}
		}
		*/
		if (strlen(response)>0)
		{
		//ImprimeMemoria(199,"Hilo de Control 6");
			sprintf(szTmp,"%c%s%c",2,response,3);
			sendto(nSocket,szTmp,strlen(szTmp),0,(struct sockaddr*)&sock,sizeof(sock));
		}
		//sprintf(szTmp,"Estado %i %i",Conexion[id].nEstado,id);
		//WriteLog(id,szTmp);
		//ImprimeMemoria(199,"Hilo de Control 7");

	} while(Conexion[id].nEstado==C_EJECUTAR);
}

int CreaProcesoControl(int i)
{

	Conexion[i].nEstado=C_EJECUTAR;
        Conexion[i].ident=pthread_create(&Conexion[i].task, NULL,(void *)TransactionControlThread,(void *)i);
        printf("Inicializa Proceso Control %i\n\r",i);
        if (Conexion[i].ident>0)
        {
                Conexion[i].nEstado=C_FALLA;
                //printf("Falla create thread control..i %s\n\r",strerror());
                WriteLog(i,"Falla Crear Thread Control\n\r");
                exit(0);
                return -1;
        }
        return 1;
}

void SET_LLAVE_EST(char szLlave[])
{
	sprintf(global.estd.szLlave,"%s",szLlave);
}

void SET_TX(int id,char szTx[])
{
	memset(Conexion[id].szTxActual,0,sizeof(Conexion[id].szTxActual));
	if (strlen(szTx)>sizeof(Conexion[id].szTxActual))
	{
		memcpy(Conexion[id].szTxActual,szTx,sizeof(Conexion[id].szTxActual)-1);
	}
	else
	{
		sprintf(Conexion[id].szTxActual,"%s",szTx);
	}
}

void SET_TIME_EST(int nTipo)
{
    switch(nTipo)
    {
        case LLEGA_CONEXION:        ftime(&global.estd.pTimeb1); break;
        case LLEGA_REQUERIMIENTO:   ftime(&global.estd.pTimeb2); break;
        case ENVIA_RESPUESTA:       ftime(&global.estd.pTimeb3); break;
        case LLEGA_CONFIRMACION:    ftime(&global.estd.pTimeb4); break;
        default: break;
    }
    return;
}


