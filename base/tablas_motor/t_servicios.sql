drop table servicios;
CREATE TABLE servicios (
    tx 				integer,
    ip 				character varying(55),
    port 			integer,
    descripcion 		character varying(100),
    tag_pagina 			character varying(50),
    tag_imagen 			character varying(50),
    url 			character varying(200),
    timeout 			integer,
    tipo_respuesta		integer,
    largo_minimo_respuesta	integer,
    llave_query 		integer,
    timeout_rafaga 		integer,
    patron_final 		character varying(100),
    tipo_conexion 		character varying(20),
    usa_dos_ip 			character varying(20),
    ip1				character varying(25),
    port1 			integer,
    ssl 			character varying(10),
    lista_ip 			character varying(500)
);

CREATE INDEX servicios_01 ON servicios USING btree (tx);

--DEC_XML
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (1000,'172.16.10.111',80,'CAP.DEC_WS',10,4,80,'</SOAP-ENV:Envelope>');

/*RME Con Nginex*/
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (5000,'127.0.0.1','5000','RME FLujo Inicial',10,5000,'WsRecetaImed');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (5001,'127.0.0.1','5000','RME2 FLujo Inicial',10,5001,'Ws2RecetaImed');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (5003,'127.0.0.1','5000','RME DEC',10,5003,'WsRmeDec'); 

/*Liquidador Con Nginx*/
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (6000,'127.0.0.1','6000','Servicios Farmacia',10,6000,'WsLiquidador');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (6001,'127.0.0.1','6000','Carga Beneficiarios',10,6001,'WsBeneficiarios');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (6002,'127.0.0.1','6000','Servicio Certificacion',10,6002,'WsCertificacion');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (6003,'127.0.0.1','6000','Servicio Confirmacion',10,6003,'WsConfirmacion');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (6004,'127.0.0.1','6000','Servicio Anulacion',10,6004,'WsAnulacion');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (6005,'127.0.0.1','6000','Servicio Conciliacion',10,6005,'WsConciliacion');

/*Consume Servicio Web, WsCSDCerBenSeg para cargar el Rut del Beneficiario y activarlo en la Cia que corresponda*/
--http://10.100.32.129/actben/WSCSCerBenSeg.asmx
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (6100,'10.100.32.129',80,'CAP.WsCSDCerBenSeg',10,4,80,6);
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta) values (6100,'Viene en __IP_CONEXION_CLIENTE__','0','Cias de Seguro',9,6);

/*De Nginx a Flujo 3003.Procesa Bono3: Request Xml, Request file Wsdl-Xsd*/
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (3002,'127.0.0.1','8980','DEV.Bono3 Motor/Nginx',12,3003,'WSIMedBono');

/*CME Con Nginex Desa*/
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (3005,'127.0.0.1','8688','Cme.Nginx Desa',17,3005,'WSIMedCtaMedica');
--insert into servicios (tx,descripcion,timeout,llave_query,url) values (3005,'DEV.CME Motor/Nginx',10,3005,'WSIMedCtaMedica');

/*Flujo Traductor WsAutentia*/
insert into servicios (tx,ip,port,descripcion,timeout,llave_query) values (3010,'127.0.0.1','7010','Traductor WsAutentia',10,3010);

/*Flujo Monitor Financiadores*/
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (3020,'127.0.0.1','7020','Monitor Financiadores',10,3020,'WsMonitor'); 
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta) values (3021,'View en __IP_CONEXION_CLIENTE__',0,'Conexion Apache Generico',10,6);

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
-- IP Antigua.
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'10.100.32.129',80,'CAP.Fonasa_WS',10,4,80,'</soap:Envelope>');
-- Dummy.
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9001,'10.100.32.214',7001,'Dummy_WebLogic',10,6,80,'</soap:Envelope>');
-- IP Nueva.
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9001,'10.152.126.17',7001,'FONASA_WebLogic',10,6,80,'</soap:Envelope>');

--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'10.100.32.56',80,'PROD.Fonasa_WS',10,4,80,'</soap:Envelope>');
--Consume Ws_Fonasa. NAT a Sonda, por la IP Publica
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'200.0.156.221',80,'Publica Fonasa_WS',10,4,80,'</soap:Envelope>');


