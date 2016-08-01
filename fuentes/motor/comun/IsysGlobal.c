#include <xml.h>
#include <pthread.h>

int INIT_GLOBAL()
{
	int sts;
	global.xml_bases=NULL;
	global.xml_paginas=NULL;
	global.xml_tablas=NULL;
	global.xml_formatosms=NULL;
	global.nTotalBases=0;
	global.nTotalServicios=0;
	global.nTotalPaginas=0;
	global.nTotalTablas=0;
	global.nTotalFormatoSms=0;
	global.xml_proceso=NULL;
	global.pGListaFormatos=NULL;
	global.pGListaQuerys=NULL;
	pthread_mutex_init(&global.mutex_querys,NULL);
	pthread_mutex_init(&global.mutex_formatos,NULL);
	
	INIT_TABLA_XML(&global.xml_servicios,"select * from servicios");
	INIT_TABLA_XML(&global.xml_isys_tx_formatos,"select * from isys_tx_formatos");
	global.nConexionesProceso=0;
	global.nConexionesProcesoMulti=0;
	global.nFormaConexionBD=0;
	SET_GLOBAL_PROCESO("ISYS_TEST");
	SET_GLOBAL_PORT_DATABASE(8001);
	SET_GLOBAL_IP_DATABASE("127.0.0.1");
	sprintf(global.szIpControl,"127.0.0.1");
	global.nPortControl=3710;
	time(&global.time_inicio);
	global.nMaxConexiones=0;
	global.nMaxConexionesMulti=0;
	global.nPortServicio=0;
	global.lConexionesTotales=0;
	global.lConexionesTotalesMulti=0;
	sprintf(global.szPrefijoLog,"XXX");
	sprintf(global.szProcesoWeb,"ISYS_WEBSRV");
	global.nTimeoutCorteSocket=1;
	global.nTimeoutLeeData=10;
	global.nMaximaRecursion=20;
	//global.nTimeoutBaseDatos=10;
	global.lTiempoPeorTx=0;
	global.lTiempoMaxCola=0;
	global.lTiempoMaxColaMulti=0;
	global.nNumProcesosAsinc=0;
	global.nDisplayAscii=1;
	global.nBorraFile=1;
	sprintf(global.szTxPeorTiempo,"");
	sprintf(global.szBaseDatos,"mc_tlog");
	sprintf(global.szConexionBD,"EXTERNA");
	for(sts=0;sts<MAX_TIPOS_ALERTA;sts++) global.time_envio_sms_proceso[sts]=0;

	for(sts=0;sts<MAX_CONEXIONES;sts++) 
	{
		Conexion[sts].nTimeoutBaseDatos=10;
		Conexion[sts].nLogActivado=1;
		//pthread_mutex_init(&Conexion[sts].mut_cierra_xml,NULL);
		Conexion[sts].nInforme=0;
		Conexion[sts].nIdPadre=-1;
		Conexion[sts].nVersion=2;
		//Inicia en 0 el correlativo
		Conexion[sts].nCorrelativo=0;
		//Para la base de datos
		Conexion[sts].stSocketDatabase.m_socket=-1;
		Conexion[sts].stSocketDatabase.nConectado=0;
		sprintf(Conexion[sts].szError,"");
	}
	for(sts=0;sts<MAX_HOSTHOST;sts++) HostHost[sts].nEstado=S_DESCONECTADO;
	for(sts=0;sts<MAX_SERVICIOS_ASIN;sts++) 
	{
		ServiciosAsincronos[sts].nEstado=S_DESCONECTADO;
		pthread_mutex_init(&ServiciosAsincronos[sts].mutex_serv_asinc,NULL);
	}
	for(sts=0;sts<MAX_INSTANCIAS;sts++) 
	{
		Instancias[sts].nServicio=0;
		Instancias[sts].nInstancia=0;
	}

	for(sts=0;sts<MAX_IP_BLOQUEADAS;sts++) global.szIpBloqueada[sts][0]=0;
	global.nTotalIpBloqueadas=0;

	global.nError=0;
	global.SSL=0;
	global.getip=0;
#ifdef _ISYS_SSL_
	global.ssl_ctx=NULL;
#endif
	global.nMataProceso=0;
	sprintf(global.szIpBd,"127.0.0.1");
	global.nNivelTags=0;
	global.nIndicaLargo=0;
	global.nLargoIndicadorData=0;
	sprintf(global.szTipodeLargo,"ASCII");

	//Marca todos los proceso con la bd 1
	SET_DATABASE(1);
	global.nIndiceServicio=0;
	
	for(sts=0;sts<MAX_SERVICIOS;sts++) 
	{
		Tipo_Hash_servicio[sts].nTx=0;
	}

	global.nTotalProcesosMulti=0;
	global.nTipoGprs=0;
	global.nHttp=0;
	sprintf(global.szPortPostgres,"8000");
	global.xml_lista_campos_bloqueados=NULL;

	//Tablas para grabar requerimientos entrantes
	global.nTotalTablasEscritura=10;

	global.nFlagPatronFinal	=0;
	sprintf(global.szUsuarioBD,"");
	sprintf(global.szClaveBD,"");
	
	//Muestre Todo
	global.nLargoLineaLog=-1;
	//Procesos Activos
	global.procesos_activos=0;

}

