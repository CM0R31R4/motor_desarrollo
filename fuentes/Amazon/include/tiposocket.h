#ifndef _TIPO_SOCKET_
#define _TIPO_SOCKET_

#include <IsysSocket.h>
//#include <IsysCuenta.h>
//#include <IsysTransaccion.h>
#include <tipos.h>

int GetSocketHostHost(int id,Tipo_Socket *pSocket,char szIp[],int nPort);
void InicializaSocket(Tipo_Socket *pSocket,char szDesc[]);
int EnviaSQL(Tipo_Socket *pSocket,char szSql[]);
//int GetTransaccion(Tipo_Transaccion *pTran);
int GetValor(Tipo_Socket *pSocket,char szCampo[],char szValor[],int nTimeout);
void CierraSocket(Tipo_Socket *pSocket);
void CreaConexiones(char szDisplay[],int nConexiones);
int InicializaServerSocket1(const char *sevicio);
int InicializaServerSocket(int nPort);
int SendSocket(int id,int nSocket,char achData[],int nLen);
int ErrorXML(char *response,char szBuffer[],char szGlosa[]);
int InsertaCampoXML(char *response,char szCampo[],char szData[]);
Tipo_XML *GetCampoXML(Tipo_XML *xml,char szCampo[]);
int InicializaServerUdp(int nPort);
int CreateUdp(int nPort);
int sendsock(int m_socket,char szData[],int nLen,int nPort);






#endif
//
