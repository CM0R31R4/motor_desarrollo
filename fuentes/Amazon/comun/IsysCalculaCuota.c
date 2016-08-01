#include <stdio.h>
#include <xml.h>
#include <tipos.h>
#include <tiposocket.h>
#include <IsysSocket.h>
#include <IsysCuenta.h>
#include <math.h>

#include <time.h>

int FechaProximoVencimiento(Tipo_Contrato *pContrato,char szFecha[])
{

    time_t   t1;
    struct tm tt1;

    time(&t1);
    tt1 = *localtime(&t1);

    //Si la fecha de facturacion es menor al dia actual..
    if (pContrato->nDiaFacturacion>tt1.tm_mday)
    {
	tt1.tm_mday = pContrato->nDiaVencimiento;
        tt1.tm_mon=(tt1.tm_mon+pContrato->nPeriodos)%12;
    	if (tt1.tm_mon+pContrato->nPeriodos>12) tt1.tm_year++;
    }
    tt1.tm_mday = pContrato->nDiaVencimiento;
 
    sprintf(szFecha,"%04i%02i%02i",tt1.tm_year+1900,tt1.tm_mon+1,tt1.tm_mday);
}

/*-----------------17-08-00 08:05p.-----------------
 * Calcula la cantidad de dias desde el dia actual
 * hasta la fecha del proximo vencimiento
 * formato AAAAMMDD
 * --------------------------------------------------*/
int NumeroDiasAntesCorte(Tipo_Contrato *pContrato)
{
    //El dia actual esta lleno en la estructura trans
    //El dia de la fecha de vencimiento esta en la tabla clitar. DD/MM/AAAA
    time_t   t1,t2;
    struct tm tt2,tt1;

    time(&t1);
	tt1 = *localtime(&t1);
	tt2 = *localtime(&t1);
 	tt2.tm_year = tt1.tm_year;
    
	if (tt1.tm_mon+1>12) 
	{
		tt2.tm_mon=1;
		tt2.tm_year++;
	}
	else tt2.tm_mon=tt1.tm_mon+1;
    
	tt2.tm_mday= pContrato->nDiaVencimiento;
    
	//realizo la converswion a segundos
    t2 = mktime(&tt2);
    return (int)(difftime(t2,t1)/86400);
}


void ValorCreditoCuotas(Tipo_Transaccion *pTran,Tipo_Interes *pInteres,Tipo_Contrato *pContrato)
{
	//Formula para obtener el valor credito
	double i=pInteres->dInteresTotal;
	double A=pow(1+i,pTran->nCuotas+1)-(1+i);
	double B=i*(pow(1+i,pTran->nCuotas));
	double dImp=0.00134 * pTran->nCuotas;
	
	//interes simple diario
	pTran->dInteresDiario=pTran->lMonto*i*NumeroDiasAntesCorte(pContrato)/30;

	//Impuesto
	if ( dImp> 0.012) dImp= 0.012;
    pTran->dImpuesto = pTran->lMonto * dImp;
	
	//Aplicamos la formula para obtener el valor Credito
	pTran->dValorCuotaCredito= B*(pTran->lMonto)/A;
	pTran->dMontoCredito=pTran->dValorCuotaCredito*pTran->nCuotas;
	pTran->dMontoCredito += pTran->dInteresDiario+pTran->dImpuesto;

}


