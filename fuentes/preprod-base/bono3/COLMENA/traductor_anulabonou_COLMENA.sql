CREATE OR REPLACE FUNCTION traductor_in_anulabonou_colmena(varchar)
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
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));	

	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        folio_bono1     :=get_campo('EXTFOLIOBONO',xml2);
        id_tratam1      :=get_campo('EXTINDTRATAM',xml2);
        --fecha_tratam1   :=to_char(get_campo('EXTFECTRATAM',xml2)::date, 'DD-MON-YYYY');
        fecha_tratam1   :=replace(get_campo('EXTFECTRATAM',xml2),'-','');

	declare_params:='DECLARE @extCodFinanciador numeric (5)
	        DECLARE @extFolioBono numeric(10)
	        DECLARE @extIndTratam char(1)
        	DECLARE @extFecTratam datetime
		DECLARE @extCodError char(1)
		DECLARE @extMensajeError char(30) ';

	--CREATE TABLE #Result(extRutAcompanante char (12),extNombreAcompanante char (40)) ';
	exec_sp:= 'execute CGCAnulaBonoU '||cod_fin1||','||folio_bono1||',"'||id_tratam1||'","'||fecha_tratam1||'", @extCodError OUTPUT, @extMensajeError OUTPUT ';	
	/*Ejemplo SP Sybase*/
	--exec CGCAnulaBonoU 78, 34, 'N', '04/20/2001', @extCodError output, @extMensajeError output;

	out_params:='select @extCodError as extCodError, @extMensajeError as extMensajeError ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_anulabonou_colmena(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
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
	xml2:=logapp(xml2,'COLMENA: RSP_ANULANONO -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1);

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
	
	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTCODERROR',xml2)||', '||
                                        get_campo('EXTMENSAJEERROR',xml2)||'}');

        return xml2;
end;
$$
LANGUAGE plpgsql;

