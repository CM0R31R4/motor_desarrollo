#include <xml.h>
#include <tipos.h>
#include <stdio.h>
#include <memory.h>
#include <IsysTransaccion.h>
#include <stdlib.h>
#include <time.h>

int InicializaFechaHora(Tipo_Transaccion *pTran)
{
    time_t   t1;
    struct tm tt2;
  	time(&t1);
	tt2 = *localtime(&t1);
	sprintf(pTran->szFecha,"%04i%02i%02i",tt2.tm_year+1900,tt2.tm_mon,tt2.tm_mday);
	sprintf(pTran->szHora,"%02i%02i%02i",tt2.tm_hour,tt2.tm_min,tt2.tm_sec);
}

int InicializaTransaccion(Tipo_Transaccion *pTran,Tipo_XML *xml)
{

	memset(pTran,0,sizeof(Tipo_Transaccion));

	InicializaFechaHora(pTran);
	GetStrXML(xml,"SERVICIO",pTran->szServicio,sizeof(pTran->szServicio));
	GetStrXML(xml,"TARJETA",pTran->szCuenta,sizeof(pTran->szCuenta));
	GetLongXML(xml,"MONTO",&pTran->lMonto);
	GetIntXML(xml,"CUOTAS",&pTran->nCuotas);
	GetStrXML(xml,"LOCAL",pTran->szLocal,sizeof(pTran->szLocal));
	GetStrXML(xml,"TERMINAL",pTran->szTerminal,sizeof(pTran->szTerminal));

	return 1;
}


int GrabaTablaTransaccion(int id,Tipo_Transaccion *pTran)
{
	char szData[1024];
	int sts;

	sprintf(szData,"insert into transaccion (codigo_cliente,fecha,servicio,codigo_autorizacion,monto_neto,monto_credito,cuotas,estado_proceso,cuenta,producto,\
		codigo_interes,interes_diario,impuesto)\
		values ('%02i','%s','%s','%s','%ld','%f','%i','%c','%s','%s','%i','%f','%f')",
		pTran->nCliente,
		pTran->szFecha,
		pTran->szServicio,
		pTran->szCodAut,
		pTran->lMonto,
		pTran->dMontoCredito,
		pTran->nCuotas,
		'P',
		pTran->szCuenta,
		pTran->szProducto,
		pTran->nCodigoInteres,
		pTran->dInteresDiario,
		pTran->dImpuesto);

		
	return SendDatabase(id,szData);
}

int GrabaEstadistica(int id,int nTx)
{
	char szSql[1024];
	char szAux[10];
	Tipo_XML *xml=NULL;
	int sts;
    	time_t   t1;
    	struct tm tt2;
	char szFecha[10];

  	time(&t1);
	tt2 = *localtime(&t1);
	sprintf(szFecha,"%04i%02i%02i",tt2.tm_year+1900,tt2.tm_mon,tt2.tm_mday);
		
	sprintf(szSql,"update ESTADISTICA set CANTIDAD=CANTIDAD+1 where TX=%i and fecha='%s'",nTx,szFecha);
	printf("%s\n\r",szSql);

	if (!SendDatabase(id,szSql)) goto close;

	CierraXML(xml);
	CloseDatabase(id);
	return 1;
close:
	CierraXML(xml);
	CloseDatabase(id);
	return 0;

inserta:
	sprintf(szSql,"insert into ESTADISTICA (TX,CANTIDAD) values (%i,%ld)",nTx,1);
	printf("%s\n\r",szSql);

	if (!SendDatabase(id,szSql)) goto close;

	CierraXML(xml);
	CloseDatabase(id);
	return 1;

}

int LeeTablaCodAut(int id,char szCodAut[])
{
	char szSql[1024];
	Tipo_XML *xml=NULL;
	int sts;
		
	//Primero Obtenemos las transacciones pendientes de pago
	//o sea en estado 'N' No pagadas.
	sprintf(szSql,"select CODIGO from CODAUT for update");

	if (!QueryDatabase(id,szSql)) goto close;

	xml=MoveNext(id,&sts);
	
	if (sts!=DATOS_OK) goto close;

	if (!GetStrXML(xml,"CODIGO",szCodAut,sizeof(szCodAut))) goto close;
	CloseDatabase(id);

	sprintf(szSql,"update CODAUT set CODIGO=%ld",atol(szCodAut)+1);

	if (!SendDatabase(id,szSql)) goto close;

	CierraXML(xml);
	CloseDatabase(id);
	return 1;
close:
	CierraXML(xml);
	CloseDatabase(id);
	return 0;

}
