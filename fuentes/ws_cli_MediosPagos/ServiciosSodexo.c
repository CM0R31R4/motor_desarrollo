#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/time.h>
#include <unistd.h>
#include <sys/timeb.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <signal.h>
#include <stdio.h>
#include <string.h> 
#include <fcntl.h>
#include <errno.h>
#include <netdb.h>
#include <pthread.h>
#include "soapH.h"
#include "MCWebSdxWS.nsmap"

#define MAX_DESCRIPTION 200
#define FECHA 25
#define BACKLOG 100

#include <xml.h>

FILE *logDebug;

void ProcesaArgumentos(int,char **);

//---------------------------------------------------------------------------------
//---------------------PROGRAMA PRINCIPAL------------------------------------------
//---------------------------------------------------------------------------------

int main(int argc,char *argv[])
{ int m, s; /* master and slave sockets */
  struct soap soap;
  void *process_request(void*);
  struct soap *tsoap;
  pthread_t tid;
  int port;  
	 	
  INIT_GLOBAL();
  ProcesaArgumentos(argc,argv);
  //soap_init(&soap);
  soap_init2(&soap,SOAP_IO_KEEPALIVE,SOAP_IO_KEEPALIVE|SOAP_IO_STORE);
  
  if (argc < 2){    
    soap_serve(&soap);	/* serve as CGI application */
    soap_destroy(&soap); 
    soap_end(&soap);
  }
  else
  {
    port = atoi(argv[1]);  
    soap.socket_flags = MSG_NOSIGNAL;
    soap.bind_flags=SO_REUSEADDR;
    m = soap_bind(&soap, NULL, port, BACKLOG);
    if (m < 0)
    { soap_print_fault(&soap, stderr);
      exit(1);
    }

    fprintf(stderr,"Conexion Socket Perfecta: Socket Maestro = %d\n", m);
       	

    for ( ; ; )
    {
      s = soap_accept(&soap);
      if (s < 0)
      { soap_print_fault(&soap, stderr);
        break;
      }
      fprintf(stderr, "Conexion Socket Perfecta: Socket Esclavo = %d\n", s);
      fprintf(stderr, "Conexion Socket Perfecta: Socket Esclavo = %d\n", s);
          
      tsoap = soap_copy(&soap);
      if (!tsoap)
	 break;
      pthread_create(&tid,NULL,(void*(*)(void*))process_request, (void*)tsoap);
    }
  }
 
  	soap_done(&soap);	
  return 0;
}




//-----------------------Process Request------------------------------------------
void *process_request(void *soap)
{
  pthread_detach(pthread_self());
  soap_serve((struct soap *)soap);
  soap_destroy((struct soap *) soap);
  soap_end((struct soap*) soap);
  soap_done((struct soap*) soap);
  free(soap);
  return NULL;
}


//--------------------Thread------------------------------------------------------
void Thread_Exit(){}
void TransactionThread() {}



char * CompletaZeros(char cadena[50], int largo)
{ 
  int h=0;
  char buffer[50];

  sprintf(buffer,"%s","");  
  
  for(h=0;h<largo;h++)
  	{
  	 strcat(buffer,"0");  		
  	}
  
  strcat(buffer,cadena);
  
  return buffer;	
}


//----------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------ACTIVACION TARJETA---------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------

