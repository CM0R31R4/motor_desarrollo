CREATE OR REPLACE FUNCTION bono3.traductor_in_datosprest_consalud(varchar)
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
        rut_conv1	:=split_part(ltrim(get_campo('EXTRUTCONVENIO',xml2),'0'),'-',1);
	cod_sucur1	:=coalesce(nullif(get_campo('EXTCODIGOSUCUR',xml2),''),'0');
        
	--Rut con formato
        if length(rut_conv1)>'0' then rut_conv1:=lpad(rut_conv1,10,'0')||'-'||motor_modulo11(rut_conv1);end if;
        xml2    :=put_campo(xml2,'RUT_BASE',rut_conv1);
	--"IMEDSOF.CONBENCERTIF_PKG.CONBENCERTIF"

	xml2:=put_campo(xml2,'INPUT','["IMEDSOF.CONDATOSPREST_PKG.CONDATOSPREST", [ "$o$STRING", '||cod_fin1||','||chr(34)||rut_conv1||chr(34)||','||chr(34)||cod_sucur1||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING" ]]'||chr(10)||chr(10));	
	
	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_datosprest_consalud(varchar)
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
	resp1:=replace(get_campo('RESPUESTA',xml2),chr(10),'');

	--Si no esta el tag result es porque hay error
        aux1:=json_field(resp1,'result');
        if aux1 is null then
                --Vemos si hay error del ORACLE
                aux1:=json_field(resp1,'ora-msg');
                if aux1 is null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                --Otro Error
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG','Error Generico');
                end if;
                return xml2;
        end if;

	--Parseo la Respuesta
	est_conv1	:=trim(replace(json_field(aux1,'1'),'"',''));			
	nivel1		:=trim(replace(json_field(aux1,'2'),'"',''));
	tipo_prest1	:=trim(replace(json_field(aux1,'3'),'"',''));	
	cod_espec1	:=trim(replace(json_field(aux1,'4'),'"',''));	
	cod_prof1	:=trim(replace(json_field(aux1,'5'),'"',''));	
	antiguedad1	:=trim(replace(json_field(aux1,'6'),'"',''));
	raise notice 'JCC_DATOSPREST_Receive extCodError=% - extMensajeError=%',est_conv1,nivel1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
	xml2:=put_campo(xml2,'EXTESTCONVENIO',est_conv1);
        xml2:=put_campo(xml2,'EXTNIVEL',nivel1);
        xml2:=put_campo(xml2,'EXTTIPOPRESTADOR',tipo_prest1);
        xml2:=put_campo(xml2,'EXTCODESPECIALIDADES',cod_espec1);
        xml2:=put_campo(xml2,'EXTCODPROFESIONES',cod_prof1);
        xml2:=put_campo(xml2,'EXTANOSANTIGUEDAD',antiguedad1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

