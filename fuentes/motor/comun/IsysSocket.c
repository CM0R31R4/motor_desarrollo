#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <IsysSocket.h>
#include <bits/time.h>
#include <xml.h>
#include <pthread.h>
#include <netdb.h>
#include <asm/ioctls.h>
#include <sys/timeb.h>
#include <signal.h>
#include <linux/types.h>
#include <linux/futex.h>
#include <sys/time.h>

#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>



#include <sys/syscall.h>
#include <unistd.h>
#include <errno.h>


#define SOCKET_ERROR -1
#define TRUE	1
#define FALSE	0
#define INVALID_SOCKET -1

/*
#ifdef __SMP__
#define LOCK "lock ; "
#else
#define LOCK ""
#endif

#define __atomic_fool_gcc(x) (*(volatile struct { int a[100]; } *)x)

#ifdef __SMP__
typedef struct { volatile int counter; } atomic_t;
#else
typedef struct { int counter; } atomic_t;
#endif

static __inline__ int atomic_add_return(int i, atomic_t *v)
{
        int __i = i;
        __asm__ __volatile__(
                LOCK "xaddl %0, %1;"
                :"=r"(i)
                :"m"(v->counter), "0"(i));
        return __i;
}

#define atomic_inc_return(v)  (atomic_add_return(1,v))


atomic_t futex_multi = {0};
#define sys_futex sbcl_sys_futex

*/
/* int sys_futex (void *futex, int op, int val, const struct timespec *timeout); */
static inline long int apc_sys_futex(void *futex, int op, int val, const struct timespec *timeout) 
{
  long int ret;

  /* x86_64 system calls are performed with the faster SYSCALL operation.
   *  the argument order is D, S, d, c, b, a rather than
   *  a, b, c, d, S, D as on the i386 int 80h call.
  */
/*
  __asm__ __volatile__ ("syscall"
       : "=a" (ret)
       : "0" (SYS_futex),
         "D" (futex),
         "S" (op),
         "d" (val),
         "c" (timeout)
       : "r11", "rcx", "memory"
      );
*/
  return ret;
}
/*static inline int sys_futex (void *futex, int op, int val, struct timespec *rel)
{
    return syscall (SYS_futex, futex, op, val, rel);
}
*/
/*
void futex_lock(int id)
{
	int old;
	char szAux[100];

	sprintf(szAux,"Valor Inicial=%i",futex_multi.counter);
	WriteLog(id,szAux);
	//Mientras no sea cero no puede proseguir
	//atomic_inc devuelve el valor antiguo e incrementa el estado
	while ((old = atomic_inc_return (&futex_multi)) != 0)
	{
		sprintf(szAux,"Espera Liberacion Valor Antiguo=%i",old);
		WriteLog(id,szAux);
		//Si el valor antiguo no era cero esperon
    		int sts=apc_sys_futex(&futex_multi.counter,FUTEX_WAIT,0,NULL);
		sprintf(szAux,"sts=%i",sts);
		WriteLog(id,szAux);
		if (sts==0) WriteLog(id,"Despertado OK");
		else if (sts==EWOULDBLOCK)  WriteLog(id,"No Bloquerado?");
		else WriteLog(id,"Otro Estado");
	}
	return ;
}

int futex_unlock( int id)
{
	char szAux[100];
	int sts;
    	sts=apc_sys_futex(&futex_multi.counter,FUTEX_WAKE,1,NULL);
	sprintf(szAux,"Procesos Despertados = %i",sts);
	WriteLog(id,szAux);
	return sts;
}
*/	
//pthread_mutex_t mut_proc = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t mut_proc_multi = PTHREAD_MUTEX_INITIALIZER;


pthread_mutex_t mut_hosthost = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t mut_hosthost_asinc = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t mut_sockets_gprs = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t mut_conexiones_activas = PTHREAD_MUTEX_INITIALIZER;

int m_hWorldSocket;


int nMaxProcesosNormales;
int nMinProcesosMulti;
int TransactionThread(int id);



int sendsock(int m_socket,char szData[],int nLen,int nPort)
{
    int retval;
    struct sockaddr_in sock;
    sock.sin_family = AF_INET;
    sock.sin_port = htons((u_short)nPort);
    sock.sin_addr.s_addr = htonl((u_long)INADDR_LOOPBACK);

    retval = sendto(m_socket,szData,nLen,0,(struct sockaddr*)&sock,sizeof(sock));
    if (retval == SOCKET_ERROR)
        return FALSE;
    return TRUE;
}


int CreateUdp(int nPort)
{
    int sts;
    struct sockaddr_in sin1;
    int linger = 0;
    int optval = 1;
    unsigned long l=1;
    int m_socket;

    if ((m_socket = socket(AF_INET,SOCK_DGRAM,0)) == -1) return FALSE;
    sin1.sin_family = AF_INET;
    sin1.sin_port = htons((u_short)nPort);
    sin1.sin_addr.s_addr = htonl((u_long)INADDR_ANY);

    //para mantener viva la coneixon con el cliente
     setsockopt(m_socket,SOL_SOCKET,SO_REUSEADDR,(const char *)&optval,sizeof(int));
     //setsockopt(m_socket,SOL_SOCKET,SO_REUSEPORT,(const char *)&optval,sizeof(int));

    //Asocia un nombre al socket
    if ( (sts=bind(m_socket, (struct sockaddr *)&sin1,sizeof(sin1))) == -1 ) return FALSE;
    return m_socket;
}

int LeeRespuestaAsincrona(int id,int nCasilla,char szData[],int nMaxBuff,char szLlave[])
{

	time_t	t2,t1;
	int i;
	int bLog=1;
	time(&t2);
	char szAux[2048];
	WriteLog(id,"Busca Respuesta Asincronica");
	do
	{
		//Buscamos la respuesta en la lista
		pthread_mutex_lock(&ServiciosAsincronos[nCasilla].mutex_serv_asinc);
		//Primero verificamos que la respuesta no este en la cola
		for (i=0;i<MAXIMO_RESPUESTAS;i++)
		{
			//Hay datos
			if (strlen(ServiciosAsincronos[nCasilla].Cola[i].szRespuesta)>0)
			{
				//Solo muestra una vez
				if (bLog)
				{
					WriteLog(id,"+Compara Resp Asin");
					WriteLog(id,ServiciosAsincronos[nCasilla].Cola[i].szRespuesta);
					sprintf(szAux,"LLAVE BUSCADA=[%s]",szLlave);
					WriteLog(id,szAux);
				}
				//Si no expiro revisamos si es la nuestra
				if (strstr(ServiciosAsincronos[nCasilla].Cola[i].szRespuesta,szLlave)>0)
				{
					WriteLog(id,"Resp Asinc Encontrada");
					WriteLog(id,ServiciosAsincronos[nCasilla].Cola[i].szRespuesta);
					sprintf(szAux,"LLAVE ENCONTRADA=[%s]",szLlave);
					WriteLog(id,szAux);
					//si es la nuestra copio al buffer de salida y ya
					memcpy(szData,ServiciosAsincronos[nCasilla].Cola[i].szRespuesta,ServiciosAsincronos[nCasilla].Cola[i].nLenRsp);
					szData[ServiciosAsincronos[nCasilla].Cola[i].nLenRsp]=0;
					//Limpio la respuesta
					memset(ServiciosAsincronos[nCasilla].Cola[i].szRespuesta,0,sizeof(ServiciosAsincronos[nCasilla].Cola[i].szRespuesta));
					pthread_mutex_unlock(&ServiciosAsincronos[nCasilla].mutex_serv_asinc);
					return ServiciosAsincronos[nCasilla].Cola[i].nLenRsp;
				}
			}
		}
		pthread_mutex_unlock(&ServiciosAsincronos[nCasilla].mutex_serv_asinc);
		usleep(100);
		bLog=0;
		time(&t1);
	} while(t1-t2<ServiciosAsincronos[nCasilla].nTimeout);
	WriteLog(id,"No Llega Respuesta Asincronica");
	return -1;

}

// FC 2011-06-29 Creado para soportar lectura de cabeceras Binarias....
// especificamente soluciona el problema de Pincenter, y en adelante de otros emisores
// de la misma linea..
int LeeRespuestaAsincronaBinaria(int id,int nCasilla,char szData[],int nMaxBuff,char szLlave[])
{

        time_t  t2,t1;
        int i;
        int bLog=1;
        time(&t2);

        WriteLog(id,"Busca Respuesta Asincronica Binaria");
        do
        {
                //Buscamos la respuesta en la lista
                pthread_mutex_lock(&ServiciosAsincronos[nCasilla].mutex_serv_asinc);
                //Primero verificamos que la respuesta no este en la cola
                //WriteLog(id,"Sale de pthread_mutex_lock");
                for (i=0;i<MAXIMO_RESPUESTAS;i++)
                {
                        //WriteLog(id,"Dentro de for MaxRptas");
                        //Hay datos
                        if (strlen(ServiciosAsincronos[nCasilla].Cola[i].szRespuesta)>0)
                        {
                                //WriteLog(id,"Strlen > 0");
                                //Solo muestra una vez
                                if (bLog)
                                {
                                        WriteLog(id,"+Compara Resp Asin");
                                        WriteLog(id,ServiciosAsincronos[nCasilla].Cola[i].szRespuesta);
                                        WriteLog(id,szLlave);
                                }
                                //Si no expiro revisamos si es la nuestra
                                // Almacenamos los bytes 3 al 7 (5 bytes) y se retorna su valor en cadena decimal..
                                char szAuxiliar1[MAX_BUFFER];
                                char szLlaveBinaria[MAX_BUFFER];

                                mc_substring(ServiciosAsincronos[nCasilla].Cola[i].szRespuesta,3,7,szAuxiliar1);
                                writenhex(szAuxiliar1,szLlaveBinaria,5);
                                printf("Campo Llave Asin Binaria %s nLen=%i\n\r",szLlaveBinaria,strlen(szLlaveBinaria));

                                //if (strstr(ServiciosAsincronos[nCasilla].Cola[i].szRespuesta,szLlave)>0)
                                if (strstr(szLlaveBinaria,szLlave)>0)
                                {
                                        WriteLog(id,"Resp Asinc Encontrada");
                                        WriteLog(id,ServiciosAsincronos[nCasilla].Cola[i].szRespuesta);
                                        WriteLog(id,szLlave);
                                        //si es la nuestra copio al buffer de salida y ya
                                        memcpy(szData,ServiciosAsincronos[nCasilla].Cola[i].szRespuesta,ServiciosAsincronos[nCasilla].Cola[i].nLenRsp);
                                        szData[ServiciosAsincronos[nCasilla].Cola[i].nLenRsp]=0;
                                        //Limpio la respuesta
                                        memset(ServiciosAsincronos[nCasilla].Cola[i].szRespuesta,0,sizeof(ServiciosAsincronos[nCasilla].Cola[i].szRespuesta));
                                        pthread_mutex_unlock(&ServiciosAsincronos[nCasilla].mutex_serv_asinc);
                                        return ServiciosAsincronos[nCasilla].Cola[i].nLenRsp;
                                }
                        }
                }
                pthread_mutex_unlock(&ServiciosAsincronos[nCasilla].mutex_serv_asinc);
                usleep(100);
                bLog=0;
                time(&t1);
        } while(t1-t2<ServiciosAsincronos[nCasilla].nTimeout);
        WriteLog(id,"No Llega Respuesta Asincronica");
        return -1;

}


Tipo_Data *LeeDataVariable(int id,int socket,Tipo_Data *pData,int nTimeout,int *sts1)
{
       int sts;
       long nLen;
       long nTotal;
       char szLinea[MAX_BUFFER];
       sts=EsperaDataSocket(id,socket,nTimeout);
       if (sts<0) 
       {
		*sts1=sts;
		return pData;
       }

       nLen=sts;
       nTotal=0;

       while (nTotal<nLen)
       {
		memset(szLinea,0,sizeof(szLinea));
       		if (global.SSL) 
       		{
#ifdef _ISYS_SSL_
	       	sts=SSL_read(Conexion[id].ssl,szLinea,sizeof(szLinea));
#endif
       		}
       		else sts=recv(socket,szLinea,sizeof(szLinea),0);
       		if (sts>0) szLinea[sts]=0;
       		else if (sts==0)
		{
			*sts1=-1;
			 return pData;
		}
		//Aumento el total leido y copio a pData
		nTotal+=sts;
		pData=ConcatenaData(szLinea,pData,sts);
       }
       *sts1=nTotal;
       return pData;
}



