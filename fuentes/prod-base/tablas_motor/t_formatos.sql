drop table formatos;
create table formatos (
formato		integer,
campo		varchar(50),
TIPO_CAMPO	varchar(50),
CARACTER	integer,
largo		integer,
secuencia	integer,
IDENTACION	varchar(50),
CARACTER_LLENADO	varchar(50),
TEXTO		varchar(50),
tipo		varchar(50),
funcion		varchar(50));

create index formatos_01 on formatos(formato);

insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (100,'INPUT','CAMPO',-1,10);
--insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (101,'RESPUESTA','CAMPO',-1,10);
insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia,funcion) values  (101,'RESPUESTA','CAMPO',-1,10,'HEX2ASC');

insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (110,'SQLINPUT','CAMPO',-1,10);
insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (111,'SQLOUTPUT','CAMPO',-1,10);
insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia,funcion) values  (112,'SQLOUTPUT','CAMPO',-1,10,'ASC2HEX');
--insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (111,'SQLOUTPUT','CAMPO',8096,10);

insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (200,'RQT_XML','CAMPO',-1,10);
--insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (201,'RSP_XML','CAMPO',8096,10);
insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (201,'RSP_XML','CAMPO',-1,10);	

insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia,funcion) values  (4000,'INPUT_CIA','CAMPO',-1,10,'HEX2ASC');
--insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (201,'RSP_XML','CAMPO',8096,10);
insert into formatos (formato,campo,TIPO_CAMPO,largo,secuencia) values  (4001,'RESPUESTA_CIA','CAMPO',-1,10);	