/*MULTICAJA Servicios*/
--[Desa] Por Internet a MC 200.111.44.187 10005
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9001,'200.111.44.187','10005','Desa_Multicaja_WS',10,4,80,'</S:Envelope>');
-- El dia 08-10-2015 se cambia el puerto a 8080. [CM].
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9001,'200.111.44.187','8080','Desa_Multicaja_WS',10,4,80,'</S:Envelope>');
-- El día 28-12-2015 se cambia el puerto a 8181. [CM].
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9001,'200.111.44.187','8181','MultiCaja_WS',10,6,80,'</S:Envelope>');

-- *** INICIO CONFIGURACION SERVICIO MULTICAJA ***
-- Servicio que RECIBE XML de MultiCaja
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (9050,'127.0.0.1','80','Multi Caja',10,9050,'WsMultiCaja');

-- Configuracion de servicio MultiCaja apuntando al puerto 8080. El puerto 8181 no funciona a traves de Motor.
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9051,'200.111.44.187','8080','MultiCaja_WS',10,6,80,'</S:Envelope>');
-- *** FIN CONFIGURACION SERVICIO MULTICAJA ***

-- *** INICIO CONFIGURACION SERVICIO LOGS DE MOTOR ***
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (9060,'127.0.0.1','80','Consulta Logs Motor',10,9060,'WsLogsMotor');
-- *** FIN CONFIGURACION SERVICIO LOGS DE MOTOR ***

--[Prod] Por Interna a MC 10.151.224.23 10000
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9001,'10.151.224.23',10000,'Prod_Multicaja_WS',10,4,80,'</SOAP-ENV:Envelope>');

--Servicio Externos de CiasSeguros
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4000,'127.0.0.1','4000','Confirmacion CiaSeg',5,4000,'Confirmacion');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4001,'127.0.0.1','4001','Certificacion CiaSeg',10,4001,'Certificacion');
--Status de las cias
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4002,'127.0.0.1','4000','Certificacion CiaSeg',10,4002,'status_cias');
--Proxy para WinPhp1 Test
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4003,'127.0.0.1','4001','Proxy',30,4003,'proxy');
--Anulacion de Cias
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4004,'127.0.0.1','4001','Anulacion CiaSeg',10,4000,'Anulacion');
--Conciliacion de Cias
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4005,'127.0.0.1','4001','Conciliacion CiaSeg',10,4001,'Conciliacion');
--Datos de Cias
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4006,'127.0.0.1','4000','Datos CiaSeg',10,4006,'url_cias');
--Monitor
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4007,'127.0.0.1','4000','Monitor CiaSeg',10,4007,'monitor');
--Confirmacion Cias Bono3 
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4008,'127.0.0.1','4000','Confirmacion CiaSeg Bono3',5,4000,'ConfirmacionBono3');
--Anulacion Cias Bono3
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4009,'127.0.0.1','4001','Anulacion Bono3 CiaSeg',10,4000,'AnulacionBono3');
--Confirmacion Cias Bonos Externos (Bono Papel)
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4013,'127.0.0.1','4000','Confirmacion CiaSeg BonoExt',5,4000,'ConfirmacionBonoExt');
--Anulacion Cias Bonos Externos (Bono Papel)
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4014,'127.0.0.1','4001','Anulacion CiaSeg BonoExt',10,4000,'AnulacionBonoExt');
--Bonos Externos con Bonificacion de CiasSeguros
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4015,'127.0.0.1','4001','Bono Externo CiaSeg',10,4001,'BonoExt');

--Servicio que llama a las cias de seguros por __IP_CONEXION_CLIENTE__
--Solo Confirmacion
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta) values (4010,'Viene en __IP_CONEXION_CLIENTE__','0','Cias de Seguro',30,6);
--Para Certificaciones
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta) values (4011,'Viene en __IP_CONEXION_CLIENTE__','0','Cias de Seguro',9,6);
--Monitor Financiadores
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4012,'127.0.0.1','4000','Monitor Financiadores',10,4012,'financiadores');


-- *** INICIO CONFIGURACION SERVICIO DEC ***
/* Servicio que recibe XML de Bono a DEC */
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (7000,'127.0.0.1','7000','Servicio Graba XML de Bono',10,7000,'WsGrabaBonoDEC');

-- Original
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (7001,'10.100.32.179',80,'BonoDec',10,4,80,'</SOAP-ENV:Envelope>');
-- Se modifica para formato HTML.
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (7001,'10.100.32.179',80,'BonoDec',30,6,80,'</SOAP-ENV:Envelope>');
-- Prueba apuntando a un puerto local de NC.
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (7001,'10.100.32.177',6000,'BonoDec',30,6,80,'</SOAP-ENV:Envelope>');

-- *** FIN CONFIGURACION SERVICIO DEC ***
