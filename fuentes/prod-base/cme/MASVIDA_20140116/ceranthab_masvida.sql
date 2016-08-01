CREATE OR REPLACE FUNCTION traductor_in_ceranthab_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	declare_params	varchar;
        exec_sp		varchar;
        out_params  	varchar;

begin
        xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Llamo a la funcion input de parseo de datos.
	xml2:=proc_parser_input_ceranthab(xml2);

	--Preparo la llamada al SP
        declare_params:='DECLARE @AnamCodError char(1)
                DECLARE @AnamMensajeError char(60) ';

	--Por ahora en duro
        --||get_campo('ANAMCODFINANCIADOR',xml2)||
        exec_sp:= 'EXECUTE dbo.ceranthab '||get_campo('ANAMTIPODET',xml2)||',
                        ['||get_campo('ANAMRUTPRESTADOR',xml2)||'],
                        '||88||',
                        ['||get_campo('ANAMNUMCTA',xml2)||'],
                        '||get_campo('ANAMNUMCOBRO',xml2)||',
                        '||get_campo('ANAMTIPENVIO',xml2)||',
                        ['||get_campo('ANAMHOMNROCONVENIO',xml2)||'],
                        ['||get_campo('ANAMHOMLUGARCONVENIO',xml2)||'],
                        '||get_campo('ANAMNUMCOR',xml2)||',
                        '||get_campo('ANAMCODHABITO',xml2)||',
                        ['||get_campo('ANAMGLOHABITO',xml2)||'],
                        ['||get_campo('ANAMTIPHABITO',xml2)||'],
                        ['||get_campo('ANAMOCURHAB',xml2)||'],
                        ['||get_campo('ANAMCANTHAB',xml2)||'],
                        ['||get_campo('ANAMTIEMPO',xml2)||'], @AnamCodError OUTPUT, @AnamMensajeError OUTPUT ';

        out_params:='SELECT @AnamCodError as AnamCodError, @AnamMensajeError as AnamMensajeError ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;

end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_ceranthab_masvida(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        i               integer ='1';
        cod_resp1       varchar;
        msj_resp1       varchar;
begin
        xml2:=xml1;
        xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        --Parseo respuesta
        cod_resp1       :=trim(get_campo('ANAMCODERROR_'||i::varchar,xml2));
        msj_resp1       :=trim(get_campo('ANAMMENSAJEERROR_'||i::varchar,xml2));
        raise notice 'JCC_ceranthab_RECEIVE AnamCodError=% - AnamMensajeError=%',cod_resp1,msj_resp1;

        /*xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
        --Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'ANAMCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'ANAMMENSAJEERROR',msj_resp1);*/

	xml2:=put_campo(xml2,'ERR',cod_resp1);
        xml2:=put_campo(xml2,'GLOSA',msj_resp1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
