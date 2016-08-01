CREATE OR REPLACE FUNCTION traductor_in_cerconciliacioncme_masvida(varchar)
returns varchar as $$
declare
        xml1    alias for $1;
        xml2    varchar;
	declare_params	varchar;
        exec_sp		varchar;
        out_params  	varchar;
	tx1 	varchar;

begin
        xml2:=xml1;
	tx1:=get_campo('TX_WS',xml2);

	--Solo para fintx, funciona como trx inicial. Para el resto de Cme, ejecuta el SP con los parametros que tiene.
	if (tx1 = 'fintx') then
		xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
		xml2:=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        	xml2:=put_campo(xml2,'CODIGO_RESP','2');
	        xml2:=put_campo(xml2,'MENSAJE_RESP','');
		xml2:=put_campo(xml2,'FECHA_IN_FIN',clock_timestamp()::varchar);
	
		--Funcion Generica que busca campos para el SP  
		xml2:=proc_parser_input_cerconciliacioncme(xml2);
		if get_campo('ERR',xml2)='S' then
			xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CONCILIACION');
                	xml2:=put_campo(xml2,'MENSAJE_RESP','Error parser_input_'||get_campo('TX_WS',xml2));
			xml2:=logapp(xml2,'Error Conciliacion Input Err='||get_campo('ERR',xml2)||' Glosa='||get_campo('GLOSA',xml2));
			return xml2;
		end if;
	end if;

	--Prepara llamada al SP
	declare_params:='DECLARE @CtaCodError char(1)
		DECLARE @CtaMensajeError char(60) ';

	exec_sp:= 'EXECUTE dbo.conciliacioncme '||88||',
			['||get_campo('CTARUTCONVENIO',xml2)||'],
			['||get_campo('CTANUMCTA',xml2)||'],
			'||get_campo('CTANUMCOBRO',xml2)||',
			'||get_campo('CTATIPENVIO',xml2)||',
			'||get_campo('CTACONCILIACION',xml2)||', @CtaCodError OUTPUT, @CtaMensajeError OUTPUT ';
			
	out_params:='SELECT @CtaCodError as CtaCodError, @CtaMensajeError as CtaMensajeError ';

	--Esta data se guarda en t_ctamed campo sp_request
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
	xml2:=logapp(xml2,'SQLINPUT sp_conciliacioncme: '||get_campo('SQLINPUT',xml2));

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_cerconciliacioncme_masvida(varchar)
returns varchar as $$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	cod_error1	varchar;
	msj_error1	varchar;
	tx1	varchar;

begin
        xml2:=xml1;
	tx1:=get_campo('TX_WS',xml2);
	xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
	xml2:=put_campo(xml2,'CODIGO_RESP','1');
        xml2:=put_campo(xml2,'MENSAJE_RESP','Conciliacion Aceptada');

	--Parseo respuesta
	cod_error1	:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_error1	:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));
	xml2:=logapp(xml2,get_campo('TX_WS',xml2)||'_Receive CtaCodError='||cod_error1||' - CtaMensajeError='||msj_error1);

	--Si viene "S", es un error. Debe hacer un Rollback
	--<STATUS>OK</STATUS><CtaCodError>S</CtaCodError><CtaMensajeError>Registro cargado anteriormente...
        if (cod_error1<>'N') then
		--Si Isapre responde Error. Reprocesar por Batch SP Conciliacion.
                xml2:=logapp(xml2,'Isapre Rechaza Cme: '||get_campo('TX_WS',xml2));
                xml2:=put_campo(xml2,'MENSAJE_RESP','Conciliacion Rechazada');
                xml2:=put_campo(xml2,'CODIGO_RESP','2');
        end if;

	--Cuando es fintx, es una trx procesada online
	if (tx1 = 'fintx') then
	        xml2:=put_campo(xml2,'FECHA_OUT_FIN',clock_timestamp()::varchar);
		xml2:=put_campo(xml2,'ERR',cod_error1);
	        xml2:=put_campo(xml2,'GLOSA',msj_error1);
		--Para guardar el response del SP en t_ctamed, campo sp_return
		xml2:=put_campo(xml2,'SQLOUTPUT','{'||cod_error1||', '||msj_error1||'}');
	else
		--Uso estas variales para no pisarme respuestas ERR y GLOSA de la trx cerenvcta 
        	xml2:=put_campo(xml2,'ERR_CON',cod_error1);
	        xml2:=put_campo(xml2,'GLOSA_CON',msj_error1);
		--Para guardar el response del SP en t_ctamed, campo sp_return
		xml2:=put_campo(xml2,'SQLOUTPUT_CON','{'||cod_error1||', '||msj_error1||'}');
	end if;

	return xml2;
end;
$$
LANGUAGE plpgsql;

