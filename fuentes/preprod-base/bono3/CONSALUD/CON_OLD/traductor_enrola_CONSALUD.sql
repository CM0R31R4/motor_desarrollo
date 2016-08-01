CREATE OR REPLACE FUNCTION bono3.traductor_in_enrola_consalud(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	extCodFinanciador	varchar;
	rut_enrolar1		varchar;
	rut_benef1	varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        extCodFinanciador	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
	rut_enrolar1           := split_part(ltrim(get_campo('EXTRUTENROLAR',xml2),'0'),'-',1);
        rut_benef1      := split_part(ltrim(get_campo('EXTRUTBENEFICIARIO',xml2),'0'),'-',1);

        --Rut con formato
	if length(rut_enrolar1)>'0' then rut_enrolar1     :=lpad(rut_enrolar1,10,'0')||'-'||motor_modulo11(rut_enrolar1);end if;
        if length(rut_benef1)>'0' then rut_benef1      :=lpad(rut_benef1,10,'0')||'-'||motor_modulo11(rut_benef1);end if;
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);       
 
        xml2:=put_campo(xml2,'INPUT','["IMEDSOF.CONENROLA_PKG.CONENROLA", [ "$o$STRING", '||extCodFinanciador||', '||chr(34)||rut_enrolar1||chr(34)||', '||chr(34)||rut_benef1||chr(34)||', "$o$STRING", "$o$STRING" ]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION bono3.traductor_out_enrola_consalud(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;
begin
        xml2:=xml1;
	xml2  :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  :=put_campo(xml2,'CODIGO_RESP','1');
        xml2  :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2  :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        resp1:=replace(get_campo('RESPUESTA',xml2),chr(10),'');
        --Si no esta el tag result es porque hay error
        aux1:=json_field(resp1,'result');
 
	if aux1 is null then
                --Vemos si hay error del ORACLE
                aux1:=json_field(resp1,'ora-msg');
                
		if aux1 is null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                --Otro Error
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG','Error Generico');
                end if;
                return xml2;
        end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',	trim(replace(json_field(aux1,'0'),'"','')));
	xml2:=put_campo(xml2,'EXTVALIDO',	trim(replace(json_field(aux1,'1'),'"','')));
        xml2:=put_campo(xml2,'EXTNOMBRECOMP',	trim(replace(json_field(aux1,'2'),'"','')));

	return xml2;
end;
$$
LANGUAGE plpgsql;
