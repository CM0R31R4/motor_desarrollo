CREATE OR REPLACE FUNCTION bono3.traductor_in_valorizi_consalud(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	extCodFinanciador	varchar;
	extHomNumeroConvenio	varchar;
	extHomLugarConvenio	varchar;
	extSucVenta		varchar;
	rut_conv1		varchar;
	rut_tratante1		varchar;
	extEspecialidad		varchar;
	rut_solic1	varchar;
	rut_benef1	varchar;
	extTratamiento		varchar;
	extCodigoDiagnostico	varchar;
	extNivelConvenio	varchar;
	extUrgencia		varchar;
	extLista1		varchar;
	extLista2		varchar;
	extLista3		varchar;
	extLista4		varchar;
	extLista5		varchar;
	extLista6		varchar;
	extNumPrestaciones	varchar;
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
        rut_tratante1          := split_part(ltrim(get_campo('EXTRUTTRATANTE',xml2),'0'),'-',1);
        extEspecialidad         := coalesce(nullif(get_campo('EXTESPECIALIDAD',xml2),''),'0');
        rut_solic1       := split_part(ltrim(get_campo('EXTRUTSOLICITANTE',xml2),'0'),'-',1);
        rut_benef1      := split_part(ltrim(get_campo('EXTRUTBENEFICIARIO',xml2),'0'),'-',1);
        extTratamiento          := coalesce(nullif(get_campo('EXTTRATAMIENTO',xml2),''),'0');
        extCodigoDiagnostico    := coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0');
        extNivelConvenio        := coalesce(nullif(get_campo('EXTNIVELCONVENIO',xml2),''),'0');
        extUrgencia             := coalesce(nullif(get_campo('EXTURGENCIA',xml2),''),'0');
        extLista1               := coalesce(nullif(get_campo('EXTLISTA1',xml2),''),'0');
        extLista2               := coalesce(nullif(get_campo('EXTLISTA2',xml2),''),'0');
        extLista3               := coalesce(nullif(get_campo('EXTLISTA3',xml2),''),'0');
        extLista4               := coalesce(nullif(get_campo('EXTLISTA4',xml2),''),'0');
        extLista5               := coalesce(nullif(get_campo('EXTLISTA5',xml2),''),'0');
        extLista6               := coalesce(nullif(get_campo('EXTLISTA6',xml2),''),'0');
        extNumPrestaciones      := coalesce(nullif(get_campo('EXTNUMPRESTACIONES',xml2),''),'0');

        --Fomato Rut
	if length(rut_conv1)>'0' then rut_conv1		:=lpad(rut_conv1,10,'0')||'-'||motor_modulo11(rut_conv1);end if;
        if length(rut_tratante1)>'0' then rut_tratante1 :=lpad(rut_tratante1,10,'0')||'-'||motor_modulo11(rut_tratante1);end if;
        if length(rut_solic1)>'0' then rut_solic1      	:=lpad(rut_solic1,10,'0')||'-'||motor_modulo11(rut_solic1);end if;
        if length(rut_benef1)>'0' then rut_benef1      	:=lpad(rut_benef1,10,'0')||'-'||motor_modulo11(rut_benef1);end if;
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

        xml2:=put_campo(xml2,'INPUT','["IMEDSOF.CONVALORIZI_PKG.CONVALORIZI", [ "$o$STRING", '||extCodFinanciador||', '||chr(34)||extHomNumeroConvenio||chr(34)||', '||chr(34)||extHomLugarConvenio||chr(34)||', '||chr(34)||extSucVenta||chr(34)||', '||chr(34)||rut_conv1||chr(34)||', '||chr(34)||rut_tratante1||chr(34)||', '||chr(34)||extEspecialidad||chr(34)||', '||chr(34)||rut_solic1||chr(34)||', '||chr(34)||rut_benef1||chr(34)||', '||chr(34)||extTratamiento||chr(34)||', '||chr(34)||extCodigoDiagnostico||chr(34)||', '||chr(34)||extNivelConvenio||chr(34)||', '||chr(34)||extUrgencia||chr(34)||', '||chr(34)||extLista1||chr(34)||', '||chr(34)||extLista2||chr(34)||', '||chr(34)||extLista3||chr(34)||', '||chr(34)||extLista4||chr(34)||', '||chr(34)||extLista5||chr(34)||', '||chr(34)||extLista6||chr(34)||', '||chr(34)||extNumPrestaciones||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$NUMBER", "$o$STRING[10]", "$o$STRING[10]" ]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION bono3.traductor_out_valorizi_consalud(varchar)
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
        xml2:=put_campo(xml2,'EXTPLAN',         trim(replace(json_field(aux1,'3'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSA1',       trim(replace(json_field(aux1,'4'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSA2',       trim(replace(json_field(aux1,'5'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSA3',       trim(replace(json_field(aux1,'6'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSA4',       trim(replace(json_field(aux1,'7'),'"','')));
        xml2:=put_campo(xml2,'EXTGLOSA5',       trim(replace(json_field(aux1,'8'),'"','')));
        xml2:=put_campo(xml2,'EXTVALORPRESTACION',      trim(replace(json_field(aux1,'9'),'"','')));
        xml2:=put_campo(xml2,'EXTAPORTEFINANCIADOR',    trim(replace(json_field(aux1,'10'),'"','')));
        xml2:=put_campo(xml2,'EXTCOPAGO',       trim(replace(json_field(aux1,'11'),'"','')));
        xml2:=put_campo(xml2,'EXTINTERNOISA',   trim(replace(json_field(aux1,'12'),'"','')));
        xml2:=put_campo(xml2,'EXTTIPOBONIF1',   trim(replace(json_field(aux1,'13'),'"','')));
        xml2:=put_campo(xml2,'EXTCOPAGO1',      trim(replace(json_field(aux1,'14'),'"','')));
        xml2:=put_campo(xml2,'EXTTIPOBONIF2',   trim(replace(json_field(aux1,'15'),'"','')));
        xml2:=put_campo(xml2,'EXTCOPAGO2',      trim(replace(json_field(aux1,'16'),'"','')));
        xml2:=put_campo(xml2,'EXTTIPOBONIF3',   trim(replace(json_field(aux1,'17'),'"','')));
        xml2:=put_campo(xml2,'EXTCOPAGO3',      trim(replace(json_field(aux1,'18'),'"','')));
        xml2:=put_campo(xml2,'EXTTIPOBONIF4',   trim(replace(json_field(aux1,'19'),'"','')));
        xml2:=put_campo(xml2,'EXTCOPAGO4',      trim(replace(json_field(aux1,'20'),'"','')));
        xml2:=put_campo(xml2,'EXTTIPOBONIF5',   trim(replace(json_field(aux1,'21'),'"','')));
        xml2:=put_campo(xml2,'EXTCOPAGO5',      trim(replace(json_field(aux1,'22'),'"','')));

	return xml2;
end;
$$
LANGUAGE plpgsql;
