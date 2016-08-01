CREATE OR REPLACE FUNCTION traductor_in_prestpaquete_consalud(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	cod_fin1 	varchar;
	num_conv1	varchar;
	lugar_conv1	varchar;
	cod_paquete1	varchar;
	l_array	varchar;
/*
      @extCodFinanciador          smallint
    , @extHomNumeroConvenio       char(15)
    , @extHomLugarConvenio        char(10)
    , @extCodPaquete              char(15)
    , @extCodError                char(1)    Output
    , @extMensajeError            char(30)   Output
	extCodHomologo        char(10) 		OUT extCodHomologo_arr,
	extItemHomologo       char(02) 		OUT extItemHomologo_arr,
	extCantidad           numeric(5) 	OUT extCantidad_arr
*/	
begin
        xml2:=xml1;
	l_array	:=40;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1	:= get_campo('EXTCODFINANCIADOR',xml2);
        num_conv1	:= get_campo('EXTHOMNUMEROCONVENIO',xml2);
        lugar_conv1	:= get_campo('EXTHOMLUGARCONVENIO',xml2);
        cod_paquete1    := get_campo('EXTCODPAQUETE',xml2);

	xml2:=put_campo(xml2,'SQLINPUT','["IMEDSOF.CONPRESTPAQUETE_PKG.CONPRESTPAQUETE", [ "$o$STRING", '||cod_fin1||','||chr(34)||num_conv1||chr(34)||','||chr(34)||lugar_conv1||chr(34)||','||chr(34)||cod_paquete1||chr(34)||', "$o$STRING","$o$STRING","$o$STRING['||l_array||']","$o$STRING['||l_array||']","$o$NUMBER['||l_array||']" ]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_prestpaquete_consalud(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	aux1		varchar;
	resp1		varchar;

	cod_resp1	varchar;
	mensaje_resp1	varchar;

	cod_homol1	varchar;
	item_homol1	varchar;
	cantidad1	varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        --Paseo la respuesta
	resp1:=replace(get_campo('SQLOUTPUT',xml2),chr(10),'');

        --Si no esta el tag result es porque hay error
        aux1:=json_field(resp1,'result');
        if aux1 is null then
                --Vemos si hay error del ORACLE
                aux1:=json_field(resp1,'ora-msg');
                if aux1 is not null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                --Otro Error
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
			xml2:=put_campo(xml2,'ERRORMSG','Consalud:Error_PrestPaquete');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
                return xml2;
        end if;

	--Parseo la Respuesta
	cod_resp1	:=trim(replace(json_field(aux1,'1'),'"',''));			
	mensaje_resp1	:=trim(replace(json_field(aux1,'2'),'"',''));	
	cod_homol1	:=replace(trim(replace(json_field(aux1,'3'),'"','')),'.0','');
	item_homol1	:=replace(trim(replace(json_field(aux1,'4'),'"','')),'.0','');
	cantidad1	:=replace(trim(replace(json_field(aux1,'5'),'"','')),'.0','');
	xml2:=logapp(xml2,'COLMENA: RSP_PRESTPAQUETE -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1||' -extCodHomologo='||cod_homol1||' -extItemHomologo='||item_homol1||' -extCantidad='||cantidad1);

	if mensaje_resp1='null' then mensaje_resp1=''; end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',trim(replace(json_field(aux1,'0'),'"','')));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        
	xml2:=put_campo(xml2,'EXTCODHOMOLOGO',cod_homol1);
        xml2:=put_campo(xml2,'EXTITEMHOMOLOGO',item_homol1);
        xml2:=put_campo(xml2,'EXTCANTIDAD',cantidad1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

