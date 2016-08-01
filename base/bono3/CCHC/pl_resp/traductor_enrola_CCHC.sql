CREATE OR REPLACE FUNCTION bono3.traductor_in_enrola_cchc(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
        declare_params 	varchar;
        out_params  	varchar;
        cod_fin1 	varchar;
        rut_benef1 	varchar;
        rut_enrola1 	varchar;

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        cod_fin1	:=get_campo('EXTCODFINANCIADOR',xml2);
        rut_enrola1	:=get_campo('EXTRUTENROLAR',xml2);
        rut_benef1	:=get_campo('EXTRUTBENEFICIARIO',xml2);

	--Valida formato del Rut
        rut_enrola1:=motor_formato_rut(rut_enrola1);
        rut_benef1:=motor_formato_rut(rut_benef1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_enrola1='') or (rut_benef1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);
	
        declare_params:='DECLARE @extValido VARCHAR(2)
                         DECLARE @extNombreComp VARCHAR(50); ';

        out_params :=' @extValido OUTPUT,@extNombreComp OUTPUT; select @extValido as extValido, @extNombreComp as extNombreComp; ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||' EXEC dbo.SMDEnrola '||cod_fin1||',"'||rut_enrola1||'","'||rut_benef1||'",'||out_params);

        return xml2;

end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION bono3.traductor_out_enrola_cchc(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
	i		integer ='1';
        cod_resp1       varchar;
        nombre1         varchar;

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo la respuesta
        cod_resp1       :=trim(get_campo('EXTVALIDO_'||i::varchar,xml2));
        nombre1         :=trim(get_campo('EXTNOMBRECOMP_'||i::varchar,xml2));

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
