CREATE OR REPLACE FUNCTION traductor_in_anulabonou_cruzdelnorte(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

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
        folio_bono1	:=get_campo('EXTFOLIOBONO',xml2);
	id_tratam1	:=get_campo('EXTINDTRATAM',xml2);
	fecha_tratam1	:=to_char(get_campo('EXTFECTRATAM',xml2)::date, 'DD-MON-YYYY');
	
	xml2:=put_campo(xml2,'SQLINPUT','["ISAPRE_ADM.CDNANULABONOU_PKG.CDNANULABONOU", [ "$o$STRING", '||cod_fin1||','||chr(34)||folio_bono1||chr(34)||','||chr(34)||id_tratam1||chr(34)||','||chr(34)||fecha_tratam1||chr(34)||',"$o$STRING", "$o$STRING" ]]'||chr(10)||chr(10));
	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_anulabonou_cruzdelnorte(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	aux1    	varchar;
        resp1   	varchar;
	
	cod_resp1	varchar;
	mensaje_resp1	varchar;
begin
        xml2:=xml1;
	xml2  :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  :=put_campo(xml2,'CODIGO_RESP','1');
        xml2  :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2  :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));	
	
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
			xml2:=put_campo(xml2,'ERRORMSG','CruzDelNorte:Error_AnulaBonoU');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
		return xml2;
        end if;		

	--Parseo la respuesta
	cod_resp1	:=trim(replace(json_field(aux1,'1'),'"',''));
	mensaje_resp1	:=trim(replace(json_field(aux1,'2'),'"',''));	
	xml2:=logapp(xml2,'CRUZDELNORTE: RSP_ANULANONO -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1);

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',trim(replace(json_field(aux1,'0'),'"','')));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        
	return xml2;
end;
$$
LANGUAGE plpgsql;

