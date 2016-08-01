DEP = enc_hex.o
CC  = gcc -g -D_REENTRANT -D_LIBC_REENTRANT
INCL = -I../include/ -I/usr/include/postgresql/9.2/server/ -I/usr/include/postgresql/

LIBS = -L../comun/ -lIsys -m64 -ldl -lpq

enc_hex.o:   enc_hex.c
	$(CC) -fpic -c enc_hex.c $(INCL)
	$(CC) $(INCL) $(LIBS) -shared -o enc_hex.so enc_hex.o


dec_hex.o:   dec_hex.c
	$(CC) -fpic -c dec_hex.c $(INCL)
	$(CC) $(INCL) $(LIBS) -shared -o dec_hex.so dec_hex.o


enc_64.o:   enc_64.c
	$(CC) -fpic -c enc_64.c $(INCL)
	$(CC) $(INCL) $(LIBS) -shared -o enc_64.so enc_64.o


dec_64.o:   dec_64.c
	$(CC) -fpic -c dec_64.c $(INCL)
	$(CC) $(INCL) $(LIBS) -shared -o dec_64.so dec_64.o


enc_hex_64.o:   enc_hex_64.c
	$(CC) -fpic -c enc_hex_64.c $(INCL)
	$(CC) $(INCL) $(LIBS) -shared -o enc_hex_64.so enc_hex_64.o


clean:
	rm -f *.o
