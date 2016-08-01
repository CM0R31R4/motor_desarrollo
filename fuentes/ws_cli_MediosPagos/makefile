#Makefile del WsGateway de Iswitch...Servidor Generico Servicios Web

FUENTES=/home/switch/fuentes/fuentes2
SOAP=$(FUENTES)/gsoap/gsoap
SOAP_BIN=$(FUENTES)/gsoap/gsoap/bin/linux386/

GSOAP=$(SOAP_BIN)/soapcpp2
SOAPH=$(SOAP)/stdsoap2.h
SOAPC=$(SOAP)/stdsoap2.c
SOAPCPP=$(SOAP)/stdsoap2.cpp
CC=gcc
CPP=g++
LIBS=-lpthread -lIsys rsaeuro.lib -lssl -ldl -D_REENTRANT -D_LIBC_REENTRANT
COFLAGS=-O2
CWFLAGS=-Wall
#Con -L=librerias. Con -I=incluye
CIFLAGS=-I$(SOAP) -I$(FUENTES)/include -L $(FUENTES)/comun -L $(FUENTES)/IsysSSL/openssl-0.9.8b -I$(FUENTES)/IsysSSL/openssl-0.9.8b/include/
CMFLAGS=
CFLAGS= $(CWFLAGS) $(COFLAGS) $(CIFLAGS) $(CMFLAGS)
all:		ServiciosSodexo 
ServiciosSodexo:	ServiciosSodexo.h ServiciosSodexo.c $(SOAPH) $(SOAPC)
		$(GSOAP) -c ServiciosSodexo.h
		$(CC) $(CFLAGS)  -DDEBUG -o ServiciosSodexo ServiciosSodexo.c soapC.c soapServer.c $(SOAPC) -lm $(LIBS)
clean:
		rm -f *.o soapH.h soapStub.h soapC.cpp soapC.c soapClient.cpp soapClient.c soapServer.cpp soapServer.c soap*Proxy.h
distclean:
		rm -f *.o *.wsdl *.xsd *.xml *.nsmap *.log soapH.h soapStub.h soapC.cpp soapC.c soapClient.cpp soapClient.c soapServer.cpp soapServer.c soap*Proxy.h cliente ServiciosSodexo

copia:
	#cp *.wsdl /wsdl/
