DROP table tx_mediospagos;
CREATE table tx_mediospagos (
	tipo_tx		varchar(30),
	cod_motor	integer,	--Correlativo del codigo_motor
	cod_motor_anu 	integer,	--Codigo Motor Anulado
	fecha_in_tx	timestamp,	--Fecha In del 3010 
	fecha_out_tx	timestamp,	--Fecha Out del 3010
        estado		varchar(20),	--EN_PROCESO,TERMINADO_OK, RECHAZADO, FALLA_TX
        cod_resp     	varchar(1),	--1=Aprobada - 2=Rechazada 
        msje_resp	text,	--Trasaccion OK. Descripcion del rechazo
        
	/*Datos Autentia*/
	nro_autentia	varchar(50),	--NroAuditoria 
	num_solicitud	varchar(50),	--Codigo TRX Cliente	
	pc_key		varchar(50),   
	cod_lugar	varchar,

	rut_titular	varchar(12),	-- Rut TarjetaHabiente
	rut_prest	varchar(12),	-- Rut Prestador
	rut_benef	varchar(12),	-- Rut Paciente
	rut_cajero	varchar(12),	-- Rut Operador Autentia

	monto		varchar(20),
	monto_anulado	varchar(20),
	cuotas		varchar(20),
	
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
	msj_resp_isw	text,	--Mensaje Respuesta de Multicaja
	codigo_isw	varchar,	--Codigo Iswitch de la Trx	
	total_emis	integer,	--Contador de la lista_emis (Ej:4)
	lista_emis	text,	--001-002-016-018

	voucher		text,
	xml_input	varchar		--Data entrante al 3010
);

CREATE index tx_mediospagos_01 on tx_mediospagos (cod_motor);
CREATE index tx_mediospagos_02 on tx_mediospagos (fecha_in_tx);
CREATE index tx_mediospagos_03 on tx_mediospagos (pc_key,cod_lugar);

--SELECT cod_fin,financiador,tipo_tx,codigo_motor,cod_autentia,fecha_in_tx,estado,codigo_resp as c_resp,mensaje_resp,mensaje_fin from tx_autentia where fecha_in_tx>='2013-12-04' and cod_fin in ('88') order by fecha_in_tx desc;

--psql -c "SELECT cod_fin,financiador,tipo_tx,codigo_motor,cod_autentia,fecha_in_tx,estado,codigo_resp c_resp,mensaje_resp,mensaje_fin from tx_autentia where fecha_in_tx>='2013-12-04' and cod_fin in ('88') order by fecha_in_tx de^C;"
