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
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Llamo a la funcion input de parseo de datos.
	xml2:=proc_parser_input_cerencepi(xml2);
	if get_campo('ERR',xml2)='S' then
                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CONTENCION');
                xml2:=put_campo(xml2,'CODIGO_RESP','2');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Trx_No_Contenida');
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

        --Si no hay falla. Contesta el Resquest con OK1.
        xml2:=put_campo(xml2,'ERR','N');
        xml2:=put_campo(xml2,'GLOSA','CME Contenida');
        xml2:=put_campo(xml2,'ESTADO_TX','CONTENIDA');
        xml2:=put_campo(xml2,'CODIGO_RESP','1');
        xml2:=put_campo(xml2,'MENSAJE_RESP','Trx_Contenida');

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

        estado1         varchar;
        cod_resp1       varchar;
        msj_resp1       varchar;

begin
        --Esta funcion se ejecuta, cuando fintx_ctamed esta en ejecucion
        xml2:=xml1;

        xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
        estado1:='COMMIT';
        cod_resp1:='1';
        msj_resp1:='Trx_Commit';

        --Parseo respuesta
        cod_error1      :=trim(get_campo('EPICODERROR_'||i::varchar,xml2));
        msj_error1      :=trim(get_campo('EPIMENSAJEERROR_'||i::varchar,xml2));
        raise notice 'JCC_CERENCEPI_RECEIVE EpiCodError=% - EpiCtaMensajeError=%',cod_error1,msj_error1;

        --Si viene "S", es un error. Debe hacer un Rollback
        --<STATUS>OK</STATUS><CtaCodError>S</CtaCodError><CtaMensajeError>Registro cargado anteriormente...
        if cod_error1<>'N' then
                --Rollback
                cod_resp1:='2';
                msj_resp1:='Trx_Rollback';
                estado1:='ROLLBACK';
		--En caso de Rollback, Siempre debe crear este tag
                xml2:=put_campo(xml2,'SP_ROLLBACK','SI');
        end if;

        /*xml2:=put_campo(xml2,'ERR',cod_error1);
        xml2:=put_campo(xml2,'GLOSA',msj_error1);*/

        xml2:=put_campo(xml2,'COD_RSP_CME',cod_resp1);
        xml2:=put_campo(xml2,'MSJ_RSP_CME',msj_resp1);
        xml2:=put_campo(xml2,'EST_CME',estado1);
        xml2:=put_campo(xml2,'MSJ_FIN_CME',msj_error1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
