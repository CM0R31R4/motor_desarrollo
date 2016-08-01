--DROP FUNCTION cme_registra_tx(varchar);
CREATE OR REPLACE FUNCTION ctamed_registra_tx(varchar)
returns varchar as $$
declare
        xml1 		alias for $1;
	xml2 		varchar;
	xml_std1	varchar;
	cod_motor1	bigint;
	cod_cme1	bigint;
	
	id_fin1		integer;
	rut_ben1	varchar;	--Temporal por ahora
	fecha_in_tx1	timestamp;
	fecha_in_fin1	timestamp;
	--fecha_out_tx1		timestamp;
	--fecha_in_fin1		timestamp;
	--fecha_out_fin1	timestamp;
	
begin
	xml2 := xml1;
	xml_std1	:= get_campo('__XML_STD__',xml2);
	id_fin1		:= get_campo('ID_FIN',xml2)::integer;
	rut_ben1	:= get_campo('RUT_BASE',xml2);
	fecha_in_tx1    := get_campo('FECHA_IN_TX',xml2)::timestamp;

	cod_motor1	:=get_campo('CODIGO_MOTOR',xml2)::bigint;
	cod_cme1	:=get_campo('COD_CME',xml2)::bigint;
	--fecha_in_fin1	:= get_campo('FECHA_IN_FIN',xml2)::timestamp;  --guarda en el update

	--fecha_out_tx1 	:= get_campo('FECHA_OUT_TX',xml2)::timestamp;  --guarda en el update
	--fecha_out_fin1	:= get_campo('FECHA_OUT_FIN',xml2)::timestamp; --guarda en el update
	--raise notice 'JCC_registra_ctmed cod_motor1=% - cod_cme1=%',cod_motor1,cod_cme1;

	--Para obtener el Numero de la Cuenta Medica que viene en el XML
	--if ()
	
	
	INSERT INTO tx_ctamed(	cod_fin,
				financiador,
				tipo_tx,
				codigo_motor,
				cod_ctamed,
				--num_ctamed,
				rut_benef,
				fecha_in_tx,
				fecha_in_fin,
				estado,
				codigo_resp,
				mensaje_resp,
				mensaje_fin,
				xml_input,
				sp_exec
		    )values(
				id_fin1,
				get_campo('FINANCIADOR',xml2),
				get_campo('TX_WS',xml2),
				get_campo('CODIGO_MOTOR',xml2)::bigint,
				get_campo('COD_CME',xml2)::bigint,
				get_campo('RUT_BASE',xml2),
				fecha_in_tx1,
				fecha_in_fin1,
				get_campo('ESTADO_TX',xml2),
				get_campo('CODIGO_RESP',xml2),
				get_campo('MENSAJE_RESP',xml2),
				get_campo('ERRORMSG',xml2),
				xml_std1,
				get_campo('SQLINPUT',xml2)
			   );
	return xml2;
end;
$$ language 'plpgsql';
