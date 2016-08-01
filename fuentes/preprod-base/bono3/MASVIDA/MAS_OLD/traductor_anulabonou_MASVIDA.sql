CREATE OR REPLACE FUNCTION bono3.traductor_in_anulabonou_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	declare_params	varchar;
        out_params  	varchar;
        exec_sp		varchar;
        exec_end  	varchar;
	select1		varchar;
	cod_fin1 	varchar;
	folio_bono1	varchar;
	id_tratam1	varchar;
	fecha_tratam1	varchar;
/*
@extCodFinanciador              int
@extFolioBono                   numeric(10,0)
@extIndTratam                   char(1)
@extFecTratam                   datetime
@extCodError                    char(1)         Output
@extMensajeError                char(30)        Output
*/	
begin
        xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1	:=get_campo('EXTCODFINANCIADOR',xml2);
        folio_bono1	:=coalesce(nullif(get_campo('EXTFOLIOBONO',xml2),''),'0');
	id_tratam1	:=coalesce(nullif(get_campo('EXTINDTRATAM',xml2),''),'0');
	--Fecha con formato YYYYMMDD
	fecha_tratam1	:=replace(coalesce(nullif(get_campo('EXTFECTRATAM',xml2),''),'0'),'-','');

	declare_params:='DECLARE @extCodFinanciador numeric (5);
	        DECLARE @extFolioBono numeric(10);
	        DECLARE @extIndTratam char(1);
        	DECLARE @extFecTratam datetime;
		DECLARE @extCodError char(1);
		DECLARE @extMensajeError char(30); ';

	--CREATE TABLE #Result(extRutAcompanante char (12),extNombreAcompanante char (40)) ';
	exec_sp:= 'execute dbo.MASAnulaBonoU '||cod_fin1||','||folio_bono1||',['||id_tratam1||'],['||fecha_tratam1||'], @extCodError OUTPUT, @extMensajeError OUTPUT; ';	
	/*Ejemplo SP MSQL SERVER*/
	--exec dbo.MASAnulaBonoU 88, 34, 'N', '04/20/2001', @extCodError output, @extMensajeError output;

	out_params:='select @extCodError as extCodError, @extMensajeError as extMensajeError; ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_anulabonou_masvida(varchar)
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
	cod_resp1	:=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
	mensaje_resp1	:=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));
	raise notice 'JCC_MV_ANULANONO_Receive extCodError=% - extMensajeError=%',cod_resp1,mensaje_resp1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

