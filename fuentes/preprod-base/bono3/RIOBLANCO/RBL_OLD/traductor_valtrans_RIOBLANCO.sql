CREATE OR REPLACE FUNCTION bono3.traductor_in_valtrans_rioblanco(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

        extCodFinanciador       varchar;
        exFolioFinanciador      varchar;
        extAccion               varchar;
        extPregunta             varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	extCodFinanciador       := trim(get_campo('EXTCODFINANCIADOR',xml2));
        exFolioFinanciador      := coalesce(nullif(get_campo('EXFOLIOFINANCIADOR',xml2),''),'0');
        extAccion               := coalesce(nullif(get_campo('EXTACCION',xml2),''),'0');
        extPregunta             := coalesce(nullif(get_campo('EXTPREGUNTA',xml2),''),'0');

        xml2:=put_campo(xml2,'INPUT','["IRB_ADMIMED.RBLVALTRANS_PKG.RBLVALTRANS", ["$o$STRING", '||extCodFinanciador||', '||exFolioFinanciador||', '||chr(34)||extAccion||chr(34)||', '||chr(34)||extPregunta||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING"]]'||chr(10)||chr(10));

        return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION bono3.traductor_out_valtrans_rioblanco(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;
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

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',        trim(replace(json_field(aux1,'0'),'"','')));
        xml2:=put_campo(xml2,'EXTRESPUESTA',    trim(replace(json_field(aux1,'1'),'"','')));
        xml2:=put_campo(xml2,'EXTCODERROR',     trim(replace(json_field(aux1,'2'),'"','')));
        xml2:=put_campo(xml2,'EXTMENSAJEERROR', trim(replace(json_field(aux1,'3'),'"','')));
	
	return xml2;
end;
$$
LANGUAGE plpgsql;

