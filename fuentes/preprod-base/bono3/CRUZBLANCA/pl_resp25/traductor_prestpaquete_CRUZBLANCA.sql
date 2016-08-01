CREATE OR REPLACE FUNCTION bono3.traductor_in_prestpaquete_cruzblanca(varchar)
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
	num_conv1	varchar;
	lugar_conv1		varchar;
	cod_paquete1	varchar;
/*
 @extCodFinanciador     smallint,
 @extHomNumeroConvenio  char(15),
 @extHomLugarConvenio   char(10),
 @extCodPaquete         char(15),
 @extCodError           char(1)  output,
 @extMensajeError       char(30) output
*/	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        := get_campo('EXTCODFINANCIADOR',xml2);
        num_conv1       := get_campo('EXTHOMNUMEROCONVENIO',xml2);
        lugar_conv1     := get_campo('EXTHOMLUGARCONVENIO',xml2);
        cod_paquete1    := get_campo('EXTCODPAQUETE',xml2);

	declare_params:='DECLARE @extCodFinanciador numeric (5)
	        DECLARE @extHomNumeroConvenio char(15)
	        DECLARE @extHomLugarConvenio char(10)
        	DECLARE @extCodPaquete char(15)
		DECLARE @extCodError char(1)
		DECLARE @extMensajeError char(30) ';

	exec_sp:= 'execute prestacion..INGPrestPaquete '||cod_fin1||',['||num_conv1||'],['||lugar_conv1||'],['||cod_paquete1||'], @extCodError OUTPUT, @extMensajeError OUTPUT ';
	/*Ejemplo*/ 
	--exec_sp:= exec prestacion..INGPrestPaquete 078, '00000042095-000', '0070681', '819308', @extCodError output, @extMensajeError output;

	out_params:='select @extCodError as extCodError, @extMensajeError as extMensajeError ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_prestpaquete_cruzblanca(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i               integer ='1';
        cod_homo1       varchar ='';
        item_homo1      varchar ='';
        cantidad1       varchar ='';

        cod_resp1       varchar;
        mensaje_resp1   varchar;

        cod_aux1        varchar;
        item_aux1       varchar;
        cant_aux1       varchar;

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parse 1er Select
        while true loop
                cod_aux1        :=trim(get_campo('EXTCODHOMOLOGO_'||i::varchar,xml2));
                item_aux1       :=trim(get_campo('EXTITEMHOMOLOGO_'||i::varchar,xml2));
                cant_aux1       :=trim(get_campo('EXTCANTIDAD_'||i::varchar,xml2));
                if length(cod_aux1)>0 or length(item_aux1)>0 or length(cant_aux1)>0 then
                        cod_homo1       :=cod_homo1||cod_aux1||'"'||','||'"';
                        item_homo1      :=item_homo1||item_aux1||'"'||','||'"';
                        cantidad1       :=cantidad1||cant_aux1||',';
                else
                        --Quito la ultima coma (ya que no volvera al ciclo) y se sale
                        if length(cod_homo1)>0 or length(item_homo1)>0 or length(cantidad1)>0 then
                                cod_homo1       :='"'||substring(cod_homo1,1,length(cod_homo1)-2);
                                item_homo1      :='"'||substring(item_homo1,1,length(item_homo1)-2);
                                cantidad1       :=substring(cantidad1,1,length(cantidad1)-1);
                        end if;
			exit;
                end if;
                i:=i+1;
        end loop;
	--Parseo el 2do Select
        cod_resp1       :=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
        mensaje_resp1   :=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));
        raise notice 'JCC_PRESTPAQUETE_Receive extCodError=% - extMensajeError=% cod_homo1=% - item_homo1=% - cantidad1=% ',cod_resp1,mensaje_resp1,cod_homo1,item_homo1,cantidad1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

        xml2:=put_campo(xml2,'EXTCODHOMOLOGO','['||cod_homo1||']');
        xml2:=put_campo(xml2,'EXTITEMHOMOLOGO','['||item_homo1||']');
        xml2:=put_campo(xml2,'EXTCANTIDAD','['||cantidad1||']');

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTCODERROR',xml2)||', '||
                                        get_campo('EXTMENSAJEERROR',xml2)||', '||get_campo('EXTCODHOMOLOGO',xml2)||', '||
                                        get_campo('EXTITEMHOMOLOGO',xml2)||', '||get_campo('EXTCANTIDAD',xml2)||'}');

        return xml2;
end;
$$
LANGUAGE plpgsql;

