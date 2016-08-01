CREATE OR REPLACE FUNCTION bono3.traductor_in_valorizi_banmedica(varchar)
returns varchar as
$$
declare
	extCodFinanciador int;
	extHomNumeroConvenio varchar;
	extHomLugarConvenio varchar;
	extSucVenta varchar;
	extRutConvenio varchar;
	extRutTratante varchar;
	extEspecialidad varchar;
	extRutSolicitante varchar;
	extRutBeneficiario varchar;
	extTratamiento varchar;
	extCodigoDiagnostico varchar;
	extNivelConvenio int;
	extUrgencia varchar;
	extLista1 varchar;
	extLista2 varchar;
	extLista3 varchar;
	extLista4 varchar;
	extLista5 varchar;
	extLista6 varchar;
	extLista7 varchar;
	extNumPrestaciones int;
       	xml1    alias for $1;
        xml2    varchar;
begin
     	xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        extCodFinanciador:=get_campo('EXTCODFINANCIADOR',xml2);
	extHomNumeroConvenio :=get_campo('EXTHOMNUMEROCONVENIO',xml2);
        extHomLugarConvenio :=get_campo('EXTHOMLUGARCONVENIO',xml2);
        extSucVenta :=get_campo('EXTSUCVENTA',xml2);
        extRutConvenio :=get_campo('EXTRUTCONVENIO',xml2);
        extRutTratante :=get_campo('EXTRUTTRATANTE',xml2);
        extEspecialidad :=get_campo('EXTESPECIALIDAD',xml2);
        extRutSolicitante :=get_campo('EXTRUTSOLICITANTE',xml2);
        extRutBeneficiario :=get_campo('EXTRUTBENEFICIARIO',xml2);
        extTratamiento :=get_campo('EXTTRATAMIENTO',xml2);
        extCodigoDiagnostico :=get_campo('EXTCODIGODIAGNOSTICO',xml2);
        extNivelConvenio :=get_campo('EXTNIVELCONVENIO',xml2);
        extUrgencia :=get_campo('EXTURGENCIA',xml2);
        extLista1 :=get_campo('EXTLISTA1',xml2);
        extLista2 :=get_campo('EXTLISTA2',xml2);
        extLista3 :=get_campo('EXTLISTA3',xml2);
        extLista4 :=get_campo('EXTLISTA4',xml2);
        extLista5 :=get_campo('EXTLISTA5',xml2);
        extLista6 :=get_campo('EXTLISTA6',xml2);
        extLista7 :=get_campo('EXTLISTA7',xml2);
	extNumPrestaciones :=get_campo('EXTNUMPRESTACIONES',xml2);
        xml2:=put_campo(xml2,'SQLINPUT','select valorizi('||extCodFinanciador||','||extHomNumeroConvenio||','||extHomLugarConvenio||','||extSucVenta||','||extRutConvenio||','||extRutTratante||','||extEspecialidad||','||extRutSolicitante||','||extRutBeneficiario||','||extTratamiento||','||extCodigoDiagnostico||','||extNivelConvenio||','||extUrgencia||','||extLista1||','||extLista2||','||extLista3||','||extLista4||','||extLista5||','||extLista6||','||extLista7||','||extNumPrestaciones||')');

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_valorizi_banmedica(varchar)
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
