CREATE OR REPLACE FUNCTION traductor_in_benrec_cruzblanca(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	declare_params	varchar;
        out_params  	varchar;
        insert1  	varchar;
        exec_sp		varchar;
        exec_end  	varchar;
	select1		varchar;
        
	cod_fin1 	varchar;
        rut_cotiza1	varchar;
        corr_benef1 	varchar;
        rut_ben1	varchar;
/*
 @extCodFinanciador     smallint,
 @extRutCotizante       char(12),
 @extCorrBenef          smallint,
 @extRutBeneficiario    char(12),
 @extCodResBen          char(1)   output,
 @extMensajeError       char(30)  output
*/

begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_cotiza1     :=get_campo('EXTRUTCOTIZANTE',xml2);
        corr_benef1     :=get_campo('EXTCORRBENEF',xml2);      -- No puede ser mayor a 99
        rut_ben1        :=get_campo('EXTRUTBENEFICIARIO',xml2);

	--Valida formato del Rut
        /*rut_cotiza1:=motor_formato_rut(rut_cotiza1);
        rut_ben1:=motor_formato_rut(rut_ben1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_cotiza1='') or (rut_ben1='') then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_ben1);

	declare_params:='DECLARE @extCodFinanciador numeric (5)
		DECLARE	@extRutCotizante char (12)
		DECLARE @extCorrBenef numeric (3)
	        DECLARE @extRutBeneficiario char (12)
	        DECLARE @extCodResBen char(1) 
        	DECLARE @extMensajeError char (30) ';
	exec_sp:= 'execute prestacion..INGBenRec '||cod_fin1||',"'||rut_cotiza1||'",'||corr_benef1||',"'||rut_ben1||'", @extCodResBen OUTPUT, @extMensajeError OUTPUT ';
	/*Ejemplo del SP de Sybase*/
	--exec prestacion..INGBenRec 78, '0005308213-0', 2, '0000000001-9', @extCodResBen output, @extMensajeError output
	out_params:='select @extCodResBen as extCodResBen, @extMensajeError as extMensajeError ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_benrec_cruzblanca(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i               integer ='1';
	cod_resp1	varchar;
	mensaje_resp1	varchar;
	
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo la Respuesta
	cod_resp1	:=trim(get_campo('EXTCODRESBEN_'||i::varchar,xml2));
	mensaje_resp1	:=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));
	xml2:=logapp(xml2,'CRUZBLANCA: RSP_BENREC -> extCodResBen='||cod_resp1||' -extMensajeError='||mensaje_resp1);
	
        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTCODRESBEN',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTCODRESBEN',xml2)||', '||
                                        get_campo('EXTMENSAJEERROR',xml2)||'}');

        return xml2;
end;
$$
LANGUAGE plpgsql;
