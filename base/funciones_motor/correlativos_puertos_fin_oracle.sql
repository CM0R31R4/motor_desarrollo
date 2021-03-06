/*CREATE SEQUENCE correlativo_ctamed
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;*/
--SELECT pg_catalog.setval('correlativo_ctamed', 1, true);

/*
	COMPOSICION DE PUERTOS: FORMATO XXXX. 
	Donde: char 1-2 = Id del Puerto
	Donde: char 3-4 = Id del Financiador
*/

--CREATE SEQUENCE seq_puerto_sanlorenzo	START WITH 8310 MINVALUE 8310 MAXVALUE 8319 INCREMENT by 1 CYCLE;
--CREATE SEQUENCE seq_puerto_chuquicamata 	START WITH 8330 MINVALUE 8330 MAXVALUE 8339 INCREMENT by 1 CYCLE;
--CREATE SEQUENCE seq_puerto_rioblanco 	START WITH 8340 MINVALUE 8340 MAXVALUE 8349 INCREMENT by 1 CYCLE;
--CREATE SEQUENCE seq_puerto_vidatres 	START WITH 8370 MINVALUE 8370 MAXVALUE 8379 INCREMENT by 1 CYCLE;

/*5 Puertos para cada Oracle*/
DROP SEQUENCE seq_puerto_fusat          CASCADE;
DROP SEQUENCE seq_puerto_consalud       CASCADE;
DROP SEQUENCE seq_puerto_fundacion      CASCADE;
DROP SEQUENCE seq_puerto_cruzdelnorte   CASCADE;
DROP SEQUENCE seq_puerto_banmedica      CASCADE;

CREATE SEQUENCE seq_puerto_fusat 	START WITH 8320 MINVALUE 8320 MAXVALUE 8321 INCREMENT by 1 CYCLE;
CREATE SEQUENCE seq_puerto_consalud 	START WITH 8350 MINVALUE 8350 MAXVALUE 8351 INCREMENT by 1 CYCLE;
CREATE SEQUENCE seq_puerto_fundacion	START WITH 8360 MINVALUE 8360 MAXVALUE 8361 INCREMENT by 1 CYCLE;
CREATE SEQUENCE seq_puerto_cruzdelnorte	START WITH 8380 MINVALUE 8380 MAXVALUE 8381 INCREMENT by 1 CYCLE;
CREATE SEQUENCE seq_puerto_banmedica 	START WITH 8390 MINVALUE 8390 MAXVALUE 8391 INCREMENT by 1 CYCLE;

--SELECT nextval('seq_puerto_banmedica');
--SELECT nextval('seq_puerto_sanlorenzo');

--ALTER SEQUENCE seq_puerto_banmedica MINVALUE 8390 MAXVALUE 8391 INCREMENT by 1 CYCLE;
--ALTER SEQUENCE seq_puerto_consalud START WITH 8350 MINVALUE 8350;

/*
DROP SEQUENCE seq_puerto_sanlorenzo 	CASCADE; 
DROP SEQUENCE seq_puerto_fusat 		CASCADE;
DROP SEQUENCE seq_puerto_chuquicamata 	CASCADE;
DROP SEQUENCE seq_puerto_rioblanco 	CASCADE;
DROP SEQUENCE seq_puerto_consalud 	CASCADE;
DROP SEQUENCE seq_puerto_fundacion 	CASCADE;
DROP SEQUENCE seq_puerto_vidatres 	CASCADE;
DROP SEQUENCE seq_puerto_cruzdelnorte 	CASCADE;
DROP SEQUENCE seq_puerto_banmedica 	CASCADE;
*/