int LeeData(int id,int socket,char szLinea[],int nMaxBuff,int nTimeout)
{
       int sts;
       long nLen;
       sts=EsperaDataSocket(id,socket,nTimeout);
       if (sts<0) return sts;

       if (global.SSL) 
       {
#ifdef _ISYS_SSL_
	       sts=SSL_read(Conexion[id].ssl,szLinea,nMaxBuff);
#endif
       }
       else sts=recv(socket,szLinea,nMaxBuff,0);
       if (sts>0)
       { 
       		szLinea[sts]=0;
       }
       else if (sts==0)
	{
		return -1;
	}
       return sts;
}

Tipo_Data *LeeDataPatronFinalData(int id,int socket,Tipo_Data *pData,int nTimeout,char szPatronFinal[],int *nLeidos)
{
	char *dta;
	int nLeidos1;
	*nLeidos=0;
	do
	{
		pData=LeeDataVariable(id,socket,pData,nTimeout,&nLeidos1);
		if (nLeidos1<0)
		{
			WriteLog(id,"Falla Lectura PatronFinal");
			pData=LiberaData(pData);
			return NULL;
		}
		*nLeidos+=nLeidos1;
	       	//una vea que leyo verifica que llega el patron final
		WriteLog(id,szPatronFinal);
		dta=strstr(pData->data,szPatronFinal);
		if (dta!=NULL) 
	   	{
			   WriteLog(id,"Patron Encontrado");
			   return pData;
		}
	} while(1);
} 

int LeeDataPatronFinal(int id,int socket,char szLinea[],int nMaxBuff,int nTimeout,char szPatronFinal[])
{
       int sts,sts1;
       long nLen;
       int nLeidos=0;
       int nTotal;
       char *dta;
       char szError[1024];
       sprintf(szError,"Busca Patron Final %s",szPatronFinal);
       WriteLog(id,szError);
       sts=EsperaDataSocket(id,socket,nTimeout);
       if (sts<0) return sts;

       do
       {
       	   if (global.SSL) 
	   {
#ifdef _ISYS_SSL_
		   sts=SSL_read(Conexion[id].ssl,&szLinea[nLeidos],nMaxBuff-nLeidos);
#endif
	   }
           else sts=recv(socket,&szLinea[nLeidos],nMaxBuff-nLeidos,0);
           if (sts>0) szLinea[nLeidos+sts]=0;
	   if (sts<=0) {return -1;}

	   dta=NULL;
	   nLeidos=nLeidos+sts;
       	   //una vea que leyo verifica que llega el patron final
	   WriteLog(id,szPatronFinal);
	   dta=strstr(szLinea,szPatronFinal);
	   if (dta!=NULL) 
	   {
		   WriteLog(id,"Patron Encontrado");
		   break;
	   }

	   //espera a que llegue la data..
       	   sts1=EsperaDataSocket(id,socket,nTimeout);
       	   if (sts1<0) return sts1;


       } while (1);
       
       return nLeidos;
}



int LeeDataRafaga(int id,int socket,char szLinea[],int nMaxBuff,int nTimeout,int nTimeoutRafaga)
{
       int sts;
       long nLen;
       int nLeidos=0;
       int nTotal;
       WriteLog(id,"Respuesta Tipo Rafaga");
       sts=EsperaDataSocket(id,socket,nTimeout);
       if (sts<0) return sts;

       do
       {
       	   if (global.SSL) 
	   {
#ifdef _ISYS_SSL_
		   sts=SSL_read(Conexion[id].ssl,&szLinea[nLeidos],nMaxBuff-nLeidos);
#endif
	   }
           else sts=recv(socket,&szLinea[nLeidos],nMaxBuff-nLeidos,0);
           if (sts>0) szLinea[nLeidos+sts]=0;
	   else 
	   {
		szLinea[nLeidos+sts]=0;
		break;
           }

       	   //una vea que leyo espera nuevamente
	   usleep(nTimeoutRafaga);
	   nTotal=0;
	   ioctl(socket,FIONREAD,&nTotal);
	   if (nTotal<=0) break;
	   nLeidos=nLeidos+sts;
	  WriteLog(id,"TEST2");
       } while (1);
       return nLeidos;
}
//Funcion que lee nLen Caracteres desde un socket 
//falla a los nTimeout
//int LeeNData(int id,int nSocket,int nDataEsperada,char szData[],int nTimeout)
//La unica diferencia es que unweb server lee toda la infromacion del socket
Tipo_Data *LeeNDataWebServer(int id,int nSocket,int nDataEsperada1,Tipo_Data *pData,int nTimeout,int *sts)
{

    int nLen,sts1;
    char szTmp[200];
    char szData[1024];
    time_t t1,t2;
    int nDataEsperada;  
	int jj;
    int nLenTotal=0;
    int chr13=0;
    nLen=0;

    nDataEsperada=nDataEsperada1;
    
    sprintf(szTmp,"LeeNDataWebServer Socket=%i DataEsperada %i Timeout=%i",nSocket,nDataEsperada,nTimeout);
    WriteLog(id,szTmp);

    time(&t1);
    while (1)
    {
        sts1=EsperaDataSocket(id,nSocket,nTimeout);
	if (sts1==CLOSE_SOCKET) 
	{ 
		*sts=-1;
		pData=LiberaData(pData);
		return pData;
	}
	if (sts1<0) 
	{
		char szTmp1[30];
		sprintf(szTmp1,"STATUS = %i",sts);
		WriteLog(id,szTmp1);
		goto timeout;
	}
        time(&t2);
        ioctl(nSocket,FIONREAD,&nLen);
	//printf("Bytes Por Leer = %i\n\r",nLen);
        if (nLen<0) 
	{ 
		WriteLog(id,"Falla en LeeNData");
		*sts=-1;
		pData=LiberaData(pData);
		return pData;
		//return -1;
	}
	else if ((nTimeout!=0) && (t2-t1>nTimeout)) goto timeout;
        //else if (nLen<nDataEsperada) 
	else if (nLen==0)
        {
		//Si ya leyo mas que el content length entonces paro
		if (pData->nLenData>nDataEsperada)
		{
			//WriteHex(id,pData->data,pData->nLenData);
			*sts=pData->nLenData;
			return pData;
		}
		if (Conexion[id].nEstado==C_TERMINAR)
		{
			WriteLog(id,"en LeeData Accion de Terminar proceso");
			*sts=-1;
			pData=LiberaData(pData);
			return pData;
		}
		usleep(10); 
		//printf("Falta por Leer\n\r");
		continue;
	} 
	sprintf(szTmp,"Por leer %i, esperada %i Total Leido=%i",nLen,nDataEsperada,nLenTotal);
	WriteLog(id,szTmp);

	//Si nDataEsperada es -1 (Leer todo), dimensionamos lo que debe leer
	if (nDataEsperada<0) nDataEsperada=nLen;

	//Aumento buffer de data para insertar lo leidos
	if (pData->data == NULL)
		pData->data = (char *)malloc(nLen+10);
	else
		pData->data = (char *)realloc(pData->data,nLen+pData->nLenData+10);
        sts1=recv(nSocket,&pData->data[pData->nLenData],nLen,0);
	if (sts1<0)
	{
		WriteLog(id,"Falla al leer en LeeNData");
		*sts=-1;
		return pData;
	}
	else if (sts1==0)
	{
		WriteLog(id,"No lee nada");
		*sts=-1;
		return pData;
	}
		

	/*
	//WriteLog(id,"Entro a chr(13)");
	char *a=&pData->data[pData->nLenData];
	chr13=0;
	//Elimino lo leidos chr(13), sin borrarlos
	for(jj=0;jj<sts1;jj++) 
	{
		if (a[jj]==0x0d) 
		{
			//WriteLog(id,"Encuentro chr(13)");
			chr13++;
		}
	}
	*/
	chr13=0;
	nLenTotal+=sts1-chr13;
	pData->nLenData+=sts1;
	pData->data[pData->nLenData+1]=0;


	sprintf(szTmp,"Largo sts1=%i pData->nLenData=%i strlen(pData->data)=%i nLenTotal=%i nLen=%i chr13=%i",sts1,pData->nLenData,strlen(pData->data),nLenTotal,nLen,chr13);
	WriteLog(id,szTmp);
	
	//Si hay mas data en el socket vuevo a leer
        ioctl(nSocket,FIONREAD,&nLen);
	//printf("Bytes Por Leer = %i\n\r",nLen);
        if (nLen>0) continue;
	
	//Verifico si termino de leer
	//Si ya leyo mas que el content length entonces paro
	if (nLenTotal>=nDataEsperada)
	{
		//WriteHex(id,pData->data,pData->nLenData);
		*sts=pData->nLenData;
		return pData;
	}

	//Siemper continua hasta que no exista informacion en el buffer
	continue;
	//if (nLenTotal<nDataEsperada) continue;
	//WriteLog(id,pData->data);
	//WriteHex(id,pData->data,pData->nLenData);
	//*sts=pData->nLenData;
	//return pData;
    }
		
timeout:
    if (nLen>0)
    {
	pData->data = (char *)realloc(pData->data,nLen+pData->nLenData+10);
   	sts1=recv(nSocket,&pData->data[pData->nLenData],nLen,0);
	pData->nLenData+=sts1;
	pData->data[pData->nLenData+1]=0;
	sprintf(szTmp,"Solo llegan %i bytes y no %i",nLen,nDataEsperada);
	WriteLog(id,szTmp);
	WriteLog(id,"Data Leida:");
	WriteLog(id,pData->data);
	pData=LiberaData(pData);
    }
    WriteLog(id,"Timeout en LeeNData");
    *sts=-1;
    return pData;
}

//Lee N Data sin CRLF
Tipo_Data *LeeNData_sin_CRLF(int id,int nSocket,int nDataEsperada1,Tipo_Data *pData,int nTimeout,int *sts)
{

    int nLen,sts1;
    char szTmp[200];
    char szData[1024];
    time_t t1,t2;
    int nDataEsperada;  
    int nLenTotal=0;
    int chr13=0;
    nLen=0;

    nDataEsperada=nDataEsperada1;
    
    sprintf(szTmp,"LeeNData_sin_CRLF Socket=%i DataEsperada %i Timeout=%i",nSocket,nDataEsperada,nTimeout);
    WriteLog(id,szTmp);
    //WriteMensajeApp(id,szTmp);


    time(&t1);
    while (1)
    {
        sts1=EsperaDataSocket(id,nSocket,nTimeout);
	if (sts1==CLOSE_SOCKET) 
	{ 
		*sts=-1;
		return pData;
	}
	if (sts1<0) 
	{
		char szTmp1[30];
		sprintf(szTmp1,"STATUS = %i",sts);
		WriteLog(id,szTmp1);
		goto timeout;
	}
        time(&t2);
        ioctl(nSocket,FIONREAD,&nLen);
	//printf("Bytes Por Leer = %i\n\r",nLen);
        if (nLen<0) 
	{ 
		WriteLog(id,"Falla en LeeNData");
		*sts=-1;
		return pData;
		//return -1;
	}
	else if ((nTimeout!=0) && (t2-t1>nTimeout)) goto timeout;
        //else if (nLen<nDataEsperada) 
	else if (nLen==0)
        {
		if (Conexion[id].nEstado==C_TERMINAR)
		{
			WriteLog(id,"en LeeData Accion de Terminar proceso");
			*sts=-1;
			return pData;
		}
		usleep(10); 
		//printf("Falta por Leer\n\r");
		continue;
	} 
	
        sts1=recv(nSocket,szData,1,0);
	if (sts1<0)
	{
		WriteLog(id,"Falla al leer en LeeNData_sin_CRLF");
		*sts=-1;
		return pData;
	}
	else if (sts1==0)
	{
		WriteLog(id,"No lee nada");
		*sts=-1;
		return pData;
	}

	pData=ConcatenaData(szData,pData,1);
	nLenTotal+=1;
	
	//sprintf(szTmp,"Concatena %i %i %i %c",szData[0],nLenTotal,nDataEsperada,szData[0]);
    	//WriteMensajeApp(id,szTmp);
	//Si termino de leer
	if (nLenTotal==nDataEsperada)
	{	
		WriteLog(id,pData->data);
		return pData;
	}
    }
timeout:
    if (nLen>0)
    {
	pData->data = (char *)realloc(pData->data,nLen+pData->nLenData+10);
   	sts1=recv(nSocket,&pData->data[pData->nLenData],nLen,0);
	pData->nLenData+=sts1;
	pData->data[pData->nLenData+1]=0;
	sprintf(szTmp,"Solo llegan %i bytes y no %i",nLen,nDataEsperada);
	WriteLog(id,szTmp);
	WriteLog(id,"Data Leida:");
	WriteLog(id,pData->data);
	pData=LiberaData(pData);
    }
    WriteLog(id,"Timeout en LeeNData");
    *sts=-1;
    return pData;
}

