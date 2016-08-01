DEP = get_campo_c.o
CC  = gcc -g -D_REENTRANT -D_LIBC_REENTRANT
INCL = -I../include/ -I/usr/include/postgresql/9.2/server/ -I/usr/include/postgresql/

LIBS = -L../comun/ -lIsys -m64 -ldl -lpq

get_campo_c.o:   get_campo_c.c
	$(CC) -fpic -c get_campo_c.c $(INCL)
	$(CC) $(INCL) $(LIBS) -shared -o get_campo_c.so get_campo_c.o

clean:
	rm -f *.o


