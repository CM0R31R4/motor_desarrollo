CREATE OR REPLACE FUNCTION traductor_in_cerencepi_masvida(varchar)
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
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',clock_timestamp()::varchar);

	--Llamo a la funcion input de parseo de datos.
	xml2:=proc_parser_input_cerencepi(xml2);
	if get_campo('ERR',xml2)='S' then
                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CME');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error parser_input_'||get_campo('TX_WS',xml2));
                return xml2;
        end if;

	--Preparo la llamada al SP
        declare_params:='DECLARE @EpiCodError char(1)
                DECLARE @EpiMensajeError char(60) ';

	--Por ahora en duro
        --||get_campo('EPICODFINANCIADOR',xml2)||
        exec_sp:= 'EXECUTE dbo.cerencepi ['||get_campo('EPIRUTPRESTADOR',xml2)||'],
                        '||88||',
                        ['||get_campo('EPINUMCTA',xml2)||'],
                        '||get_campo('EPINUMCOBRO',xml2)||',
                        '||get_campo('EPITIPENVIO',xml2)||',
                        ['||get_campo('EPIHOMNROCONVENIO',xml2)||'],
                        ['||get_campo('EPIHOMLUGARCONVENIO',xml2)||'],
                        ['||get_campo('EPIRUTPACIENTE',xml2)||'],
                        ['||get_campo('EPIAPELLIDOPAT',xml2)||'],
                        ['||get_campo('EPIAPELLIDOMAT',xml2)||'],
                        ['||get_campo('EPINOMBRES',xml2)||'],
                        '||get_campo('EPIEDAD',xml2)||',
                        ['||get_campo('EPIRUTPROFESIONAL',xml2)||'],
                        ['||get_campo('EPINOMBREPROFESIONAL',xml2)||'],
                        ['||get_campo('EPIFECCONTROL',xml2)||'], @EpiCodError OUTPUT, @EpiMensajeError OUTPUT ';

        out_params:='SELECT @EpiCodError as EpiCodError, @EpiMensajeError as EpiMensajeError ';
	
	--Esta data se guarda en t_ctamed campo sp_request
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);

        return xml2;

end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_cerencepi_masvida(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        i               integer ='1';
	cod_error1      varchar;
        msj_error1      varchar;

begin
        --Esta funcion se ejecuta, cuando fintx_ctamed esta en ejecucion
        xml2:=xml1;

	--xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        --xml2:=put_campo(xml2,'CODIGO_RESP','1');
        --xml2:=put_campo(xml2,'MENSAJE_RESP','Acepta Financiador');
        xml2:=put_campo(xml2,'FECHA_OUT_FIN',clock_timestamp()::varchar);

        --Parseo respuesta
        cod_error1      :=trim(get_campo('EPICODERROR_'||i::varchar,xml2));
        msj_error1      :=trim(get_campo('EPIMENSAJEERROR_'||i::varchar,xml2));
	xml2:=logapp(xml2,upper(get_campo('TX_WS',xml2))||'_Receive CtaCodError='||cod_error1||' - CtaMensajeError='||msj_error1);

        --Se guarda el response del SP en t_ctamed, campo sp_return. Tal como llega
        xml2:=put_campo(xml2,'SQLOUTPUT','{'||cod_error1||', '||msj_error1||'}');

        if (cod_error1='') then
                --Si campo ctacoderror viene en vacio. Activa SpConcilacion por Api2
                xml2:=logapp(xml2,'Isapre Responde Sin Valor ctacoderror: '||get_campo('TX_WS',xml2));
                xml2:=put_campo(xml2,'LOOP_API','SI');

                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_API');
                xml2:=put_campo(xml2,'CODIGO_RESP','2');
                xml2:=put_campo(xml2,'MENSAJE_RESP','No Viene Respuesta Financiador');

                --Respuesta a Sonda
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','No Viene Respuesta Financiador');

                --El Sp de Conciliacion solo usa variables "CTA"
                xml2:=put_campo(xml2,'CTARUTCONVENIO',get_campo('ANAMRUTPRESTADOR',xml2));
                xml2:=put_campo(xml2,'CTANUMCTA',get_campo('ANAMNUMCTA',xml2));
                xml2:=put_campo(xml2,'CTANUMCOBRO',get_campo('ANAMNUMCOBRO',xml2));
                xml2:=put_campo(xml2,'CTATIPENVIO',get_campo('ANAMTIPENVIO',xml2));
                return xml2;

        elsif (cod_error1='S') then
                --Si Isapre responde Error. Activar SP ConciliacionCme con recursion de secuencia.
                --<STATUS>OK</STATUS><CtaCodError>S</CtaCodError><CtaMensajeError>Registro cargado anteriormente...
                xml2:=logapp(xml2,'Isapre Rechaza Cme: '||get_campo('TX_WS',xml2));

                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','2');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Rechaza Financiador');

        else
                --Esta Aprobada. Viene "N"
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Informada Financiador');

        end if;

        --Responde a Sonda.
        xml2:=put_campo(xml2,'ERR',cod_error1);
        xml2:=put_campo(xml2,'GLOSA',msj_error1);


        return xml2;
end;
$$
LANGUAGE plpgsql;