//Funcion que lee nLen Caracteres desde un socket 
//falla a los nTimeout
//int LeeNData(int id,int nSocket,int nDataEsperada,char szData[],int nTimeout)
Tipo_Data *LeeNData(int id,int nSocket,int nDataEsperada1,Tipo_Data *pData,int nTimeout,int *sts)
{

    int nLen,sts1;
    char szTmp[200];
    char szData[1024];
    time_t t1,t2;
    int nDataEsperada;  
    int nLenTotal=0;
    int chr13=0;
    nLen=0;

    nDataEsperada=nDataEsperada1;
    
    sprintf(szTmp,"LeeNData Socket=%i DataEsperada %i Timeout=%i",nSocket,nDataEsperada,nTimeout);
    printf("LeeNData Socket=%i DataEsperada %i Timeout=%i\n",nSocket,nDataEsperada,nTimeout);
    WriteLog(id,szTmp);


    time(&t1);
    while (1)
    {
        sts1=EsperaDataSocket(id,nSocket,nTimeout);
	if (sts1==CLOSE_SOCKET) 
	{ 
		*sts=-1;
		return pData;
	}
	if (sts1<0) 
	{
		char szTmp1[30];
		sprintf(szTmp1,"STATUS = %i",sts);
		WriteLog(id,szTmp1);
		goto timeout;
	}
        time(&t2);
        ioctl(nSocket,FIONREAD,&nLen);
	//printf("Bytes Por Leer = %i\n\r",nLen);
        if (nLen<0) 
	{ 
		WriteLog(id,"Falla en LeeNData");
		*sts=-1;
		return pData;
		//return -1;
	}
	else if ((nTimeout!=0) && (t2-t1>nTimeout)) goto timeout;
        //else if (nLen<nDataEsperada) 
	else if (nLen==0)
        {
		if (Conexion[id].nEstado==C_TERMINAR)
		{
			WriteLog(id,"en LeeData Accion de Terminar proceso");
			*sts=-1;
			return pData;
		}
		usleep(10); 
		//printf("Falta por Leer\n\r");
		continue;
	} 
	//Hay que leer todo del socket
	else if (nDataEsperada<0)
	{
		nDataEsperada=nLen;
	}
	//Lo que hay en el buffer + lo que he leido es mayor a lo esperado...
	else if (nLen+nLenTotal>nDataEsperada) 
	{
		//sprintf(szTmp,"*** nLen=%i nLenTotal=%i nDataEsperada=%i",nLen,nLenTotal,nDataEsperada);
		//printf("*** nLen=%i nLenTotal=%i nDataEsperada=%i\n",nLen,nLenTotal,nDataEsperada);
		//WriteLog(id,szTmp);
		nLen=nDataEsperada-nLenTotal;
		//sprintf(szTmp,"*** nLen=%i nLenTotal=%i nDataEsperada=%i",nLen,nLenTotal,nDataEsperada);
		//printf("*** nLen=%i nLenTotal=%i nDataEsperada=%i\n",nLen,nLenTotal,nDataEsperada);
		//WriteLog(id,szTmp);
	}

	sprintf(szTmp,"Por leer %i, esperada %i Total Leido=%i",nLen,nDataEsperada,nLenTotal);
	printf("Por leer %i, esperada %i Total Leido=%i\n",nLen,nDataEsperada,nLenTotal);
	WriteLog(id,szTmp);

	//Si nDataEsperada es -1 (Leer todo), dimensionamos lo que debe leer
	if (nDataEsperada<0) nDataEsperada=nLen;
	//Si esl pData es nulo lo creo
	if (pData  == NULL)
	{
		pData=CreaData();
		pData->data = (char *)malloc(nLen+10);
	}
	//Aumento buffer de data para insertar lo leidos
	else if (pData->data == NULL)
		pData->data = (char *)malloc(nLen+10);
	else
		pData->data = (char *)realloc(pData->data,nLen+pData->nLenData+10);

        sts1=recv(nSocket,&pData->data[pData->nLenData],nLen,0);
	if (sts1<0)
	{
		WriteLog(id,"Falla al leer en LeeNData");
		*sts=-1;
		return pData;
	}
	else if (sts1==0)
	{
		WriteLog(id,"No lee nada");
		*sts=-1;
		return pData;
	}

	nLenTotal+=sts1;
	pData->nLenData+=sts1;
	pData->data[pData->nLenData+1]=0;


	sprintf(szTmp,"Largo sts1=%i pData->nLenData=%i strlen(pData->data)=%i nLenTotal=%i nLen=%i chr13=%i",sts1,pData->nLenData,strlen(pData->data),nLenTotal,nLen,chr13);
	//printf("Largo sts1=%i pData->nLenData=%i strlen(pData->data)=%i nLenTotal=%i nLen=%i chr13=%i\n",sts1,pData->nLenData,strlen(pData->data),nLenTotal,nLen,chr13);
	WriteLog(id,szTmp);
	if (nLenTotal<nDataEsperada) continue;
	//WriteLog(id,pData->data);
	WriteHex(id,pData->data,pData->nLenData);
	*sts=pData->nLenData;
	
	return pData;
    }
		
timeout:
    if (nLen>0)
    {
	pData->data = (char *)realloc(pData->data,nLen+pData->nLenData+10);
   	sts1=recv(nSocket,&pData->data[pData->nLenData],nLen,0);
	pData->nLenData+=sts1;
	pData->data[pData->nLenData+1]=0;
	sprintf(szTmp,"Solo llegan %i bytes y no %i",nLen,nDataEsperada);
	WriteLog(id,szTmp);
	WriteLog(id,"Data Leida:");
	WriteLog(id,pData->data);
	pData=LiberaData(pData);
    }
    WriteLog(id,"Timeout en LeeNData");
    *sts=-1;
    return pData;
}

int EnviaData(Tipo_Data *pData,int socket)
{
	        //WriteLog(0,"DATA ENVIADA");
	//        //WriteLog(0,pData->data);
	return send(socket,pData->data,pData->nLenData,MSG_NOSIGNAL);
}

int SendSocketXML2(int id,int m_socket,Tipo_XML *xml)
{
	int sts;
	char szTmp[6];
	char szAux[200];
	long nLenTotal=0;
	long nLen=0;
	char szData[1024];

	sprintf(szAux,"Socket=%i SendSocketXML2",m_socket);
	WriteLog(id,szAux);
	printf("SendSocketXML2\n");
	sprintf(szData,"%c",0x02);
	sts=send(m_socket,szData,1,MSG_NOSIGNAL);
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura1");
	}
	WriteLog(id,"Envia XML");
	sprintf(szData,"<%s=%ld>",xml->szCampo,strlen(xml->pData));
	sts=send(m_socket,szData,strlen(szData),MSG_NOSIGNAL );
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura2");
	}
	WriteLog(id,szData);

	if (strlen(xml->pData)>0) 
	{
		sts=send(m_socket,xml->pData,strlen(xml->pData),MSG_NOSIGNAL );
		WriteLog(id,xml->pData);
		if (sts<0)
		{
			WriteLog(id,"Falla Escritura3");
		}	
	}
	sprintf(szData,"%c",0x03);
	sts=send(m_socket,szData,1,MSG_NOSIGNAL );
	WriteLog(id,"Send ETX");
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura4");
	}	
	return sts;
}

int SendSocketXML1(int id,int m_socket,Tipo_XML *xml)
{
	int sts;
	char szTmp[6];
	char szAux[200];
	long nLenTotal=0;
	long nLen=0;
	char szData[1024];
	Tipo_XML *xml_next_nivel;

	sprintf(szAux,"Socket=%i SendSocketXML1",m_socket);
	WriteLog(id,szAux);
	//printf("SendSocketXML1\n");
	sprintf(szData,"%c",0x02);
	sts=send(m_socket,szData,1,MSG_NOSIGNAL );
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura1");
	}
	do
	{
	   xml_next_nivel=xml->pNextNivel;
	   while(xml!=NULL)
	   {
		sprintf(szData,"<%s=%ld>",xml->szCampo,strlen(xml->pData));
		//printf("Data=%s\n",szData);
		sts=send(m_socket,szData,strlen(szData),MSG_NOSIGNAL );
		WriteLog(id,szData);
		if (strlen(xml->pData)>0) 
		{
			sts=send(m_socket,xml->pData,strlen(xml->pData),MSG_NOSIGNAL );
			WriteLog(id,xml->pData);
		}
		if (sts<0)
		{
			WriteLog(id,"Falla Escritura2");
			break;
		}	
		xml = xml->pNext;
	   }
	   xml=xml_next_nivel;
	}while(xml!=NULL);
	sprintf(szData,"%c",0x03);
	sts=send(m_socket,szData,1,MSG_NOSIGNAL );
	WriteLog(id,"Send ETX");
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura3");
	}	
	return sts;
}


int SendSocketXML(int id,int m_socket,Tipo_XML *xml)
{
	char szData[MAX_BUFFER+3];
	int sts;
	char szTmp[6];
	int nLen;

	memset(szData,0,sizeof(szData));
	sprintf(szData,"%cXXXXX",2);
	nLen=strlen(szData);
	while(xml!=NULL)
	{
		if (nLen>sizeof(szData))
		{
			printf("BUFFER MUY CORTO!!!!\n\r");
			WriteLog(id,"BUFFER MUY CORTO");
			WriteLog(id,szData);
			return 0;
		}
		else
		{
			InsertaCampoXML(szData,xml->szCampo,xml->pData);
			xml = xml->pNext;
			nLen=strlen(szData);
		}
	}
	//El largo del paquete mas el ETX
	sprintf(szTmp,"%05ld",nLen-5);
	memcpy(&szData[1],szTmp,5);
	szData[nLen]=0x03;
	nLen=strlen(szData);

	WriteLog(id,szData);
	printf("Len=%i Envia Serv=%s\n\r",nLen,szData);

	sts=send(m_socket,szData,nLen,MSG_NOSIGNAL );
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura4");
	}
	return sts;
}


int SendSocketV1pData(int id,int m_socket,char *achData,int nLen)
{
	int nLen1,sts;
	char szTmp[6];
	char szData[1024];
	memset(szData,0,sizeof(szData));
	szData[0]=0x02;
	//El largo del paquete mas el ETX
	sprintf(szTmp,"%05ld",nLen+1);
	memcpy(&szData[1],szTmp,5);
	sts=send(m_socket,szData,strlen(szData),MSG_NOSIGNAL );
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura5");
		return sts;
	}
	sts=send(m_socket,achData,strlen(achData),MSG_NOSIGNAL );
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura5");
		return sts;
	}
	WriteLog(id,"Send Version1");
	WriteLog(id,achData);

	szData[0]=0x03;
	szData[1]=0x00;
	sts=send(m_socket,szData,strlen(szData),MSG_NOSIGNAL );
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura5");
		return sts;
	}
	return sts;
}

int SendSocketV1(int id,int m_socket,char achData[],int nLen)
{
	char szData[MAX_BUFFER+3];
	int nLen1,sts;
	char szTmp[6];
	szData[0]=0x02;
	if (nLen>sizeof(szData))
	{
		printf("BUFFER MUY CORTO!!!!\n\r");
		WriteLog(id,"BUFFER MUY CORTO");
		exit(1);
		memcpy(&szData[1],achData,sizeof(szData)-2);
		szData[sizeof(szData)-1]=0x03;
		nLen1=sizeof(szData);
	}
	else
	{
		//El largo del paquete mas el ETX
		sprintf(szTmp,"%05ld",nLen+1);
		memcpy(&szData[1],szTmp,5);
		memcpy(&szData[6],achData,nLen);
		szData[nLen+6]=0x03;
		szData[nLen+7]=0x00;
		nLen1=nLen;
		WriteLog(id,szData);
	}
	sts=send(m_socket,szData,nLen1+7,MSG_NOSIGNAL );
	if (sts<0)
	{
		WriteLog(id,"Falla Escritura5");
	}
	return sts;
}
//20121023 FAY sin limite de largo envia 2 STX al principio para soportar las 2 versiones
int SendSocket(int id,int m_socket,char achData[],int nLen)
{
        char szData[1024];
        int nLen1,sts;
        char szTmp[6];

	//Si se leyo un paquete con V2 se contesta con Version2, sino la version antigua
	if (Conexion[id].nVersion==1) return SendSocketV1pData(id,m_socket,achData,nLen);

	WriteLog(id,"Send Version2");
	memset(szData,0,sizeof(szData));
        szData[0]=0x02;
        szData[1]=0x02;
        //El largo del paquete mas el ETX
        sprintf(&szData[2],"%ld;",nLen+1);
	nLen1=strlen(szData);
	WriteLog(id,szData);
        sts=send(m_socket,szData,nLen1,MSG_NOSIGNAL );
        if (sts<0)
        {
                WriteLog(id,"Falla Escritura5");
		return sts;
        }
		
	//Envia la data
        sts=send(m_socket,achData,nLen,MSG_NOSIGNAL );
        if (sts<0)
        {
                WriteLog(id,"Falla Escritura6");
		return sts;
        }
        WriteLog(id,achData);
	//Envia ETX
	szData[0]=0x03;
	szData[1]=0;
        sts=send(m_socket,szData,1,MSG_NOSIGNAL );
        if (sts<0)
        {
                WriteLog(id,"Falla Escritura7");
		return sts;
        }
        return sts;
}

