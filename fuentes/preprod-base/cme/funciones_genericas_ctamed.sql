CREATE OR REPLACE FUNCTION fintx_ctamed(varchar)
returns varchar as
$$
declare
        xml1	alias for $1;
        xml2	varchar;
	stCme	tx_ctamed%ROWTYPE;
	stSec	bono3.define_secuencia_ws%ROWTYPE;
	campo	record;
	
	id_fin1		varchar;
	cod_cme1	varchar;
	cod_motor_orig1	varchar;
	i	integer =1;
	cuenta1	integer =0;
	
begin
        xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','30');
	/*xml2:=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2:=put_campo(xml2,'CODIGO_RESP','2');
        xml2:=put_campo(xml2,'MENSAJE_RESP','');
        xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));*/

	id_fin1:=get_campo('ID_FIN',xml2);
	cod_cme1:=get_campo('COD_CME',xml2);

	--Cuenta el total de CME registadas por cod_cme.
	select count(*) into cuenta1 from tx_ctamed WHERE cod_fin=id_fin1::integer and cod_ctamed=cod_cme1::integer and estado='CONTENIDA' and length(sp_exec)>0;
	--raise notice 'JCC_TotContenidas1 =%',cuenta1;
	if cuenta1 = 0 then
		xml2:=put_campo(xml2,'ERR','S');
		xml2:=put_campo(xml2,'GLOSA','CME idxTx="'||cod_cme1||'", Sin Registros');
		raise notice 'JCC_SIN_REG. =%',cod_cme1;
		--Vuelve al 8081 con este error
		xml2:=put_campo(xml2,'__SECUENCIAOK__','30');
		return xml2;
	end if;
	--Si hay trx CME. Abro una conexion persistente al financiador
	--xml2:=put_campo(xml2,'__CONTROL_BD_PERSISTENTE__','OPEN');

	--Saco los SP que debo ejecutar
	for campo in SELECT * FROM tx_ctamed WHERE cod_fin=id_fin1::integer and cod_ctamed=cod_cme1::integer and estado='CONTENIDA' and length(sp_exec)>0 
		ORDER BY fecha_in_tx ASC LOOP
		--raise notice 'JCC_SP-Request tx_cme=% ',campo.tipo_tx;
		xml2:=put_campo(xml2,'COD_MOTOR_ORIG_'||i::varchar,campo.codigo_motor::varchar);
		xml2:=put_campo(xml2,'TX_CME_'||i::varchar,campo.tipo_tx);
		xml2:=put_campo(xml2,'SP_REQ_'||i::varchar,campo.sp_exec);
		
		/***
		Podria guardar la funcion_out en tx_ctamed. 
		Asi CONTENGO solo lo tenga funcion_output x cada CME.
		y tengo que volver a leer de esta tabla.
		***/

		--Ejecuta la funcion parseadora de respuesta por cada servicio enviado a la Isapre
                select * into stSec from bono3.define_secuencia_ws where tipo_tx=campo.tipo_tx and financiador = id_fin1::integer;
                --raise notice 'JCC_stSec.funcion_output =% ',stSec.funcion_output;
                xml2:=put_campo(xml2,'FUNC_SALIDA_'||i::varchar,stSec.funcion_output);
		--Incremente para el sgte registro. 
		i:=i+1;
		
		--Va al flujo 8085	
		--xml2:=put_campo(xml2,'__SECUENCIAOK__','500');
	END LOOP;
	--Cierra conexion
	--xml2:=put_campo(xml2,'__CONTROL_BD_PERSISTENTE__','CLOSE');
	
	--Total registros encontrados
	xml2:=put_campo(xml2,'TOTAL_CME',cuenta1::varchar);
	--Va al flujo 8085	
	xml2:=put_campo(xml2,'CONTADOR_CME','1');
	xml2:=put_campo(xml2,'__SECUENCIAOK__','500');

	/*xml2:=put_campo(xml2,'ERR','N');
        xml2:=put_campo(xml2,'GLOSA','Fintx:Transacciones Informadas');*/

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION iniciotx_ctamed (varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        cod_cme1     varchar;
begin
        xml2:=xml1;
        --xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2:=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2:=put_campo(xml2,'CODIGO_RESP','2');
        xml2:=put_campo(xml2,'MENSAJE_RESP','');
        --xml2:=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        --Este cod puede venir en tag IDXTX.
        cod_cme1:=get_campo('COD_CME',xml2);

	if (cod_cme1='0') then
        	cod_cme1:=nextval('correlativo_ctamed')::varchar;
                
		--Necesario para el Update de tx_ctamed
                xml2:=put_campo(xml2,'COD_CME',cod_cme1);
       		
		--Para respuesta del WS_SOAP
        	xml2:=put_campo(xml2,'IDXTX',cod_cme1);
        else
                xml2:=put_campo(xml2,'COD_CME','0'::varchar);
        end if;
        /*--Si no viene.
        if motor_isnumber(cod_cme1)=0 then
                cod_cme1:=nextval('correlativo_ctamed')::varchar;
                --Necesario para el Update de tx_ctamed
                xml2:=put_campo(xml2,'COD_CME',cod_cme1);
        end if;*/
        --raise notice 'JCC_iniciotx_ctamed cod_cme1=%',cod_cme1;

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION anulatx_ctamed(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;

        cod_cme1     varchar;
begin
        xml2:=xml1;
        xml2:=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2:=put_campo(xml2,'CODIGO_RESP','2');
        xml2:=put_campo(xml2,'MENSAJE_RESP','');
        xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        xml2:=put_campo(xml2,'ERR','S');
        xml2:=put_campo(xml2,'GLOSA','Transacciones Anuladas');

        return xml2;
end;
$$
LANGUAGE plpgsql;

