CREATE OR REPLACE FUNCTION traductor_in_enrola_banmedica(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	cod_fin1 	varchar;
        rut_enrola1	varchar;
        rut_ben1	varchar;

/*
      @cod_fin1        	int
    , @rut_enrola1   	char(12)
    , @rut_ben1       char(12)
    , @extValido        char(1)         Output
    , @extNombreComp    char(40)        Output 
*/
	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1       	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_enrola1	:= get_campo('EXTRUTENROLAR',xml2);
        rut_ben1      := get_campo('EXTRUTBENEFICIARIO',xml2);

	--Valida formato del Rut
        rut_enrola1:=motor_formato_rut(rut_enrola1);
        rut_ben1:=motor_formato_rut(rut_ben1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_enrola1='') or (rut_ben1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Envia y almacena lo que viene.
        --rut_enrola1:=split_part(rut_enrola1,'-',1);
        --rut_ben1:=split_part(rut_ben1,'-',1);
        xml2    :=put_campo(xml2,'RUT_BASE',rut_ben1);

	xml2:=put_campo(xml2,'SQLINPUT','["INFOMEDICA.BANENROLA_PKG.BANENROLA", [ "$o$STRING", '||cod_fin1||','||chr(34)||rut_enrola1||chr(34)||','||chr(34)||rut_ben1||chr(34)||', "$o$STRING", "$o$STRING" ]]'||chr(10)||chr(10));
        
	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_enrola_banmedica(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	aux1		varchar;
	resp1		varchar;

	cod_resp1	varchar;
	nombre1		varchar;
	
begin
        xml2:=xml1;
	xml2  :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  :=put_campo(xml2,'CODIGO_RESP','1');
        xml2  :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2  :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        --Paseo la respuesta
	resp1:=replace(get_campo('SQLOUTPUT',xml2),chr(10),'');

	 --Si no esta el tag result es porque hay error
        aux1:=json_field(resp1,'result');
        if aux1 is null then
                --Vemos si hay error del ORACLE
                aux1:=json_field(resp1,'ora-msg');
                if aux1 is not null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                --Otro Error
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
			xml2:=put_campo(xml2,'ERRORMSG','Banmedica:Error_Enrola');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
                return xml2;
        end if;

	--Parseo la Respuesta
	cod_resp1	:=trim(replace(json_field(aux1,'1'),'"',''));			
	nombre1		:=trim(replace(json_field(aux1,'2'),'"',''));	
	
	xml2:=logapp(xml2,'BANMEDICA: RSP_ENROLA -> extCodResp1='||cod_resp1||' -extNombre1='||nombre1);
	
	--raise notice 'JCC_ENROLA_Receive extValido=% - extNombreComp=%',cod_resp1,nombre1;
	
        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTVALIDO',cod_resp1);
        xml2:=put_campo(xml2,'EXTNOMBRECOMP',nombre1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

