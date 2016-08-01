CREATE OR REPLACE FUNCTION bono3.traductor_in_leerutcotiz_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	declare_params varchar;
	output_params varchar;
	ext_cod_financiador varchar;
	ext_rut_cotizante varchar;

begin

	xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	ext_cod_financiador:= get_campo('EXTCODFINANCIADOR',xml2);
	ext_rut_cotizante:= get_campo('EXTRUTCOTIZANTE',xml2);
	
	declare_params:='DECLARE @extNomCotizante char(50)
			 DECLARE @extcodError char(2)
			 DECLARE @extMensajeError char(50)';

	output_params:=' @extNomCotizante OUTPUT,@extcodError OUTPUT,@extMensajeError OUTPUT ';
	xml2:=put_campo(xml2,'SQLINPUT',declare_params||' EXEC dbo.MASLeeRutCotiz '||ext_cod_financiador||',['||ext_rut_cotizante||'], '||output_params);
        return xml2;

end;
$$
LANGUAGE plpgsql;
                                
CREATE OR REPLACE FUNCTION bono3.traductor_out_leerutcotiz_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
begin

        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	xml2:=put_campo(xml2,'EXTNOMCOTIZANTE',	trim(get_campo('EXTNOMCOTIZANTE',xml2)));
       	xml2:=put_campo(xml2,'EXTCODERROR',	trim(get_campo('EXTCODERROR',xml2)));
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',	trim(get_campo('EXTMENSAJEERROR',xml2)));
	
        xml2:=put_campo(xml2,'EXTCORBENEF',	trim(get_campo('bnf_rut',xml2)));
        xml2:=put_campo(xml2,'EXTRUTBENEFICIARIO',	trim(get_campo('BNF_RUT',xml2)));
        xml2:=put_campo(xml2,'EXTAPELLIDOPAT',	trim(get_campo('BNF_PATERNO',xml2)));
        xml2:=put_campo(xml2,'EXTAPELLIDOMAT',	trim(get_campo('BNF_MATERNO',xml2)));
        xml2:=put_campo(xml2,'EXTNOMBRES',	trim(get_campo('BNF_NOMBRES',xml2)));
        xml2:=put_campo(xml2,'EXTCODESTBEN',	trim(get_campo('BNF_CODEST',xml2)));
        xml2:=put_campo(xml2,'EXTDESCESTADO',	trim(get_campo('BNF_NOMEST',xml2)));
    	return xml2;

end;
$$
LANGUAGE plpgsql;
