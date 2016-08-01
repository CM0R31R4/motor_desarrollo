#ifndef _TIPOS_
#define _TIPOS_

#include <string.h>
#include <IsysSocket.h>
#include <xml.h>
#include <pthread.h> 
#ifdef FLAG_POSTGRES
#include <libpq-fe.h>
#endif
#include <dirent.h>
#include <const.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/timeb.h>
#ifdef _ISYS_SSL_
#include <openssl/ssl.h>
#include <openssl/bio.h>
#include <openssl/crypto.h>
#include <openssl/evp.h>
#include <openssl/x509.h>
#include <openssl/err.h>
#include <openssl/rand.h>
#ifndef OPENSSL_NO_ENGINE
#include <openssl/engine.h>
#endif
#endif
#include <sybdb.h>
#include <syberror.h>
#include <sys/param.h>

#ifdef FLAG_MYSQL
#include <mysql.h>
#endif


#define MAX_SOCKETS_GPRS	5000
typedef struct tag_sockets_gprs
{
	int nSocket;
	int nProceso;
} Tipo_Gprs;
Tipo_Gprs stGprs[MAX_SOCKETS_GPRS];

#define MAX_IP_BLOQUEADAS	5

#define MAX_SERV_SSL_CLI	5
typedef struct tag_serv_ssl_cli
{
#ifdef _ISYS_SSL_
	SSL_CTX *ctx;
#endif
	int nServicio;
}Tipo_SSL_Cli[MAX_SERV_SSL_CLI];

typedef struct tag_proceso
{
	int nCantidad;
	int nPort;
	char szIp[20];
	int nFormaConexionBD;
} Tipo_Proceso;

#define MAX_HOSTHOST	30
typedef struct tag_socket_host_host
{
	int nEstado;
	int nSocket;
	char szIp[200];
	int nPort;
	int szLLave[25];
} Tipo_HostHost;

Tipo_HostHost HostHost[MAX_HOSTHOST];

typedef struct tag_servicios
{
    char szDescripcion[45];
    char szIp[200];
    char szPagina[30];
    char szImagen[30];
    int nPort;
    int nTx;
    int nValido;
    char szUrl[50];
    int nTimeout;
    int nTipoRespuesta;			//0 lee largo total, 1 resp variable, 2 respuesta esperando largo minimo
    int nLenMinimo;			//Largo minimo para respuesta
    int nLlaveQuery;			//Query que consulta
    int nTimeoutRafaga; 		//timeout para esperar una rafaga
    char szPatronFinal[100];
    //Si es "CON" especifica que debe conectarse cada vez
    //Si es "HOST" guarda y espera conexion
    char szTipoConexion[12];			
    //PAra Servicios con 2 Modulos Procesadores
    char szUsaDosIP[3];
    char szIp1[200];
    int nPort1;
    int ssl;
    char szListaIP[210];
    //Para escribir un archivo
    char szEscribeFile[3];
    char szRutaFile[101];
    char szDataHeader[1025];
    char szDataRespuesta[1025];
} Tipo_Servicio;

#define MAX_SERVICIOS	2000
Tipo_Servicio Tipo_Hash_servicio[MAX_SERVICIOS];

#define MAX_INSTANCIAS	10
typedef struct tag_instancias
{
	int nServicio;
	//Indica la alternancia de las ip del servicio
        int nInstancia;
}Tipo_Instancia;
Tipo_Instancia Instancias[MAX_INSTANCIAS];

//Datos unicos de cada proceso.
typedef struct tag_thread
{
        int nSocket;
        int ident;
        pthread_t  task;
	pid_t pid;
	sigset_t mask;

        volatile int nEstado;

	//Datos para la base de datos
#ifdef FLAG_POSTGRES
	PGconn     *conn;
#endif
	DBPROCESS  *dbconn;
	int nAbierta;

	//Datos para las conexiones clientes..
	Tipo_Socket stSocketDatabase;

	//Para almancenar los datos del servicio
	Tipo_Servicio stServ;

	//Datos para el paso de parametros
	char szData[512];
	
	//Puntero a XML para paso de parametros
	Tipo_XML *xml;
	
	//Puntero a un directorio
	DIR *directorio;
	int nLogActivado;

	//Data de Control
	char szTxActual[256];
	struct timeb pTimeInicio;
	struct timeb pTimeFin;
	char szTime[25];
#ifdef _ISYS_SSL_
	SSL *ssl;
#endif
	//Indica si el proceso es de tipo socket o solo XML
	int nTipoProceso;
	char szIp[200];
	//Socket multiuso
	Tipo_Socket stSocket;

	int nPortDatabase;
	char szIpDatabase[20];
	int nDatabase;
	//pthread_mutex_t mut_cierra_xml;
	int nInforme;
	int nIdPadre;
	int nNoCierreConexionHttp;
	int nIntentosConexionesBD;
	Tipo_XML *ultimo_xml;
	int nVersion;

	//Indica un correlativo para Listener_File
	int nCorrelativo;
	pthread_t  id_thread;

#ifdef FLAG_MYSQL
	MYSQL *pMysqlconn;
#endif
	//Timeout para la conexion hacia la BD
	int nTimeoutBaseDatos;
} Tipo_Conexion;

