CREATE OR REPLACE FUNCTION bono3.traductor_in_solicfolios_masvida(character varying)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

        declare_params  varchar;
        exec_sp         varchar;
        select1         varchar;
        out_params      varchar;
        exec_end        varchar;

        cod_fin1        varchar;
        num_folios1     varchar;

/*
      @extCodFinanciador              smallint
    , @extNumFolios                   tinyint
    , @extCodError                    char(1)         Output
    , @extMensajeError                char(30)        Output
*/
begin
        xml2:=xml1;
        xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        cod_fin1	:=get_campo('EXTCODFINANCIADOR',xml2);
        num_folios1	:=coalesce(nullif(get_campo('EXTNUMFOLIOS',xml2),''),'0');
	
        declare_params:='DECLARE @extCodFinanciador numeric (5);
                DECLARE @extNumFolios numeric(2);
                DECLARE @extCodError char(1);
                DECLARE @extMensajeError char(30);
                DECLARE @exFoliosDevueltos varchar(8000); ';
                --DECLARE @exFoliosDevueltos numeric(10);
                
		--DECLARE @extFoliosAExportar varchar(8000) -- Temp
        --CREATE TABLE #Result(Folios varchar (20)); ';
        --exec_sp:= 'INSERT INTO #Result execute dbo.MASSolicFolios '||cod_fin1||','||num_folios1||', @extCodError OUTPUT, @extMensajeError OUTPUT; ';
        exec_sp:='EXECUTE dbo.MASSolicFolios '||cod_fin1||','||num_folios1||', @extCodError OUTPUT, @extMensajeError OUTPUT; ';
        /*Ejemplo SP_SYBASE*/
        --exec dbo.MASSolicFolios 74,1, @extCodError output, @extMensajeError output

        --select1:='Select @extFoliosAExportar = COALESCE(@extFoliosAExportar + ",","") + res.Folios from #Result res;
        --        Select @extFoliosAExportar = SUBSTRING(@extFoliosAExportar, 2, LEN(@extFoliosAExportar)); ';

        --out_params:='Select @extCodError as extCodError, @extMensajeError as extMensajeError, @extFoliosAExportar as exFoliosDevueltos; ';
        out_params:='SELECT @extCodError as extCodError, @extMensajeError as extMensajeError';
        --exec_end:=' Drop Table #Result; ';
        
	--xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||select1||out_params||exec_end);
	xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_solicfolios_masvida(character varying)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
	i		integer ='1';
        cod_resp1       varchar;
        mensaje_resp1   varchar;
        folios_resp1    varchar ='';
        folio_aux1     	varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	
	while true loop
                folio_aux1:=	trim(get_campo('EXTFOLIOSDEVUELTOS_'||i::varchar,xml2));
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
        cod_resp1	:=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
        mensaje_resp1	:=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));

        raise notice 'JCC_SOLIFOLIOS_Receive extCodError=% - extMensajeError=% - exFoliosDevueltos=% ',cod_resp1,mensaje_resp1,folios_resp1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        xml2:=put_campo(xml2,'EXFOLIOSDEVUELTOS','['||folios_resp1||']');

        return xml2;
end;
$$
LANGUAGE plpgsql;