int INIT_TABLA_XML(Tipo_Tabla_XML *p,char szSql[])
{
	p->xml=NULL;
	sprintf(p->szSql,"%s",szSql);
	pthread_mutex_init(&p->mutex,NULL);
}

int SET_GLOBAL_PORT_DATABASE(int nPort)
{
	int i;
	for(i=0;i<MAX_CONEXIONES;i++) 
		Conexion[i].nPortDatabase=nPort;
}

int SET_GLOBAL_PROCESO(char szProceso[])
{
	sprintf(global.szProceso,"%s",szProceso);
}

int SET_GLOBAL_IP_DATABASE(char szIp[])
{
	int i;
	for(i=0;i<MAX_CONEXIONES;i++) 
		sprintf(Conexion[i].szIpDatabase,"%s",szIp);
}

int SET_DATABASE(int nDatabase)
{
	int i;
	for(i=0;i<MAX_CONEXIONES;i++) 
		Conexion[i].nDatabase=nDatabase;
}

int GET_DATABASE(int id)
{
	return Conexion[id].nDatabase;
}

int SET_GLOBAL_DATABASE(int id,int nDatabase)
{
	Tipo_XML *xml=NULL;
	int i,nBase,sts;
	char szTmp[100];
	if (Conexion[id].nDatabase==nDatabase) return 1; 
	if (global.xml_bases==NULL)
	{
		char szSql[1024];
		sprintf(szSql,"select * from base_datos");
		global.xml_bases=GetRecords(id,szSql,&global.nTotalBases,global.xml_bases,&sts);
		if (!sts)	
		{
			WriteLog(id,"No puede leer Tabla base_datos");
			printf("Falla leer base_datos\n\r");
		}
	}

	for(i=0;i<global.nTotalBases;i++)
	{
		xml=global.xml_bases;
		GetNivelIntXML(xml,"BASE",&nBase,i);
		if (nBase==nDatabase)
		{
			GetNivelIntXML(xml,"PORT",&Conexion[id].nPortDatabase,i);
			GetNivelStrXML(xml,"IP",Conexion[id].szIpDatabase,sizeof(Conexion[id].szIpDatabase),i);
			Conexion[id].nDatabase=nBase;
			sprintf(szTmp,"Cambia a Base %i %s:%i",nBase,Conexion[id].szIpDatabase,Conexion[id].nPortDatabase);
			WriteLog(id,szTmp);
			//printf("%s\n\r",szTmp);
			return 1;
		}
	}
	sprintf(szTmp,"Falla Cambiar a Base %i",nDatabase);
	WriteLog(id,szTmp);
	printf("%s\n\r",szTmp);
	return 0;
}

