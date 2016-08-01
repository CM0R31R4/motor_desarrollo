drop table servicios;
CREATE TABLE servicios (
    tx 		integer,
    ip 		character varying(55),
    port 	integer,
    descripcion character varying(100),
    tag_pagina 	character varying(50),
    tag_imagen 	character varying(50),
    url 	character varying(200),
    timeout 	integer,
    tipo_respuesta		integer,
    largo_minimo_respuesta	integer,
    llave_query 		integer,
    timeout_rafaga 		integer,
    patron_final 	character varying(100),
    tipo_conexion 	character varying(20),
    usa_dos_ip 	character varying(20),
    ip1		character varying(25),
    port1 	integer,
    ssl 	character varying(10),
    lista_ip 	character varying(500)
);
CREATE INDEX servicios_01 ON servicios USING btree (tx);


/*Flujo Traductor Ws Bono3 y Cuenta Medica*/
--insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8081,'127.0.0.1','8010','Traductor WS',190,8081);	--190 segundos
--insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (3000,'127.0.0.1','8980','Traductor WS Test',10,3000);

/*Flujo WSDL Por PXML*/
--insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (3001,'127.0.0.1','8980','WSDL',10,3001);

/*De Nginx a Flujo 3003.Procesa Bono3: Request Xml, Request file Wsdl-Xsd*/
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (3002,'127.0.0.1','8980','PROD.Bono3 Motor/Nginx',12,3003,'WSIMedBono');

/*Flujo Traductor WsAutentia*/
--insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (3010,'127.0.0.1','8980','Traductor WsAutentia',10,3010);

--BONO3 WSDl-XSD FILES
/*
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9101,'127.0.0.1','8101','Fonasa.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9111,'127.0.0.1','8111','Cchc.Wsdl'		,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9144,'127.0.0.1','8144','VidaCamara.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9162,'127.0.0.1','8162','SanLorenzo.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9163,'127.0.0.1','8163','Fusat.Wsdl'		,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9165,'127.0.0.1','8165','Chuquicamata.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9167,'127.0.0.1','8167','Colmena.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9168,'127.0.0.1','8168','RioBlanco.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9171,'127.0.0.1','8171','Consalud.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9176,'127.0.0.1','8176','Fundacion.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9178,'127.0.0.1','8178','CruzBlanca.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9180,'127.0.0.1','8180','Vidatres.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9181,'127.0.0.1','8181','Ferrosalud.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9188,'127.0.0.1','8188','MasVida.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9194,'127.0.0.1','8194','CruzdelNorte.Wsdl'	,17,3001);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9199,'127.0.0.1','8199','Banmedica.Wsdl'	,17,3001);
*/

--BONO3 PXML
/*
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8101,'127.0.0.1','8101','Fonasa.bno'		,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8111,'127.0.0.1','8111','Cchc.bno'		,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8144,'127.0.0.1','8144','VidaCamara.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8162,'127.0.0.1','8162','SanLorenzo.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8163,'127.0.0.1','8163','Fusat.bno'		,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8165,'127.0.0.1','8165','Chuquicamata.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8167,'127.0.0.1','8167','Colmena.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8168,'127.0.0.1','8168','RioBlanco.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8171,'127.0.0.1','8171','Consalud.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8176,'127.0.0.1','8176','Fundacion.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8178,'127.0.0.1','8178','CruzBlanca.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8180,'127.0.0.1','8180','Vidatres.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8181,'127.0.0.1','8181','Ferrosalud.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8188,'127.0.0.1','8188','MasVida.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8194,'127.0.0.1','8194','CruzdelNorte.bno'	,17,3000);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8199,'127.0.0.1','8199','Banmedica.bno'	,17,3000);
*/

--CME PXML
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (8688,'127.0.0.1','8688','MasVida.cme',10,3005);
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (9688,'127.0.0.1','8688','MasVida.Wsdl',10,3005);

