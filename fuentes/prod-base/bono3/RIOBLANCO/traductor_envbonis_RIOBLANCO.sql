CREATE OR REPLACE FUNCTION traductor_in_envbonis_rioblanco(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

        extCodFinanciador       varchar;
        extHomNumeroConvenio    varchar;
        extHomLugarConvenio     varchar;
        extSucVenta             varchar;
        rut_conv1          varchar;
        rut_asoc1          varchar;
        extNomPrestador         varchar;
        rut_tratante1          varchar;
        extEspecialidad         varchar;
        rut_benef1      varchar;
        rut_cotiza1         varchar;
        rut_acomp1       varchar;
        rut_emisor1            varchar;
        rut_cajero1            varchar;
        extCodigoDiagnostico    varchar;
        extDescuentoxPlanilla   varchar;
        extMontoExcedente       varchar;
        extFechaEmision         varchar;
        extNivelConvenio        varchar;
        extFolioFinanciador     varchar;
        extMontoValorTotal      varchar;
        extMontoAporteTotal     varchar;
        extMontoCopagoTotal     varchar;
        extNumOperacion         varchar;
        extCorrPrestacion       varchar;
        extTipoSolicitud        varchar;
        extFechaInicio          varchar;
        extUrgencia             varchar;
        extPlan                 varchar;
        extLista1               varchar;
        extLista2               varchar;
        extLista3               varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	extCodFinanciador       := trim(get_campo('EXTCODFINANCIADOR',xml2));
        extHomNumeroConvenio    := get_campo('EXTHOMNUMEROCONVENIO',xml2);
        extHomLugarConvenio     := get_campo('EXTHOMLUGARCONVENIO',xml2);
        extSucVenta             := get_campo('EXTSUCVENTA',xml2);
        rut_conv1          	:= get_campo('EXTRUTCONVENIO',xml2);
        rut_asoc1          	:= get_campo('EXTRUTASOCIADO',xml2);
        extNomPrestador         := elimina_tildes(convert_escape(get_campo('EXTNOMPRESTADOR',xml2)));
        rut_tratante1          	:= get_campo('EXTRUTTRATANTE',xml2);
        extEspecialidad         := get_campo('EXTESPECIALIDAD',xml2);
        rut_benef1     		:= get_campo('EXTRUTBENEFICIARIO',xml2);
        rut_cotiza1        	:= get_campo('EXTRUTCOTIZANTE',xml2);
        rut_acomp1       	:= get_campo('EXTRUTACOMPANANTE',xml2);
        rut_emisor1            	:= get_campo('EXTRUTEMISOR',xml2);
        rut_cajero1            	:= get_campo('EXTRUTCAJERO',xml2);
        extCodigoDiagnostico    := get_campo('EXTCODIGODIAGNOSTICO',xml2);
        extDescuentoxPlanilla   := get_campo('EXTDESCUENTOXPLANILLA',xml2);
        extMontoExcedente       := get_campo('EXTMONTOEXCEDENTE',xml2);
        extFechaEmision         := to_char(get_campo('EXTFECHAEMISION',xml2)::date, 'YYYY/MM/DD');
        --extFechaEmision         := to_char(get_campo('EXTFECHAEMISION',xml2)::date, 'DD-MON-YYYY');
        extNivelConvenio        := get_campo('EXTNIVELCONVENIO',xml2);
        extFolioFinanciador     := get_campo('EXTFOLIOFINANCIADOR',xml2);
        extMontoValorTotal      := get_campo('EXTMONTOVALORTOTAL',xml2);
        extMontoAporteTotal     := get_campo('EXTMONTOAPORTETOTAL',xml2);
        extMontoCopagoTotal     := get_campo('EXTMONTOCOPAGOTOTAL',xml2);
        extNumOperacion         := get_campo('EXTNUMOPERACION',xml2);
        extCorrPrestacion       := get_campo('EXTCORRPRESTACION',xml2);
        extTipoSolicitud        := get_campo('EXTTIPOSOLICITUD',xml2);
        extFechaInicio          := to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'YYYY/MM/DD');
        --extFechaInicio          := to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'DD-MON-YYYY');
        extUrgencia             := get_campo('EXTURGENCIA',xml2);
        extPlan                 := get_campo('EXTPLAN',xml2);
        extLista1               := get_campo('EXTLISTA1',xml2);
        extLista2               := get_campo('EXTLISTA2',xml2);
        extLista3               := get_campo('EXTLISTA3',xml2);

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
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

        xml2:=put_campo(xml2,'SQLINPUT','["ADMIMED.RBLENVBONIS_PKG.RBLENVBONIS", ["$o$STRING", '||extCodFinanciador||', '||chr(34)||extHomNumeroConvenio||chr(34)||', '||chr(34)||extHomLugarConvenio||chr(34)||', '||chr(34)||extSucVenta||chr(34)||', '||chr(34)||rut_conv1||chr(34)||', '||chr(34)||rut_asoc1||chr(34)||', '||chr(34)||extNomPrestador||chr(34)||', '||chr(34)||rut_tratante1||chr(34)||', '||chr(34)||extEspecialidad||chr(34)||', '||chr(34)||rut_benef1||chr(34)||', '||chr(34)||rut_cotiza1||chr(34)||', '||chr(34)||rut_acomp1||chr(34)||', '||chr(34)||rut_emisor1||chr(34)||', '||chr(34)||rut_cajero1||chr(34)||', '||chr(34)||extCodigoDiagnostico||chr(34)||', '||chr(34)||extDescuentoxPlanilla||chr(34)||', '||extMontoExcedente||', '||chr(34)||extFechaEmision||chr(34)||', '||extNivelConvenio||', '||extFolioFinanciador||', '||extMontoValorTotal||', '||extMontoAporteTotal||', '||extMontoCopagoTotal||', '||extNumOperacion||', '||extCorrPrestacion||', '||extTipoSolicitud||', '||chr(34)||extFechaInicio||chr(34)||', '||chr(34)||extUrgencia||chr(34)||', '||chr(34)||extPlan||chr(34)||', '||chr(34)||extLista1||chr(34)||', '||chr(34)||extLista2||chr(34)||', '||chr(34)||extLista3||chr(34)||', "$o$STRING", "$o$STRING"]]'||chr(10)||chr(10));

        return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION traductor_out_envbonis_rioblanco(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;

	cod_resp1       varchar;
        mensaje_resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        resp1:=replace(get_campo('SQLOUTPUT',xml2),chr(10),'');
        aux1:=json_field(resp1,'result');

        if aux1 is null then
                aux1:=json_field(resp1,'ora-msg');
                if aux1 is not null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
			xml2:=put_campo(xml2,'ERRORMSG','RioBlanco:Error_EnvBonIs');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
		return xml2;
        end if;

	--Parseo la Respuesta
        cod_resp1       :=trim(replace(json_field(aux1,'1'),'"',''));
        mensaje_resp1   :=trim(replace(json_field(aux1,'2'),'"',''));
        xml2:=logapp(xml2,'RIOBLANCO: RSP_ENVBONIS -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1);

        if mensaje_resp1='null' then mensaje_resp1=''; end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
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

