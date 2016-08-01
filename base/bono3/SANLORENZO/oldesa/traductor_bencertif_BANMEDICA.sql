CREATE OR REPLACE FUNCTION bono3.traductor_in_bencertif_banmedica(varchar)
returns varchar as
$$
declare
	extCodFinanciador int;
	extRutBeneficiario varchar;
	extFechaActual varchar;

       	xml1    alias for $1;
        xml2    varchar;
begin
        xml2:=xml1;
        extCodFinanciador  := get_campo('EXTCODFINANCIADOR',xml2);
        extRutBeneficiario := trim(get_campo('EXTRUTBENEFICIARIO',xml2));
        --Si viene el guion en el rut...
        if strpos(extRutBeneficiario,'-')>0 then
                extRutBeneficiario:=substring(extRutBeneficiario,1,length(extRutBeneficiario)-2);
        end if;
        extFechaActual     := replace(replace(get_campo('EXTFECHAACTUAL',xml2),'-',''),'/','');

        xml2:=put_campo(xml2,'INPUT','["IMEDSOF.CONBENCERTIF_PKG.CONBENCERTIF", [ "$o$STRING", '||extCodFinanciador||','||chr(34)||extRutBeneficiario||chr(34)||','||chr(34)||extFechaActual||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$NUMBER", "$o$STRING[10]", "$o$STRING[10]" ]]'||chr(10)||chr(10));

return xml2;
end;

$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_bencertif_banmedica   (varchar)
returns varchar as
$$
declare
       	xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;
begin
        xml2:=xml1;
        raise notice 'xml2=%',xml2;
        raise notice 'RESPUESTA=%',get_campo('RESPUESTA',xml2);
        resp1:=replace(get_campo('RESPUESTA',xml2),chr(10),'');
        raise notice 'resp1=%',resp1;
        --Si no esta el tag result es porque hay error
        aux1:=json_field(resp1,'result');
        raise notice 'aux1=%',aux1;
        if aux1 is null then
                --Vemos si hay error del ORACLE
                aux1:=json_field(resp1,'ora-msg');
                raise notice '*aux1=%',aux1;
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

        --Parseo la respuesta
        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
        xml2:=put_campo(xml2,'EXTAPELLIDOPAT',replace(json_field(aux1,'1'),'"',''));
        xml2:=put_campo(xml2,'EXTAPELLIDOMAT',replace(json_field(aux1,'2'),'"',''));
        xml2:=put_campo(xml2,'EXTNOMBRES',replace(json_field(aux1,'3'),'"',''));
        xml2:=put_campo(xml2,'EXTSEXO',replace(json_field(aux1,'4'),'"',''));
        xml2:=put_campo(xml2,'EXTFECHANACIMI',replace(json_field(aux1,'5'),'"',''));
        xml2:=put_campo(xml2,'EXTCODESTBEN',replace(json_field(aux1,'6'),'"',''));
        xml2:=put_campo(xml2,'EXTDESCESTADO',replace(json_field(aux1,'7'),'"',''));
        xml2:=put_campo(xml2,'EXTRUTCOTIZANTE',replace(json_field(aux1,'8'),'"',''));
        xml2:=put_campo(xml2,'EXTNOMCOTIZANTE',replace(json_field(aux1,'9'),'"',''));
        xml2:=put_campo(xml2,'EXTDIRPACIENTE',trim(replace(json_field(aux1,'10'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSACOMUNA',trim(replace(json_field(aux1,'11'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSACIUDAD',trim(replace(json_field(aux1,'12'),'"','')));
        xml2:=put_campo(xml2,'EXTPREVISION',replace(json_field(aux1,'13'),'"',''));
        xml2:=put_campo(xml2,'EXTGLOSA',trim(replace(json_field(aux1,'14'),'"','')));
        xml2:=put_campo(xml2,'EXTPLAN',replace(json_field(aux1,'15'),'"',''));
        xml2:=put_campo(xml2,'EXTDESCUENTOXPLANILLA',replace(json_field(aux1,'16'),'"',''));
        xml2:=put_campo(xml2,'EXTMONTOEXCEDENTE',replace(json_field(aux1,'17'),'"',''));
        xml2:=put_campo(xml2,'EXTRUTACOMPANANTE',replace(json_field(aux1,'18'),'"',''));
        xml2:=put_campo(xml2,'EXTNOMBREACOMPANANTE',replace(json_field(aux1,'19'),'"',''));

        return xml2;
end;

$$
LANGUAGE plpgsql;
