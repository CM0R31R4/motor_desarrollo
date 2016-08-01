CREATE OR REPLACE FUNCTION bono3.traductor_in_envbonis_rioblanco(varchar)
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
        extHomNumeroConvenio    := coalesce(nullif(get_campo('EXTHOMNUMEROCONVENIO',xml2),''),'0');
        extHomLugarConvenio     := coalesce(nullif(get_campo('EXTHOMLUGARCONVENIO',xml2),''),'0');
        extSucVenta             := coalesce(nullif(get_campo('EXTSUCVENTA',xml2),''),'0');
        rut_conv1          := split_part(ltrim(get_campo('EXTRUTCONVENIO',xml2),'0'),'-',1);
        rut_asoc1          := split_part(ltrim(get_campo('EXTRUTASOCIADO',xml2),'0'),'-',1);
        extNomPrestador         := coalesce(nullif(get_campo('EXTNOMPRESTADOR',xml2),''),'0');
        rut_tratante1          := split_part(ltrim(get_campo('EXTRUTTRATANTE',xml2),'0'),'-',1);
        extEspecialidad         := coalesce(nullif(get_campo('EXTESPECIALIDAD',xml2),''),'0');
        rut_benef1      := split_part(ltrim(get_campo('EXTRUTBENEFICIARIO',xml2),'0'),'-',1);
        rut_cotiza1         := split_part(ltrim(get_campo('EXTRUTCOTIZANTE',xml2),'0'),'-',1);
        rut_acomp1       := split_part(ltrim(get_campo('EXTRUTACOMPANANTE',xml2),'0'),'-',1);
        rut_emisor1            := split_part(ltrim(get_campo('EXTRUTEMISOR',xml2),'0'),'-',1);
        rut_cajero1            := split_part(ltrim(get_campo('EXTRUTCAJERO',xml2),'0'),'-',1);
        extCodigoDiagnostico    := coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0');
        extDescuentoxPlanilla   := coalesce(nullif(get_campo('EXTDESCUENTOXPLANILLA',xml2),''),'0');
        extMontoExcedente       := coalesce(nullif(get_campo('EXTMONTOEXCEDENTE',xml2),''),'0');
        extFechaEmision         := to_char(get_campo('EXTFECHAEMISION',xml2)::date, 'DD-MON-YYYY');
        extNivelConvenio        := coalesce(nullif(get_campo('EXTNIVELCONVENIO',xml2),''),'0');
        extFolioFinanciador     := coalesce(nullif(get_campo('EXTFOLIOFINANCIADOR',xml2),''),'0');
        extMontoValorTotal      := coalesce(nullif(get_campo('EXTMONTOVALORTOTAL',xml2),''),'0');
        extMontoAporteTotal     := coalesce(nullif(get_campo('EXTMONTOAPORTETOTAL',xml2),''),'0');
        extMontoCopagoTotal     := coalesce(nullif(get_campo('EXTMONTOCOPAGOTOTAL',xml2),''),'0');
        extNumOperacion         := coalesce(nullif(get_campo('EXTNUMOPERACION',xml2),''),'0');
        extCorrPrestacion       := coalesce(nullif(get_campo('EXTCORRPRESTACION',xml2),''),'0');
        extTipoSolicitud        := coalesce(nullif(get_campo('EXTTIPOSOLICITUD',xml2),''),'0');
        extFechaInicio          := to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'DD-MON-YYYY');
        extUrgencia             := coalesce(nullif(get_campo('EXTURGENCIA',xml2),''),'0');
        extPlan                 := coalesce(nullif(get_campo('EXTPLAN',xml2),''),'0');
        extLista1               := coalesce(nullif(get_campo('EXTLISTA1',xml2),''),'0');
        extLista2               := coalesce(nullif(get_campo('EXTLISTA2',xml2),''),'0');
        extLista3               := coalesce(nullif(get_campo('EXTLISTA3',xml2),''),'0');

        --Rut con formato
	if length(rut_conv1)>'0' then rut_conv1       :=lpad(rut_conv1,10,'0')||'-'||motor_modulo11(rut_conv1);end if;
        if length(rut_asoc1)>'0' then rut_asoc1       :=lpad(rut_asoc1,10,'0')||'-'||motor_modulo11(rut_asoc1);end if;
        if length(rut_tratante1)>'0' then rut_tratante1   :=lpad(rut_tratante1,10,'0')||'-'||motor_modulo11(rut_tratante1);end if;
        if length(rut_benef1)>'0' then rut_benef1      :=lpad(rut_benef1,10,'0')||'-'||motor_modulo11(rut_benef1);end if;
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);
        if length(rut_cotiza1)>'0' then rut_cotiza1     :=lpad(rut_cotiza1,10,'0')||'-'||motor_modulo11(rut_cotiza1);end if;
        if length(rut_acomp1)>'0' then rut_acomp1      :=lpad(rut_acomp1,10,'0')||'-'||motor_modulo11(rut_acomp1);end if;
        if length(rut_emisor1)>'0' then rut_emisor1     :=lpad(rut_emisor1,10,'0')||'-'||motor_modulo11(rut_emisor1);end if;
        if length(rut_cajero1)>'0' then rut_cajero1     :=lpad(rut_cajero1,10,'0')||'-'||motor_modulo11(rut_cajero1);end if;	

        xml2:=put_campo(xml2,'INPUT','["IRB_ADMIMED.RBLENVBONIS_PKG.RBLENVBONIS", ["$o$STRING", '||extCodFinanciador||', '||chr(34)||extHomNumeroConvenio||chr(34)||', '||chr(34)||extHomLugarConvenio||chr(34)||', '||chr(34)||extSucVenta||chr(34)||', '||chr(34)||rut_conv1||chr(34)||', '||chr(34)||rut_asoc1||chr(34)||', '||chr(34)||extNomPrestador||chr(34)||', '||chr(34)||rut_tratante1||chr(34)||', '||chr(34)||extEspecialidad||chr(34)||', '||chr(34)||rut_benef1||chr(34)||', '||chr(34)||rut_cotiza1||chr(34)||', '||chr(34)||rut_acomp1||chr(34)||', '||chr(34)||rut_emisor1||chr(34)||', '||chr(34)||rut_cajero1||chr(34)||', '||chr(34)||extCodigoDiagnostico||chr(34)||', '||chr(34)||extDescuentoxPlanilla||chr(34)||', '||extMontoExcedente||', '||chr(34)||extFechaEmision||chr(34)||', '||extNivelConvenio||', '||extFolioFinanciador||', '||extMontoValorTotal||', '||extMontoAporteTotal||', '||extMontoCopagoTotal||', '||extNumOperacion||', '||extCorrPrestacion||', '||extTipoSolicitud||', '||chr(34)||extFechaInicio||chr(34)||', '||chr(34)||extUrgencia||chr(34)||', '||chr(34)||extPlan||chr(34)||', '||chr(34)||extLista1||chr(34)||', '||chr(34)||extLista2||chr(34)||', '||chr(34)||extLista3||chr(34)||', "$o$STRING", "$o$STRING"]]'||chr(10)||chr(10));

        return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION bono3.traductor_out_envbonis_rioblanco(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        resp1:=replace(get_campo('RESPUESTA',xml2),chr(10),'');
        aux1:=json_field(resp1,'result');

        if aux1 is null then
                aux1:=json_field(resp1,'ora-msg');
                if aux1 is null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG','Error Generico');
                end if;
                return xml2;
        end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',        trim(replace(json_field(aux1,'0'),'"','')));
        xml2:=put_campo(xml2,'EXTCODERROR',     trim(replace(json_field(aux1,'1'),'"','')));
        xml2:=put_campo(xml2,'EXTMENSAJEERROR', trim(replace(json_field(aux1,'2'),'"','')));
	return xml2;
end;
$$
LANGUAGE plpgsql;

