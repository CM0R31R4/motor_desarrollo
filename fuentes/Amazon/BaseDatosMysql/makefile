DEP = BaseDatosMysql.o
CC  = gcc -g -D_REENTRANT -D_LIBC_REENTRANT  -D_THREAD_SAFE -D_POSIX_PTHREAD_SEMANTICS -DFLAG_MYSQL
#INCL = -I../include/ -I/usr/local/ssl/include/
INCL = -I../include/ -I/usr/include/mysql/ -L/usr/lib64/mysql -lmysqlclient_r -lz -lcrypt -lnsl -lm -L/usr/lib64 -lssl -lcrypto
LIBS =  -L../comun/ -lIsys -lpthread -lcrypt -lssl rsaeuro_64.lib -lpq
#LIBS =  -L../comun/ -lIsys -lpthread -lcrypt -lssl rsaeuro_64.lib /home/switch/postgresql-8.4.2/src/interfaces/libpq/libpq.a
#LIBS =  -L../comun/ -lIsys -lpthread rsaeuro_64.lib /home/switch/postgresql-8.4.2/src/interfaces/libpq/libpq.a
#LIBS =  -L../comun/ -lIsys -lpthread /home/iswitch/postgresql-8.2.1/src/interfaces/libpq/libpq.a

all:	$(DEP)	
	$(CC) $(INCL) $(DEP) $(LIBS) -o BaseMysql

BaseDatosMysql.o:	BaseDatosMysql.c
	$(CC) -c  BaseDatosMysql.c $(INCL) 

clean:
	rm -f *.o