void CierraSocket(Tipo_Socket *pSocket)
{
	int sts;
	pSocket->nConectado=0;
	WriteLog(0,"CierraSocket");
	sts=close(pSocket->m_socket);
	if (sts<0) WriteLog(0,"Falla Cerrar Socket");
	pSocket->m_socket=-1;
	sprintf(pSocket->szDescripcion,"Closed");
}

void InicializaSocket(Tipo_Socket *pSocket,char szDesc[])
{
	pSocket->nConectado=0;
	pSocket->m_socket=-1;
	sprintf(pSocket->szDescripcion,"%s",szDesc);
}

//Funcion llamada por ThreadOrejaAsincronica
//Para reconectar el socket en caso de problemas
int ReconectaSocketAsinc(int id,int *m_socket)
{

	char szAux[1024];	
	Tipo_Socket stSocket;
	pthread_mutex_lock(&ServiciosAsincronos[id].mutex_serv_asinc);
	//Cierra Socket
	close(ServiciosAsincronos[id].nSocket);

	//tiempo para darle
	sleep(5);
        //Si ninguno cumplio la condicion
        sprintf(szAux,"H2H Re-Conectando H2H_Asinc %s;%i..\n\r",ServiciosAsincronos[id].szIp,ServiciosAsincronos[id].nPort);
        WritePid(szAux);

	//Ciclo hasta que este conectado...
	while (1)
	{
        	InicializaSocket(&stSocket,"Socket Asinc");
        	if (!ConectaCliente(id,ServiciosAsincronos[id].nPort,ServiciosAsincronos[id].szIp,&stSocket))
	        {
        	      sprintf(szAux,"Falla Conexion H2H_Asinc a %s;%i..\n\r",ServiciosAsincronos[id].szIp,ServiciosAsincronos[id].nPort);
                      WritePid(szAux);
              	      pthread_mutex_unlock(&ServiciosAsincronos[id].mutex_serv_asinc);
		      usleep(100);
		      pthread_mutex_lock(&ServiciosAsincronos[id].mutex_serv_asinc);
		}
		else break;
        }
	pthread_mutex_unlock(&ServiciosAsincronos[id].mutex_serv_asinc);
	//Asigno el puntero al socket abierto
	*m_socket=stSocket.m_socket;
	ServiciosAsincronos[id].nSocket=stSocket.m_socket;
	WritePid("Reconexion OK");
}

//Proceso que recibe un socket abierto y lee sobre el
//Este proceso termina cuando hay un timeout o hay un error en la lectura
//Este proceso una vez que parte nunca deja de conectarse a la ip puerto
void ThreadOrejaAsincronica(int *id1)
{
	int id=*id1;
	int m_socket=ServiciosAsincronos[id].nSocket;
	int nTimeout=ServiciosAsincronos[id].nTimeout;
	int bVariable=0;
	int bLargo1=0;
	int nLeidos,nLeidos1;
	char szLinea[MAX_BUFFER];
	char szLargo1[MAX_BUFFER];
	int i,bOk,sts;
	time_t	t2;
	char szAux[256];
	int bVariableHexa=0;
	Tipo_Data *pData;

	WritePid("Inicia Oreja Asincronica");
	if (memcmp(ServiciosAsincronos[id].szTipoLargo,"VAR_HEXA",8)==0) {
                bVariableHexa=1;
                bLargo1=ServiciosAsincronos[id].nTotalBytesIdData;
                WritePid("Tipo Variable Hexadecimal");
        } 
	else if (memcmp(ServiciosAsincronos[id].szTipoLargo,"VARIABLE",8)==0) 
	{ 
		bVariable=1; 
		bLargo1=ServiciosAsincronos[id].nTotalBytesIdData;
		WritePid("Tipo Variable");
	}
	
	do
	{
		memset(szLinea,0,sizeof(szLinea));
		WritePid("Espera Data");
		//Por defecto espera 300 segundos
		if ((sts=EsperaDataSocket(0,m_socket,300))<0)
		{
			WritePid("Falla en EsperaDataSocket Asinc");
			ReconectaSocketAsinc(id,&m_socket);
			continue;
		}
		//Si es data variable
		if (bVariable)
		{
			int nPorLeer;
			//Setea el largo de la respuesta
			WritePid("Lee Data Variable1");
			//Lee el largo
			pData=CreaData();
			//nLeidos1=LeeNData(0,m_socket,bLargo1,szLinea,nTimeout);
			pData=LeeNData(0,m_socket,bLargo1,pData,nTimeout,&nLeidos1);
			if (nLeidos1<0)
			{
				WritePid("Falla Leer largo Asinc");
				ReconectaSocketAsinc(id,&m_socket);
				continue;
			}
			memcpy(szLinea,pData->data,nLeidos1);
			szLinea[nLeidos1]=0;
			pData=LiberaData(pData);
			pData=CreaData();
			nPorLeer=atoi(szLinea);
			WritePid("Lee Data Variable2");
			//nLeidos=LeeNData(0,m_socket,nPorLeer,&szLinea[nLeidos1],nTimeout);
			pData=LeeNData(0,m_socket,nPorLeer,pData,nTimeout,&nLeidos);
			if (nLeidos<0)
			{
				WritePid("Falla Leer Data Asinc");
				ReconectaSocketAsinc(id,&m_socket);
				continue;
			}
			memcpy(&szLinea[nLeidos1],pData->data,nLeidos);
			szLinea[nLeidos]=0;
			pData=LiberaData(pData);
		}
		/// FC 2011-06-30 Se incluye lectura de longitud hexa
		else if (bVariableHexa) 
		{
                               int nPorLeerHexa;
                               char szAux[100];
                               //Setea el largo de la respuesta
                               nLeidos1=0;
                                WritePid("Lee Data Hexa Variable1");
                                //Lee el largo
				pData=CreaData();
                                //nLeidos1=LeeNData(0,m_socket,bLargo1,szLargo1,nTimeout);
				pData=LeeNData(0,m_socket,bLargo1,pData,nTimeout,&nLeidos1);
                                if (nLeidos1<0)
                                {
                                        WritePid("Falla Leer largo Asinc");
                                        ReconectaSocketAsinc(id,&m_socket);
                                        continue;
                                }
				memcpy(szLargo1,pData->data,nLeidos1);
				szLargo1[nLeidos1]=0;
				pData=LiberaData(pData);
                                writenhex(szLargo1,szAux,bLargo1);
				pData=CreaData();
                                nPorLeerHexa=hex2long(szAux);
                                WritePid("Lee Data Hexa Variable2");
                                //nLeidos=LeeNData(0,m_socket,nPorLeerHexa,&szLargo1[nLeidos1],nTimeout);
				pData=LeeNData(0,m_socket,nPorLeerHexa,pData,nTimeout,&nLeidos);
                                if (nLeidos<0)
                                {
                                        WritePid("Falla Leer Data Asinc");
                                        ReconectaSocketAsinc(id,&m_socket);
                                        continue;
                                }

				memcpy(&szLargo1[nLeidos1],pData->data,nLeidos);
				szLargo1[nLeidos]=0;
				pData=LiberaData(pData);
                                writenhex(szLargo1,szLinea,bLargo1+nLeidos);
                                WritePid(szLinea);
                                nLeidos=nLeidos*2;
                                nLeidos1=nLeidos1*2;
                }
		//Si es largo fijo cada respuesta
		else
		{	
			nLeidos1=0;
			WritePid("Lee Data Fija");
			pData=CreaData();
		//	nLeidos=LeeNData(0,m_socket,ServiciosAsincronos[id].nLenRsp,szLinea,nTimeout);
			pData=LeeNData(0,m_socket,ServiciosAsincronos[id].nLenRsp,pData,nTimeout,&nLeidos);
			if (nLeidos<0)
			{
				WritePid("Falla Leer Data Asinc");
				ReconectaSocketAsinc(id,&m_socket);
				continue;
			}
			memcpy(szLinea,pData->data,nLeidos);
			szLinea[nLeidos]=0;
		}

		time(&t2);

		WritePid("Respuesta Asincronica");
		WritePid(szLinea);
		
		bOk=1;
		pthread_mutex_lock(&ServiciosAsincronos[id].mutex_serv_asinc);
	        for (i=0;i<MAXIMO_RESPUESTAS;i++)
	        {
			//Si aun no ha asignado la respuesta
			if (bOk)
			{
				//Si esta vacia la casilla o expiro la respuesta que existe
            	   		if ((strlen(ServiciosAsincronos[id].Cola[i].szRespuesta)==0) || (t2-ServiciosAsincronos[id].Cola[i].time_ini>ServiciosAsincronos[id].nTimeout))
                	 	{
					//limpia la respuesta
					memset(ServiciosAsincronos[id].Cola[i].szRespuesta,0,sizeof(ServiciosAsincronos[id].Cola[i].szRespuesta));

					WritePid("Asigna Respuesta");
       		        	        memcpy(ServiciosAsincronos[id].Cola[i].szRespuesta,szLinea,nLeidos+nLeidos1);
               		        	ServiciosAsincronos[id].Cola[i].szRespuesta[nLeidos+nLeidos1]=0;
					ServiciosAsincronos[id].Cola[i].nLenRsp=nLeidos+nLeidos1;
					ServiciosAsincronos[id].Cola[i].time_ini=t2;
					bOk=0;
					break;
        	       		}
			}
			//si ya asigno respuesta verifico si hay algo que limpiar
			else
			{
				//Si hay una respuesta  esta expirada
            	   		if ((strlen(ServiciosAsincronos[id].Cola[i].szRespuesta)>0) && (t2-ServiciosAsincronos[id].Cola[i].time_ini>ServiciosAsincronos[id].nTimeout))
                	 	{
					//limpia la respuesta
					WritePid("Limpia Respuesta");
					WritePid(ServiciosAsincronos[id].Cola[i].szRespuesta);
					memset(ServiciosAsincronos[id].Cola[i].szRespuesta,0,sizeof(ServiciosAsincronos[id].Cola[i].szRespuesta));
					ServiciosAsincronos[id].Cola[i].nLenRsp=0;
					ServiciosAsincronos[id].Cola[i].time_ini=0;
        	       		}
			}
       		}
		pthread_mutex_unlock(&ServiciosAsincronos[id].mutex_serv_asinc);

		if (bOk)
		{
			WritePid("TODAS LAS CASILLAS DE RESPUESTA LLENAS");
		}

		//Si falla alguna tx volvemos a abrir el socket
		if (ServiciosAsincronos[id].nEstado==S_POR_CERRAR)
		{
			WritePid("Orden de Cerrar Socket");
			ReconectaSocketAsinc(id,&m_socket);
			continue;
		}
	} while(1);
	WritePid("Cierra Socket Asincronico");
}


