CREATE OR REPLACE FUNCTION bono3.traductor_in_enrola_cruzblanca(varchar)
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
        rut_enrola1	varchar;
        rut_benef1	varchar;

/*
 @extCodFinanciador     smallint,
 @extRutEnrolar         char(12),
 @extRutBeneficiario    char(12),
 @extValido             char(1)   output,
 @extNombreComp         char(40)  output
*/
	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
        rut_enrola1     :=get_campo('EXTRUTENROLAR',xml2);
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);

	--Valida formato del Rut
        rut_enrola1:=motor_formato_rut(rut_enrola1);
        rut_benef1:=motor_formato_rut(rut_benef1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_enrola1='') or (rut_benef1='') then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	declare_params:='DECLARE @extCodFinanciador numeric (5)
		DECLARE	@extRutEnrolar char (12)
	        DECLARE @extRutBeneficiario char (12)
	        DECLARE @extValido char(1) 
        	DECLARE @extNombreComp char (40) ';

	exec_sp:= 'execute prestacion..INGEnrola '||cod_fin1||',['||rut_enrola1||'],['||rut_benef1||'], @extValido OUTPUT, @extNombreComp OUTPUT ';
	/*Ejemplo SP SYBASE*/
	--exec prestacion..INGEnrola 78, '0006456149-9', '0005308213-0', @extValido output, @extNombreComp output

	out_params:='select @extValido as extValido, @extNombreComp as extNombreComp ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_enrola_cruzblanca(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	cod_resp1	varchar;
	nombre1		varchar;
	
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	
	--Parseo la Respuesta
	cod_resp1	:=trim(get_campo('EXTVALIDO_'||i::varchar,xml2));
	nombre1		:=trim(get_campo('EXTNOMBRECOMP_'||i::varchar,xml2));
	raise notice 'JCC_ENROLA_Receive extValido=% - extNombreComp=%',cod_resp1,nombre1;
	
        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTVALIDO',cod_resp1);
        xml2:=put_campo(xml2,'EXTNOMBRECOMP',nombre1);

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTVALIDO',xml2)||', '||
                                        get_campo('EXTNOMBRECOMP',xml2)||'}');

        return xml2;
end;
$$
LANGUAGE plpgsql;
