
//#define _ISYS_SSL_
//#define _RSA_

#define MAX_CONEXIONES 1000
#define C_ENUSO         1
#define C_LIBRE         2
#define C_EJECUTAR      3
#define C_TERMINAR	4
#define C_TERMINADO	5
#define C_FALLA		6
#define C_ESPERA	7
#define C_XXX		8	//Estado despues de tenerlo libre pero aun no ejecutado

//retornos de la base de datos
#define DATOS_OK	1
#define NO_HAY_DATOS	2
#define ERROR_BASE	3

#define MAX_BUFFER1	8192
#define MAX_BUFFER	262144
//#define MAX_BUFFER	32768

#define BUSCA_TX	1
#define BUSCA_URL	2

#define TIMEOUT_SOCKET		-1
#define CLOSE_SOCKET		-2
#define DATA_SOCKET		1

#define INTEGER			1
#define	STRING			2
#define	LONG			3
#define	STRSTR			4

#define	LLEGA_CONEXION		1
#define	LLEGA_REQUERIMIENTO	2
#define	ENVIA_RESPUESTA		3
#define	LLEGA_CONFIRMACION	4

//Tipo de alerta 
#define MAX_TIPOS_ALERTA	5
#define ALERTA_PROCESO		1
#define ALERTA_PROCESO_ASINC	2

//tipo de proceso
#define PROC_SOCKET		1
#define PROC_XML		2	
#define PROC_MUERTO		3	

//estado del socket

#define S_DESCONECTADO		-1
#define S_CONECTADO		1
#define S_PROCESO		2
#define S_POR_CERRAR		3
