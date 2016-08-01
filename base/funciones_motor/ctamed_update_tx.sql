--DROP function cme_update_tx(varchar);
CREATE OR REPLACE FUNCTION ctamed_update_tx(varchar)
returns varchar as $$
declare
        xml1 		alias for $1;
	xml2 		varchar;
	cod_motor1	bigint;
	cod_cme1	bigint;
	respuesta1      varchar;

	--id_fin1	integer;
	--fecha_in_tx1	timestamp;
	fecha_out_tx1	timestamp;
	fecha_in_fin1	timestamp;
	fecha_out_fin1	timestamp;
	
begin
	xml2 := xml1;
	cod_motor1	:= get_campo('CODIGO_MOTOR',xml2)::bigint;
	cod_cme1	:= get_campo('COD_CME',xml2)::bigint;
	
	--id_fin1	:= get_campo('ID_FIN',xml2);
	--fecha_in_tx1	:= get_campo('FECHA_IN_TX',xml2);   --guarda en el registra
	fecha_out_tx1 	:= get_campo('FECHA_OUT_TX',xml2)::timestamp;	
	--fecha_in_fin1	:= get_campo('FECHA_IN_FIN',xml2)::timestamp;
	--fecha_out_fin1:= get_campo('FECHA_OUT_FIN',xml2)::timestamp;

	--Para guardar en campo xml_output 
	if (length(get_campo('RESPUESTA_HEX',xml2))>0) then
                respuesta1:=get_campo('RESPUESTA_HEX',xml2);
		--xml2:=logapp(xml2,'Viene RESPUESTA_HEX cme_update_tx');
        else
                respuesta1:=get_campo('RESPUESTA',xml2);
		--xml2:=logapp(xml2,'Viene RESPUESTA cme_update_tx');
        end if;

	--Si viene el tag 
	/*if get_campo('ERR',xml2)='S' then
                xml2  :=put_campo(xml2,'CODIGO_RESP','2');
                xml2  :=put_campo(xml2,'MENSAJE_RESP','Rechazado_Update_CME');
                --xml2  :=put_campo(xml2,'MENSAJE_RESP','Rechazado_Update_CME');
        end if;*/

	UPDATE tx_ctamed SET 
				fecha_out_tx 	= fecha_out_tx1,
				estado 		= get_campo('ESTADO_TX',xml2),
				codigo_resp	= get_campo('CODIGO_RESP',xml2),
				mensaje_resp	= get_campo('MENSAJE_RESP',xml2),
				mensaje_fin	= get_campo('GLOSA',xml2),
				--mensaje_fin	= get_campo('CTAMENSAJEERROR',xml2),
				sp_return       = get_campo('SQLOUTPUT',xml2),
				xml_output      = respuesta1
		     	WHERE
				codigo_motor = cod_motor1;
	if not found then
		xml2 := put_campo(xml2,'MENSAJE_RESP','Error en Update tx_ctamed: '||cod_motor1);
		return xml2;
	end if;	
				
	return xml2;
end;
$$ language 'plpgsql';