int GetSocketHostHostAsinc(int id,Tipo_Socket *pSocket,Tipo_Servicio *pServ)
{
	int i;
	int nCasillaLibre=-1;
	char szAux[512];
	time_t	t1,t2;
	int bLog;
	Tipo_XML *xml1=NULL;

	//ENTRO REGION CRITICA
    	pthread_mutex_lock(&mut_hosthost_asinc);
	for (i=0;i<MAX_SERVICIOS_ASIN;i++)
	{
	    //Primero verificamos si hay alguno conectado al servicio
	    if (ServiciosAsincronos[i].nEstado==S_CONECTADO)
	    {
		sprintf(szAux,"Proceso Socket H2H_Asinc[%i] Conectado %i",i,ServiciosAsincronos[i].nSocket);
		WriteLog(id,szAux);

		//si esta conectado vemos si sirve
		if ((memcmp(pServ->szIp,ServiciosAsincronos[i].szIp,strlen(ServiciosAsincronos[i].szIp))==0)&& (pServ->nPort==ServiciosAsincronos[i].nPort))
		{
			WriteLog(id,"Servicio Asinc Conectado y Libre");

			//Si estamos aqui sirve, vemos si aun sirve
			pSocket->nConectado=1;
			pSocket->m_socket=ServiciosAsincronos[i].nSocket;

			//Para el log
			sprintf(pSocket->szIp,"%s",pServ->szIp);
			pSocket->nPort=pServ->nPort;
			//SALE REGION CRITICA
    			pthread_mutex_unlock(&mut_hosthost_asinc);
			return i;
		}
	   }
	}
	WriteLog(id,"Ninguno Asinc Conectado");
	//Busco casilla libre
	time(&t1);
	bLog=1;
	do
	{
		for (i=0;i<MAX_SERVICIOS_ASIN;i++)
		{
	    		if (ServiciosAsincronos[i].nEstado==S_DESCONECTADO)
			{	
				sprintf(szAux,"Casilla Libre H2H_Asinc %i",i);
				WriteLog(id,szAux);
				goto fin;
			}
		}
		if (bLog) WriteLog(id,"H2H_Asinc todos en uso");
		bLog=0;
		//LIBERA REGION CRITICA
    		pthread_mutex_unlock(&mut_hosthost_asinc);
		usleep(100);
		//ENTRO REGION CRITICA
	    	pthread_mutex_lock(&mut_hosthost_asinc);
		time(&t2);
		if (t2-t1>10)
		{
              		sprintf(szAux,"No hay casilla Libre para %s;%i.. h2h_asinc",pServ->szIp,pServ->nPort);
              		WriteLog(id,szAux);
              		return -1;
		}
	}while(1);

fin:

	//Si ninguno cumplio la condicion
        sprintf(szAux,"Conectando H2H_Asinc %s;%i..\n\r",pServ->szIp,pServ->nPort);
        WriteLog(id,szAux);
        InicializaSocket(pSocket,"Socket Servicio");
        if (!ConectaCliente(id,pServ->nPort,pServ->szIp,pSocket))
        {
              sprintf(szAux,"Falla Conexion H2H_Asinc a %s;%i..\n\r",pServ->szIp,pServ->nPort);
              WriteLog(id,szAux);
	      ServiciosAsincronos[i].nEstado=S_DESCONECTADO;
	      //Libera REGION CRITICA
	      pthread_mutex_unlock(&mut_hosthost_asinc);
              return -1;
        }
	sprintf(ServiciosAsincronos[i].szIp,"%s",pServ->szIp);
	ServiciosAsincronos[i].nPort=pServ->nPort;
	ServiciosAsincronos[i].nSocket = pSocket->m_socket;

	//Ademas en el patron final vienen los datos de donde buscar la respuesta y el largo de esta de esta forma
	//<len_rsp>519</len_rsp><ini_header>2</ini_header><fin_header>80</fin_header>
	xml1=ProcesaInputXML1(xml1,pServ->szPatronFinal);
	WriteLog(id,"PATRON_FINAL");
	WriteLog(id,pServ->szPatronFinal);
	ImprimeXML(xml1);
	GetIntXML(xml1,"LEN_RSP",&ServiciosAsincronos[i].nLenRsp);
	GetIntXML(xml1,"INI_HEADER",&ServiciosAsincronos[i].ini_header);
	GetIntXML(xml1,"FIN_HEADER",&ServiciosAsincronos[i].fin_header);
	//Si el tipo de largo es VARIABLE entonces busca tag "TOTAL_BYTES_LARGO_ID_DATA" para saber el largo
	GetStrXML(xml1,"TIPO_LARGO",ServiciosAsincronos[i].szTipoLargo,sizeof(ServiciosAsincronos[i].szTipoLargo));
	//Indica la cantidad de bytes con que viene el largo
	GetIntXML(xml1,"TOTAL_BYTES_LARGO_ID_DATA",&ServiciosAsincronos[i].nTotalBytesIdData);
	ServiciosAsincronos[i].nTimeout=pServ->nTimeout;
	ServiciosAsincronos[i].nTotalRespuestas=0;  //No llega nada todavia
        sprintf(szAux,"Socket Asic %i Asignado a %i en servicio %s:%i (Header ini=%i fin=%i)\n\r",pSocket->m_socket,i,pServ->szIp,pServ->nPort,ServiciosAsincronos[i].ini_header,ServiciosAsincronos[i].fin_header);
			
	//Creamos el proceso que lee sobre el socket
	ServiciosAsincronos[i].ident=pthread_create(&ServiciosAsincronos[i].task,NULL,(void *)ThreadOrejaAsincronica,(void *)&i);
        if (ServiciosAsincronos[i].ident>0) 
        {
		WriteLog(id,"Falla Crear ThreadOrejaAsincronica");
		ServiciosAsincronos[i].nEstado=S_DESCONECTADO;		
		//Libera Region Critica
		pthread_mutex_unlock(&mut_hosthost_asinc);
		return -1;
	}
	//Si abrio el socket y creo el proceso...
	ServiciosAsincronos[i].nEstado=S_CONECTADO;
	//Libera Region Critica
	pthread_mutex_unlock(&mut_hosthost_asinc);
        WriteLog(id,szAux);
	return i;
}
	      
/*
   Obtiene un socket conectado al h2h o genera una nueva conexion
*/
int GetSocketHostHostAsinc_malo(int id,Tipo_Socket *pSocket,Tipo_Servicio *pServ)
{
	int i;
	int nCasillaLibre=-1;
	char szAux[512];
	time_t	t1,t2;
	Tipo_XML *xml1=NULL;
    	pthread_mutex_lock(&mut_hosthost_asinc);
	for (i=0;i<MAX_SERVICIOS_ASIN;i++)
	{
	    //Primero verificamos si hay alguno conectado al servicio
	    if (ServiciosAsincronos[i].nEstado==S_CONECTADO)
	    {
		sprintf(szAux,"Socket H2H_Asinc[%i] Conectado %i",i,ServiciosAsincronos[i].nSocket);
		WriteLog(id,szAux);

		//si esta conectado vemos si sirve
		if ((memcmp(pServ->szIp,ServiciosAsincronos[i].szIp,strlen(ServiciosAsincronos[i].szIp))==0)&& (pServ->nPort==ServiciosAsincronos[i].nPort))
		{
			WriteLog(id,"Servicio Asinc Conectado y Libre");
			//Si estamos aqui sirve, vemos si aun sirve
			pSocket->nConectado=1;
			pSocket->m_socket=ServiciosAsincronos[i].nSocket;
			//ServiciosAsincronos[i].nEstado=S_PROCESO;
    			pthread_mutex_unlock(&mut_hosthost_asinc);
			return i;
		}
	   }
	}
	WriteLog(id,"Ninguno Asinc Conectado");
        //Libero region critica			
	pthread_mutex_unlock(&mut_hosthost_asinc);
	//Busco casilla libre
	time(&t1);
	do
	{
    		pthread_mutex_lock(&mut_hosthost_asinc);
		for (i=0;i<MAX_SERVICIOS_ASIN;i++)
		{
	    		if (ServiciosAsincronos[i].nEstado==S_DESCONECTADO)
			{	
				sprintf(szAux,"Casilla Libre H2H_Asinc %i",i);
				WriteLog(id,szAux);
				ServiciosAsincronos[i].nEstado=S_PROCESO;
				goto fin;
			}
		}
		WriteLog(id,"H2H_Asinc todos en uso");
    		pthread_mutex_unlock(&mut_hosthost_asinc);
		usleep(100);
		time(&t2);
		if (t2-t1>10)
		{
              		sprintf(szAux,"No hay casilla Libre para %s;%i.. h2h_asinc",pServ->szIp,pServ->nPort);
              		WriteLog(id,szAux);
              		return -1;
		}
	}while(1);

fin:
	//Si ninguno cumplio la condicion
    	pthread_mutex_unlock(&mut_hosthost_asinc);

        sprintf(szAux,"Conectando H2H_Asinc %s;%i..\n\r",pServ->szIp,pServ->nPort);
        WriteLog(id,szAux);
        InicializaSocket(pSocket,"Socket Servicio");
        if (!ConectaCliente(id,pServ->nPort,pServ->szIp,pSocket))
        {
              sprintf(szAux,"Falla Conexion H2H_Asinc a %s;%i..\n\r",pServ->szIp,pServ->nPort);
              WriteLog(id,szAux);
	      pthread_mutex_lock(&mut_hosthost_asinc);
	      ServiciosAsincronos[i].nEstado=S_DESCONECTADO;
	      pthread_mutex_unlock(&mut_hosthost_asinc);
              return -1;
        }
	sprintf(ServiciosAsincronos[i].szIp,"%s",pServ->szIp);
	ServiciosAsincronos[i].nPort=pServ->nPort;
	ServiciosAsincronos[i].nSocket = pSocket->m_socket;

	//Ademas en el patron final vienen los datos de donde buscar la respuesta y el largo de esta de esta forma
	//<len_rsp>519</len_rsp><ini_header>2</ini_header><fin_header>80</fin_header>
	xml1=ProcesaInputXML1(xml1,pServ->szPatronFinal);
	WriteLog(id,"PATRON_FINAL");
	WriteLog(id,pServ->szPatronFinal);
	ImprimeXML(xml1);
	GetIntXML(xml1,"LEN_RSP",&ServiciosAsincronos[i].nLenRsp);
	GetIntXML(xml1,"INI_HEADER",&ServiciosAsincronos[i].ini_header);
	GetIntXML(xml1,"FIN_HEADER",&ServiciosAsincronos[i].fin_header);
	ServiciosAsincronos[i].nTimeout=pServ->nTimeout;
	ServiciosAsincronos[i].nTotalRespuestas=0;  //No llega nada todavia
        sprintf(szAux,"Socket Asic %i Asignado a %i en servicio %s:%i (Header ini=%i fin=%i)\n\r",pSocket->m_socket,i,pServ->szIp,pServ->nPort,ServiciosAsincronos[i].ini_header,ServiciosAsincronos[i].fin_header);
        WriteLog(id,szAux);
	return i;
}


/*
 * Obtiene un socket conectado al host o genera uno nuevo
 * en caso de estar usando o desconectado
 */ 
int GetSocketHostHost(int id,Tipo_Socket *pSocket,char szIp[],int nPort)
{
	int i;
	int nCasillaLibre=-1;
	char szAux[200];
	time_t	t1,t2;
	int nLog=0;
    	pthread_mutex_lock(&mut_hosthost);
	for (i=0;i<MAX_HOSTHOST;i++)
	{
	    //sprintf(szAux,"H2H Casilla=%i Estado=%i",i,HostHost[i].nEstado);
	    //WriteLog(id,szAux);
	    //Primero verificamos si hay alguno conectado al servicio
	    if (HostHost[i].nEstado==S_CONECTADO)
	    {
		sprintf(szAux,"H2H Socket HostHost[%i] Conectado %i (%s:i%)",i,HostHost[i].nSocket,szIp,nPort);
		WriteLog(id,szAux);

		//si esta conectado vemos si sirve
		if ((memcmp(szIp,HostHost[i].szIp,strlen(HostHost[i].szIp))==0)&& (nPort==HostHost[i].nPort))
		{
			WriteLog(id,"H2H Servicio Conectado y Libre");
			
			//Si estamos aqui sirve, vemos si aun sirve
			pSocket->nConectado=1;
			pSocket->m_socket=HostHost[i].nSocket;

			//Para el log
                        sprintf(pSocket->szIp,"%s",szIp);
                        pSocket->nPort=nPort;

			HostHost[i].nEstado=S_PROCESO;
    			pthread_mutex_unlock(&mut_hosthost);
			return i;
		}
	   }
	}
	WriteLog(id,"H2H Ninguno Conectado");
        //Libero region critica			
	pthread_mutex_unlock(&mut_hosthost);
	//Busco casilla libre
	time(&t1);
	do
	{
    		pthread_mutex_lock(&mut_hosthost);
		for (i=0;i<MAX_HOSTHOST;i++)
		{
	    		if (HostHost[i].nEstado==S_DESCONECTADO)
			{	
				sprintf(szAux,"H2H Casilla Libre HH %i",i);
				WriteLog(id,szAux);
				HostHost[i].nEstado=S_PROCESO;
				goto fin;
			}
		}
		if (!nLog) {WriteLog(id,"H2H HOST-HOST todos en uso"); nLog=1;}
    		pthread_mutex_unlock(&mut_hosthost);
		usleep(100);
		time(&t2);
		if (t2-t1>10)
		{
              		sprintf(szAux,"H2H No hay casilla Libre para %s;%i..",szIp,nPort);
              		WriteLog(id,szAux);
              		return -1;
		}
	}while(1);

fin:
	//Si ninguno cumplio la condicion
    	pthread_mutex_unlock(&mut_hosthost);

        sprintf(szAux,"H2H Conectando H-H %s;%i..\n\r",szIp,nPort);
        WriteLog(id,szAux);
        InicializaSocket(pSocket,"Socket Servicio");
        if (!ConectaCliente(id,nPort,szIp,pSocket))
        {
              sprintf(szAux,"H2H Falla Conexion H-H a %s;%i..\n\r",szIp,nPort);
              WriteLog(id,szAux);
	      pthread_mutex_lock(&mut_hosthost);
	      HostHost[i].nEstado=S_DESCONECTADO;
	      pthread_mutex_unlock(&mut_hosthost);
              return -1;
        }
	sprintf(HostHost[i].szIp,"%s",szIp);
	HostHost[i].nPort=nPort;
	HostHost[i].nSocket = pSocket->m_socket;
        sprintf(szAux,"H2H Socket %i Asignado a Casilla %i en servicio %s:%i\n\r",pSocket->m_socket,i,szIp,nPort);
        WriteLog(id,szAux);
	return i;
}

