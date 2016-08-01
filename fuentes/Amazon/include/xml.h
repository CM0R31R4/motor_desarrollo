#ifndef _TIPO_XML_
#define _TIPO_XML_

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "tiposocket.h"


Tipo_Data *LeeNData_sin_CRLF(int id,int nSocket,int nDataEsperada1,Tipo_Data *pData,int nTimeout,int *sts);
Tipo_Data *AplicaFuncionesVar(int id,char szAux[],Tipo_Formatos *pFor,int nLen);
unsigned char *base64_decode(const char *data, size_t input_length, size_t *output_length);
char *base64_encode(const unsigned char *data, size_t input_length, size_t *output_length);
Tipo_XML *WriteLogApp(int id,Tipo_XML *xml);
Tipo_XML *InsertaDataLenXML(Tipo_XML *xml,char szCampo[],char szData[],int nLen);
Tipo_Data *LeeDataPatronFinalData(int id,int socket,Tipo_Data *pData,int nTimeout,char szPatronFinal[],int *nLeidos);
Tipo_Data *GetOneRecordAsinc1(int id,char szSql[],Tipo_Data *pData);
Tipo_Data *AplicaFuncionesData(Tipo_Data *pData,char szBuffer[]);
Tipo_XML *GetMultiple(int id,char szSql[],int *nTotal,Tipo_XML *xml,int *nStatus);
Tipo_XML *GetRecordMulti(int id,char szSql[],Tipo_XML *xml,int *nStatus);
//int LeeWebServer(int id,int socket,char szBuffer[],int nMaxLenBuffer,int nTimeout);
Tipo_Data *LeeWebServer(int id,int socket,Tipo_Data *pData,int nTimeout,int *Status);
Tipo_Data *LeeNData(int id,int nSocket,int nDataEsperada,Tipo_Data *pData,int nTimeout,int *sts);
Tipo_Data *LeeNDataWebServer(int id,int nSocket,int nDataEsperada,Tipo_Data *pData,int nTimeout,int *sts);
#ifdef FLAG_POSTGRES
PGconn     *OpenDatabase(int id,char dbName[],char pghost[],char pgport[]);
PGresult *EsperoResultados(int id,int *nTotal);
Tipo_Data *SacoResultados(int id,PGresult *res,int nReg,Tipo_Data *pData);
#elif FLAG_MYSQL
MYSQL      *OpenDatabase(int id,char dbName[],char pghost[],char pgport[]);
#endif
void EsperaActivacion2(int id,Tipo_Conexion *p);
Tipo_XML *LeePaqueteXML(int id,int socket,int nTimeout,Tipo_XML *xml,int *nStatus);
Tipo_XML *LeePaqueteSCGI(int id,int socket,int nTimeout,Tipo_XML *xml,int *nStatus);
int EsperaConexionLibre(int id,int nProcesos);
int EsperaConexionLibreMulti(int id,int nProcesos);
Tipo_XML *MoveNext100(int id,Tipo_XML *xml,int *sts,char szTipo[]);
Tipo_XML *BuscaNivel(Tipo_XML *xml,int nNivel);
Tipo_XML *DeserializaXML(Tipo_XML *xml,char *);
Tipo_XML *ExecuteSql1(int id,char szSql[],int *nTotal,int nTipo,Tipo_XML *xml,int *sts);
Tipo_XML *AplicaQuerysServicio(int id,Tipo_XML *xml,int nTx,int *bContesta,int *nStatus);
Tipo_XML *GetRespuestaServicio(int id,Tipo_Socket *pSocket,int nTimeout,Tipo_XML*xml,int *sts);
Tipo_XML *TransformaDataEntranteNivelXML(int id,Tipo_XML *xml,Tipo_XML *xmlin,int nNivel);
Tipo_XML *TransformaDataEntranteNivel(int id,Tipo_XML *xml,char szMsg[],int nNivel);
Tipo_XML *TransformaDataEntranteNivel1(int id,Tipo_XML *xml,char szMsg[],int nNivel,int nLenMsg);
Tipo_XML *TransformaDataEntranteXML(int id,Tipo_XML *xml,Tipo_XML *xmlin);
Tipo_XML *TransformaDataEntrante(int id,Tipo_XML *xml,char szMsg[]);
Tipo_XML *TransformaPaquete(int id,Tipo_XML *xml,char szMsg[],char szData[]);
Tipo_XML *ProcesaInputXML1(Tipo_XML *xml,char szInput[]);
Tipo_XML *ProcesaInputXML2(Tipo_XML *xml,char szInput[]);
Tipo_XML *ProcesaInputRaizXML(char szRaiz[],char szInput[],Tipo_XML *xml);
int GetStrXML(Tipo_XML *xml,char szCampo[],char szValor[],int size);
Tipo_XML *GetStrXMLData(Tipo_XML *xml,char szCampo[]);
Tipo_XML *GetStrXMLRec(Tipo_XML *xml,char szCampo[],char szValor[],int size);
Tipo_XML *GetRecord(int id,char szSql[],Tipo_XML *xml,int *nStatus);
Tipo_XML *GetRecords(int id,char szSql[],int *nTotal,Tipo_XML *xml,int *nStatus);
Tipo_XML *GetRecords1(int id,char szSql[],int *nTotal,Tipo_XML *xml,int *nStatus);
Tipo_XML *GetNivelXML(Tipo_XML *xml,int nNivel);
//int EnviaComando(Tipo_Socket *pSocket,char szComando[],char szSql[]);

