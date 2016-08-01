CREATE OR REPLACE FUNCTION bono3.traductor_in_prestpaquete_vidatres(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	extCodFinanciador	varchar;
	extHomNumeroConvenio	varchar;
	extHomLugarConvenio	varchar;
	extCodPaquete		varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	extCodFinanciador       := get_campo('EXTCODFINANCIADOR',xml2);
        extHomNumeroConvenio    := coalesce(nullif(get_campo('EXTHOMNUMEROCONVENIO',xml2),''),'0');
        extHomLugarConvenio     := coalesce(nullif(get_campo('EXTHOMLUGARCONVENIO',xml2),''),'0');
        extCodPaquete           := coalesce(nullif(get_campo('EXTCODPAQUETE',xml2),''),'0');

        xml2:=put_campo(xml2,'INPUT','["INFOMEDICA.VIDPRESTPAQUETE_PKG.VIDPRESTPAQUETE", [ "$o$STRING", '||extCodFinanciador||', '||chr(34)||extHomNumeroConvenio||chr(34)||', '||chr(34)||extHomLugarConvenio||chr(34)||', '||chr(34)||extCodPaquete||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING[10]", "$o$STRING[2]", "$o$NUMBER[5]"]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION bono3.traductor_out_prestpaquete_vidatres(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;

	cod_resp1       varchar;
        mensaje_resp1   varchar;

        cod_homol1      varchar;
        item_homol1     varchar;
        cantidad1       varchar;
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

	--Parseo la Respuesta
        cod_resp1       :=trim(replace(json_field(aux1,'1'),'"',''));
        mensaje_resp1   :=trim(replace(json_field(aux1,'2'),'"',''));
        cod_homol1      :=trim(replace(json_field(aux1,'3'),'"',''));
        item_homol1     :=trim(replace(json_field(aux1,'4'),'"',''));
        cantidad1       :=trim(replace(json_field(aux1,'5'),'"',''));

	raise notice 'JCC_PRESTPAQUETE_Receive extCodError=% - extMensajeError=% - cod_homol1% - item_homol1% ',cod_resp1,mensaje_resp1,cod_homol1,item_homol1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
	xml2:=put_campo(xml2,'ERRORMSG',        trim(replace(json_field(aux1,'0'),'"','')));
        xml2:=put_campo(xml2,'EXTCODERROR',     trim(replace(json_field(aux1,'1'),'"','')));
        xml2:=put_campo(xml2,'EXTMENSAJEERROR', trim(replace(json_field(aux1,'2'),'"','')));
        xml2:=put_campo(xml2,'EXTCODHOMOLOGO',  trim(replace(json_field(aux1,'3'),'"','')));
        xml2:=put_campo(xml2,'EXTITEMHOMOLOGO', trim(replace(json_field(aux1,'4'),'"','')));
        xml2:=put_campo(xml2,'EXTCANTIDAD',     trim(replace(json_field(aux1,'5'),'"','')));

        return xml2;
end;
$$
LANGUAGE plpgsql;