Tipo_Conexion Conexion[MAX_CONEXIONES];

typedef struct tag_campos
{
	char szNombre[100];
	char szTipo[12];
	int nLen;
	int nValido;
} Tipo_Campo;

typedef struct tag_tablas
{
	char szTabla[50];
	char szOrden[100];
	int nLimit,nTx;
	char szTitulo[100];
	char szQuery[500];
	int nValido;
	int nBaseDatos;
} Tipo_Tabla;

typedef struct tag_formatos
{
	char szTipoCampo[15];
	char szTipo[10];
	char szCampo[35];
	char szTexto[256];
	int nCaracter,nLargo,nSecuencia;
	char szIdent[4];
	char chLlenado;
	int nFormato;
	char szFuncion[55];
	struct tag_formatos	*pNext;
} Tipo_Formatos;

typedef struct tag_listaformatos
{
	int nFormato;
	Tipo_Formatos *pFormato;
	struct tag_listaformatos *pNext;
} Tipo_Lista_Formatos;

typedef struct tag_querys
{
	char szLlave[100];
	int nSecuencia;
	int nServicio;
	int nForSalida;
	int nForAck;
	int nTipo;
	int nBaseQuery;
	char szQuery[4096];
	int nValidaOutput;
	int nEsperaOutput;
	int nSecOk;
	int nSecError;
	struct tag_querys	*pNext;
} Tipo_Querys;

typedef struct tag_listaquerys
{
	char szLlave[100];
	Tipo_Querys *pQuery;
	struct tag_listaquerys *pNext;
} Tipo_Lista_Querys;

typedef struct tag_nombrecampos
{
	char szNombre[100];
	struct tag_nombrecampos *pNext;
} Tipo_NombreCampos;

#define LEN_CAMPOS	200
#define LEN_TABLAS	100

Tipo_Campo stCampos[LEN_CAMPOS];
Tipo_Tabla stTablas[LEN_TABLAS];

typedef struct tag_data
{
       char *data;
       long nLenData;
} Tipo_Data;

typedef struct tag_bo_vendedor
{
	char szCodVendedor[10];
	struct tag_bo_vendedor *pNext;
} Tipo_Vendedores;

typedef struct tag_exporta
{
	char szQuery[1025];
	char szRuta[512];
	char szFile[100];
	int nFormato,nFormatoHeader;
	struct tag_exporta *pNext;
} Tipo_Exporta;

typedef struct tag_ipbackoffices
{
	char szCliente[10];
	char chTipoTx;
	char szIp[200];
	int nPort;
	char szTxBack[50];
	struct tag_ipbackoffices *pNext;
} Tipo_IpBackoffices;

typedef struct tag_formato_sms_msg 
{
	char szCliente[5];
	char chTipoTx;
	char chProtocolo;
	int nFormatoIn;
	int nFormatoInTrans;
	int nFormatoOut;
	int nFormatoOutTexto;
	int nPosicionDatos;
	int nFormatoOutTrans;
	char szTxBack[35];
} Tabla_FormatoSms;

typedef struct tag_tabla_xml
{
	Tipo_XML *xml;
	int nTotal;
	pthread_mutex_t mutex;
	char szSql[256];
} Tipo_Tabla_XML;

typedef struct tag1_estadistica
{
    struct timeb pTimeb1;
    struct timeb pTimeb2;
    struct timeb pTimeb3;
    struct timeb pTimeb4;
    char szLlave[100];
} Tipo_Estadistica;


/*Esto se define para conexiones asincronas donde puede llegar una
 respuesta de manera alernada, entonces se almacena en la lista de respuestas y antes de leer el socket 
 se verifica que no este en la lista de ya recibidos.  
 Cada paquete de respuesta tiene un timeout de vida en la cola igual al timeout del servicio.
 Ademas la region critica es por cada socket asincronico, por ende hay un mutex por cada servicio asincrono.
 Funciona igual que el host-host pero mejorado ....creo :-)*/
#define MAXIMO_RESPUESTAS	500
#define MAX_SERVICIOS_ASIN	100

typedef struct tag_resp_serv_asinc
{
	time_t time_ini;
	char szRespuesta[1024];	
	int nLenRsp;
} Tipo_Resp_Serv_Asinc;

typedef struct tag_serv_asinc
{
	int nEstado;
	int nSocket;
	char szIp[200];
	int nPort;
	int ini_header;
	int fin_header;
	int nLenRsp;
	int nTimeout;
	pthread_mutex_t mutex_serv_asinc;
	int nTotalRespuestas;
	Tipo_Resp_Serv_Asinc Cola[MAXIMO_RESPUESTAS];
	pthread_t  task;
	char szTipoLargo[20];
	int nTotalBytesIdData;
	int ident;
} Tipo_Serv_Asinc;

