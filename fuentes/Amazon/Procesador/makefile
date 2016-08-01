DEP = IsysProcesaXml.o 
CC  = gcc -g -D_REENTRANT -D_LIBC_REENTRANT 
INCL = -I../include/ -I/usr/include/openssl/ -I/usr/include/postgresql/
#LIBS = -L/usr/local/pgsql/lib/ -L../comun/ -lpq -lIsys -lpthread
#LIBS =  -L../comun/ -lpq -lIsys -lpthread -lssl 

#Con posstgres para interfaz Web
#LIBS =  -L../comun/ -lIsys -lpthread rsaeuro_64.lib -lpq -m64

#Sin postgres para ProcesadorXML
LIBS =  -L../comun/ -lIsys -lpthread rsaeuro_64.lib   -m64 -ldl

all:	$(DEP)	
	$(CC) $(INCL) $(DEP) $(LIBS) -o TestProcesaXml

IsysProcesaXml.o:	IsysProcesaXml.c
	$(CC) -c  IsysProcesaXml.c $(INCL) 

clean:
	rm -f *.o

