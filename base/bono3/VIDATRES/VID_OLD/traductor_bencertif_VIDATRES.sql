CREATE OR REPLACE FUNCTION bono3.traductor_in_bencertif_vidatres(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	extCodFinanciador	varchar;
	rut_benef1	varchar;
	extFechaActual		varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	extCodFinanciador  := get_campo('EXTCODFINANCIADOR',xml2);
        rut_benef1 := split_part(ltrim(get_campo('EXTRUTBENEFICIARIO',xml2),'0'),'-',1);
        extFechaActual     := to_char(get_campo('EXTFECHAACTUAL',xml2)::date, 'DD-MON-YY');

        --Rut con formato
	if length(rut_benef1)>'0' then rut_benef1:=lpad(rut_benef1,10,'0')||'-'||motor_modulo11(rut_benef1);end if;
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	xml2:=put_campo(xml2,'INPUT','["INFOMEDICA.VIDBENCERTIF_PKG.VIDBENCERTIF", [ "$o$STRING", '||extCodFinanciador||','||chr(34)||rut_benef1||chr(34)||','||chr(34)||extFechaActual||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$NUMBER", "$o$STRING[12]", "$o$STRING[40]" ]]'||chr(10)||chr(10));

return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION bono3.traductor_out_bencertif_vidatres(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	aux1	varchar;
	resp1	varchar;
	fecha_nac1 	varchar;
	cod_est_ben1    varchar;

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

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
	
	fecha_nac1      :=trim(replace(json_field(aux1,'5'),'"',''));
	--Si es un beneficiario certificado
        cod_est_ben1    :=trim(replace(json_field(aux1,'6'),'"',''));
        if cod_est_ben1='C' then
                --Resp OK fecha_nac viene asi 12-AUG-13
                fecha_nac1:=to_char(to_date(fecha_nac1,'DD Mon YY'),'YYYYMMDD');
        else
                --Resp viene con error/rechazo, fecha_nac viene asi 1900/01/01
                --fecha_nac1:=to_char(to_date(fecha_nac1,'YYYY-MM-DD'),'YYYYMMDD');
                fecha_nac1:='';
		xml2    :=put_campo(xml2,'CODIGO_RESP','2');
		xml2    :=put_campo(xml2,'MENSAJE_RESP','Rechazado');
        end if;

        --Parseo la respuesta
        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',        trim(replace(json_field(aux1,'0'),'"','')));
        xml2:=put_campo(xml2,'EXTAPELLIDOPAT',  trim(replace(json_field(aux1,'1'),'"','')));
        xml2:=put_campo(xml2,'EXTAPELLIDOMAT',  trim(replace(json_field(aux1,'2'),'"','')));
        xml2:=put_campo(xml2,'EXTNOMBRES',      trim(replace(json_field(aux1,'3'),'"','')));
        xml2:=put_campo(xml2,'EXTSEXO',         trim(replace(json_field(aux1,'4'),'"','')));
        xml2:=put_campo(xml2,'EXTFECHANACIMI',  fecha_nac1);
        xml2:=put_campo(xml2,'EXTCODESTBEN',   cod_est_ben1);
        xml2:=put_campo(xml2,'EXTDESCESTADO',   trim(replace(json_field(aux1,'7'),'"','')));
        xml2:=put_campo(xml2,'EXTRUTCOTIZANTE', trim(replace(json_field(aux1,'8'),'"','')));
        xml2:=put_campo(xml2,'EXTNOMCOTIZANTE', trim(replace(json_field(aux1,'9'),'"','')));
        xml2:=put_campo(xml2,'EXTDIRPACIENTE',  trim(replace(json_field(aux1,'10'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSACOMUNA',  trim(replace(json_field(aux1,'11'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSACIUDAD',  trim(replace(json_field(aux1,'12'),'"','')));
        xml2:=put_campo(xml2,'EXTPREVISION',    trim(replace(json_field(aux1,'13'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSA',        trim(replace(json_field(aux1,'14'),'"','')));
        xml2:=put_campo(xml2,'EXTPLAN',         trim(replace(json_field(aux1,'15'),'"','')));
        xml2:=put_campo(xml2,'EXTDESCUENTOXPLANILLA',   trim(replace(json_field(aux1,'16'),'"','')));
        xml2:=put_campo(xml2,'EXTMONTOEXCEDENTE',       trim(replace(json_field(aux1,'17'),'"','')));
        xml2:=put_campo(xml2,'EXTRUTACOMPANANTE',       trim(replace(json_field(aux1,'18'),'"','')));
        xml2:=put_campo(xml2,'EXTNOMBREACOMPANANTE',    trim(replace(trim(json_field(aux1,'19')),'"','')));

	--Guarda me mensaje en base
        xml2:=put_campo(xml2,'EXTMENSAJEERROR', trim(replace(json_field(aux1,'14'),'"','')));

        return xml2;
end;
$$
LANGUAGE plpgsql;