Tipo_XML *EnviaComando(int id,char szComando[],char szSql[],int *sts,Tipo_XML *xml);
int ConectaCliente(int id,int nPort,char szIp[],Tipo_Socket *pSocket);
int GetDoubleXML(Tipo_XML *xml,char szCampo[],double *l);
int GetCharXML(Tipo_XML *xml,char szCampo[],char *l);
int GetLongXML(Tipo_XML *xml,char szCampo[],long *l);
int GetIntXML(Tipo_XML *xml,char szCampo[],int *l);
void WriteLog(int id,char szMen[]);
Tipo_XML *CierraXML(Tipo_XML *xml);

Tipo_XML *MoveNext(int id,int *sts);
int QueryDatabase(int id,char szSql[]);
int LeePaquete(int id,int socket,Tipo_Data *pData,int nTimeout);
Tipo_XML *QueryDatabase1(int id,char szSql[],char szCampo[],char szError[],Tipo_XML *xml,int *nStatus);
Tipo_XML *GetCamposDatabase(int id,int *sts,char szTabla[]);
Tipo_Querys *LeeQuery(int id,int nTx);
Tipo_Formatos *LeeFormato(int id,int nFormato);
void CierraFormato(Tipo_Formatos *pFormato);
int LargoFormato(Tipo_Formatos *pFormato);
int EjecutaServicio(int id,int nTx,Tipo_XML *xml,int nFlag);

Tipo_Data *BorraTags(Tipo_Data *pData,char szPatron[]);
Tipo_Data *BorraTags1(Tipo_Data *pData,char szPatron[]);
Tipo_Data *LiberaData(Tipo_Data *pData);
Tipo_Data *ReemplazaTags(Tipo_Data *pData,Tipo_XML *xml,char szPatron[]);
Tipo_Data *ReemplazaTags1(Tipo_Data *pData,Tipo_XML *xml,char szPatron[]);
Tipo_Data *ReemplazaTagsHtml(Tipo_Data *pData,Tipo_XML *xml,char szPatron[]);
Tipo_Data *ReemplazaComillasTags(Tipo_Data *pData,Tipo_XML *xml,char szPatron[]);
Tipo_Data *ReemplazaTagsStr1(Tipo_XML *xml,char szSql[]);
Tipo_Data *NewData(char szData[]);
Tipo_Data *NewString(Tipo_Data *pData,char szData[]);
Tipo_Data *CreaData(void);
Tipo_Data *ConcatenaData(char szData[],Tipo_Data *pData,int nLeido);
Tipo_Data *LeeDataVariable(int id,int socket,Tipo_Data *pData,int nTimeout,int *sts1);

void LimpiaVendedores(Tipo_Vendedores *pFormato);
void LimpiaExporta(Tipo_Exporta *pFormato);
Tipo_Exporta *InicializaFilesExportacion(int id,int nCliente);
Tipo_Vendedores *InicializaVendedores(int id);

