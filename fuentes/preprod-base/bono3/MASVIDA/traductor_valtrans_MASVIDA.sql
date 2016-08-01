CREATE OR REPLACE FUNCTION traductor_in_valtrans_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	declare_params 		varchar;
	output_params 		varchar;
	ext_cod_financiador 	varchar;
	ext_folio_financiador 	varchar;
	ext_accion 		varchar;
	ext_pregunta 		varchar;

begin
        xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	ext_cod_financiador	:= get_campo('EXTCODFINANCIADOR',xml2);
	ext_folio_financiador   := get_campo('EXFOLIOFINANCIADOR',xml2);
        ext_accion              := get_campo('EXTACCION',xml2);
        ext_pregunta            := get_campo('EXTPREGUNTA',xml2);	
	
	declare_params:='DECLARE @extRespuesta char(20)
			 DECLARE @extcodError char(2)
			 DECLARE @extMensajeError char(50)';

	output_params:=' @extRespuesta OUTPUT,@extcodError OUTPUT,@extMensajeError OUTPUT; select @extRespuesta as extRespuesta,@extcoderror as extCodError, @extmensajeerror as extMensajeError';
	
	xml2:=put_campo(xml2,'SQLINPUT',declare_params||' execute dbo.MASvaltrans '||ext_cod_financiador||','||ext_folio_financiador||',"'||ext_accion||'","'||ext_pregunta||'", '||output_params);
        return xml2;

end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION traductor_out_valtrans_masvida(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
	i               integer ='1';
        respuesta1      varchar;
        cod_resp1       varchar;
        mensaje_resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo la respuesta
	respuesta1      :=trim(get_campo('EXTRESPUESTA_'||i::varchar,xml2));
        cod_resp1       :=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
        mensaje_resp1   :=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));

	xml2:=logapp(xml2,'MAS_VIDA: RSP_VALTRANS -> extRespuesta='||respuesta1||' -extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1);

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
        --Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTRESPUESTA',respuesta1);
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTRESPUESTA',xml2)||', '||
                                        get_campo('EXTCODERROR',xml2)||', '||get_campo('EXTMENSAJEERROR',xml2)||'}');

        return xml2;
end;
$$
LANGUAGE plpgsql;
