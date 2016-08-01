--DROP table tx_ctamed cascade;
CREATE table tx_ctamed (
	cod_fin 	integer,	--88,99
        financiador     varchar(50),	--MASVIDA  
	tipo_tx		varchar(20),
	
	codigo_motor	bigint,	--Correlativo del codigo_motor
	cod_ctamed	bigint,	--Correlativo del codigo Cta Medica 
	num_cta		bigint,	--Numero de Cta Medica
	
	rut_benef	varchar(12),
	fecha_in_tx	timestamp,	--Fecha In del Core_8081 
	fecha_out_tx	timestamp,	--Fecha Out del Core_8081
	fecha_in_fin	timestamp,	--Fecha In Financiador (Va en los sp de c/financiador) 
	fecha_out_fin	timestamp,	--Fecha Out Financiador (Va en los sp de c/financiador)

        estado		varchar(20),	--EN_PROCESO,TERMINADO_OK, RECHAZADO, FALLA_TX
        codigo_resp     varchar(1),	--1=Aprobada - 2=Rechazada 
        mensaje_resp	varchar(50),	--Trasaccion OK
	mensaje_fin	varchar(50),
	xml_input       varchar,        --Xml entrante al Listener
        xml_output      varchar,        --Xml saliente del Listener
	sp_exec         varchar,        --SP a ejecutar en base datos del financiador
        sp_return       varchar         --Respuesta del SP ejecutado

);

CREATE index tx_ctamed_01 on tx_ctamed (codigo_motor);
CREATE index tx_ctamed_02 on tx_ctamed (fecha_in_tx);
CREATE index tx_ctamed_03 on tx_ctamed (cod_ctamed);

--SELECT cod_fin,financiador,tipo_tx,codigo_motor,cod_ctamed,fecha_in_tx,estado,codigo_resp as c_resp,mensaje_resp,mensaje_fin from tx_ctamed where fecha_in_tx>='2013-12-04' and cod_fin in ('88') order by fecha_in_tx desc;

--psql -c "SELECT cod_fin,financiador,tipo_tx,codigo_motor,cod_ctamed,fecha_in_tx,estado,codigo_resp c_resp,mensaje_resp,mensaje_fin from tx_ctamed where fecha_in_tx>='2013-12-04' and cod_fin in ('88') order by fecha_in_tx de^C;"