int LiberaSocketHostHost(int id,int i)
{
     char szTmp[200];
      pthread_mutex_lock(&mut_hosthost);
      HostHost[i].nEstado=S_CONECTADO;
      sprintf(szTmp,"H2H Libera Socket H2H %i",i);
      WriteLog(id,szTmp);
      pthread_mutex_unlock(&mut_hosthost);
}
int LiberaSocketH2H_Asinc(int id,int i)
{
     char szTmp[200];
      pthread_mutex_lock(&mut_hosthost_asinc);
      ServiciosAsincronos[i].nEstado=S_CONECTADO;
      sprintf(szTmp,"H2H Libera Socket H2H Asinc %i",i);
      WriteLog(id,szTmp);
      pthread_mutex_unlock(&mut_hosthost_asinc);
}
int CierraSocketHostHost(int id,int i)
{
      pthread_mutex_lock(&mut_hosthost);
      HostHost[i].nEstado=S_DESCONECTADO;
      close(HostHost[i].nSocket);
      sprintf(HostHost[i].szIp,"");
      HostHost[i].nPort=0;
      pthread_mutex_unlock(&mut_hosthost);
}
int CierraSocketHostHostAsinc(int id,int i)
{
      //pthread_mutex_lock(&mut_hosthost_asinc);
      //ServiciosAsincronos[i].nEstado=S_POR_CERRAR;
      //pthread_mutex_unlock(&mut_hosthost_asinc);
}



void LiberaProcesoMulti(Tipo_Conexion *p,int id)
{
    	//pthread_mutex_lock(&mut_proc_multi);
	//futex_wait(&futex_multi,id);
	if (p->nTipoProceso==PROC_XML) p->nEstado=C_ESPERA;
	else p->nEstado=C_LIBRE;
	//global.nConexionesProcesoMulti--;
	//futex_wake(&futex_multi,id);
    	//pthread_mutex_unlock(&mut_proc_multi);
}

/*PAra este tipo de proceso no es necesario mutex */
void LiberaProceso(Tipo_Conexion *p,int id)
{
    	//pthread_mutex_lock(&mut_proc);
	if (p->nTipoProceso==PROC_XML) p->nEstado=C_ESPERA;
	else p->nEstado=C_LIBRE;
	//global.nConexionesProceso--;
    	//pthread_mutex_unlock(&mut_proc);
}

void EsperaActivacion(int id,Tipo_Conexion *p)
{
	int sts;
	char szTmp[200];
	long l;
	
	sprintf(szTmp,"Proceso %i en espera por tiempo...PID=[%i]\n\r",id,p->pid);
	WriteLog(id,szTmp);
	ftime(&p->pTimeFin);

	if ((p->pTimeFin.time>0) && (p->pTimeInicio.time>0))
	{
	   l=GetMilliSeconds(&p->pTimeFin,&p->pTimeInicio);
	   if (l>global.lTiempoPeorTx)
	   {
		sprintf(szTmp,"Peor Tiempo %ld",l);
		WriteLog(id,szTmp);
		global.lTiempoPeorTx=l;
		sprintf(global.szTxPeorTiempo,"%s",p->szTxActual);
	  }
	}
	
	//Espera hasta que llegue la senal
	LiberaProceso(p,id);
	if (p->nEstado==C_ESPERA) WriteLog(id,"Proceso en Espera!!");
	else WriteLog(id,"Proceso Libre!!"); 
	while (1)
	{
		if (p->nEstado==C_EJECUTAR) 
		{
			WriteLog(id,"Ejecuta");
			return;
		}
		else if (p->nEstado==C_TERMINAR) 
    		{
			int l;
			if (p->nSocket>0) close(p->nSocket);
			printf("Proceso %i Terminado...\n\r",id);
			p->nEstado=C_TERMINADO;
			Thread_Exit(id);
			pthread_exit((void *)&l);
		}
		usleep(100);
	}
}

void EsperaActivacion2(int id,Tipo_Conexion *p)
{
#ifndef _ISYS_SIGNAL_
	int sts;
	char szTmp[200];
	long l;
	
	sprintf(szTmp,"Proceso %i en espera...PID=[%i]\n\r",id,p->pid);
	printf("%s\n\r",szTmp);
	WriteLog(id,szTmp);
	ftime(&p->pTimeFin);

	if ((p->pTimeFin.time>0) && (p->pTimeInicio.time>0))
	{
	   l=GetMilliSeconds(&p->pTimeFin,&p->pTimeInicio);
	   if (l>global.lTiempoPeorTx)
	   {
		sprintf(szTmp,"Peor Tiempo %ld",l);
		WriteLog(id,szTmp);
		global.lTiempoPeorTx=l;
		sprintf(global.szTxPeorTiempo,"%s",p->szTxActual);
	  }
	}
	
	//Espera hasta que llegue la senal
	if (id>=nMinProcesosMulti) LiberaProcesoMulti(p,id);
	else LiberaProceso(p,id);

	if (p->nEstado==C_ESPERA) WriteLog(id,"Proceso en Espera!!");
	else if (p->nEstado==C_LIBRE) WriteLog(id,"Proceso Libre!!"); 
	else WriteLog(id,"Proceso ?!");
	sigwait(&p->mask,&sts);
        if (p->nEstado==C_TERMINAR) 
	{
		int l;
		if (p->nSocket>0) close(p->nSocket);
		printf("Proceso %i Terminado...\n\r",id);
		p->nEstado=C_TERMINADO;
		Thread_Exit(id);
		pthread_exit((void *)&l);
	}
	//Para contar los procesos activos
	pthread_mutex_lock(&mut_conexiones_activas);
	global.procesos_activos++;
	pthread_mutex_unlock(&mut_conexiones_activas);




#else
	EsperaActivacion(id,p);
#endif
}


void DesactivaProceso2(int id)
{
	//Si tiene conexion INTERNA desconecta la BD
	if (memcmp(global.szConexionBD,"INTERNA",7)==0)
	{
#ifdef FLAG_POSTGRES
	    PQfinish(Conexion[id].conn);
	    Conexion[id].conn=NULL;
#endif
	    WriteLog(id,"CIERRA BASE");
	}
	//Para contar los procesos activos
	pthread_mutex_lock(&mut_conexiones_activas);
	if (global.procesos_activos>0) global.procesos_activos--;
	pthread_mutex_unlock(&mut_conexiones_activas);
}

int TerminaProcesos()
{
	int i;
	char szAux[100];
	time_t t1,t2;
        for(i=1;i<global.nProcesos;i++)
        {
		sprintf(szAux,"Termina Proceso %i",i);
		WriteLog(0,szAux);
                Conexion[i].nEstado=C_TERMINAR;
		//kill(Conexion[i].pid,SIGUSR2);
		pthread_kill(Conexion[i].task,SIGUSR2);
        }
	//Termina Proceso de Control
	Conexion[global.nProcesos+1].nEstado=C_TERMINAR;

	CierraListaFormatos();

        while(1)
        {
	time(&t1);
        for(i=1;i<global.nProcesos;i++)
        {
		time(&t2);
		if (t2-t1>5) 
		{
			WriteLog(0,"Timeout en espera de termino");
			break;
		}
                if (Conexion[i].nEstado!=C_TERMINADO)
                {
                        i=0;
                        usleep(1);
                }
        }
        break;
        }
	WriteLog(0,"Termina proceso padre ...");
}             

int LimpiaConexion(int i,Tipo_Conexion *p)
{
	p->nEstado=C_LIBRE;
#ifdef FLAG_POSTGRES
	p->conn = NULL;
#endif
	p->nAbierta=0;
	p->pid=0;
	p->pTimeFin.time=0;
	p->pTimeInicio.time=0;
	p->nTipoProceso=PROC_SOCKET;
	sprintf(p->szData,"");
	sprintf(p->szTxActual,"");

}

int CreaProceso(int i,Tipo_Conexion *p)
{
	p->pid=getpid();
	sigemptyset(&p->mask);
	sigaddset(&p->mask,SIGUSR2);
	pthread_sigmask(SIG_SETMASK,&p->mask,NULL);

	p->ident=pthread_create(&p->task,NULL,(void *)TransactionThread,(void *)i);
	//p->ident=pthread_create(&p->task,NULL,(void *)TransactionThread,(void *)&i);
	printf("Inicializa Proceso* %i %i\n\r",i,p->task);
        if (p->ident>0) 
        {
		p->nEstado=C_FALLA;
		//printf("Falla create thread..i %s\n\r",strerror());
		WriteLog(i,"Falla Crear Thread\n\r");
		exit(0);
		return -1;
	}
	return 1;
}

int puntero_proceso_activo=1;
int puntero_proceso_activo_multi=1;

int DespiertaProcesoMulti(int i)
{
#ifndef _ISYS_SIGNAL_
//Necesita la senal para partir
Conexion[i].nEstado=C_EJECUTAR;
//kill(Conexion[i].pid,SIGUSR2);
pthread_kill(Conexion[i].task,SIGUSR2);
#else
//Solo esta en usleep el proceso
pthread_mutex_lock(&mut_proc_multi);
WriteLog(i,"Despierta Proceso");
Conexion[i].nEstado=C_EJECUTAR;
pthread_mutex_unlock(&mut_proc_multi);
#endif
}	
int DespiertaProceso(int i)
{
#ifndef _ISYS_SIGNAL_
//Necesita la senal para partir
Conexion[i].nEstado=C_EJECUTAR;
//kill(Conexion[i].pid,SIGUSR2);
//printf("TASK=%i\n",Conexion[i].task);
pthread_kill(Conexion[i].task,SIGUSR2);
#else
//Solo esta en usleep el proceso
//pthread_mutex_lock(&mut_proc);
WriteLog(i,"Despierta Proceso");
Conexion[i].nEstado=C_EJECUTAR;
//pthread_mutex_unlock(&mut_proc);
#endif
}	