int __ns1__ActivacionTarjeta(struct soap *soap, struct ns1__ActivacionTarjeta *entrada, struct ns1__ActivacionTarjetaResponse *salida)
{
	Tipo_XML *xml=NULL;
        Tipo_XML *xml1=NULL;        
        Tipo_Servicio stServ;
        int id;        
        char szAux[200];
        char tem[30];
	char cola[3]=",00";       
	char vectorTarjetas[200];
	char sbufferTar[100];

	char glosaSalida[100];
	char vectorSalida[200];
	int  statusGlosaSalida;

        int sts;
        int x;
        int i;
               
	sprintf(vectorTarjetas,"%s","");
	sprintf(vectorSalida,"%s","");

	fprintf(stderr,"Inicia Activaion Tarjeta \n");
	
	id=0;
        //Los WebServices se definen como el servicio 5
        stServ.nTx=1600;
        sprintf(stServ.szIp,"127.0.0.1");
        stServ.nPort=2010;
        stServ.nTimeout=10;
        stServ.nTipoRespuesta=2;
        stServ.nLenMinimo=100;

        //fprintf(stderr,"1 status=%i error=%i entrada=%x\n",soap->status,soap->error,entrada);
        if (!entrada)
        {
           WriteLog(id,"No viene estructura de Entrada");
           return soap_receiver_fault(soap, "No viene estructura de Entrada", NULL);
        }
        else
        {	
        	fprintf(stderr,"Valores de Entrada\n");
        	WriteLog(id,"Valores de Entrada: ");
        	fprintf(stderr,"   entrada->arg0->sTipoId: %d\n",entrada->arg0->sTipoId);
        	fprintf(stderr,"   entrada->arg0->sCliente: %s\n",entrada->arg0->sCliente);
        	fprintf(stderr,"   entrada->arg0->sValorId: %s\n",entrada->arg0->sValorId);
        	fprintf(stderr,"   entrada->arg0->sServicio: %d\n",entrada->arg0->sServicio);
        	fprintf(stderr,"   entrada->arg0->sizeTarjetas:%d\n",entrada->arg0->__sizesTarjetas);
        	
        	fprintf(stderr,"\nInsertando en # \n");       	        	
	        xml=InsertaDataIntXML(xml,"TX",stServ.nTx);	
	        //xml=InsertaDataXML(xml,"ID_CONSULTA",entrada->arg0->sTipoId);
	        xml=InsertaDataXML(xml,"RUT_CLIENTE",entrada->arg0->sCliente);
	        xml=InsertaDataXML(xml,"COD_USUARIO",entrada->arg0->sValorId);
	        xml=InsertaDataIntXML(xml,"SERVICIO",entrada->arg0->sServicio);	        
	        			    
	        
	        fprintf(stderr,"__sizesTarjetas: %d",entrada->arg0->__sizesTarjetas);	
	        
	        
	        if(entrada->arg0->__sizesTarjetas==0)
	        {
	        	entrada->arg0->sTarjetas = (struct ns1__ListTarjetas *) malloc (sizeof(struct ns1__ListTarjetas));	
	        	entrada->arg0->sTarjetas[0].Tarjeta = (char *) malloc (100);
	        	sprintf(entrada->arg0->sTarjetas[0].Tarjeta,"0000000000000000");
	        	entrada->arg0->__sizesTarjetas=1;
		}
	            
	        			       	        
	        for (x=0;x<entrada->arg0->__sizesTarjetas;x++)
	        {	             
	             sprintf(sbufferTar,entrada->arg0->sTarjetas[x].Tarjeta);
	             if(strlen(sbufferTar)==0)
	             {
		       sprintf(sbufferTar,"0000000000000000");      
		     }
		     
		     if(strlen(sbufferTar)<16)
		     {
		     	sprintf(sbufferTar, CompletaZeros(sbufferTar,(16-strlen(sbufferTar))));
		     } 
		     
		    strcpy(tem,sbufferTar);
		    strcat(tem,cola);             
		    strcat(vectorTarjetas,tem);	          		        
		    fprintf(stderr,"    entrada->arg0->sTarjetas[%d].Tarjeta: %s \n",x,tem);
	        }	        
	        
		fprintf(stderr,"     vector en #: %s \n",vectorTarjetas);
		
	 	xml=InsertaDataXML(xml,"VECTOR_TARJETA",vectorTarjetas);
				
	
		//Enviamos al Switch con la Funcion AutorizaServicio1	
	        xml1=AutorizaServicio1(id,xml,&stServ,&sts);
		
		  if (!sts)
		        {
	                fprintf (stderr,"Servicio no contesta\n");
	                return soap_receiver_fault(soap,szAux, NULL);
		        }
	
	          fprintf (stderr,"Servicio Contesta\n");
	          //Si la variable __SOAP_FAULT__ viene en 1 entonces falla servicio 6000
	          if (GetIntXML(xml1,"__SOAP_FAULT__",&sts))
		        {
		            if (sts)
		            {
		               GetStrXML(xml1,"MENSAJE_RESP",szAux,sizeof(szAux));
		               WriteLog(id,szAux);
		               fprintf (stderr,"MENSAJE_RESP:%s\n",szAux);
		               return soap_receiver_fault(soap,szAux , NULL);
		            }
		        }

	        fprintf (stderr,"\nComenzamos a capturar respuesta en #\n");
		//capturamos la respuesta y empezamos a procesarla
		GetStrXML(xml1,"GLOSASTATUSSP",glosaSalida,sizeof(glosaSalida));
		GetIntXML(xml1,"STATUSSP",&statusGlosaSalida);
		
		fprintf(stderr,"   respuesta:%s\n",glosaSalida); 
		fprintf(stderr,"   codio res:%d\n",statusGlosaSalida); 
		
		
		//salida = (struct ns1__ActivacionTarjetaResponse *) malloc (sizeof(struct ns1__ActivacionTarjetaResponse));
		salida->return_ = (struct ns1__outputWSActivacionTarjeta *) malloc (sizeof(struct ns1__outputWSActivacionTarjeta));		
		salida->return_->SGlosaStatus=(char *) malloc (100);					
		
		fprintf(stderr,"Asignamos memoria Ok\n"); 	
		
		salida->return_->__sizelistaTrjOut=0;
		fprintf(stderr,"__sizelistaTrjOut OK\n"); 	
		
		if(strcmp(glosaSalida,"SIN GLOSA STATUS")==0)
		{
		  sprintf (glosaSalida,"%s",""); 
		}
		
		 	
		sprintf (salida->return_->SGlosaStatus,"%s",glosaSalida); 
		fprintf(stderr,"salida->return_->SGlosaStatus OK\n"); 	
		 		
		salida->return_->SStatusMsg=statusGlosaSalida;			
		fprintf(stderr,"salida->return_->statusGlosaSalida OK\n"); 
		
		
		int sElementos=0;
		GetIntXML(xml1,"SELEMENTOS",&sElementos);	
				
		i=0;
		if(sElementos>0)		
		{		
			salida->return_->listaTrjOut= (struct ns1__listTrjOut *)malloc(sizeof(struct ns1__listTrjOut));			

			char szCampo[100];												 		
							
			for ( i=0 ; i < sElementos ; i++)
			{
			salida->return_->listaTrjOut= (struct ns1__listTrjOut *)realloc(salida->return_->listaTrjOut,sizeof(struct ns1__listTrjOut )*(i+1));
			salida->return_->listaTrjOut[i].SStatusTarjeta=(char *)malloc(100);
			salida->return_->listaTrjOut[i].STarjeta=(char *)malloc(100);		
			
			sprintf(szCampo,"SPAN%i",i+1);
			GetStrXML(xml1,szCampo,salida->return_->listaTrjOut[i].STarjeta,100);
			fprintf(stderr,"SPAN %d:%s\n",i,salida->return_->listaTrjOut[i].STarjeta);
			
			sprintf(szCampo,"SESTADO%i",i+1);
			GetStrXML(xml1,szCampo,salida->return_->listaTrjOut[i].SStatusTarjeta,100);				      			
	   		}	
		}
		
		salida->return_->__sizelistaTrjOut = i;			
					
		fprintf(stderr,"Llegue aca size: %i\n", salida->return_->__sizelistaTrjOut); 			        	
		        	
        	soap_done(&soap);                	        	        		
        	//soap_done(soap);                	        	        		
        	return SOAP_OK;		
	} 
}

