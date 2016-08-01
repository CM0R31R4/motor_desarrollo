CREATE OR REPLACE FUNCTION bono3.traductor_in_solicfolios_masvida(varchar)
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
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0'); 
        ext_cod_financiador:=get_campo('EXTCODFINANCIADOR',xml2);
	ext_cantidad_folios =get_campo('EXTNUMFOLIOS',xml2); 
 	 declare_params:= ' 
	DECLARE @extFoliosSolicitados VARCHAR(8000);
	DECLARE @extMensajeError VARCHAR(8000);
	DECLARE @extFoliosAExportar VARCHAR(8000);

	CREATE TABLE #Result( 
		extFoliosSolicitados varchar (20)
	);';

	--exec_cmd:= ' INSERT INTO #Result EXEC  dbo.MASSolicFolios '||ext_cod_financiador||','||ext_cantidad_folios||', @extFoliosSolicitados OUTPUT,@extMensajeError OUTPUT;select @extFoliosAExportar = COALESCE(@extFoliosAExportar + ",","") + res.extFoliosSolicitados from #Result res;select @extFoliosAExportar = SUBSTRING(@extFoliosAExportar, 2, LEN(@extFoliosAExportar));';
	exec_cmd:= ' INSERT INTO #Result EXEC  dbo.MASSolicFolios '||ext_cod_financiador||','||ext_cantidad_folios||', @extFoliosSolicitados OUTPUT,@extMensajeError OUTPUT;
	select @extFoliosAExportar = COALESCE(@extFoliosAExportar + ",","") + res.extFoliosSolicitados from #Result res;
	select @extFoliosAExportar = SUBSTRING(@extFoliosAExportar, 2, LEN(@extFoliosAExportar));';

	out_params:=' select @extFoliosAExportar as exFoliosDevueltos;';
	exec_end:=' Drop Table #Result; ';
	xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_cmd||out_params||exec_end);
	return xml2;


end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_solicfolios_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        ape     varchar;
begin
        xml2:=xml1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	xml2:=put_campo(xml2,'EXFOLIOSDEVUELTOS','['||get_campo('EXFOLIOSDEVUELTOS',xml2)||']');
	xml2:=put_campo(xml2,'EXTMENSAJEERROR','Sin Errores');
	xml2:=put_campo(xml2,'EXTCODERROR','S');
        return xml2;
end;
$$
LANGUAGE plpgsql;