Tipo_Data *InsertaData(char szData[],Tipo_Data *pDAta);
Tipo_Data *InsertaDataLen(char szData[],int nLen,Tipo_Data *pDAta);
Tipo_Data *LeeArchivo(char szPagina[]);

Tipo_Formatos *LeeFormatoBase(int id,int nFormato);
Tipo_IpBackoffices *BuscaIpBackoffices(char szCliente[],char chTipoTx,Tipo_IpBackoffices *p);
Tipo_IpBackoffices *InicializaIpBackoffices(int id);
Tipo_XML *UpdateXML(Tipo_XML *xml,Tipo_XML *xml2);
Tipo_XML *UpdateXMLSinNulo(Tipo_XML *xml,Tipo_XML *xml2);
Tipo_XML *SetValorIntXML(Tipo_XML *xml,char szCampo[],int nValor);
Tipo_XML *AutorizaServicio(int id,char szPaquete[],int nMaxLen,char szIp[],int nPort);
Tipo_XML *AutorizaServicio1(int id,Tipo_XML *xml,Tipo_Servicio *pServ,int *sts);
//Tipo_XML *AutorizaServicio2(int id,char szPaquete[],Tipo_Formatos *pFor,char szIp[],int nPort);


Tipo_XML *InsertaDataXML(Tipo_XML *xml,char szCampo[],char szData[]);
Tipo_XML *InsertaDataXMLNivel(Tipo_XML *xml,char szCampo[],char szData[],int i);
Tipo_XML *InsertaDataXML1(Tipo_XML *xml,char szCampo[],char szData[],int nTipo);
Tipo_XML *InsertaDataIntXML(Tipo_XML *xml,char szCampo[],int nData);
Tipo_XML *InsertaDataLongXML(Tipo_XML *xml,char szCampo[],long lData);
Tipo_XML *GetXMLRaiz(char szRaiz[],Tipo_XML *xml);
Tipo_XML *IniciaXML();
char *GET_PAGINA_SERVICIO(int id);
int BuscaArchivosDirectorio(int id,char szPath[],char szFile[]);
int BuscaArchivosPatron(int id,char szPath[],char szPatron[],char szFile[]);
int BuscaServicio(int id,Tipo_Servicio *p,int nTipo);
		
int AplicaFormatoSalida(int id,char szLinea[],Tipo_XML *xml1,Tipo_Formatos *pFor,int *nLenLinea);
Tipo_Data *AplicaFormatoSalidaVar(int id,Tipo_Data *pData,Tipo_XML *xml1,Tipo_Formatos *pFor,int *nLenLinea);
Tipo_XML *AplicaFormatoEntrada(int id,Tipo_XML *xml,char data[],Tipo_Formatos *pFor,int nLenData);
Tipo_XML *AutorizaServicioXML(int id,Tipo_XML *xml,Tipo_Formatos *pForSalida,Tipo_Formatos *pForAck,Tipo_Servicio *pServ,int *nStatus);
Tipo_XML *BorraCampoXML(Tipo_XML *xml1,char szCampo[]);
Tipo_XML *StrcpyXML(Tipo_XML *xml,Tipo_XML *xml2);
Tipo_XML *StrcatXML(Tipo_XML *xml,Tipo_XML *xml2);
Tipo_XML *GetCampoDataXML(Tipo_XML *xml,char szCampo[],char szData[]);
Tipo_Data *CierraDataFile(int id,Tipo_XML *xml,Tipo_Data *pData);
Tipo_Data *InsertaDataFile(int id,Tipo_Data *pData,Tipo_XML *xml1,Tipo_Formatos *pForSalida,Tipo_XML *xml);


Tipo_XML *BuscaTablaXml(int id,Tipo_Tabla_XML *p,char szCampo[],char szData[],int nTipo,int *nNivel);

int INIT_GLOBAL();
int SET_GLOBAL_PORT_DATABASE(int nPort);
int SET_GLOBAL_IP_DATABASE(char szIp[]);
int SET_DATABASE(int nDatabase);
int GET_DATABASE(int id);
int SET_GLOBAL_DATABASE(int id,int nDatabase);
long hex2long(char szHex[]);
int EnviaSms(int id,char szData[],char szFono[]);

#endif
