CREATE OR REPLACE FUNCTION traductor_in_valtrans_chuqui(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	extCodFinanciador	varchar;
	exFolioFinanciador	varchar;
	extAccion		varchar;
	extPregunta		varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        extCodFinanciador	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
        exFolioFinanciador	:= get_campo('EXFOLIOFINANCIADOR',xml2);
        extAccion		:= get_campo('EXTACCION',xml2);
        extPregunta		:= get_campo('EXTPREGUNTA',xml2);

        xml2:=put_campo(xml2,'SQLINPUT','["ADMIMED.CHUVALTRANS_PKG.CHUVALTRANS", ["$o$STRING", '||extCodFinanciador||', '||exFolioFinanciador||', '||chr(34)||extAccion||chr(34)||', '||chr(34)||extPregunta||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING"]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;
 

CREATE OR REPLACE FUNCTION traductor_out_valtrans_chuqui(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;

	respuesta1      varchar;
        cod_resp1       varchar;
        mensaje_resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        resp1:=replace(get_campo('SQLOUTPUT',xml2),chr(10),'');
        aux1:=json_field(resp1,'result');
 
	if aux1 is null then
                aux1:=json_field(resp1,'ora-msg');
		if aux1 is not null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
			xml2:=put_campo(xml2,'ERRORMSG','Chuqui:Error_Valtrans');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
		return xml2;
        end if;

	--Parseo la Respuesta
        respuesta1      :=trim(replace(json_field(aux1,'1'),'"',''));
        cod_resp1       :=trim(replace(json_field(aux1,'2'),'"',''));
        mensaje_resp1   :=trim(replace(json_field(aux1,'3'),'"',''));
        
	xml2:=logapp(xml2,'CHUQUICAMATA: RSP_VALTRANS -> extRespuesta1='||respuesta1||' -extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1);

	--raise notice 'JCC_VALTRANS_Receive extRespuesta=% - extCodError=% - extMensajeError=%',respuesta1,cod_resp1,mensaje_resp1;

        if mensaje_resp1='null' then mensaje_resp1=''; end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
        --Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTRESPUESTA',respuesta1);
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
