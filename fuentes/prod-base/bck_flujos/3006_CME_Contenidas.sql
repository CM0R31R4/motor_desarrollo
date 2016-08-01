delete from isys_querys_tx where llave='3006';

insert into isys_querys_tx values ('3006',10,1,1,'SELECT proc_parser_input_cme_3006(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Usa la API 188, definida en tabla base_datos
insert into isys_querys_tx values ('3006',88,188,1,'$$SQLINPUT$$',0,0,0,6,1,100,100);	--GET_MULTIPLE 

insert into isys_querys_tx values ('3006',100,1,1,'SELECT proc_parser_output_cme_3006(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);
--Limpia Variables
--insert into isys_querys_tx values ('3006',35,1,1,'SELECT ''CLEAR_JCC'' as SQLINPUT',0,0,0,1,1,30,30);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_input_cme_3006(varchar)
returns varchar as $$
declare
        xml1   	alias for $1;
        xml2   	varchar;
	--i	integer;
	--stSec		bono3.define_secuencia_ws%ROWTYPE;
	--stData		bono3.respuestas_soap%ROWTYPE;

	sql_cme1	varchar;
	tx_cme1		varchar;
	cod_motor_orig1	varchar;
	total_cme1	integer;
	cont_cme1	integer;
	func_out1	varchar;
	
begin
	xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	--xml2:=put_campo(xml2,'CODIGO_RESP','');
	--xml2:=put_campo(xml2,'MENSAJE_RESP','');
	--xml2:=put_campo(xml2,'FECHA_IN_FIN,to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	--Total de SP Execute	
	total_cme1:=get_campo('TOTAL_CME',xml2)::integer;
	cont_cme1:=get_campo('CONTADOR_CME',xml2)::integer;	--Contador Local del flujo3006
	raise notice 'JCC_3006_CONT =% * TOTAL =% ',cont_cme1,total_cme1;

	--Tomo el primer sql_CME. Lo enia a la Isapre.
	cod_motor_orig1	:=get_campo('COD_MOTOR_ORIG_'||cont_cme1::varchar,xml2);
	tx_cme1		:=get_campo('TX_CME_'||cont_cme1::varchar,xml2);
	sql_cme1	:=get_campo('SP_REQ_'||cont_cme1::varchar,xml2);
	func_out1	:=get_campo('FUNC_SALIDA_'||cont_cme1::varchar,xml2);

	--Solo la primera vez, envia el BEGIN TRANSACTION.
	if (cont_cme1=1) then
		--Abre Conexion Persistente
	        xml2:=put_campo(xml2,'__CONTROL_BD_PERSISTENTE__','OPEN');
		sql_cme1:='BEGIN TRANSACTION '||sql_cme1;
	end if;

	--Tomo de a 1SP. Envia el SP-Request, parsea la respuesta Isapre. Vuelve al input de 3006
	if (cont_cme1 <= total_cme1) then 
		xml2:=put_campo(xml2,'COD_MOTOR_CME',cod_motor_orig1);	--Se usa en /home/isys/base/CM/MASVIDA/cerenvcta_masvida.sql
		xml2:=put_campo(xml2,'SQLINPUT',sql_cme1);
		xml2:=put_campo(xml2,'FUNC_OUT',func_out1);
		xml2:=put_campo(xml2,'CME_TX',tx_cme1);
		xml2:=put_campo(xml2,'__SECUENCIAOK__','88');
		
		raise notice 'JCC_3006_IN-LOOP > SQLINPUT=88(SecOK) -- FUNC_OUT =%',func_out1;
	else
		--Proceso todo, envia Commit y cierra la CME
                xml2:=put_campo(xml2,'SQLINPUT','SELECT 1 COMMIT');
		--xml2:=put_campo(xml2,'FUNC_OUT',func_out1);
		xml2:=put_campo(xml2,'__SECUENCIAOK__','88');

		raise notice 'JCC_3006_FIN-LOOP > COMMIT=88(SecOK) -- FUNC_OUT =%',func_out1;
		
		--Cierra Conexion Persistente
	        xml2:=put_campo(xml2,'__CONTROL_BD_PERSISTENTE__','CLOSE');
	end if;
	
	return xml2;	
end;
$$
LANGUAGE plpgsql;

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_output_cme_3006(varchar)
returns varchar as $$
declare
        xml1   	alias for $1;
	xml2   	varchar;
	--i	integer ='1';

	func_out1	varchar;
	cont_cme1	integer;
	--tx_cme1		varchar;

begin
	xml2:=xml1;
	--xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	--xml2	:=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
	--xml2	:=put_campo(xml2,'CODIGO_RESP','');
	--xml2	:=put_campo(xml2,'MENSAJE_RESP','');
	xml2	:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	--tx_cme1:=get_campo('TX_CME',xml2);
	cont_cme1:=get_campo('CONTADOR_CME',xml2)::integer;
	func_out1:=get_campo('FUNC_OUT',xml2);
        raise notice 'JCC_3006_FUNC_OUT=%',func_out1;

	--Si hay COMMIT, Todas la CME Procesadas=OK y responde al 3005 con OK.
	if strpos(get_campo('SQLINPUT',xml2),'COMMIT') > 0 then
		xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
		xml2	:=put_campo(xml2,'ERR','N');
		
		--Glosa de Retorno del Servicio
                xml2	:=put_campo(xml2,'GLOSA','CME idxTx="'||get_campo('COD_CME',xml2)||'".Informadas');
		return xml2;

	elsif strpos(get_campo('SQLINPUT',xml2),'ROLLBACK') > 0 then
                xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
                xml2    :=put_campo(xml2,'ERR','S');
		
		--Glosa de Retorno del Servicio
                xml2    :=put_campo(xml2,'GLOSA','CME idxTx="'||get_campo('COD_CME',xml2)||'".Rollback'||' ['||get_campo('CME_TX',xml2)||': '||get_campo('MSJ_FIN_CME',xml2)||']');
                
		return xml2;  
	end if;

	--Parseo respuesta con la funcion_output de cada CME.
        if length(func_out1)>0 then
		raise notice 'JCC_3006.ExecFuncion.Out =%',func_out1;
                EXECUTE 'SELECT ' || func_out1 || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
		
		--Update 1a1 del CME Original. Me fue bien o mal.
		UPDATE tx_ctamed SET estado = get_campo('EST_CME',xml2), 
					codigo_resp 	= get_campo('COD_RSP_CME',xml2), 
					fecha_out_fin 	= get_campo('FECHA_OUT_FIN',xml2)::timestamp, 
					mensaje_resp	= get_campo('MSJ_RSP_CME',xml2),
					--mensaje_fin 	= get_campo('CTAMENSAJEERROR',xml2)
					mensaje_fin 	= get_campo('MSJ_FIN_CME',xml2),
					sp_return 	= get_campo('SQLOUTPUT',xml2)
               	WHERE codigo_motor = get_campo('COD_MOTOR_CME',xml2)::bigint and cod_ctamed = get_campo('COD_CME',xml2)::bigint;
               	--Error en Update CME Procesada 
		if not found then
                	raise notice 'JCC_Error Update tx_ctamed -> FuncOut =% - CodMotorCME=% ',get_campo('FUNC_OUT',xml2),get_campo('COD_MOTOR_CME',xml2)::bigint;
                	xml2 := put_campo(xml2,'MENSAJE_RESP','Error en Update tx_ctamed: CodMotorCME = '||get_campo('COD_MOTOR_CME',xml2)::bigint);
                end if;
		
		--Rollback solo debe venir de las funciones_outputs.
	        if get_campo('SP_ROLLBACK',xml2) = 'SI' then
        	        --Envia un Rollback con Recursion de Secuencia
	                xml2:=put_campo(xml2,'SQLINPUT','SELECT 1 ROLLBACK');
        	        xml2:=put_campo(xml2,'__SECUENCIAOK__','88');
			--Cierra Conexion Persistente, No Incrementa CONTADOR_CME
	                xml2:=put_campo(xml2,'__CONTROL_BD_PERSISTENTE__','CLOSE');
			return xml2;
	        end if;
	
		--Aumenta Contador y vuelve al 10 del 3006
		xml2:=put_campo(xml2,'CONTADOR_CME',(cont_cme1+1)::varchar);
		xml2:=put_campo(xml2,'__SECUENCIAOK__','10');
	
		xml2:=put_campo(xml2,'SQLINPUT','LIMPIADO_3006');
		xml2:=put_campo(xml2,'FUNC_OUT','LIMPIADO_3006');
		xml2:=put_campo(xml2,'SP_REQ_'||cont_cme1::varchar,'PROCESADO_3006');
		xml2:=put_campo(xml2,'FUNC_SALIDA_'||cont_cme1::varchar,'PROCESADO_3006');

        end if;
	--Si no tiene func_out1. Significa que no existe en t_respuestas_soap o fallo en algo.

	--Debiera 

	--No vuelva a ejecutar Funcion_Out en 8081.
	--xml2:=put_campo(xml2,'FUNCION_OUTPUT','');

	--Si viene ROLLBACK
	/*if get_campo('SP_ROLLBACK',xml2) = 'SI' then
		--Envia un Rollback. Recursion de Secuencia
		xml2:=put_campo(xml2,'SQLINPUT','ROLLBACK');
		xml2:=put_campo(xml2,'__SECUENCIAOK__','88');
	end if;*/

	return xml2;
end;
$$
LANGUAGE plpgsql;