int AsignaArgumento(char szCampo[],char szData[])
{
	char szTmp[100];
	if (memcmp(szCampo,"log",3)==0)
	{
		int nLog=atoi(szData);
		int i;
		for(i=0;i<MAX_CONEXIONES;i++) 
			Conexion[i].nLogActivado=nLog;
	}
	else if (memcmp(szCampo,"procesoweb",10)==0)
	{
		sprintf(global.szProcesoWeb,"%s",szData);
	}
	else if (memcmp(szCampo,"proceso",7)==0)
	{
		SET_GLOBAL_PROCESO(szData);
	}
	else if (memcmp(szCampo,"portdb",6)==0)
	{
		global.nPortBase=atoi(szData);
		SET_GLOBAL_PORT_DATABASE(atoi(szData));
	}
	else if (memcmp(szCampo,"port_postgres",13)==0)
	{
		sprintf(global.szPortPostgres,"%s",szData);
		WriteLog(0,"Puerto Postgres");
		WriteLog(0,global.szPortPostgres);
	}
	else if (memcmp(szCampo,"ipdb",4)==0)
	{
		sprintf(global.szIpBase,"%s",szData);
		SET_GLOBAL_IP_DATABASE(szData);
	}
	else if (memcmp(szCampo,"ipcontrol",9)==0)
	{
		sprintf(global.szIpControl,"%s",szData);
	}
	else if (memcmp(szCampo,"portcontrol",11)==0)
	{
		global.nPortControl=atoi(szData);
	}
	else if (memcmp(szCampo,"timeoutcortesocket",18)==0)
	{
		global.nTimeoutCorteSocket=atoi(szData);
	}
	else if (memcmp(szCampo,"timeoutleedata",14)==0)
	{
		global.nTimeoutLeeData=atoi(szData);
		sprintf(szTmp,"timeoutleedata=%i",global.nTimeoutLeeData);
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"timeoutbd",9)==0)
	{
		//global.nTimeoutBaseDatos=atoi(szData);
		int i;
		for(i=0;i<MAX_CONEXIONES;i++) 
			Conexion[i].nTimeoutBaseDatos=atoi(szData);
		sprintf(szTmp,"timeoutbd=%i",Conexion[0].nTimeoutBaseDatos);
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"numprocesosasinc",16)==0)
	{
		global.nNumProcesosAsinc=atoi(szData);
	}
	else if (memcmp(szCampo,"basedatos",9)==0)
	{
		sprintf(global.szBaseDatos,"%s",szData);
	}
	else if (memcmp(szCampo,"conexionbd",10)==0)
	{
		sprintf(global.szConexionBD,"%s",szData);
	}
	else if (memcmp(szCampo,"transaccion",12)==0)
	{
		sprintf(global.szTransaccion,"%s",szData);
	}
	else if (memcmp(szCampo,"borra_files",11)==0)
	{
		if (memcmp(szData,"si",2)==0) global.nBorraFile=1;
		else global.nBorraFile=0;
	}
	else if (memcmp(szCampo,"display",7)==0)
	{
		//1 Display Ascci 2 display Hex
		global.nDisplayAscii=atoi(szData);
	}
	else if (memcmp(szCampo,"ssl",3)==0)
	{
		//1 Display Ascci 2 display Hex
		global.SSL=atoi(szData);
		InitSSL();
	}
	else if (memcmp(szCampo,"guarda_ip",9)==0)
	{
		global.getip=atoi(szData);
		WriteLog(0,"Guarda Ip Conexion");
	}
	else if (memcmp(szCampo,"mata_proceso",12)==0)
	{
		global.nMataProceso=atoi(szData);
	}
	else if (memcmp(szCampo,"ip_conexion_bd",14)==0)
	{
		sprintf(global.szIpBd,"%s",szData);
		WriteLog(0,global.szIpBd);
	}
	else if (memcmp(szCampo,"nivel_tags",10)==0)
	{
		global.nNivelTags=atoi(szData);
		sprintf(szTmp,"nivel_tags=%i",atoi(szData));
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"largo_indicador",15)==0)
	{
		global.nLargoIndicadorData=atoi(szData);
		sprintf(szTmp,"largo_indicador=%i",atoi(szData));
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"largo_linea_log",15)==0)
	{
		global.nLargoLineaLog=atoi(szData);
		sprintf(szTmp,"largo_linea_log=%i",atoi(szData));
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"tipo_largo_paquete",18)==0)
	{
		sprintf(global.szTipodeLargo,"%s",szData);
		sprintf(szTmp,"tipo_largo_paquete=%s",szData);
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"indica_largo",12)==0)
	{
		global.nIndicaLargo=1;
		sprintf(szTmp,"indica_largo=1");
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"scgi",1)==0)
	{
		global.scgi=1;
		sprintf(szTmp,"Protocolo SGCI Activado");
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"ip_bloqueada",12)==0)
	{
		int i,j,k;
		char szTmp[210];
		j=0;
		k=0;
		for(i=0;i<strlen(szData);i++)
		{
			
			if (szData[i]==',')
			{	
				global.szIpBloqueada[j][k]=0;
				j++;	
				k=0;
			}
			else 
			{
				global.szIpBloqueada[j][k]=szData[i];
				k++;
			}
		}	
		global.szIpBloqueada[j][k]=0;
		
		for(i=0;i<MAX_IP_BLOQUEADAS;i++)
		{
			if (strlen(global.szIpBloqueada[i])>0)
			{
				sprintf(szTmp,"IP_BLOQUEADA%i=%s",i,global.szIpBloqueada[i]);
				WriteLog(0,szTmp);
				global.nTotalIpBloqueadas++;
			}
		}
		sprintf(szTmp,"TOTAL IP BLOQUEADAS %i",global.nTotalIpBloqueadas);
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"campos_bloqueados_log",21)==0)
        {
                int i,j,k;
                char szTmp[512];
		char szAux[10];
                k=0;
		j=0;
		WriteLog(0,szData);
                for(i=0;i<strlen(szData);i++)
                {

                        if (szData[i]==',')
                        {
                                szTmp[k]=0;
				WriteLog(0,szTmp);
				sprintf(szAux,"BLOQU_%i",j++);
				global.xml_lista_campos_bloqueados=InsertaDataXML(global.xml_lista_campos_bloqueados,szAux,szTmp);
                                k=0;
                        }
                        else
                        {
                                szTmp[k]=szData[i];
                                k++;
                        }
                }
                sprintf(szTmp,"Campos BLoquedos en el LOG");
                WriteLog(0,szTmp);
		ImprimeXML(global.xml_lista_campos_bloqueados);
        }

	else if (memcmp(szCampo,"init_rsa_din",12)==0)
	{
		global.rsa_ok=1;
	}
	else if (memcmp(szCampo,"num_procesos_multi",18)==0)
	{
		global.nTotalProcesosMulti=atoi(szData);
		sprintf(szTmp,"nTotalProcesosMulti=%i",atoi(szData));
		WriteLog(0,szTmp);
	}
	else if (memcmp(szCampo,"clave_bd",8)==0)
	{
		sprintf(global.szClaveBD,"%s",szData);
		WriteLog(0,"Clave BD");
		WriteLog(0,global.szClaveBD);
	}
	else if (memcmp(szCampo,"usuario_bd",10)==0)
	{
		sprintf(global.szUsuarioBD,"%s",szData);
		WriteLog(0,"Usuario BD");
		WriteLog(0,global.szUsuarioBD);
	}
	else if (memcmp(szCampo,"prefijo_log",11)==0)
	{
		sprintf(global.szPrefijoLog,"%s",szData);
		WriteLog(0,"Prejijo LOG");
		WriteLog(0,global.szPrefijoLog);
	}
	else if (memcmp(szCampo,"socket_gprs",11)==0)
	{
		global.nTipoGprs=1;
		WriteLog(0,"Socket GPRS Activado");
	}
	else if (memcmp(szCampo,"http",4)==0)
	{
		global.nHttp=1;
		WriteLog(0,"HTTP Activado");
	}
	else if (memcmp(szCampo,"patron_final",12)==0)
	{
		global.nFlagPatronFinal=1;
		WriteLog(0,"Busqueda Patron Final Activada");
	}
	else if (memcmp(szCampo,"total_tablas_escritura",22)==0)
	{
		//Indica el loop de cuantas tablas graba el Listener_File
		global.nTotalTablasEscritura=atoi(szData);
		WriteLog(0,"total_tablas_escritura");
		WriteLog(0,szData);
	}
	else if (memcmp(szCampo,"maximo_recursion",16)==0)
	{
		//Marca el maximo de recursion en el flujo, un -1 no controla
		global.nMaximaRecursion=atoi(szData);
		WriteLog(0,"maximo_recursion");
		WriteLog(0,szData);
	}
	//Si el argumento no existe lo pone como parametro de entrada
	Upper(szCampo);
	//global.xml = InsertaDataXML(global.xml,szCampo,szData);
	//Los Parametros siempre al nivel -1
	global.xml = InsertaDataXMLNivel(global.xml,szCampo,szData,-1);	
	return 1;
}

