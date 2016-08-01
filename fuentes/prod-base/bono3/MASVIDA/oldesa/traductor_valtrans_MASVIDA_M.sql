CREATE OR REPLACE FUNCTION bono3.traductor_in_valtrans_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	declare_params varchar;
	output_params varchar;
	ext_cod_financiador varchar;
	ext_folio_financiador varchar;
	ext_accion varchar;
	ext_pregunta varchar;

begin

        xml2:=xml1;
	ext_cod_financiador:= get_campo('EXTCODFINANCIADOR',xml2);
	ext_folio_financiador:= get_campo('EXFOLIOFINANCIADOR',xml2);
	ext_accion:= get_campo('EXTACCION',xml2);
	ext_pregunta:= get_campo('EXTPREGUNTA',xml2);
	
	declare_params:='DECLARE @extRespuesta char(20)
			 DECLARE @extcodError char(2)
			 DECLARE @extMensajeError char(50)';

	output_params:=' @extRespuesta OUTPUT,@extcodError OUTPUT,@extMensajeError OUTPUT; select @extRespuesta as extRespuesta,@extcoderror as extCodError, @extmensajeerror as extMensajeError';
	xml2:=put_campo(xml2,'SQLINPUT',declare_params||' EXEC dbo.MASvaltrans '||ext_cod_financiador||','||ext_folio_financiador||','||ext_accion||','||ext_pregunta||', '||output_params);
        return xml2;

end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_valtrans_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
begin

        xml2:=xml1;
        return xml2;

end;
$$
LANGUAGE plpgsql;
