DROP table tx_autentia;
CREATE table tx_autentia (
	tipo_tx		varchar(20),
	cod_motor	integer,	--Correlativo del codigo_motor
	cod_motor_anu 	integer,	--Codigo Motor Anulado
	fecha_in_8061	timestamp,	--Fecha In del 8061 
	fecha_out_8061	timestamp,	--Fecha Out del 8061
        estado		varchar(20),	--EN_PROCESO,TERMINADO_OK, RECHAZADO, FALLA_TX
        cod_resp     	varchar(1),	--1=Aprobada - 2=Rechazada 
        msje_resp	varchar(50),	--Trasaccion OK. Descripcion del rechazo
        
	/*Datos Autentia*/
	nro_autentia	bigint,		--NroAuditoria 
	num_solicitud	bigint,	 	--Codigo Imed	
	sensor_id     	varchar(40),	--pc_key
	pc_key		varchar(40),
	cod_lugar	bigint,

	rut_titular	varchar(12),
	rut_prest	varchar(12),
	rut_benef	varchar(12),
	rut_cajero	varchar(12),

	monto		varchar(20),
	monto_anulado	varchar(20),
	cuotas		integer,
	
	huella		varchar(2),
	tipo_venta	integer,
	fecha_oper	varchar(14),
	tipo_producto	varchar(10),
	fecha_pc	varchar(14),
	track1		varchar(100),
	track2		varchar(100),
	emisor		varchar(3),
	pin		varchar(50),
	version		varchar(5),
	fecha_anula	varchar(14),
	
	
	/*Datos MC*/	
	fecha_in_isw	timestamp,	--Fecha In MC (Va en los sp de c/financiador) 
	fecha_out_isw	timestamp,	--Fecha Out MC (Va en los sp de c/financiador)
	cod_resp_isw	varchar(2),	--Codigo Respuesta de Multicaja
	msj_resp_isw	varchar(50),	--Mensaje Respuesta de Multicaja
	codigo_isw	varchar,	--Codigo Iswitch de la Trx	
	total_emis	integer,	--Contador de la lista_emis (Ej:4)
	lista_emis	varchar(50),	--001-002-016-018

	voucher		text,
	xml_input	varchar		--Data entrante al 8061
);

CREATE index tx_autentia_01 on tx_autentia (cod_motor);
CREATE index tx_autentia_02 on tx_autentia (fecha_in_8061);
CREATE index tx_autentia_03 on tx_autentia (pc_key,cod_lugar);

--SELECT cod_fin,financiador,tipo_tx,codigo_motor,cod_autentia,fecha_in_tx,estado,codigo_resp as c_resp,mensaje_resp,mensaje_fin from tx_autentia where fecha_in_tx>='2013-12-04' and cod_fin in ('88') order by fecha_in_tx desc;

--psql -c "SELECT cod_fin,financiador,tipo_tx,codigo_motor,cod_autentia,fecha_in_tx,estado,codigo_resp c_resp,mensaje_resp,mensaje_fin from tx_autentia where fecha_in_tx>='2013-12-04' and cod_fin in ('88') order by fecha_in_tx de^C;"
