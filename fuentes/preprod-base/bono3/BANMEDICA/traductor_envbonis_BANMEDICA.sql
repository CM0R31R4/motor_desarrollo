CREATE OR REPLACE FUNCTION traductor_in_envbonis_banmedica(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	cod_fin1 	varchar;
	num_conv1	varchar;
	lugar_conv1	varchar;
	suc_venta1	varchar;
	rut_conv1	varchar;
	rut_asoc1	varchar;
	nom_prest1	varchar;
	rut_tratante1	varchar;
	especialidad1	varchar;
	rut_benef1	varchar;
	rut_cotiza1	varchar;
	rut_acomp1	varchar;
	rut_emisor1	varchar;
	rut_cajero1	varchar;
	cod_diag1	varchar;
	dscto_planilla1	varchar;
	monto_exec1	varchar;
	fecha_emision1	varchar;
	nivel_conv1	varchar;
	folio_financ1	varchar;
	monto_valor1	varchar;
	monto_aporte1	varchar;
	monto_copago1	varchar;
	num_opera1	varchar;
	corr_presta1	varchar;
	tipo_solic1	varchar;
	fecha_inicio1	varchar;
	urgencia1	varchar;	
	plan1		varchar;	
	lista1		varchar;
	lista2		varchar;
	lista3		varchar;

/*
 @extCodFinanciador              int
    , @extHomNumeroConvenio           char(15)
    , @extHomLugarConvenio            char(10)
    , @extSucVenta                    char(10)
    , @extRutConvenio                 char(12)
    , @extRutAsociado                 char(12)
    , @extNomPrestador                char(40)
    , @extRutTratante                 char(12)
    , @extEspecialidad                char(10)
    , @extRutBeneficiario             char(12)
    , @extRutCotizante                char(12)
    , @extRutAcompanante              char(12)
    , @extRutEmisor                   char(12)
    , @extRutCajero                   char(12)
    , @extCodigoDiagnostico           char(10)
    , @extDescuentoxPlanilla          char(1)
    , @extMontoExcedente              numeric(10,0)
    , @extFechaEmision                datetime
    , @extNivelConvenio               tinyint
    , @extFolioFinanciador            numeric(10,0)
    , @extMontoValorTotal             numeric(10,0)
    , @extMontoAporteTotal            numeric(10,0)
    , @extMontoCopagoTotal            numeric(10,0)
    , @extNumOperacion                numeric(10,0)
    , @extCorrPrestacion              numeric(10,0)
    , @extTipoSolicitud               tinyint
    , @extFechaInicio                 datetime
    , @extUrgencia                    char(1)
    , @extPlan                        char(15)
    , @extLista1                      char(255)
    , @extLista2                      char(255)
    , @extLista3                      char(255)
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
	
	cod_fin1	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
        num_conv1	:= get_campo('EXTHOMNUMEROCONVENIO',xml2);
        lugar_conv1	:= get_campo('EXTHOMLUGARCONVENIO',xml2);
        suc_venta1	:= get_campo('EXTSUCVENTA',xml2);
        rut_conv1	:= get_campo('EXTRUTCONVENIO',xml2);
        rut_asoc1	:= get_campo('EXTRUTASOCIADO',xml2);
        nom_prest1	:= elimina_tildes(convert_escape(get_campo('EXTNOMPRESTADOR',xml2)));
        rut_tratante1	:= get_campo('EXTRUTTRATANTE',xml2);
        especialidad1	:= get_campo('EXTESPECIALIDAD',xml2);
        rut_benef1	:= get_campo('EXTRUTBENEFICIARIO',xml2);
        rut_cotiza1	:= get_campo('EXTRUTCOTIZANTE',xml2);
        rut_acomp1	:= get_campo('EXTRUTACOMPANANTE',xml2);
        rut_emisor1	:= get_campo('EXTRUTEMISOR',xml2);
        rut_cajero1	:= get_campo('EXTRUTCAJERO',xml2);
        cod_diag1	:= get_campo('EXTCODIGODIAGNOSTICO',xml2);
        dscto_planilla1	:= get_campo('EXTDESCUENTOXPLANILLA',xml2);
        monto_exec1	:= get_campo('EXTMONTOEXCEDENTE',xml2);
        fecha_emision1	:= to_char(get_campo('EXTFECHAEMISION',xml2)::date, 'DD-MON-YYYY');
        nivel_conv1	:= get_campo('EXTNIVELCONVENIO',xml2);
        folio_financ1	:= get_campo('EXTFOLIOFINANCIADOR',xml2);
        monto_valor1	:= get_campo('EXTMONTOVALORTOTAL',xml2);
        monto_aporte1	:= get_campo('EXTMONTOAPORTETOTAL',xml2);
        monto_copago1	:= get_campo('EXTMONTOCOPAGOTOTAL',xml2);
        num_opera1	:= get_campo('EXTNUMOPERACION',xml2);
        corr_presta1	:= get_campo('EXTCORRPRESTACION',xml2);
        tipo_solic1	:= get_campo('EXTTIPOSOLICITUD',xml2);
        fecha_inicio1	:= to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'DD-MON-YYYY');
        urgencia1	:= get_campo('EXTURGENCIA',xml2);
        plan1		:= get_campo('EXTPLAN',xml2);
        lista1		:= get_campo('EXTLISTA1',xml2);
        lista2		:= get_campo('EXTLISTA2',xml2);
        lista3	        := get_campo('EXTLISTA3',xml2);

	 --Valida formato del Rut
        /*rut_conv1       :=motor_formato_rut(rut_conv1);
        rut_asoc1       :=motor_formato_rut(rut_asoc1);
        rut_tratante1   :=motor_formato_rut(rut_tratante1);
        rut_benef1      :=motor_formato_rut(rut_benef1);
        rut_cotiza1     :=motor_formato_rut(rut_cotiza1);
        rut_acomp1      :=motor_formato_rut(rut_acomp1);
        rut_emisor1     :=motor_formato_rut(rut_emisor1);
        rut_cajero1     :=motor_formato_rut(rut_cajero1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_conv1='')       or (rut_asoc1='')       or
           (rut_tratante1='')   or (rut_benef1='')      or
           (rut_cotiza1='')     or (rut_acomp1='')      or
           (rut_emisor1='')     or (rut_cajero1='')      then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
	/*
	rut_conv1	:=split_part(rut_conv1,'-',1);
	rut_asoc1	:=split_part(rut_asoc1,'-',1);
	rut_tratante1	:=split_part(rut_tratante1,'-',1);
	rut_benef1	:=split_part(rut_benef1,'-',1);
	rut_cotiza1	:=split_part(rut_cotiza1,'-',1);
	rut_acomp1	:=split_part(rut_acomp1,'-',1);
	rut_emisor1	:=split_part(rut_emisor1,'-',1);
	rut_cajero1	:=split_part(rut_cajero1,'-',1);
	*/
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	xml2:=put_campo(xml2,'SQLINPUT','["INFOMEDICA.BANENVBONIS_PKG.BANENVBONIS", [ "$o$STRING", '||cod_fin1||','||chr(34)||num_conv1||chr(34)||','||chr(34)||lugar_conv1||chr(34)||','||chr(34)||suc_venta1||chr(34)||','||chr(34)||rut_conv1||chr(34)||','||chr(34)||rut_asoc1||chr(34)||','||chr(34)||nom_prest1||chr(34)||','||chr(34)||rut_tratante1||chr(34)||','||chr(34)||especialidad1||chr(34)||','||chr(34)||rut_benef1||chr(34)||','||chr(34)||rut_cotiza1||chr(34)||','||chr(34)||rut_acomp1||chr(34)||','||chr(34)||rut_emisor1||chr(34)||','||chr(34)||rut_cajero1||chr(34)||','||chr(34)||cod_diag1||chr(34)||','||chr(34)||dscto_planilla1||chr(34)||','||monto_exec1||','||chr(34)||fecha_emision1||chr(34)||','||nivel_conv1||','||folio_financ1||','||monto_valor1||','||monto_aporte1||','||monto_copago1||','||num_opera1||','||corr_presta1||','||tipo_solic1||','||chr(34)||fecha_inicio1||chr(34)||','||chr(34)||urgencia1||chr(34)||','||chr(34)||plan1||chr(34)||','||chr(34)||lista1||chr(34)||','||chr(34)||lista2||chr(34)||','||chr(34)||lista3||chr(34)||', "$o$STRING", "$o$STRING"]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_envbonis_banmedica(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	aux1            varchar;
        resp1           varchar;
	
	cod_resp1       varchar;
        mensaje_resp1   varchar;	

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
			xml2:=put_campo(xml2,'ERRORMSG','Banmedica:Error_EnvBonIs');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
                return xml2;
        end if;
	
	--Parseo la Respuesta
        cod_resp1	:=trim(replace(json_field(aux1,'1'),'"',''));
        mensaje_resp1	:=trim(replace(json_field(aux1,'2'),'"',''));
	xml2:=logapp(xml2,'BANMEDICA: RSP_ENVBONIS -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1);

	if mensaje_resp1='null' then mensaje_resp1=''; end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
		--mensaje_resp1:=replace(json_field(aux1,'0'),'"','');
        end if;
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
