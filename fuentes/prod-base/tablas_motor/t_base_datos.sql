--DROP TABLE base_datos;

CREATE TABLE base_datos (
    base 	integer,
    ip 		character varying(20),
    port 	integer,
    descripcion character varying(20),
    proyecto 	character varying(20),
    tipo_db 	character varying(20)
);


/*BNO*/
INSERT INTO base_datos VALUES (1,  '127.0.0.1', 9000,  NULL,		NULL,	'POSTGRES');
INSERT INTO base_datos VALUES (2,  '127.0.0.1', 8201, 'FONASA',		'BNO',	'POSTGRES');
INSERT INTO base_datos VALUES (11, '127.0.0.1', 8211, 'SM_CCHC',	'BNO',	'MSQL');
INSERT INTO base_datos VALUES (44, '127.0.0.1', 8244, 'VIDA_CAMARA',	'BNO',	'MSQL');
INSERT INTO base_datos VALUES (62, '127.0.0.1', 8262, 'SAN_LORENZO',	'BNO',	'ORACLE');
INSERT INTO base_datos VALUES (63, '127.0.0.1', 8263, 'FUSAT',		'BNO',	'ORACLE');
INSERT INTO base_datos VALUES (65, '127.0.0.1', 8265, 'CHUQUICAMATA',	'BNO',	'ORACLE');
INSERT INTO base_datos VALUES (67, '127.0.0.1', 8267, 'COLMENA',	'BNO',	'SYBASE');
INSERT INTO base_datos VALUES (68, '127.0.0.1', 8268, 'RIO_BLANCO',	'BNO',	'ORACLE');
INSERT INTO base_datos VALUES (71, '127.0.0.1', 8271, 'CONSALUD',	'BNO',	'ORACLE');
INSERT INTO base_datos VALUES (76, '127.0.0.1', 8276, 'FUNDACION',	'BNO',	'ORACLE');
INSERT INTO base_datos VALUES (78, '127.0.0.1', 8278, 'CRUZ_BLANCA',	'BNO',	'SYBASE');
INSERT INTO base_datos VALUES (80, '127.0.0.1', 8277, 'VIDA_TRES',	'BNO',	'ORACLE');
INSERT INTO base_datos VALUES (81, '127.0.0.1', 8281, 'FERROSALUD',	'BNO',	'MSQL');  ---Choca con el port del LSTR
INSERT INTO base_datos VALUES (88, '127.0.0.1', 8288, 'MAS_VIDA',	'BNO',	'MSQL');
INSERT INTO base_datos VALUES (94, '127.0.0.1', 8294, 'CRUZ_DEL_NORTE',	'BNO',	'ORACLE');
INSERT INTO base_datos VALUES (99, '127.0.0.1', 8299, 'BANMEDICA',	'BNO',	'ORACLE');

/*CME*/
INSERT INTO base_datos VALUES (188, '127.0.0.1', 8788, 'MAS_VIDA_CME',	'CME',	'MSQL');

/*Sybase de Imed*/
INSERT INTO base_datos VALUES (4100, '127.0.0.1', 4100, 'SYBASE_IMED',	'CIA',	'SYBASE');
INSERT INTO base_datos VALUES (5000, '127.0.0.1', 5000, 'SYBASE_IMED_CERT',	'CIA',	'SYBASE');

/*Percona*/
INSERT INTO base_datos VALUES (10001,'127.0.0.1','10001','MYSQL_PERCONA','BD','MYSQL');


CREATE INDEX base_datos_01 ON base_datos USING btree (base);

--
-- PostgreSQL database dump complete
--
