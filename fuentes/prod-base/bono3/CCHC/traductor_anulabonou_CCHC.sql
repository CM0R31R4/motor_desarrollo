CREATE OR REPLACE FUNCTION traductor_in_anulabonou_cchc(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        declare_params varchar;
        output_params varchar;
        ext_cod_financiador varchar;
        ext_folio_bono varchar;
        ext_ind_tratam varchar;
        ext_fec_tratam varchar;

begin
        xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        ext_cod_financiador	:= get_campo('EXTCODFINANCIADOR',xml2);
        ext_folio_bono		:= get_campo('EXTFOLIOBONO',xml2);
        ext_ind_tratam		:= get_campo('EXTINDTRATAM',xml2);
        ext_fec_tratam		:= replace(get_campo('EXTFECTRATAM',xml2),'-',''); --Formato YYYYMMDD

        declare_params:='DECLARE @extcoderror char(2)
                         DECLARE @extmensajeerror char(50)';
        output_params:=' @extcoderror OUTPUT,@extmensajeerror OUTPUT; select @extcoderror as extCodError,@extmensajeerror as extMensajeError';
        
	xml2:=put_campo(xml2,'SQLINPUT',declare_params||' EXEC dbo.SMDAnulaBonoU '||ext_cod_financiador||','||ext_folio_bono||',"'||ext_ind_tratam||'","'||ext_fec_tratam||'",'||output_params);
        return xml2;

end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_anulabonou_cchc(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	i               integer ='1';
	cod_resp1       varchar;
        mensaje_resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        --Parseo la Respuesta
        cod_resp1       :=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
        mensaje_resp1   :=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));
        xml2:=logapp(xml2,'CCHC: RSP_ANULANONO -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1);

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTCODERROR',xml2)||', '||
                                        get_campo('EXTMENSAJEERROR',xml2)||'}');

        return xml2;

end;
$$
LANGUAGE plpgsql;