//----------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------CONSULTA SALDO Y TRANSACCIONES DEL DIA POR BENEFICIAERIO-------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
int __ns1__ConsultaSaldoYTrxDiaPorBeneficiario(struct soap *soap,struct ns1__ConsultaSaldoYTrxDiaPorBeneficiario* entrada,struct ns1__ConsultaSaldoYTrxDiaPorBeneficiarioResponse* salida){
	Tipo_XML *xml=NULL;
        Tipo_XML *xml1=NULL;        
        Tipo_Servicio stServ;
        int id;
        char szAux[200];        
	char vectorTarjetas[2000]="";

	char glosaSalida[100];
	int SSaldoDisp;
	int SSaldoVenc;
	int SStatus;
	
	char vectorSalida[200];
	
        int sts;        
        int i;
        
                	
	sprintf(vectorTarjetas,"%s","");
	strcpy(vectorSalida,"");

	fprintf(stderr,"Inicia Activaion Tarjeta \n");
	
	id=0;
        //Los WebServices se definen como el servicio 5
        stServ.nTx=1610;
        sprintf(stServ.szIp,"127.0.0.1");
        stServ.nPort=2010;
        stServ.nTimeout=10;
        stServ.nTipoRespuesta=2;
        stServ.nLenMinimo=100;

        //fprintf(stderr,"1 status=%i error=%i entrada=%x\n",soap->status,soap->error,entrada);
        if (!entrada)
        {
           WriteLog(id,"No viene estructura de Entrada");
	   fprintf(stderr,"Error Entrada\n");
           return soap_receiver_fault(soap, "No viene estructura de Entrada", NULL);
        }
        else
        {	
        	fprintf(stderr,"Valores de Entrada\n");
        	fprintf(stderr,"   entrada->arg0->S_USCORETipo_USCOREID: %d\n",entrada->arg0->S_USCORETipo_USCOREID);
        	fprintf(stderr,"   entrada->arg0->S_USCOREValor_USCOREID: %s\n",entrada->arg0->S_USCOREValor_USCOREID);
        	fprintf(stderr,"   entrada->arg0->S_USCOREServicio: %d\n",entrada->arg0->S_USCOREServicio);
        	fprintf(stderr,"   entrada->arg0->S_USCORECliente: %s\n",entrada->arg0->S_USCORECliente);
        	        	
        	fprintf(stderr,"\nInsertando en # \n");
	        xml=InsertaDataIntXML(xml,"TX",stServ.nTx);
	        xml=InsertaDataIntXML(xml,"WS_SAL",2);
	        xml=InsertaDataIntXML(xml,"ID_CONSULTA",entrada->arg0->S_USCORETipo_USCOREID);
	        xml=InsertaDataXML(xml,"ID_IDENTIFICA_CONSULTA",entrada->arg0->S_USCOREValor_USCOREID);
	        xml=InsertaDataIntXML(xml,"SERVICIO",entrada->arg0->S_USCOREServicio);	        
	        xml=InsertaDataXML(xml,"RUT_CLIENTE",entrada->arg0->S_USCORECliente);
	
		//Enviamos al Switch con la Funcion AutorizaServicio1	
	        xml1=AutorizaServicio1(id,xml,&stServ,&sts);
		fprintf(stderr,"AutorizaServicio1 Ok \n");
	
		  if (!sts)
		        {
	                fprintf (stderr,"Servicio no contesta\n");
	                return soap_receiver_fault(soap,szAux, NULL);
		        }
	
	          fprintf (stderr,"Servicio Contesta\n");
	          //Si la variable __SOAP_FAULT__ viene en 1 entonces falla servicio 6000
	          if (GetIntXML(xml1,"__SOAP_FAULT__",&sts))
		        {
		            if (sts)
		            {
		               GetStrXML(xml1,"MENSAJE_RESP",szAux,sizeof(szAux));
		               WriteLog(id,szAux);
		               fprintf (stderr,"MENSAJE_RESP:%s\n",szAux);
		               return soap_receiver_fault(soap,szAux , NULL);
		            }
		        }

	        fprintf (stderr,"\nComenzamos a capturar respuesta en #\n");
	        
    
		//capturamos la respuesta y empezamos a procesarla
		GetStrXML(xml1,"GLOSASTATUSSP",glosaSalida,sizeof(glosaSalida));
		GetIntXML(xml1,"STATUSSP",&SStatus);
		GetIntXML(xml1,"S_SALDO_DISPONIBLE",&SSaldoDisp);
		GetIntXML(xml1,"S_SALDO_VENCIDO",&SSaldoVenc);
		//GetStrXML(xml1,"RESULSET",vectorTarjetas,sizeof(vectorTarjetas));
		
		
		fprintf(stderr,"   glosaSalida:%s\n",glosaSalida); 
		fprintf(stderr,"   SStatus:%d\n",SStatus); 
		fprintf(stderr,"   SSaldoDisp:%d\n",SSaldoDisp); 
		fprintf(stderr,"   SSaldoVenc:%d\n",SSaldoVenc); 
		fprintf(stderr,"   Resulset:%s\n",vectorTarjetas); 
		
			        
		fprintf(stderr,"\establecemos valores\n"); 	
		//salida = (struct ns1__ConsultaSaldoYTrxDiaPorBeneficiarioResponse *) malloc (sizeof(struct ns1__ConsultaSaldoYTrxDiaPorBeneficiarioResponse));		
		salida->return_ = (struct ns1__outputWSSaldoTrxBenef *) malloc (sizeof(struct ns1__outputWSSaldoTrxBenef));		
		salida->return_->SGlosaStatus=(char *) malloc (100);		
		
		fprintf(stderr,"Asignamos memoria Ok\n"); 	
		
		salida->return_->__sizetrxsBeneficiario=0;
		fprintf(stderr,"__sizetrxsBeneficiario OK\n"); 	
		
		sprintf (salida->return_->SGlosaStatus,glosaSalida); 
		fprintf(stderr,"salida->return_->SGlosaStatus OK\n"); 
		
		salida->return_->SStatus=SStatus;			
		fprintf(stderr,"salida->return_->statusGlosaSalida OK\n"); 
		
		salida->return_->SSaldoDisp=SSaldoDisp;			
		fprintf(stderr,"salida->return_->SSaldoDisp OK\n"); 
		
		salida->return_->SSaldoVenc=SSaldoVenc;			
		fprintf(stderr,"salida->return_->SSaldoVenc OK\n"); 
			
		
	        fprintf(stderr,"Entra a for\n");
		int sElementos=0;
		GetIntXML(xml1,"SELEMENTOS",&sElementos);
		i=0;
		if(sElementos>0)
		{
			salida->return_->trxsBeneficiario=(struct ns1__rsspSaldoTrxBenef *)malloc(sizeof(struct ns1__rsspSaldoTrxBenef));		
		
			for ( i=0 ; i < sElementos ; i++)
			{				
				char szCampo[100];					
	
				salida->return_->trxsBeneficiario = (struct ns1__rsspSaldoTrxBenef *)realloc(salida->return_->trxsBeneficiario,sizeof(struct ns1__rsspSaldoTrxBenef )* (i+1));
												
				salida->return_->trxsBeneficiario[i].SFecha=(char *)malloc(100);
				salida->return_->trxsBeneficiario[i].SIdConsumo=(char *)malloc(100);
				salida->return_->trxsBeneficiario[i].STarjeta=(char *)malloc(100);			
	
				sprintf(szCampo,"SFECHA%i",i+1);
				GetStrXML(xml1,szCampo,salida->return_->trxsBeneficiario[i].SFecha,100);
	
				sprintf(szCampo,"STARJETA%i",i+1);
				GetStrXML(xml1,szCampo,salida->return_->trxsBeneficiario[i].STarjeta,100);			
	
				sprintf(szCampo,"SMONTO%i",i+1);
				GetIntXML(xml1,szCampo,&salida->return_->trxsBeneficiario[i].SMonto);
	
				sprintf(szCampo,"STIPO%i",i+1);
				GetIntXML(xml1,szCampo,&salida->return_->trxsBeneficiario[i].STipo);
	
				sprintf(szCampo,"SIDCONSUMO%i",i+1);
				GetStrXML(xml1,szCampo,salida->return_->trxsBeneficiario[i].SIdConsumo,100);
			}
		}
				
		salida->return_->__sizetrxsBeneficiario = i;
		
		fprintf(stderr,"Llegue aca size: %i\n", salida->return_->__sizetrxsBeneficiario); 
        	        	       	
        	soap_done(&soap);
        	//soap_done(soap);
        	return SOAP_OK;		
        }
}