Tipo_Serv_Asinc ServiciosAsincronos[MAX_SERVICIOS_ASIN];

struct tag_global
{
	//int nPortDatabase;
	//char szIpDatabase[20];
	int nPortBase;
	char szIpBase[35];
	int nProcesosActivos;
	int nProcesosActivosMulti;
	int nFormaConexionBD;
	Tipo_Lista_Formatos *pGListaFormatos;
	pthread_mutex_t mutex_formatos;
	Tipo_Lista_Querys *pGListaQuerys;
	pthread_mutex_t mutex_querys;
	Tipo_Proceso stProcesoWeb;
	Tipo_Tabla_XML xml_servicios;
	Tipo_Tabla_XML xml_isys_tx_formatos;
	Tipo_XML *xml_proceso;
	Tipo_XML *xml_bases;
	//Tipo_XML *xml_servicios;
	Tipo_XML *xml_paginas;
	Tipo_XML *xml_tablas;
	Tipo_XML *xml_formatosms;
	int nTotalBases;
	int nTotalServicios;
	int nTotalPaginas;
	int nTotalTablas;
	int nTotalFormatoSms;

	//int nDatabase;

	//Estadisticas de Proceso
	int nConexionesProceso;
	int nConexionesProcesoMulti;
	int nConexionesBD;
	char szProceso[100];
	char szIpControl[20];
	char szProcesoWeb[20];
	int nPortControl;
	long time_inicio;
	int nMaxConexiones;
	int nMaxConexionesMulti;
	int nPortServicio;
	long lConexionesTotales;
	long lConexionesTotalesMulti;
	Tipo_Estadistica	estd;
	int nTimeoutCorteSocket;
	int nTimeoutLeeData;
	//int nTimeoutBaseDatos;
	char szTransaccion[100];
		
	char szTxPeorTiempo[1024];
	long lTiempoPeorTx;
	long lTiempoPeorTxMulti;
	int nNumProcesosAsinc;
	char szBaseDatos[100];
	char szConexionBD[20];
	int nDisplayAscii;
	int nBorraFile;

	char szError[100];
	int nError;
	int SSL;
#ifdef _ISYS_SSL_
	SSL_CTX* ssl_ctx;
#endif

	//Para 10 tipos de alerta
	time_t time_envio_sms_proceso[MAX_TIPOS_ALERTA];
	int nProcesos;
	Tipo_XML *xml;
	int getip;
	int nMataProceso;
	char szIpBd[20];
	//Si nivel es mayor que uno, reemplaza tags 2 veces
	int nNivelTags;

	//Para indicar los largos de paquetes de entrada
	int nLargoIndicadorData;
	int nIndicaLargo;

	//indica si ya inicializo el rsa este hilo
	int rsa_ok;
#ifdef _ISYS_SSL_
	SSL_CTX* ssl_ctxv2;
#endif
	int nIndiceServicio;
	time_t lTiempoMaxCola;
	time_t lTiempoMaxColaMulti;
	char szIpBloqueada[MAX_IP_BLOQUEADAS][20];
	int nTotalIpBloqueadas;

	//Para dividir procesos multi que funcionan con la verder
	//Este numero separa 2 tipos de proceos 1 hasta N y de N hasta el maximo de proceos
	//1-n procesos normales
	//n-fin procesos multi
	int nTotalProcesosMulti;

	//Para identificar el LOG
	char szPrefijoLog[20];

	//Indica si la aplicacion maneja red gprs sin cerrar conexiones
	char nTipoGprs;
	
	//Indica el tipo de largo que ASCII o HEX para los paquetes entrantes que traigan largo
	char szTipodeLargo[20];

	//Si esta activado lee POST y GET como webserver
	int nHttp;
	//Puerto del Postgres solo para API BaseDatos y ProcesaXmlWeb que va directo a la base
	char szPortPostgres[6];
	char szBasePostgres[30];

	//Lista de Campos BLoqueados
	Tipo_XML *xml_lista_campos_bloqueados;

	//Para que un Listener use Patron Final
	int nFlagPatronFinal;
	char szPatronFinal[200];
	
	//Usuario y clave para base de datos MSQL
	char szUsuarioBD[100];
	char szClaveBD[100];

	//Indica el loop de grabacion de tablas
	int nTotalTablasEscritura;


	//Indica el largo maximo dela linea del log
	int nLargoLineaLog;	
	//Si esta en 1 indica que el protocolo de entrada para el Pxml es desde el apache con scgi
	int scgi;
	//Este parametro determina cuantos ciclos recursivos puede hacer un flujo (parametro de control)
	int nMaximaRecursion;
} global;
Tipo_Tabla_XML stTablaTxForm;


#endif

