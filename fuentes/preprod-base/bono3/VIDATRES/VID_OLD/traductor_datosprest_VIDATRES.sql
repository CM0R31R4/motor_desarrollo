CREATE OR REPLACE FUNCTION bono3.traductor_in_datosprest_vidatres(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	extCodFinanciador	varchar;
	rut_conv1		varchar;
	extCodigoSucur		varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        extCodFinanciador	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
	rut_conv1		:= split_part(ltrim(get_campo('EXTRUTCONVENIO',xml2),'0'),'-',1);
	extCodigoSucur		:= coalesce(nullif(get_campo('EXTCODIGOSUCUR',xml2),''),'0');

	--Formato Rut	
	if length(rut_conv1)>'0' then rut_conv1 :=lpad(rut_conv1,10,'0')||'-'||motor_modulo11(rut_conv1);end if;
        xml2    :=put_campo(xml2,'RUT_BASE',rut_conv1);
 
        xml2:=put_campo(xml2,'INPUT','["INFOMEDICA.VIDDATOSPREST_PKG.VIDDATOSPREST", [ "$o$STRING", '||extCodFinanciador||', '||chr(34)||rut_conv1||chr(34)||', '||chr(34)||extCodigoSucur||chr(34)||', "$o$STRING", "$o$NUMBER", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING"]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION bono3.traductor_out_datosprest_vidatres(varchar)
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

	aux1:=json_field(resp1,'result');
        if aux1 is null then
                aux1:=json_field(resp1,'ora-msg');
		if aux1 is null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG','Error Generico');
                end if;
                return xml2;
        end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',	trim(replace(json_field(aux1,'0'),'"','')));
        xml2:=put_campo(xml2,'EXTESTCONVENIO',	trim(replace(json_field(aux1,'1'),'"','')));
        xml2:=put_campo(xml2,'EXTNIVEL',	trim(replace(json_field(aux1,'2'),'"','')));
        xml2:=put_campo(xml2,'EXTTIPOPRESTADOR',trim(replace(json_field(aux1,'3'),'"','')));
        xml2:=put_campo(xml2,'EXTCODESPECIALIDADES',	trim(replace(json_field(aux1,'4'),'"','')));
        xml2:=put_campo(xml2,'EXTCODPROFESIONES',	trim(replace(json_field(aux1,'5'),'"','')));
        xml2:=put_campo(xml2,'EXTANOSANTIGUEDAD',	trim(replace(json_field(aux1,'6'),'"','')));

	return xml2;
end;
$$
LANGUAGE plpgsql;
