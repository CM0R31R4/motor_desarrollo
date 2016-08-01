#include <stdio.h>

#include <xml.h>
#include <tipos.h>
#include <tiposocket.h>
#include <IsysSocket.h>
#include <IsysCuenta.h>


int LeeTablaCuenta(int id,char szTarjeta[],Tipo_Cuenta *pCuenta,char response[])
{
	char szSql[1000];
	Tipo_XML *xml=NULL;
	int sts;

	sprintf(szSql,"select * from CUENTAS where TARJETA='%s'",szTarjeta);

	if (!QueryDatabase(id,szSql)) return ErrorXML(response,"Lo sentimos, falla comando a la base de datos.","REINTENTE");

	xml=MoveNext(id,&sts);
	if (sts==ERROR_BASE) 
	{
	    ErrorXML(response,"Lo sentimos, error al leer tabla de tarjetas","REINTENTE");
	    goto fin;
	}
	else if (sts==NO_HAY_DATOS)
	{
	    ErrorXML(response,"Lo sentimos, la tarjeta no esta registrada.","CUENTA NO EXISTE");
	    goto fin;
	}
	else
	{
		GetStrXML(xml,"TARJETA",pCuenta->szTarjeta,sizeof(pCuenta->szTarjeta));
		GetIntXML(xml,"CLIENTE",&pCuenta->nCliente);
		GetLongXML(xml,"DISPONIBLE",&pCuenta->lDisponible);
		GetLongXML(xml,"DUEDA_ACTUAL",&pCuenta->lDeudaTotal);
		GetLongXML(xml,"DUEDA_ACTUAL",&pCuenta->lPagoMinimo);
		GetStrXML(xml,"PRODUCTO",pCuenta->szProducto,sizeof(pCuenta->szProducto));
		CierraXML(xml);
		CloseDatabase(id);
		return 1;
	}
fin:
	CierraXML(xml);
	CloseDatabase(id);
	return 0;
}


int ActualizaCupoDisponible(int id,Tipo_Cuenta *pCuenta)
{
	char szSql[1000];
	int sts;

	sprintf(szSql,"update CUENTAS set DISPONIBLE='%ld' where TARJETA='%s'",pCuenta->lDisponible,pCuenta->szTarjeta);

	return SendDatabase(id,szSql);
}

int CalculaCupo(Tipo_Transaccion *pTran,Tipo_Cuenta *pCuenta)
{
	//Verificamos si tiene cupo disponible
	if (pCuenta->lDisponible<pTran->lMonto) return 0;
	
	pCuenta->lDisponible-=pTran->lMonto;
	return 1;
}

/*
int LeeTablaInteres(int id,int nCliente,Tipo_Interes *pInteres,char *response)
{
	char szSql[100];
	int i,j,sts;
	Tipo_XML *xml=NULL;
	
	sprintf(szSql,"select * from CLIENTE_INTERES where codigo_cliente=%i",nCliente);

	if (!QueryDatabase(id,szSql)) goto fin;

	xml=MoveNext(id,&sts);
	if (sts==ERROR_BASE)
        {
            ErrorXML(response,"Lo sentimos, error al leer tabla de interes","REINTENTE");
            goto fin;
        }
        else if (sts==NO_HAY_DATOS)
        {
            ErrorXML(response,"Lo sentimos,no hay datos en CLIENTE_INTERES.","REINTENTE");
            goto fin;
        }
	else
	{
	   CloseDatabase(id);
	   if (!GetIntXML(xml,"CODIGO_INTERES",&pInteres->nCodigoInteres))  goto fin;
	   sprintf(szSql,"select * from interes_desglosados where codigo_interes=%i",pInteres->nCodigoInteres);
	   if (!QueryDatabase(id,szSql)) goto fin;
			
	   i=0;
		pInteres->dInteresTotal=0;
		do
		{
		    xml=MoveNext(id,&sts);
		    if (sts==ERROR_BASE)
        	    {
            		ErrorXML(response,"Lo sentimos, error al leer tabla de CODIGO_INTERES","REINTENTE");
            		goto fin;
        	    }
        	    else if (sts==NO_HAY_DATOS) break;
		    if (!GetStrXML(xml,"DESCRIPCION",pInteres->szDescripcion[i],30)) goto fin;
		    if (!GetDoubleXML(xml,"VALOR",&pInteres->dInteres[i])) goto fin;
		
		     //Obtenemos el interes total
		    pInteres->dInteresTotal += pInteres->dInteres[i];
		    i++;
		} while(1);
	}

	//Calula los pesos relativos
	pInteres->nTotalIntereses = i;
	for(j=0;j<i;j++)
		pInteres->dPesoRelativo[j]=pInteres->dInteres[j]/pInteres->dInteresTotal;
	
	CierraXML(xml);
	CloseDatabase(id);
	return 1;
fin:
	CierraXML(xml);
	CloseDatabase(id);
	return 0;
}
*/

int LeeTablaContrato(int id,int nCliente,Tipo_Contrato *pContrato,char *response)
{
	char szSql[1024];
	char szAux[20],szAux1[10];
	Tipo_XML *xml=NULL;
	int sts;
		
	//Primero Obtenemos las transacciones pendientes de pago
	//o sea en estado 'N' No pagadas.
	sprintf(szSql,"select * from CONTRATO where codigo_cliente=%i",nCliente);
	if (!QueryDatabase(id,szSql)) return ErrorXML(response,"Lo sentimos, falla comando a la base de datos.","REINTENTE");
	
	xml=MoveNext(id,&sts);
	if (sts==ERROR_BASE)
        {
            ErrorXML(response,"Lo sentimos, error al leer tabla CONTRATO","REINTENTE");
            goto fin;
        }
        else if (sts==NO_HAY_DATOS)
        {
            ErrorXML(response,"Lo sentimos, el CONTRATO no esta registrado.","CONTRATO NO REG");
            goto fin;
        }
	if (!GetIntXML(xml,"DIA_FACTURACION",&pContrato->nDiaFacturacion)) goto fin;
	if (!GetIntXML(xml,"DIA_VENCIMIENTO",&pContrato->nDiaVencimiento)) goto fin;
	if (!GetIntXML(xml,"PERIODOS",&pContrato->nPeriodos)) goto fin;
	CierraXML(xml);
	CloseDatabase(id);
	return 1;
fin:
	CierraXML(xml);
	CloseDatabase(id);
	return 0;
	
}

int LeeTablaProducto(int id,char szProducto[],Tipo_Producto *pProducto,char *response)
{
	char szSql[1024];
	Tipo_XML *xml=NULL;
	int sts;
		
	//Primero Obtenemos las transacciones pendientes de pago
	//o sea en estado 'N' No pagadas.
	sprintf(szSql,"select * from PRODUCTOS where producto='%s'",szProducto);

	if (!QueryDatabase(id,szSql)) goto close;
	
	xml=MoveNext(id,&sts);
	if (sts==ERROR_BASE)
        {
            ErrorXML(response,"Lo sentimos, error al leer tabla de PRODUCTOS","REINTENTE");
            goto close;
        }
        else if (sts==NO_HAY_DATOS)
        {
            ErrorXML(response,"Lo sentimos,el producto no esta registrado.","NO EXISTE PROD");
            goto close;
        }
	GetIntXML(xml,"MAX_CUOTAS",&pProducto->nMaxCuotas);
	GetIntXML(xml,"MIN_CUOTAS",&pProducto->nMinCuotas);
	CierraXML(xml);
	CloseDatabase(id);
	return 1;
close:
	CierraXML(xml);
	CloseDatabase(id);
	return 0;
	
}