//----------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------CONSULTA SALDO Y TRANSACCIONES DEL DIA POR AFILIADO------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
int __ns1__ConsultaSaldoYTrxDiaPorAfiliado(struct soap *soap,struct ns1__ConsultaSaldoYTrxDiaPorAfiliado* entrada,struct ns1__ConsultaSaldoYTrxDiaPorAfiliadoResponse* salida){
	
	Tipo_XML *xml=NULL;
        Tipo_XML *xml1=NULL;        
        Tipo_Servicio stServ;
        int id;
        char szAux[200];        
	char vectorTarjetas[900];

	char glosaSalida[100];	
	int SStatus;
	
	char vectorSalida[200];	

        int sts;
        int i;
                        	
	strcpy(vectorTarjetas,"");
	strcpy(vectorSalida,"");

	fprintf(stderr,"Inicia Activaion Tarjeta \n");
	
	id=0;
        //Los WebServices se definen como el servicio 5
        stServ.nTx=1610;
        sprintf(stServ.szIp,"127.0.0.1");
        stServ.nPort=2010;
        stServ.nTimeout=10;
        stServ.nTipoRespuesta=2;
        stServ.nLenMinimo=100;

        //fprintf(stderr,"1 status=%i error=%i entrada=%x\n",soap->status,soap->error,entrada);
        if (!entrada)
        {
           WriteLog(id,"No viene estructura de Entrada");
           return soap_receiver_fault(soap, "No viene estructura de Entrada", NULL);
        }
        else
        {	
        	fprintf(stderr,"Valores de Entrada\n");
        	fprintf(stderr,"   entrada->arg0->S_USCORETipo_USCOREID: %d\n",entrada->arg0->S_USCORETipo_USCOREID);
        	fprintf(stderr,"   entrada->arg0->S_USCOREValor_USCOREID: %s\n",entrada->arg0->S_USCOREValor_USCOREID);
        	fprintf(stderr,"   entrada->arg0->S_USCOREServicio: %d\n",entrada->arg0->S_USCOREServicio);
        	fprintf(stderr,"   entrada->arg0->S_USCORECliente: %s\n",entrada->arg0->S_USCORECliente);
        	        	
        	fprintf(stderr,"\nInsertando en # \n");
	        xml=InsertaDataIntXML(xml,"TX",stServ.nTx);
	        xml=InsertaDataIntXML(xml,"WS_SAL",1);
	        xml=InsertaDataIntXML(xml,"ID_CONSULTA",entrada->arg0->S_USCORETipo_USCOREID);
	        xml=InsertaDataXML(xml,"ID_IDENTIFICA_CONSULTA",entrada->arg0->S_USCOREValor_USCOREID);
	        xml=InsertaDataIntXML(xml,"SERVICIO",entrada->arg0->S_USCOREServicio);	        
	        xml=InsertaDataXML(xml,"RUT_CLIENTE",entrada->arg0->S_USCORECliente);
	
		//Enviamos al Switch con la Funcion AutorizaServicio1	
	        xml1=AutorizaServicio1(id,xml,&stServ,&sts);
	
		  if (!sts)
		        {
	                fprintf (stderr,"Servicio no contesta\n");
	                return soap_receiver_fault(soap,szAux, NULL);
		        }
	
	          fprintf (stderr,"Servicio Contesta\n");
	          //Si la variable __SOAP_FAULT__ viene en 1 entonces falla servicio 6000
	          if (GetIntXML(xml1,"__SOAP_FAULT__",&sts))
		        {
		            if (sts)
		            {
		               GetStrXML(xml1,"MENSAJE_RESP",szAux,sizeof(szAux));
		               WriteLog(id,szAux);
		               fprintf (stderr,"MENSAJE_RESP:%s\n",szAux);
		               return soap_receiver_fault(soap,szAux , NULL);
		            }
		        }

	        fprintf (stderr,"\nComenzamos a capturar respuesta en #\n");
	        
    
		//capturamos la respuesta y empezamos a procesarla
		GetStrXML(xml1,"GLOSASTATUSSP",glosaSalida,sizeof(glosaSalida));
		GetIntXML(xml1,"STATUSSP",&SStatus);
		//GetStrXML(xml1,"RESULSET",vectorTarjetas,sizeof(vectorTarjetas));
		
		
		fprintf(stderr,"   vectorTarjetas:%s\n",vectorTarjetas); 
		fprintf(stderr,"   glosaSalida:%s\n",glosaSalida); 
		fprintf(stderr,"   SStatus:%d\n",SStatus); 
			
	        
		fprintf(stderr,"\establecemos valores\n"); 	
		//salida = (struct ns1__ConsultaSaldoYTrxDiaPorAfiliadoResponse *) malloc (sizeof(struct ns1__ConsultaSaldoYTrxDiaPorAfiliadoResponse));
		salida->return_ = (struct ns1__outputWSSaldoTrxAfiliad *) malloc (sizeof(struct ns1__outputWSSaldoTrxAfiliad));
		salida->return_->SGlosaStatus=(char *) malloc (100);		
		
		fprintf(stderr,"Asignamos memoria Ok\n"); 	
		
		salida->return_->__sizetrxsAfiliado=0;
		fprintf(stderr,"__sizetrxsBeneficiario OK\n"); 	
		
		sprintf (salida->return_->SGlosaStatus,glosaSalida); 
		fprintf(stderr,"salida->return_->SGlosaStatus OK\n"); 
		
		salida->return_->SStatus=SStatus;			
		fprintf(stderr,"???salida->return_->statusGlosaSalida OK\n"); 
		
						
		int sElementos=0;
		GetIntXML(xml1,"SELEMENTOS",&sElementos);
		fprintf(stderr,"SELEMENTOS:%d\n",sElementos); 
						
		char szCampo[100];
		i=0;
		if(sElementos>0)
		  {
		        salida->return_->trxsAfiliado=(struct ns1__rsspSaldoTrxAfiliad *)malloc(sizeof(struct ns1__rsspSaldoTrxAfiliad));		  
		
		        for ( i=0 ; i < sElementos ; i++)
			{							
			salida->return_->trxsAfiliado= (struct ns1__rsspSaldoTrxAfiliad *)realloc(salida->return_->trxsAfiliado,sizeof(struct ns1__rsspSaldoTrxAfiliad )* (i+1));	
			salida->return_->trxsAfiliado[i].SFecha=(char *)malloc(100);
			salida->return_->trxsAfiliado[i].SIdConsumo=(char *)malloc(100);
			salida->return_->trxsAfiliado[i].SRutBenef=(char *)malloc(100);
			salida->return_->trxsAfiliado[i].STarjeta=(char *)malloc(200);						
				
			fprintf(stderr,"linea:%i\n",i+1);	
				
			sprintf(szCampo,"SFECHA%i",i+1);
			GetStrXML(xml1,szCampo,salida->return_->trxsAfiliado[i].SFecha,100);
			fprintf(stderr,"fecha:%s\n",salida->return_->trxsAfiliado[i].SFecha);
			
			sprintf(szCampo,"SIDCONSUMO%i",i+1);
			GetStrXML(xml1,szCampo,salida->return_->trxsAfiliado[i].SIdConsumo,100);
			fprintf(stderr,"SIdConsumo:%s\n",salida->return_->trxsAfiliado[i].SIdConsumo);
			
			sprintf(szCampo,"SRUTBENEF%i",i+1);
			GetStrXML(xml1,szCampo,salida->return_->trxsAfiliado[i].SRutBenef,100);
			fprintf(stderr,">SRUTBENEF:%s\n",salida->return_->trxsAfiliado[i].SRutBenef);
			
			sprintf(szCampo,"SMONTO%i",i+1);
			GetIntXML(xml1,szCampo,&salida->return_->trxsAfiliado[i].SMonto);
			fprintf(stderr,"SMonto:%ld\n",salida->return_->trxsAfiliado[i].SMonto);
			
			sprintf(szCampo,"SSTATUSTRX%i",i+1);
			GetIntXML(xml1,szCampo,&salida->return_->trxsAfiliado[i].SStatusTrx);
			fprintf(stderr,"SStatusTrx:%d\n",salida->return_->trxsAfiliado[i].SStatusTrx);
			
			sprintf(szCampo,"STIPO%i",i+1);
			GetIntXML(xml1,szCampo,&salida->return_->trxsAfiliado[i].STipo);
			fprintf(stderr,"STipo:%d\n",salida->return_->trxsAfiliado[i].STipo);
			
			sprintf(szCampo,"STARJETA%i",i+1);			
			GetStrXML(xml1,szCampo,salida->return_->trxsAfiliado[i].STarjeta,200);
			fprintf(stderr,"STarjeta:%s\n",salida->return_->trxsAfiliado[i].STarjeta);
			}
		}
		salida->return_->__sizetrxsAfiliado=i;
		
		
		fprintf(stderr,"Llegue aca\n"); 	
		
        	soap_done(&soap);       
        	//soap_done(soap);       
        	return SOAP_OK;		
        }
}
