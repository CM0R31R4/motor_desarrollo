CREATE OR REPLACE FUNCTION bono3.traductor_in_envbonis_banmedica(varchar)
returns varchar as
$$
declare
	extCodFinanciador int;
	extHomNumeroConvenio varchar;
	extHomLugarConvenio varchar;
	extSucVenta varchar;
	extRutConvenio varchar;
	extRutAsociado varchar;
	extNomPrestador varchar;
	extRutTratante varchar;
	extEspecialidad varchar;
	extRutBeneficiario varchar;
	extRutCotizante varchar;
	extRutAcompanante varchar;
	extRutEmisor varchar;
	extRutCajero varchar;
	extCodigoDiagnostico varchar;
	extDescuentoxPlanilla varchar;
	extMontoExcedente bigint;
	extFechaEmision varchar;
	extNivelConvenio int;
	extFolioFinanciador bigint;
	extMontoValorTotal bigint;
	extMontoAporteTotal bigint;
	extMontoCopagoTotal bigint;
	extNumOperacion bigint;
	extCorrPrestacion bigint;
	extTipoSolicitud int;
	extFechaInicio varchar;
	extUrgencia varchar;
	extPlan varchar;
	extLista1 varchar;
	extLista2 varchar;
	extLista3 varchar;

       	xml1    aldatosprestias for $1;
        xml2    varchar;
begin
     	xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	extCodFinanciador:=get_campo('EXTCODFINANCIADOR',xml2);
	extHomNumeroConvenio:=get_campo('EXTHOMNUMEROCONVENIO',xml2);
	extHomLugarConvenio:=get_campo('EXTHOMLUGARCONVENIO',xml2);
	extSucVenta:= get_campo('EXTSUCVENTA',xml2);
	extRutConvenio:= get_campo('EXTRUTCONVENIO',xml2);
	extRutAsociado:= get_campo('EXTRUTASOCIADO',xml2);
	extNomPrestador := get_campo('EXTNOMPRESTADOR',xml2);
        extRutTratante := get_campo('EXTRUTTRATANTE',xml2);
        extEspecialidad := get_campo('EXTESPECIALIDAD',xml2);
        extRutBeneficiario := get_campo('EXTRUTBENEFICIARIO',xml2);
        extRutCotizante := get_campo('EXTRUTCOTIZANTE',xml2);
        extRutAcompanante := get_campo('EXTRUTACOMPANANTE',xml2);
        extRutEmisor := get_campo('EXTRUTEMISOR',xml2);
        extRutCajero := get_campo('EXTRUTCAJERO',xml2);
        extCodigoDiagnostico := get_campo('EXTCODIGODIAGNOSTICO',xml2);
        extDescuentoxPlanilla := get_campo('EXTDESCUENTOXPLANILLA',xml2);
        extMontoExcedente := get_campo('EXTMONTOEXCEDENTE',xml2);
        extFechaEmision := get_campo('EXTFECHAEMISION',xml2);
        extNivelConvenio := get_campo('EXTNIVELCONVENIO',xml2);
        extFolioFinanciador := get_campo('EXTFOLIOFINANCIADOR',xml2);
        extMontoValorTotal := get_campo('EXTMONTOVALORTOTAL',xml2);
        extMontoAporteTotal := get_campo('EXTMONTOAPORTETOTAL',xml2);
        extMontoCopagoTotal := get_campo('EXTMONTOCOPAGOTOTAL',xml2);
        extNumOperacion := get_campo('EXTNUMOPERACION',xml2);
        extCorrPrestacion := get_campo('EXTCORRPRESTACION',xml2);
        extTipoSolicitud := get_campo('EXTTIPOSOLICITUD',xml2);
        extFechaInicio := get_campo('EXTFECHAINICIO',xml2);
        extUrgencia := get_campo('EXTURGENCIA',xml2);
        extPlan := get_campo('EXTPLAN',xml2);
        extLista1 := get_campo('EXTLISTA1',xml2);
        extLista2 := get_campo('EXTLISTA2',xml2);
        extLista3 := get_campo('EXTLISTA3',xml2);

        xml2:=put_campo(xml2,'SQLINPUT','select envbonis('||extCodFinanciador||','||extHomNumeroConvenio||','||extHomLugarConvenio||','||extSucVenta||','||extRutConvenio||','||extRutAsociado:||','||extNomPrestador||','||extRutTratante||','||extEspecialidad||','||extRutBeneficiario||','||extRutCotizante||','||extRutAcompanante||','||extRutEmisor||','||extRutCajero||','||extCodigoDiagnostico||','||extDescuentoxPlanilla||','||extMontoExcedente||','||extFechaEmision||','||extNivelConvenio||','||extFolioFinanciador||','||extMontoValorTotal||','||extMontoAporteTotal||','||extMontoCopagoTotal||','||extNumOperacion||','||extCorrPrestacion||','||extTipoSolicitud||','||extFechaInicio||','||extUrgencia||','||extPlan||','||extLista1||','||extLista2||','||extLista3||')');

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_envbonis_banmedica   (varchar)
returns varchar as
$$
declare
       	xml1    alias for $1;
        xml2    varchar;
begin
     	xml2:=xml1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('NAME',xml2));

        return xml2;
end;
$$
LANGUAGE plpgsql;
