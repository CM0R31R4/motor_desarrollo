CREATE OR REPLACE FUNCTION traductor_in_datosprest_vidatres(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	cod_fin1 	varchar;
	rut_conv1	varchar;
	cod_sucur1	varchar;
/*
      @extCodFinanciador              smallint
    , @extRutConvenio                 char(12)
    , @extCodigoSucur                 char(10)
    , @extEstConvenio                 char(10)        Output
    , @extNivel                       tinyint         Output
    , @extTipoPrestador               char(1)         Output
    , @extCodEspecialidades           char(255)       Output
    , @extCodProfesiones              char(255)       Output
    , @extAnosAntiguedad              char(2)         Output
*/	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1	:=trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_conv1	:=get_campo('EXTRUTCONVENIO',xml2);
	cod_sucur1	:=get_campo('EXTCODIGOSUCUR',xml2);
       
	--Valida formato del Rut
        /*rut_conv1        :=motor_formato_rut(rut_conv1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_conv1='') then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
        --rut_conv1        :=split_part(rut_conv1,'-',1);
        xml2    :=put_campo(xml2,'RUT_BASE',rut_conv1);
 
	xml2:=put_campo(xml2,'SQLINPUT','["INFOMEDICA.VIDDATOSPREST_PKG.VIDDATOSPREST", [ "$o$STRING", '||cod_fin1||','||chr(34)||rut_conv1||chr(34)||','||chr(34)||cod_sucur1||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING" ]]'||chr(10)||chr(10));	
	
	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_datosprest_vidatres(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
        aux1            varchar;
        resp1           varchar;
  
	est_conv1	varchar;
	nivel1		varchar;
	tipo_prest1	varchar;
	cod_espec1	varchar;
	cod_prof1	varchar;
	antiguedad1	varchar;
	
begin
        xml2:=xml1;
	xml2  :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  :=put_campo(xml2,'CODIGO_RESP','1');
        xml2  :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2  :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

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
			xml2:=put_campo(xml2,'ERRORMSG','VidaTres:Error_DatosPrest');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
                return xml2;
        end if;

	--Parseo la Respuesta
	est_conv1	:=trim(replace(json_field(aux1,'1'),'"',''));			
	nivel1		:=split_part(trim(replace(json_field(aux1,'2'),'"','')),'.',1);
	tipo_prest1	:=trim(replace(json_field(aux1,'3'),'"',''));	
	cod_espec1	:=trim(replace(json_field(aux1,'4'),'"',''));	
	cod_prof1	:=trim(replace(json_field(aux1,'5'),'"',''));	
	antiguedad1	:=trim(replace(json_field(aux1,'6'),'"',''));
	xml2:=logapp(xml2,'VIDATRES: RSP_DATOSPREST -> extEstConvenio='||est_conv1||' -extNivel='||nivel1||' -extTipoPrestador='||tipo_prest1||' -extCodEspecialidades='||cod_espec1||' -extCodProfesiones='||cod_prof1||' -extAnosAntiguedad='||antiguedad1);

	if est_conv1 ='null' then est_conv1=''; end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
	xml2:=put_campo(xml2,'EXTESTCONVENIO',est_conv1);
        xml2:=put_campo(xml2,'EXTNIVEL',replace(nivel1,'.0',''));
        xml2:=put_campo(xml2,'EXTTIPOPRESTADOR',replace(tipo_prest1,'.0',''));
        xml2:=put_campo(xml2,'EXTCODESPECIALIDADES',replace(cod_espec1,'.0',''));
        xml2:=put_campo(xml2,'EXTCODPROFESIONES',replace(cod_prof1,'.0',''));
        xml2:=put_campo(xml2,'EXTANOSANTIGUEDAD',replace(antiguedad1,'.0',''));

        return xml2;
end;
$$
LANGUAGE plpgsql;

