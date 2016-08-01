CREATE OR REPLACE FUNCTION traductor_in_infenrola_banmedica(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	cod_fin1        varchar;
        rut_benef1      varchar;
        rut_acomp1      varchar;
	id_enrola1	varchar;

/*
extCodFinanciador	Integer (3)
extRutBeneficiario	char(12)
extRutAcompañante	char(12)
extIndEnrola		inyint
extCodError		har(1) 		output
extMensajeError		har(30) 	output
*/	
	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1 	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_benef1      := get_campo('EXTRUTBENEFICIARIO',xml2);
        rut_acomp1	:= get_campo('EXTRUTACOMPANANTE',xml2);
        id_enrola1	:= get_campo('EXTINDENROLA',xml2);

	--Valida formato del Rut
        /*rut_benef1:=motor_formato_rut(rut_benef1);
        rut_acomp1:=motor_formato_rut(rut_acomp1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_benef1='') or (rut_acomp1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
        --rut_acomp1:=split_part(rut_acomp1,'-',1);
        --rut_benef1:=split_part(rut_benef1,'-',1);
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);	

	xml2:=put_campo(xml2,'SQLINPUT','["INFOMEDICA.BANINFENROLA_PKG.BANINFENROLA", [ "$o$STRING", '||cod_fin1||','||chr(34)||rut_benef1||chr(34)||','||chr(34)||rut_acomp1||chr(34)||','||chr(34)||id_enrola1||chr(34)||',"$o$STRING", "$o$STRING" ]]'||chr(10)||chr(10));

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_infenrola_banmedica(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	aux1            varchar;
        resp1           varchar;

        cod_resp1       varchar;
        mensaje_resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

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
			xml2:=put_campo(xml2,'ERRORMSG','Banmedica:Error_InfEnrola');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
                return xml2;
        end if;

        --Parseo la Respuesta
        cod_resp1       :=trim(replace(json_field(aux1,'1'),'"',''));
        mensaje_resp1   :=trim(replace(json_field(aux1,'2'),'"',''));
	xml2:=logapp(xml2,'BANMEDICA: RSP_INFENROLA -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1);
	
	if mensaje_resp1='null' then mensaje_resp1=''; end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
