#ifndef _ISYS_SOCKET_
#define _ISYS_SOCKET_

#define MAX_LEN_CAMPO	512

typedef struct xml_generica
{
	char szCampo[MAX_LEN_CAMPO];
	char *pData;
	int nLenData;
	int nLenCampo; //Sirve para algunas optimizaciones
	int nNivel;
	int nTipoCampo;
	struct xml_generica *pNext;
	struct xml_generica *pNextNivel;
} Tipo_XML;

typedef struct tag_comunicacion
{
	int m_socket;
	int nConectado;
	char szDescripcion[20];

	/*Para saber donde se conecto*/
	char szIp[200];
	int nPort;
} Tipo_Socket;

#endif

