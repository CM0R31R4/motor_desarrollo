CREATE OR REPLACE FUNCTION traductor_in_valtrans_colmena(varchar)
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
	folio_fin1	varchar;
	accion1		varchar;
	pregunta1	varchar;
/*
      @extCodFinanciador         smallint
    , @extFolioFinanciador       numeric(10,0)
    , @extAccion                 char(1)
    , @extPregunta               char(1)
    , @extRespuesta              char(1)         Output
    , @extCodError               char(1)         Output
    , @extMensajeError           char(30)        Output
*/	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
        folio_fin1      :=get_campo('EXFOLIOFINANCIADOR',xml2);
        accion1         :=get_campo('EXTACCION',xml2);
        pregunta1       :=get_campo('EXTPREGUNTA',xml2);

	declare_params:='DECLARE @extCodFinanciador numeric (5)
	        DECLARE @extFolioFinanciador numeric(10)
	        DECLARE @extAccion char(1)
        	DECLARE @extPregunta char(1)
		DECLARE @extRespuesta char(1)
		DECLARE @extCodError char(1)
		DECLARE @extMensajeError char(30) ';

	exec_sp:= 'execute isapre..CGCValTrans '||cod_fin1||','||folio_fin1||',"'||accion1||'","'||pregunta1||'", @extRespuesta OUTPUT, @extCodError OUTPUT, @extMensajeError OUTPUT ';
	/*Ejemplo*/ 
	--exec_sp:= exec isapre..CGCValTrans 67, 15721115, 'C', 'V',@extRespuesta output, @extCodError output, @extMensajeError output;
	out_params:='select @extRespuesta as extRespuesta, @extCodError as extCodError, @extMensajeError as extMensajeError ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_valtrans_colmena(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	respuesta1	varchar;
	cod_resp1	varchar;
	mensaje_resp1	varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        --Parseo la Respuesta
	respuesta1	:=trim(get_campo('EXTRESPUESTA_'||i::varchar,xml2));
	cod_resp1	:=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
	mensaje_resp1	:=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));
	
	xml2:=logapp(xml2,'COLMENA: RSP_VALTRANS -> extRespuesta1='||respuesta1||' -extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1);

	--raise notice 'JCC_VALTRANS_Receive extRespuesta=% - extCodError=% - extMensajeError=%',respuesta1,cod_resp1,mensaje_resp1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTRESPUESTA',respuesta1);
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTRESPUESTA',xml2)||', '||
                                        get_campo('EXTCODERROR',xml2)||', '||get_campo('EXTMENSAJEERROR',xml2)||'}');

        return xml2;
end;
$$
LANGUAGE plpgsql;

