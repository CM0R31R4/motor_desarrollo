CREATE OR REPLACE FUNCTION traductor_in_solicfolios_cruzblanca(varchar)
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
	num_folios1	varchar;

/*
 @extCodFinanciador     smallint
 @extNumFolios          tinyint
 @extCodError           char(1)  output
 @extMensajeError       char(30) output 
 @exFoliosDevueltos	numeric(10) output --Busca en la tabla temporal #EntregaFolios
*/	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
        num_folios1     :=get_campo('EXTNUMFOLIOS',xml2);

	declare_params:='DECLARE @extCodFinanciador numeric (5)
	        DECLARE @extNumFolios numeric(2)
	        DECLARE @extCodError char(1)
		DECLARE @extMensajeError char(30)
		DECLARE @exFoliosDevueltos numeric(10) ';
	
	exec_sp:= 'execute prestacion..INGSolicFolios '||cod_fin1||','||num_folios1||', @extCodError OUTPUT, @extMensajeError OUTPUT, @exFoliosDevueltos OUTPUT ';
	/*Ejemplo SP_SYBASE*/
	--exec INGSolicFolios 78,1, @extCodError output, @extMensajeError output
	
	--select1:= ' Select exFoliosDevueltos From #EntregaFolios ';
	--out_params:='select @extCodError as extCodError, @extMensajeError as extMensajeError, @exFoliosDevueltos as exFoliosDevueltos ';
	out_params:='select @extCodError as extCodError, @extMensajeError as extMensajeError ';
        --xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||select1||out_params);
        
	xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_solicfolios_cruzblanca(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	cod_resp1	varchar;
	mensaje_resp1	varchar;
	folios_resp1	varchar ='';
	folio_aux1	varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Tags con un nuevo formato 
	--###EXFOLIOSDEVUELTOS_3[9]=980993045
	--###EXFOLIOSDEVUELTOS_1[9]=980993047
	--###EXFOLIOSDEVUELTOS_2[9]=980993046
	--###EXTCODERROR_4[1]=S
	--###EXTMENSAJEERROR_4[0]
	
	--Parseo todos los exFoliosDevueltos
        while true loop
                folio_aux1:=get_campo('EXFOLIOSDEVUELTOS_'||i::varchar,xml2);
                if length(folio_aux1)>0 then
                        folios_resp1:=folios_resp1||folio_aux1||',';
                else
                        --Quito la ultima coma (ya que no volvera al ciclo) y se sale
                        if length(folios_resp1)>0 then
                                folios_resp1:=substring(folios_resp1,1,length(folios_resp1)-1);
                        end if;
                        exit;
                end if;
                i:=i+1;
        end loop;

        cod_resp1       :=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
        mensaje_resp1   :=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));

        xml2:=logapp(xml2,'CRUZBLANCA: RSP_SOLICFOLIOS -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1||' -extFoliosResp1='||folios_resp1);

	--raise notice 'JCC_SOLIFOLIOS_Receive extCodError=% - extMensajeError=% - exFoliosDevueltos=% ',cod_resp1,mensaje_resp1,folios_resp1;
        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        xml2:=put_campo(xml2,'EXFOLIOSDEVUELTOS','['||folios_resp1||']');

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTCODERROR',xml2)||', '||
                                        get_campo('EXTMENSAJEERROR',xml2)||', '||get_campo('EXFOLIOSDEVUELTOS',xml2)||'}');

        return xml2;
end;
$$
LANGUAGE plpgsql;

