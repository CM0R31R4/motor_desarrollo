#ifndef _ISYS_CUENTA_
#define _ISYS_CUENTA_

#include <tipos.h>
#include <IsysTransaccion.h>

typedef struct tag_cuenta
{
	char szTarjeta[20];
	int nCliente;
	long lDisponible;
	long lDeudaTotal;
	long lPagoMinimo;
	char chEstado;
	char szProducto[11];
} Tipo_Cuenta;

int CalculaCupo(Tipo_Transaccion *pTran,Tipo_Cuenta *pCuenta);

int LeeTablaCuenta(int id,char szTarjeta[],Tipo_Cuenta *pCuenta,char response[]);
int ActualizaCupoDisponible(int id,Tipo_Cuenta *pCuenta);
int LeeTablaInteres(int id,int nCliente,Tipo_Interes *pInteres,char *response);
int LeeTablaContrato(int id,int nCliente,Tipo_Contrato *pContrato,char *response);
int LeeTablaProducto(int id,char szProducto[],Tipo_Producto *pProducto,char *response);





#endif

