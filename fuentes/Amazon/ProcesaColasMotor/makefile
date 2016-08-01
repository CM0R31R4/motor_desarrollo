DEP = ProcesaColasMotor.o
#INCL = -I../include/ -I/usr/include/openssl
INCL = -I../include/ -I/usr/include/openssl/ -I/usr/include/postgresql/ -I/usr/include/freetds/
#LIBS = -L/usr/lib/ -L../comun/ -L. -L/home/iswitch/fuentes/fuentes2/ProcesaColasMotor -lpq -lIsys -lpthread -lssl_log -lcrypto
#LIBS = -L/usr/lib/ -L../comun/ -L. -L/home/iswitch/fuentes/fuentes2/ProcesaColasMotor -lpq -lIsys -lpthread -lssl3 -lcrypto
LIBS = -L../comun/ -L. -L/home/iswitch/fuentes/fuentes2/ProcesaColasMotor -lIsys -lpthread -lssl3 -L/usr/pgsql-9.2/lib/ -lpq


#PAra IsysSSL
#CC  = gcc -g -D_ISYS_SSL_ -D_REENTRANT
#CC  = gcc -g 


#PAra ProcesaColasMotor
CC  = gcc -g -fpic -D_REENTRANT -D_LIBC_REENTRANT -m64 -fsched2-use-traces -funroll-loops -minline-all-stringops -DFLAG_POSTGRES
#CC  = gcc -g -m64 -fpic

#LIBS = -L../comun/ -L/usr/local/ssl/lib/ -lIsys -lpthread -ldl rsaeuro.lib -lpq -lssl -lcrypto
#LIBS = -L../comun/ -lIsys -lpthread -ldl rsaeuro_64.lib -lssl -lcrypto 
LIBS = -L../comun/ -lIsys -lpthread -ldl -L /usr/lib/ -lpq

all:    $(DEP)
	$(CC) $(INCL) $(DEP) $(LIBS) -o Procesa_ColasMotor

ProcesaColasMotor.o:       ProcesaColasMotor.c
	$(CC) -c  ProcesaColasMotor.c $(INCL)

clean:
	rm -f *.o


