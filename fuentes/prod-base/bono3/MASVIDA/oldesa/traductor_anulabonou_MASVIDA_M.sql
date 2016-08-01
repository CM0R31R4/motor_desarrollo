CREATE OR REPLACE FUNCTION bono3.traductor_in_anulabonou_masvida(varchar)
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
	ext_cod_financiador:= get_campo('EXTCODFINANCIADOR',xml2);
	ext_folio_bono:= get_campo('EXTFOLIOBONO',xml2);
	ext_ind_tratam:= get_campo('EXTINDTRATAM',xml2);
	ext_fec_tratam:= get_campo('EXTFECTRATAM',xml2);
	
	declare_params:='DECLARE @extcoderror char(2)
			 DECLARE @extmensajeerror char(50)';
	output_params:=' @extcoderror OUTPUT,@extmensajeerror OUTPUT; select @extcoderror as extCodError, @extmensajeerror as extMensajeError';
	xml2:=put_campo(xml2,'SQLINPUT',declare_params||' EXEC dbo.MASAnulaBonoU '||ext_cod_financiador||','||ext_folio_bono||',0,0, '||output_params);
        return xml2;

end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_anulabonou_masvida(varchar)
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
