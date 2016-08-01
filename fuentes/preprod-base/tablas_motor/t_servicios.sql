drop table servicios;
CREATE TABLE servicios (
    tx          integer,
    ip          character varying(55),
    port        integer,
    descripcion character varying(100),
    tag_pagina  character varying(50),
    tag_imagen  character varying(50),
    url         character varying(200),
    timeout     integer,
    tipo_respuesta              integer,
    largo_minimo_respuesta      integer,
    llave_query                 integer,
    timeout_rafaga              integer,
    patron_final        character varying(100),
    tipo_conexion       character varying(20),
    usa_dos_ip  character varying(20),
    ip1         character varying(25),
    port1       integer,
    ssl         character varying(10),
    lista_ip    character varying(500)
);
CREATE INDEX servicios_01 ON servicios USING btree (tx);

/*Request Bono3/Wsdl-Xsd*/
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (3002,'127.0.0.1','8980','QA.Bono3 Motor/Nginx',12,3003,'WSIMedBono');

/*Multi-API Oracle Isapres Bono3. Servicio con Patron Final*/
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,patron_final) values (8100,'Define __IP_CONEXION_CLIENTE__','0','Servicio MultiAPI Oracle',11,4,'**fin**');

--Consume Ws_Fonasa. Directo a Sonda, por la IP Interna
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'10.100.32.129',80,'CAP.Fonasa_WS',10,4,80,'</soap:Envelope>');
--insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'10.100.32.56',80,'PROD.Fonasa_WS',10,4,80,'</soap:Envelope>');
--Consume Ws_Fonasa por el HA local
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta,largo_minimo_respuesta,patron_final) values (9000,'127.0.0.1',8200,'WinPhp QA-Fonasa',10,4,80,'</soap:Envelope>');

--Request CiasSeg Bono2/Bono3
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4000,'127.0.0.1','4000','Confirmacion Cias Seguro',5,4000,'Confirmacion');
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4001,'127.0.0.1','4001','Certificacion Cias Seguro',10,4001,'Certificacion');

--Servicios Consumen los Ws de CiasSeg Tag=__IP_CONEXION_CLIENTE__
--Confirmaciones
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta) values (4010,'Viene en __IP_CONEXION_CLIENTE__','0','Cias de Seguro',30,6);
--Cetificaciones
insert into servicios (tx,ip,port,descripcion,timeout,tipo_respuesta) values (4011,'Viene en __IP_CONEXION_CLIENTE__','0','Cias de Seguro',9,6);

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
--Cofirmacion Cias Bono3
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4008,'127.0.0.1','4000','Confirmacion Cias Seguro Bono3',5,4000,'ConfirmacionBono3');
--Anulacion Cias Bono3
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4009,'127.0.0.1','4001','Anulacion Bono3 Cias Seguro',10,4000,'AnulacionBono3');

--Confirmacion Cias Bonos Externos (Bono Papel)
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4013,'127.0.0.1','4000','Confirmacion CiaSeg BonoExt',5,4000,'ConfirmacionBonoExt');
--Anulacion Cias Bonos Externos (Bono Papel)
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4014,'127.0.0.1','4001','Anulacion CiaSeg BonoExt',10,4000,'AnulacionBonoExt');

--Monitor Financiadores
insert into servicios (tx,ip,port,descripcion,timeout,llave_query,url) values (4012,'127.0.0.1','4000','Monitor Financiadores',10,4012,'financiadores');