int ProcesaArgumentos(int argc,char *argv[])
{
	char *ini;
	char *data;
	char szInput[1000];
	char *szValor;
	//char szValor[3000];
	int i;
	printf("argc=%i\n\r",argc);
	for(i=1;i<argc;i++)
	{
		data=argv[i];
		ini=(char *)strchr(data,'=');
		//printf("Argumento %s %s\n\r",data,ini);
		if (ini==NULL) continue;
		memset(szInput,0,sizeof(szInput));
		memcpy(szInput,data,ini-data);
		szInput[ini-data]=0;
		szValor=(char *)malloc(strlen(ini)+10);	
		//memset(szValor,0,sizeof(szValor));
		ini++;
		memcpy(szValor,ini,strlen(ini));
		szValor[strlen(ini)]=0;
		printf("Input %s %s\n\r",szInput,szValor);
		AsignaArgumento(szInput,szValor);
		free(szValor);
	}
}

//Verifica si corresponde enviar un sms dependiendo del tipo de alerta
void ALERTA_SMS(int id,int nTipo,char szData[])
{
	time_t t1;
	time(&t1);
	//si han pasado 5 minutos del ultimo aviso de este tipo
	if (t1-global.time_envio_sms_proceso[nTipo]>(5*60))
	{
		//EnviaSms(id,szData,"5696192123");
		global.time_envio_sms_proceso[nTipo]=t1;
	}
}
