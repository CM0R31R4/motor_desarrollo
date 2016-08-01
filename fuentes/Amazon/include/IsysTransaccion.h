#ifndef _ISYS_TRANSACCION_
#define _ISYS_TRANSACCION_

typedef struct tag_transacc
{
	char szServicio[12];
	int nCliente;
	long lMonto;
	double dMontoCredito;
	char szCodAut[11];
	int nCuotas;
	char chEstado;
	char szCuenta[17];
	char szFecha[9];
	char szHora[7];
	double dInteresDiario;
	double dImpuesto;
	double dValorCuotaCredito;
	char szProducto[11];
	int nCodigoInteres;
	char szLocal[10];
	char szTerminal[10];
	
} Tipo_Transaccion;

int InicializaTransaccion(Tipo_Transaccion *pTran,Tipo_XML *xml);
int GrabaTablaTransaccion(int id,Tipo_Transaccion *pTran);
int LeeTablaCodAut(int id,char szCodAut[]);


#endif