/*Clientes Python(API), para Bases Oracle*/
/*
insert into servicios (tx,ip,port,descripcion,timeout) values (8062,'127.0.0.1','8062','Oracle San Lorenzo',15);
insert into servicios (tx,ip,port,descripcion,timeout) values (8063,'127.0.0.1','8063','Oracle Fusat',15);
insert into servicios (tx,ip,port,descripcion,timeout) values (8065,'127.0.0.1','8065','Oracle Chuquicamata',15);
insert into servicios (tx,ip,port,descripcion,timeout) values (8068,'127.0.0.1','8068','Oracle Rio Blanco',15);
insert into servicios (tx,ip,port,descripcion,timeout) values (8071,'127.0.0.1','8071','Oracle Consalud',15);
insert into servicios (tx,ip,port,descripcion,timeout) values (8076,'127.0.0.1','8076','Oracle Fundacion',15);
insert into servicios (tx,ip,port,descripcion,timeout) values (8077,'127.0.0.1','8077','Oracle Vida Tres',15);
insert into servicios (tx,ip,port,descripcion,timeout) values (8094,'127.0.0.1','8094','Oracle Cruz del Norte',15);
insert into servicios (tx,ip,port,descripcion,timeout) values (8099,'127.0.0.1','8099','Oracle Banmedica',15);
*/

/*MultiAPI Oracle. Servicio con Patron Final*/
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,patron_final) values (8100,'Define __IP_CONEXION_CLIENTE__','0','Servicio MultiAPI Oracle',11,4,'**fin**');

--Consume Ws_Fonasa. Directo a Sonda, por la IP Interna
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'10.100.32.129',80,'CAP.Fonasa_WS',10,4,80,'</soap:Envelope>');
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'10.100.32.56',80,'PROD.Fonasa_WS',10,4,80,'</soap:Envelope>');
--Consume Ws_Fonasa por el HA local
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'127.0.0.1',8200,'PROD.Fonasa_WS',10,4,80,'</soap:Envelope>');
--Consume Ws_Fonasa. NAT a Sonda, por la IP Publica
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'200.0.156.221',80,'Publica Fonasa_WS',10,4,80,'</soap:Envelope>');

/*MULTICAJA Servicios*/
--[Desa] Por Internet a MC 200.111.44.187 10004
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9001,'200.111.44.187',10004,'Desa_Multicaja_WS',10,4,80,'</SOAP-ENV:Envelope>');
--[Desa] Por Internet a MC 146.82.89.139 10004

--[Prod] Por Interna a MC 10.151.224.23 10000
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9001,'10.151.224.23',10000,'Prod_Multicaja_WS',10,4,80,'</SOAP-ENV:Envelope>');

--Servicio para Confirmacion de Companias de seguro
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4000,'127.0.0.1','4000','Confirmacion Cias Seguro',5,4000,'Confirmacion');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4001,'127.0.0.1','4001','Certificacion Cias Seguro',10,4001,'Certificacion');
--Status de las cias
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4002,'127.0.0.1','4000','Certificacion Cias Seguro',10,4002,'status_cias');
--Proxy para WinPhp1 Test
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4003,'127.0.0.1','4001','Proxy',30,4003,'proxy');
--Anulacion de Cias
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4004,'127.0.0.1','4001','Anulacion Cias Seguro',10,4000,'Anulacion');
--Conciliacion de Cias
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4005,'127.0.0.1','4001','Conciliacion Cias Seguro',10,4001,'Conciliacion');
--Datos de Cias
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4006,'127.0.0.1','4000','Datos Cias Seguro',10,4006,'url_cias');
--Monitor
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4007,'127.0.0.1','4000','Monitor Cias Seguro',10,4007,'monitor');
--Confirmacion Cias Bono3 
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4008,'127.0.0.1','4000','Confirmacion Cias Seguro Bono3',5,4000,'ConfirmacionBono3');
--Anulacion Cias Bono3
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4009,'127.0.0.1','4001','Anulacion Bono3 Cias Seguro',10,4000,'AnulacionBono3');

--Servicio que llama a las cias de seguros por __IP_CONEXION_CLIENTE__
--Solo para la Confirmacion
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta) values (4010,'Viene en __IP_CONEXION_CLIENTE__','0','Cias de Seguro',30,6);
--Para las Certificaciones/Anulaciones
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta) values (4011,'Viene en __IP_CONEXION_CLIENTE__','0','Cias de Seguro',9,6);
--Monitor Financiadores
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4012,'127.0.0.1','4000','Monitor Financiadores',10,4012,'financiadores');

--Confirmacion Cias Bonos Externos (Bono Papel)
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4013,'127.0.0.1','4000','Confirmacion CiaSeg BonoExt',5,4000,'ConfirmacionBonoExt');
--Anulacion Cias Bonos Externos (Bono Papel)
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4014,'127.0.0.1','4001','Anulacion CiaSeg BonoExt',10,4000,'AnulacionBonoExt');

--Test
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4055,'127.0.0.1','4000','Test',10,4055,'test');
