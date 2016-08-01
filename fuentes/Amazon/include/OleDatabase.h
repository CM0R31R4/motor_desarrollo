#include "libpq-fe.h" 

PGconn     *OpenDatabase(int id,char szBaseDatos[],char szHost[],char szPort[]);
void CloseDatabase(int id);
int IsOpenDatabase(int id);
PGresult *ExecuteSql(int id,int nSocket,char szSql[],PGconn *conn);
int MoveNextData(int id,int nSocket,PGresult   *res,int nFila);
int CierraSql(int id,PGconn *conn);
