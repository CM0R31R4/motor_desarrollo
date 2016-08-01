CREATE OR REPLACE FUNCTION traductor_in_solicfolios_cchc(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        declare_params varchar;
        out_params  varchar;
        exec_cmd  varchar;
        exec_end  varchar;
        ext_cod_financiador varchar;
        ext_cantidad_folios varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        ext_cod_financiador:=get_campo('EXTCODFINANCIADOR',xml2);
        ext_cantidad_folios:=get_campo('EXTNUMFOLIOS',xml2);
        
	declare_params:= 'DECLARE @extCodError char(1);
        	DECLARE @extMensajeError char(30);
                DECLARE @exFoliosDevueltos varchar(8000); ';
        exec_cmd:= 'EXEC dbo.SMDSolicFolios '||ext_cod_financiador||','||ext_cantidad_folios||', @extCodError OUTPUT,@extMensajeError OUTPUT; ';

        --CREATE TABLE #Result(extFoliosSolicitados varchar (20)); ';
        --exec_cmd:= ' INSERT INTO #Result EXEC  dbo.SMDSolicFolios '||ext_cod_financiador||','||ext_cantidad_folios||', @extFoliosSolicitados OUTPUT,@extMensajeError OUTPUT;select @extFoliosAExportar = COALESCE(@extFoliosAExportar + ",","") + res.extFoliosSolicitados from #Result res;select @extFoliosAExportar = SUBSTRING(@extFoliosAExportar, 2, LEN(@extFoliosAExportar)); ';
	--select1:= 'select @extFoliosAExportar = COALESCE(@extFoliosAExportar + ",","") + res.extFoliosSolicitados from #Result res;select @extFoliosAExportar = SUBSTRING(@extFoliosAExportar, 2, LEN(@extFoliosAExportar)); ';

       	--out_params:=' select @extFoliosAExportar as exFoliosDevueltos; ';
       	out_params:= 'SELECT @extCodError as extCodError, @extMensajeError as extMensajeError';
	
        --exec_end:=' Drop Table #Result; ';
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_cmd||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_solicfolios_cchc(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	i               integer ='1';
	cod_resp1       varchar;
        mensaje_resp1   varchar;
        folios_resp1    varchar ='';
	folio_aux1      varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	while true loop
                folio_aux1:=    trim(get_campo('EXTFOLIOSDEVUELTOS_'||i::varchar,xml2));
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
	xml2:=logapp(xml2,'CCHC: RSP_SOLICFOLIOS -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1||' -extFoliosDevueltos='||folios_resp1);

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
