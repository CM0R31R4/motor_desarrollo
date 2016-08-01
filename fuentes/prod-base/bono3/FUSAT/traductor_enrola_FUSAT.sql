CREATE OR REPLACE FUNCTION traductor_in_enrola_fusat(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	cod_fin1 	varchar;
        rut_enrola1	varchar;
        rut_benef1	varchar;

/*
      @extCodFinanciador        int
    , @extRutEnrolar            char(12)
    , @extRutBeneficiario       char(12)
    , @extValido                char(1)         Output
    , @extNombreComp            char(40)        Output 
*/
	
begin
        xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	
	cod_fin1	:=get_campo('EXTCODFINANCIADOR',xml2);
	rut_enrola1     :=get_campo('EXTRUTENROLAR',xml2);
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);

	--Valida formato del Rut
        /*rut_enrola1:=motor_formato_rut(rut_enrola1);
        rut_benef1:=motor_formato_rut(rut_benef1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_enrola1='') or (rut_benef1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	xml2:=put_campo(xml2,'SQLINPUT','["ADMIMED.FUSENROLA_PKG.FUSENROLA", [ "$o$STRING", '||cod_fin1||','||chr(34)||rut_enrola1||chr(34)||','||chr(34)||rut_benef1||chr(34)||', "$o$STRING", "$o$STRING" ]]'||chr(10)||chr(10));
        
	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_enrola_fusat(varchar)
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
			xml2:=put_campo(xml2,'ERRORMSG','Fusat:Error_Enrola');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
		return xml2;
        end if;

	--Aca podria necesitar un rtrim
	cod_resp1	:=trim(replace(json_field(aux1,'1'),'"',''));
	nombre1		:=trim(replace(json_field(aux1,'2'),'"',''));	
	xml2:=logapp(xml2,'FUSAT: RSP_ENROLA -> extValido='||cod_resp1||' -extNombreComp='||nombre1);
	
        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',trim(replace(json_field(aux1,'0'),'"','')));
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

