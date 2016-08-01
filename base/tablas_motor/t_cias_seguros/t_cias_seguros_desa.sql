drop table cias_seguros;

create table cias_seguros (
	codigo				integer,
	nombre 				varchar,
	nemo				varchar(20), --Max largo del prefijo del motor
	tx					varchar,
	url 				varchar,
	funcion_respuesta	varchar,
	funcion_input		varchar,
	mail_cia			varchar default 'cmoreira@i-med.cl'
);

create index cias_seguros_01 on cias_seguros(codigo);
create index cias_seguros_02 on cias_seguros(nemo);

/*DROP RULE r_cias_seguros ON cias_seguros;
CREATE RULE r_cias_seguros AS ON INSERT TO cias_seguros 
WHERE NEW.tx in ('Conciliacion','Certificacion')
DO INSERT INTO cias_seguros VALUES (NEW.codigo, NEW.nombre, NEW.nemo, NEW.tx, NEW.url, NEW.funcion_respuesta, NEW.funcion_input, '')
;*/