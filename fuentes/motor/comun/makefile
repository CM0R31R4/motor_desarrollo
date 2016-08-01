DEP = IsysSocket.o IsysXml.o IsysFunciones.o IsysSignal.o IsysDes.o IsysTags.o IsysFormatos.o IsysGlobal.o IsysWebsrv.o IsysBase80.o IsysSms.o IsysQuerys.o IsysControl.o IsysBase81.o IsysProcesaQuerys.o IsysPostgres.o IsysTxComun.o IsysBase64.o IsysMysql.o IsysJson.o


#Para Operar 
#CC  = gcc -Ofast -g -fpic -D_REENTRANT -D_LIBC_REENTRANT -funroll-loops -minline-all-stringops -finline-functions
CC  = gcc -m64 -g -fpic -D_REENTRANT -D_LIBC_REENTRANT -funroll-loops -minline-all-stringops -finline-functions

#Para Bono3
#CC  = gcc -g -D_REENTRANT -D_LIBC_REENTRANT -funroll-loops -minline-all-stringops -finline-functions


#Para Operar RSA Procesa XML
#ProcesadorCa4dnd, Procesador, ProcesadorTraza,
#CC  = gcc -g -fpic -D_REENTRANT -D_LIBC_REENTRANT -funroll-loops -minline-all-stringops -D_RSA_


#Para Operar con Postgres Incrustadp
#ProcesaColaMotor, BasePostgres
#CC  = gcc -Ofast -g -fpic -D_REENTRANT -D_LIBC_REENTRANT -m64 -fsched2-use-traces -funroll-loops -minline-all-stringops -DFLAG_POSTGRES
#CC  = gcc -g -fpic -D_REENTRANT -D_LIBC_REENTRANT -m64 -DFLAG_POSTGRES


#Con MYSQL
#CC  = gcc -g -fpic -D_REENTRANT -D_LIBC_REENTRANT -m64 -fsched2-use-traces -funroll-loops -minline-all-stringops -DFLAG_MYSQL
#Para SSL
#CC  = gcc -Ofast -g -fpic -D_REENTRANT -D_LIBC_REENTRANT -D_ISYS_SSL_ 



#PAra operar comn wait
#CC  = gcc -g -D_REENTRANT -D_LIBC_REENTRANT -D_ISYS_SIGNAL_

INCL = -I../include/ -I/usr/include/openssl -I/usr/include/postgresql/ -I/usr/include/mysql/
#INCL = -I../include/ -I/usr/include/openssl -I/usr/include/mysql/
LIBS = -L /usr/lib/

all:	$(DEP)	
	ar -r libIsys.a $(DEP) 

IsysTxComun.o:		IsysTxComun.c
	$(CC) -c  IsysTxComun.c $(INCL) 

IsysPostgres.o:		IsysPostgres.c
	$(CC) -c  IsysPostgres.c $(INCL) 

IsysProcesaQuerys.o:	IsysProcesaQuerys.c
	$(CC) -c  IsysProcesaQuerys.c $(INCL) 

IsysControl.o:	IsysControl.c
	$(CC) -c  IsysControl.c $(INCL) 

IsysQuerys.o:	IsysQuerys.c
	$(CC) -c  IsysQuerys.c $(INCL) 

IsysSms.o:	IsysSms.c
	$(CC) -c  IsysSms.c $(INCL) 

IsysBase81.o:	IsysBase81.c
	$(CC) -c  IsysBase81.c $(INCL) 

IsysBase80.o:	IsysBase80.c
	$(CC) -c  IsysBase80.c $(INCL) 

IsysWebsrv.o:	IsysWebsrv.c
	$(CC) -c  IsysWebsrv.c $(INCL) 

IsysGlobal.o:	IsysGlobal.c
	$(CC) -c  IsysGlobal.c $(INCL) 

IsysDes.o:	IsysDes.c
	$(CC) -c  IsysDes.c $(INCL) 

IsysSignal.o:	IsysSignal.c
	$(CC) -c  IsysSignal.c $(INCL) 

IsysCuenta.o:	IsysCuenta.c
	$(CC) -c  IsysCuenta.c $(INCL) 

IsysSocket.o:	IsysSocket.c
	$(CC) -c  IsysSocket.c $(INCL) 

IsysXml.o:	IsysXml.c
	$(CC) -c  IsysXml.c $(INCL) 

IsysCalculaCuota.o:	IsysCalculaCuota.c
	$(CC) -c  IsysCalculaCuota.c $(INCL) 

IsysFunciones.o:	IsysFunciones.c
	$(CC) -c  IsysFunciones.c $(INCL) 

IsysTransaccion.o:	IsysTransaccion.c
	$(CC) -c  IsysTransaccion.c $(INCL) 

IsysTags.o:	IsysTags.c
	$(CC) -c  IsysTags.c $(INCL) 

IsysBase64.o:	IsysBase64.c
	$(CC) -c  IsysBase64.c $(INCL) 

IsysMysql.o:	IsysMysql.c
	$(CC) -c  IsysMysql.c $(INCL) 

IsysFormatos.o:	IsysFormatos.c
	$(CC) -c  IsysFormatos.c $(INCL) 

IsysJson.o:	IsysJson.c
	$(CC) -c  IsysJson.c $(INCL) 
clean:
	rm -f *.o *.a