int EsperaConexionLibreMulti(int id,int nConexiones)
{
    int i,nRef;
    char szAux[100];
    int nInforme=0;
    time_t t1,t2;
    
    pthread_mutex_lock(&mut_proc_multi);
    //futex_lock(id);
    global.nConexionesProcesoMulti++;
    global.lConexionesTotalesMulti++;
    if (global.nMaxConexionesMulti<global.nConexionesProcesoMulti) 
    {
		global.nMaxConexionesMulti=global.nConexionesProcesoMulti;
		time(&global.lTiempoMaxColaMulti);
    }

    nRef=puntero_proceso_activo_multi;
    do
    {
	//Si esta libre
       if (Conexion[puntero_proceso_activo_multi].nEstado==C_LIBRE)
       {
       	       i=puntero_proceso_activo_multi;
	       //Estado de no libre y no en ejecucion aun
	       Conexion[i].nEstado=C_XXX;
       	       puntero_proceso_activo_multi++;
       	       if (puntero_proceso_activo_multi>nConexiones-1) puntero_proceso_activo_multi=nMinProcesosMulti; 
	       pthread_mutex_unlock(&mut_proc_multi);
    	       //futex_unlock(id);
	       return i;
       }
       //Si no alcanzo a terminar a tiempo y el padre ya no lo necesita... 
       else if (Conexion[puntero_proceso_activo_multi].nEstado==C_ESPERA && Conexion[puntero_proceso_activo_multi].nIdPadre==-1)
       {
       	       i=puntero_proceso_activo_multi;
	       Conexion[i].nEstado=C_XXX;
       	       puntero_proceso_activo_multi++;
       	       if (puntero_proceso_activo_multi>nConexiones-1) puntero_proceso_activo_multi=nMinProcesosMulti; 
	       pthread_mutex_unlock(&mut_proc_multi);
    	       //futex_unlock(id);
	       //Estado de no libre y no en ejecucion aun
       	       sprintf(szAux,"Despega Proceso Multi %i",i);
	       WriteLog(id,szAux);
	       WriteError(id,szAux);
	       //pthread_mutex_lock(&Conexion[i].mut_cierra_xml);
	       if (Conexion[i].xml) Conexion[i].xml=CierraXML(Conexion[i].xml);
	       //pthread_mutex_unlock(&Conexion[i].mut_cierra_xml);
	       return i;
       }
       else
       {
       		//Estan todos ocupados o se quedo pegado un proceso...
		usleep(1);
      	 	//sprintf(szAux,"Proceso Pegado %i Estado=%i",puntero_proceso_activo,Conexion[puntero_proceso_activo].nEstado);
       		//WriteLog(id,szAux);
       		//WriteError(id,szAux);
       		//WriteError(id,Conexion[puntero_proceso_activo].szTxActual);
       		puntero_proceso_activo_multi++;
       		if (puntero_proceso_activo_multi>nConexiones-1) puntero_proceso_activo_multi=nMinProcesosMulti;
       		if (nRef==puntero_proceso_activo_multi) 
       		{
			if (!nInforme)
			{
				time(&t1);
		    		WriteLog(0,"TODOS LOS HILOS EN USO MULTI!");
	    			WriteError(0,"TODOS LOS HILOS EN USO MULTI!");
				nInforme=1;
			}
       	    		pthread_mutex_unlock(&mut_proc_multi);
    	       	        //futex_unlock(id);
            		usleep(600);
			time(&t2);
			//Si pasan 10 seg vuelve a decir que estan todos pegados
			if (t2-t1>10) nInforme=0;
	    		if (global.nMataProceso)
	    		{
    				WriteLog(id,"DETIENE SERVICIO");
	        		WriteError(id,"TODOS LOS HILOS EN USO!");
				exit(1);
	    		}
       	    		pthread_mutex_lock(&mut_proc_multi);
    			//futex_lock(id);
    			nRef=puntero_proceso_activo_multi;
       		}
       }
   }while(1);
}

//Lista circular
int EsperaConexionLibre(int id,int nConexiones)
{
    int i,nRef;
    char szAux[100];
    int nInforme=0;
    time_t t1,t2;
    
    //pthread_mutex_lock(&mut_proc);
    global.nConexionesProceso++;
    global.lConexionesTotales++;
	/*
    if (global.nMaxConexiones<global.nConexionesProceso) 
    {
		global.nMaxConexiones=global.nConexionesProceso;
		time(&global.lTiempoMaxCola);
    }
	*/

    nRef=puntero_proceso_activo;
    do
    {
       if (Conexion[puntero_proceso_activo].nEstado==C_LIBRE)
       {
       	       i=puntero_proceso_activo;
	       //Estado de no libre y no en ejecucion aun
	       Conexion[i].nEstado=C_XXX;
       	       puntero_proceso_activo++;
       	       if (puntero_proceso_activo>nMaxProcesosNormales) puntero_proceso_activo=1; 
	       //pthread_mutex_unlock(&mut_proc);
	       return i;
       }
       //Si no alcanzo a terminar a tiempo y el padre ya no lo necesita... 
       else if (Conexion[puntero_proceso_activo].nEstado==C_ESPERA && Conexion[puntero_proceso_activo].nIdPadre==-1)
       {
       	       i=puntero_proceso_activo;
	       Conexion[i].nEstado=C_XXX;
       	       puntero_proceso_activo++;
       	       if (puntero_proceso_activo>nMaxProcesosNormales) puntero_proceso_activo=1; 
	       //pthread_mutex_unlock(&mut_proc);
       //Estado de no libre y no en ejecucion aun
       	       sprintf(szAux,"Despega Proceso %i",i);
	       WriteLog(id,szAux);
	       WriteError(id,szAux);
	       //pthread_mutex_lock(&Conexion[i].mut_cierra_xml);
	       if (Conexion[i].xml) Conexion[i].xml=CierraXML(Conexion[i].xml);
	       //pthread_mutex_unlock(&Conexion[i].mut_cierra_xml);
	       return i;
       }
       else
       {
       		//Estan todos ocupados o se quedo pegado un proceso...
		usleep(1);
      	 	//sprintf(szAux,"Proceso Pegado %i Estado=%i",puntero_proceso_activo,Conexion[puntero_proceso_activo].nEstado);
       		//WriteLog(id,szAux);
       		//WriteError(id,szAux);
       		//WriteError(id,Conexion[puntero_proceso_activo].szTxActual);
       		puntero_proceso_activo++;
       		if (puntero_proceso_activo>nMaxProcesosNormales) puntero_proceso_activo=1;
       		if (nRef==puntero_proceso_activo) 
       		{
			if (!nInforme)
			{
				time(&t1);
		    		WriteLog(0,"TODOS LOS HILOS EN USO!");
	    			WriteError(0,"TODOS LOS HILOS EN USO!");
				nInforme=1;
			}
       	    		//pthread_mutex_unlock(&mut_proc);
            		usleep(600);
			time(&t2);
			//Si pasan 10 seg vuelve a decir que estan todos pegados
			if (t2-t1>10) nInforme=0;
	    		if (global.nMataProceso)
	    		{
    				WriteLog(id,"DETIENE SERVICIO");
	        		WriteError(id,"TODOS LOS HILOS EN USO!");
				exit(1);
	    		}
       	    		//pthread_mutex_lock(&mut_proc);
    			nRef=puntero_proceso_activo;
       		}
       }
   }while(1);
}


void CreaProcesos(char szDisplay[],int nConexiones)
{
	char szAux[100];
	int i;


	//Inicializa senales
	InicializaSenales();

	//Para finalizar los procesos..
	for(i=1;i<MAX_CONEXIONES;i++) Conexion[i].nEstado=C_TERMINADO;

	//Inicializa Conexiones...
	if (nConexiones>MAX_CONEXIONES) nConexiones=MAX_CONEXIONES;
	
	//Inicializa los procesos
	sprintf(szAux,"ProcesosMulti=%i ProcesosNormales=%i",global.nTotalProcesosMulti,nConexiones-global.nTotalProcesosMulti);
	WriteLog(0,szAux);

	//Asigna cotas para separar proceos
	nMaxProcesosNormales=nConexiones-global.nTotalProcesosMulti;
	nMinProcesosMulti=nMaxProcesosNormales+1;
	puntero_proceso_activo=1; //puntero inicial proceos normales
	puntero_proceso_activo_multi=nMinProcesosMulti; //Puntero inicial procesos multi

	//Procesos Multi van desde nMinProcesosMulti hasta nConexiones
	//Procesos iNormales van desde 0 hasta nMaxProcesosNormales
	
	
	//Variables de control
	global.nProcesosActivos=nConexiones-global.nTotalProcesosMulti;
	global.nProcesosActivosMulti=global.nTotalProcesosMulti;

	printf("Inicializa Procesos...\n\r");
	for(i=1;i<nConexiones;i++) 
	{
		//Al crear el proceso le resta
		if (i>=nMinProcesosMulti) global.nConexionesProcesoMulti++;
	        else global.nConexionesProceso++;

		LimpiaConexion(i,&Conexion[i]);
		CreaProceso(i,&Conexion[i]);
	}
	CreaProcesoControl(nConexiones+1);


	printf("%s\n\r",szDisplay);
}

int ImprimeEstProcesos(int nConexiones)
{
	int nEje=0,nLibre=0,nOtro=0;
	int i;
	char szAux[200];
	for(i=0;i<nConexiones;i++)
	{
		switch (Conexion[i].nEstado)
		{
			case C_EJECUTAR: nEje++; break;
			case C_LIBRE:	nLibre++; break;
			default : nOtro++; break;
		}
	}
	sprintf(szAux,"Conexiones en PRoceso = %i Proce Eje=%i,Libres=%i,Otro=%i",global.nConexionesProceso,nEje,nLibre,nOtro);
	//WriteLogEst(0,szAux);
}

void CreaConexiones(char szDisplay[],int nConexiones)
{
	char szAux[200];
	int i,j;
	struct timeb pTime1;
	int nMaximo=0;
	if (nConexiones>MAX_CONEXIONES) nConexiones=MAX_CONEXIONES;
	CreaProcesos(szDisplay,nConexiones);

	if (global.nTipoGprs)
	{
		//Inicializo Socket Clientes GPRS
		for (j=0; j<MAX_SOCKETS_GPRS; j++)
		{
			stGprs[j].nSocket=0;
			stGprs[j].nProceso=0;
		}
	}

	//Para Estadistica
	global.lConexionesTotalesMulti=0;
	// run until no longer required
	while(1) 
	{
		// local data
		int m_hAcceptSocket,i;
		struct sockaddr_in sa_cli;
		socklen_t client_len;
		char szIpCliente[50];

		//ImprimeEstProcesos(nConexiones);
ini:
		if (global.nTipoGprs) 
		{
			char szTmp[512];
			int nAux=0;
			//WriteLog(0,"Tipo GPRS");
			//Armo select de clientes
			fd_set descriptoresLectura; 
			nMaximo=0;

			FD_ZERO (&descriptoresLectura); 
			FD_SET (m_hWorldSocket, &descriptoresLectura); 
			nMaximo=m_hWorldSocket;
			nAux=0;
			pthread_mutex_lock(&mut_sockets_gprs);
			for (j=0; j<MAX_SOCKETS_GPRS; j++)
			{
				if (stGprs[j].nSocket!=0) 
				{
    					FD_SET (stGprs[j].nSocket, &descriptoresLectura); 
					//sprintf(szTmp,"Asigno Socket %i a lista",stGprs[j].nSocket);
					//WriteLog(0,szTmp);
					if (nMaximo<stGprs[j].nSocket) nMaximo=stGprs[j].nSocket;
					nAux++;
				}
			}
			global.lConexionesTotalesMulti=nAux;
			pthread_mutex_unlock(&mut_sockets_gprs);
			//sprintf(szTmp,"Maximo=%i Espera select Total en Lista=%i\n",nMaximo,nCount);
			//WriteLog(0,szTmp);
			select (nMaximo+1,&descriptoresLectura, NULL, NULL, NULL);

			//Verificamos is hay una conexion del socket maestro
			/* Se trata el socket servidor */ 
			if (FD_ISSET (m_hWorldSocket, &descriptoresLectura)) 
			{ 
				// accept the connection
				client_len = sizeof(sa_cli);
				m_hAcceptSocket = accept(m_hWorldSocket,(struct sockaddr*)&sa_cli,&client_len);
				printf("IP CLiente=%s",inet_ntoa(sa_cli.sin_addr));
				sprintf(szIpCliente,"%s",inet_ntoa(sa_cli.sin_addr));
		
				if (global.nTotalIpBloqueadas>0)
				{
					int j;
					for(j=0;j<global.nTotalIpBloqueadas;j++)
					{
						//Si la ip de conexion esta como bloqueada ignoro la conexion
						if (memcmp((char *)szIpCliente,global.szIpBloqueada[j],strlen(global.szIpBloqueada[j]))==0)
						{
							//Ignora conexion
							close(m_hAcceptSocket);
							goto sigue;
						}
					}
				}

				ftime(&pTime1);
				WriteLog(0,szIpCliente);
				sprintf(szAux,"Acepta Conexion %i IP=%s",m_hAcceptSocket,szIpCliente);
				//sprintf(szAux,"Acepta Conexion %i",m_hAcceptSocket);
				WriteLog(0,szAux);
				printf("Acepta Conexion %i\n\r",m_hAcceptSocket);
				// if the accept did not fail then process
				if(INVALID_SOCKET != m_hAcceptSocket) 
				{
					//Solo asigno el socket a la lista para que espere la lectura
					//sprintf(Conexion[i].szIp,"%s",szIpCliente);
			                pthread_mutex_lock(&mut_sockets_gprs);
			                for (j=0; j<MAX_SOCKETS_GPRS; j++)
               				{
 			                       if (stGprs[j].nSocket==0)
                        			{
                          			     stGprs[j].nSocket=m_hAcceptSocket;
                   			             WriteLog(0,"Asigno Socket en stGprs");
                        			     break;
                        			}
                			}				
                			pthread_mutex_unlock(&mut_sockets_gprs);
				}
				else
				{
					WriteError(0,"Falla Conexion");
					close(m_hAcceptSocket);
				}
			}
sigue:

			//Si sale de aca revisamos que paso
			/* Se tratan los clientes */ 
			pthread_mutex_lock(&mut_sockets_gprs);
			for (j=0; j<MAX_SOCKETS_GPRS; j++)
			{
    				if (stGprs[j].nSocket && (stGprs[j].nProceso==0) && (FD_ISSET (stGprs[j].nSocket, &descriptoresLectura)))
				{
					int sts,l;
					//sprintf(szTmp,"Socket %i con senal",stGprs[j].nSocket);
					//WriteLog(0,szTmp);
					//Verificamos si esta cerrando o hay datos
					sts=ioctl(stGprs[j].nSocket,FIONREAD,&l);
        				if (sts<0)
        				{
  				              sprintf(szAux,"Error Socket %i",stGprs[j].nSocket);
       					      WriteLog(0,szAux);
					      close(stGprs[j].nSocket);
					      stGprs[j].nSocket=0;
					}
					else if (l==0)
					{
  				              sprintf(szAux,"Socket Cerrado Remoto %i",stGprs[j].nSocket);
       					      WriteLog(0,szAux);
					      close(stGprs[j].nSocket);
					      stGprs[j].nSocket=0;
					}
					//Hay data de un socket cliente
					else
					{
						struct tm thoy;
						sprintf(szTmp,"Socket %i con data=%i",stGprs[j].nSocket,l);
						WriteLog(0,szTmp);

						//Libera los procesos En caso de que se llenen los proceso
						pthread_mutex_unlock(&mut_sockets_gprs);	
						i=EsperaConexionLibre(0,nConexiones);
						pthread_mutex_lock(&mut_sockets_gprs);	

						Conexion[i].pTimeInicio.time=pTime1.time;
						Conexion[i].pTimeInicio.millitm=pTime1.millitm;
						Conexion[i].pTimeFin.time=0;
						localtime_r(&pTime1.time,&thoy);
						sprintf(Conexion[i].szTime,"%04i/%02i/%02i %02i:%02i:%02i",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec);
						//printf("Asigna Ejecucion %lx:%x\n\r",sa_cli.sin_addr.s_addr,sa_cli.sin_port);
						Conexion[i].nSocket = stGprs[j].nSocket;
						stGprs[j].nProceso=i;
						Conexion[i].nTipoProceso = PROC_SOCKET;
						sprintf(Conexion[i].szIp,"");
#ifndef _ISYS_SIGNAL_
						sprintf(szAux,"Hace Senal %i SIGUSR2",i);
						WriteLog(0,szAux);
#endif
						sprintf(szAux,"Asigna Proceso=%i a Socket=%i",i, stGprs[j].nSocket);
						WriteLog(0,szAux);
						Conexion[i].xml=CierraXML(Conexion[i].xml);
						//stGprs[j].nSocket=0;
						DespiertaProceso(i);
					}
				}
				//Si no despierta el proceso...
				else
				{
					/*
					if (stGprs[j].nSocket && (FD_ISSET (stGprs[j].nSocket, &descriptoresLectura)))
					{
						sprintf(szAux,"Socket %i ya atendido por proceso %i",stGprs[j].nSocket,stGprs[j].nProceso);
						WriteLog(0,szAux);
					}
					*/
				}
			}
			pthread_mutex_unlock(&mut_sockets_gprs);	
		}		
		else
		{
			// accept the connection
			client_len = sizeof(sa_cli);
			m_hAcceptSocket = accept(m_hWorldSocket,(struct sockaddr*)&sa_cli,&client_len);
			printf("IP CLiente=%s",inet_ntoa(sa_cli.sin_addr));
			sprintf(szIpCliente,"%s",inet_ntoa(sa_cli.sin_addr));
		
			if (global.nTotalIpBloqueadas>0)
			{
				int j;
				for(j=0;j<global.nTotalIpBloqueadas;j++)
				{
					//Si la ip de conexion esta como bloqueada ignoro la conexion
					if (memcmp((char *)szIpCliente,global.szIpBloqueada[j],strlen(global.szIpBloqueada[j]))==0)
					{
						//Ignora conexion
						close(m_hAcceptSocket);
						goto ini;
					}
				}
			}

			ftime(&pTime1);
			WriteLog(0,szIpCliente);
			sprintf(szAux,"Acepta Conexion %i IP=%s",m_hAcceptSocket,szIpCliente);
			//sprintf(szAux,"Acepta Conexion %i",m_hAcceptSocket);
			WriteLog(0,szAux);
			printf("Acepta Conexion %i\n\r",m_hAcceptSocket);
			// if the accept did not fail then process
			if(INVALID_SOCKET != m_hAcceptSocket) 
			{
				struct tm thoy;
				i=EsperaConexionLibre(0,nConexiones);
				Conexion[i].pTimeInicio.time=pTime1.time;
				Conexion[i].pTimeInicio.millitm=pTime1.millitm;
				Conexion[i].pTimeFin.time=0;
				localtime_r(&pTime1.time,&thoy);
				sprintf(Conexion[i].szTime,"%04i/%02i/%02i %02i:%02i:%02i",thoy.tm_year+1900,thoy.tm_mon+1,thoy.tm_mday,thoy.tm_hour,thoy.tm_min,thoy.tm_sec);
				printf("Asigna Ejecucion %lx:%x\n\r",sa_cli.sin_addr.s_addr,sa_cli.sin_port);
				Conexion[i].nSocket = m_hAcceptSocket;
				Conexion[i].nTipoProceso = PROC_SOCKET;
				sprintf(Conexion[i].szIp,"%s",szIpCliente);
#ifndef _ISYS_SIGNAL_
				sprintf(szAux,"Hace Senal %i SIGUSR2",i);
				WriteLog(0,szAux);
#endif
				Conexion[i].xml=CierraXML(Conexion[i].xml);
				DespiertaProceso(i);
				//malloc_trim(0);
			}
			else
			{
				close(m_hAcceptSocket);
				//FAY 2015-07-06 Si falla la conexion 
				//Esperamos y reabrimos el socket server
				sprintf(szAux,"Falla Conexion, Se Reabre Socket Server");
				WriteLog(0,szAux);
				WriteError(0,szAux);
				WriteMensajeApp(0,szAux);
				sleep(1);
				close(m_hWorldSocket);
				InicializaServerSocket(global.nPortServicio);			
				//WriteLogEst(0,"Falla Conexion");
				//global.nConexionesProceso--;
			}
		}
	} //while
}


int InicializaServerSocket(int nPort)
{
	struct sockaddr_in addr;
	 int optval = 1;
	char szTmp[1024];

	// create the incoming socket
	m_hWorldSocket = socket(AF_INET,SOCK_STREAM,0);

	// if the socket did not create then fai
	if(INVALID_SOCKET == m_hWorldSocket) 
	{
		// warn user
		printf("Could not create World socket\n\r");

		// fail
		exit(0);
	}

	// set the bind parameters for this socket
	addr.sin_family = AF_INET;
	addr.sin_port = htons(nPort);
	addr.sin_addr.s_addr = htonl((u_long)INADDR_ANY);

	//para mantener viva la coneixon con el cliente
        setsockopt(m_hWorldSocket,SOL_SOCKET,SO_REUSEADDR,(const char *)&optval,sizeof(int));
        setsockopt(m_hWorldSocket,SOL_SOCKET,SO_REUSEPORT,(const char *)&optval,sizeof(int));

	// if this socket does not bind then fail
	if(bind(m_hWorldSocket,(struct sockaddr *)&addr,sizeof(addr))==-1) {
		sprintf(szTmp,"Falla Bind Socket %i",nPort);
		WriteLog(0,szTmp);
		WriteError(0,szTmp);
		WriteMensajeApp(0,szTmp);
		printf("Falla bind...\n\r");
				exit(0);
	}

	// if this socket won't listen then fail
	if(listen(m_hWorldSocket,1024)==-1) {
		sprintf(szTmp,"Falla Listen Socket %i",nPort);
		WriteLog(0,szTmp);
		WriteError(0,szTmp);
		WriteMensajeApp(0,szTmp);
		exit(0);
	}
	global.nPortServicio=nPort;
	return 1;
}

int InicializaServerSocket1(const char *szNameServ)
{

	struct sockaddr_in addr;
	struct servent *sv;
	struct linger ls = {1,0};
	 int optval = 1;

	sv = getservbyname(szNameServ,NULL);
	if (sv==NULL) 
	{
		printf("Servicio %s no encontrado en /etc/services\n\r");
		exit(0);
	}
	printf("Servicio abre Port %i en /etc/services\n\r",ntohs(sv->s_port));
	

	// create the incoming socket
	m_hWorldSocket = socket(AF_INET,SOCK_STREAM,0);

	// if the socket did not create then fail
	if(INVALID_SOCKET == m_hWorldSocket) 
	{
		// warn user
		printf("Could not create World socket\n\r");

		// fail
		exit(0);
	}

	// set the bind parameters for this socket
	addr.sin_family = AF_INET;
	addr.sin_port = htons(ntohs(sv->s_port));
	addr.sin_addr.s_addr = htonl((u_long)INADDR_ANY);

	//para mantener viva la coneixon con el cliente
        setsockopt(m_hWorldSocket,SOL_SOCKET,SO_REUSEADDR,(const char *)&optval,sizeof(int));
        setsockopt(m_hWorldSocket,SOL_SOCKET,SO_REUSEPORT,(const char *)&optval,sizeof(int));
        //setsockopt(m_hWorldSocket,SOL_SOCKET,SO_LINGER,(struct linger *)&ls,sizeof(struct linger *));

	// if this socket does not bind then fail
	if(bind(m_hWorldSocket,(struct sockaddr *)&addr,sizeof(addr))==-1) {
		printf("Falla bind...\n\r");
				exit(0);
	}

	// if this socket won't listen then fail
	if(listen(m_hWorldSocket,1024)==-1) {
		printf("Falla listen...\n\r");
		exit(0);
	}
	return 1;
}



int InicializaServerUdp(int nPort)
{

	struct sockaddr_in	addr;
	int nSocket;

	// create the incoming socket
	nSocket = socket(AF_INET,SOCK_DGRAM,0);

	// if the socket did not create then fail
	if(INVALID_SOCKET == nSocket) 
	{
		// warn user
		printf("Falla inicializaion Server UDP\n\r");

		exit(0);
	}

	// set the bind parameters for this socket
	addr.sin_family = AF_INET;
	addr.sin_port = htons(nSocket);
	addr.sin_addr.s_addr = INADDR_LOOPBACK;

	// if this socket does not bind then fail
	if(bind(nSocket,(struct sockaddr *)&addr,sizeof(addr))) {
		printf("Falla bind...\n\r");
		// fail
		exit(0);
	}


	// run until no longer required
	while(1) 
	{
		// local data
		int		nSelect;
		fd_set	read_set;
		struct timeval time1;

			char		szBuffer[4096];
			struct sockaddr_in	addr;
			int			nRead,nFromLen = sizeof(addr);

			// begin
			// read the message
			nRead = recvfrom(nSocket,szBuffer,4096,0,(struct sockaddr *)&addr,&nFromLen);
			printf("LEi....\n\r");

			// if data read correctly then process it
			if(nRead && (SOCKET_ERROR != nRead)) 
			{
				// null terminate the buffer
				szBuffer[nRead] = 0;

				//TransactionThread(nSocket,szBuffer);

			}
	}
	return 1;
}

int SERVICIO_PROCESO(int id,int nTx)
{
	Conexion[id].stServ.nTx=nTx;
	BuscaServicio(id,&Conexion[id].stServ,BUSCA_TX);
}

int ESTADO_PROCESO(int nProceso)
{
	return Conexion[nProceso].nEstado;
}

int XML_PROCESO(int nProceso,Tipo_XML *xml)
{
	Conexion[nProceso].xml=xml;
}

int DATA_PROCESO(int nProceso,char szData[])
{
	sprintf(Conexion[nProceso].szData,"%s",szData);
}

int ACCION_PROCESO(int nProceso,int nAccion)
{
	Conexion[nProceso].nEstado=nAccion;
}

char *GET_PAGINA_SERVICIO(int id)
{
	return Conexion[id].stServ.szPagina;
}

int GET_SOCKET_PROCESO(int id)
{
	return Conexion[id].nSocket;
}

int LOG(int id) { return Conexion[id].nLogActivado; }
int SET_LOG(int id,int n) { Conexion[id].nLogActivado=n; }


int SendCaracter(int nSocket,char szAux)
{
	send(nSocket,&szAux,1,MSG_NOSIGNAL );
}

int SendData(int nSocket,char szCampo[],char szData[])
{
	char szAux[1024];
	sprintf(szAux,"<%s=%ld>",szCampo,strlen(szData));
	send(nSocket,szAux,strlen(szAux),MSG_NOSIGNAL);
	return send(nSocket,szData,strlen(szData),MSG_NOSIGNAL);
}
