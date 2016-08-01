CREATE OR REPLACE FUNCTION traductor_in_valorvari_fundacion(varchar)
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
	extLista7		varchar;
	extNumPrestaciones	varchar;
	l_array	varchar;
begin
        xml2:=xml1;
	l_array:=40;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	--Setea Timeout de la base de datos
        xml2    :=put_campo(xml2,'__TIMEOUT_SERV_PXML__','81');

	extCodFinanciador       := trim(get_campo('EXTCODFINANCIADOR',xml2));
        extHomNumeroConvenio    := get_campo('EXTHOMNUMEROCONVENIO',xml2);
        extHomLugarConvenio     := get_campo('EXTHOMLUGARCONVENIO',xml2);
        extSucVenta             := get_campo('EXTSUCVENTA',xml2);
        rut_conv1          	:= get_campo('EXTRUTCONVENIO',xml2);
        rut_tratante1          	:= get_campo('EXTRUTTRATANTE',xml2);
        extEspecialidad         := get_campo('EXTESPECIALIDAD',xml2);
        rut_solic1       	:= get_campo('EXTRUTSOLICITANTE',xml2);
        rut_benef1      	:= get_campo('EXTRUTBENEFICIARIO',xml2);
        extTratamiento          := get_campo('EXTTRATAMIENTO',xml2);
        extCodigoDiagnostico    := get_campo('EXTCODIGODIAGNOSTICO',xml2);
        extNivelConvenio        := get_campo('EXTNIVELCONVENIO',xml2);
        extUrgencia             := get_campo('EXTURGENCIA',xml2);
        extLista1               := get_campo('EXTLISTA1',xml2);
        extLista2               := get_campo('EXTLISTA2',xml2);
        extLista3               := get_campo('EXTLISTA3',xml2);
        extLista4               := get_campo('EXTLISTA4',xml2);
        extLista5               := get_campo('EXTLISTA5',xml2);
        extLista6               := get_campo('EXTLISTA6',xml2);
        extLista7               := get_campo('EXTLISTA7',xml2);
        extNumPrestaciones      := get_campo('EXTNUMPRESTACIONES',xml2);

	 --Valida formato del Rut
        /*rut_conv1       :=motor_formato_rut(rut_conv1);
        rut_tratante1   :=motor_formato_rut(rut_tratante1);
        rut_solic1      :=motor_formato_rut(rut_solic1);
        rut_benef1      :=motor_formato_rut(rut_benef1);

        --Si no corresponde al formato, retorna error al flujo. No llama a la Api.
        if (rut_conv1='')       or (rut_tratante1='')    or
           (rut_solic1='')      or (rut_benef1='')       then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	xml2:=put_campo(xml2,'SQLINPUT','["ADMIMED.FNDVALORVARI_PKG.FNDVALORVARI", [ "$o$STRING", '||extCodFinanciador||', '||chr(34)||extHomNumeroConvenio||chr(34)||', '||chr(34)||extHomLugarConvenio||chr(34)||', '||chr(34)||extSucVenta||chr(34)||', '||chr(34)||rut_conv1||chr(34)||', '||chr(34)||rut_tratante1||chr(34)||', '||chr(34)||extEspecialidad||chr(34)||', '||chr(34)||rut_solic1||chr(34)||', '||chr(34)||rut_benef1||chr(34)||', '||chr(34)||extTratamiento||chr(34)||', '||chr(34)||extCodigoDiagnostico||chr(34)||', '||chr(34)||extNivelConvenio||chr(34)||', '||chr(34)||extUrgencia||chr(34)||', '||chr(34)||extLista1||chr(34)||', '||chr(34)||extLista2||chr(34)||', '||chr(34)||extLista3||chr(34)||', '||chr(34)||extLista4||chr(34)||', '||chr(34)||extLista5||chr(34)||', '||chr(34)||extLista6||chr(34)||','||chr(34)||extLista7||chr(34)||', '||chr(34)||extNumPrestaciones||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$STRING['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']", "$o$NUMBER['||l_array||']" ]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION traductor_out_valorvari_fundacion(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;

	cod_resp1       varchar;
        mensaje_resp1   varchar;
        plan_resp1      varchar;
        glosa1          varchar;
        glosa2          varchar;
        glosa3          varchar;
        glosa4          varchar;
        glosa5          varchar;

        /*Datos que no siempre podrian venir en la respuesta del financiador*/
        valor_prest1    varchar;
        aporte_fin1     varchar;
        copago1         varchar;
        interno_isa1    varchar;        --Interno Isapre
        tipo_bonif1     varchar;
        ext_copago1     varchar;
        tipo_bonif2     varchar;
        ext_copago2     varchar;
        tipo_bonif3     varchar;
        ext_copago3     varchar;
        tipo_bonif4     varchar;
        ext_copago4     varchar;
        tipo_bonif5     varchar;
        ext_copago5     varchar;
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
			xml2:=put_campo(xml2,'ERRORMSG','Fundacion:Error_ValorVari');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');	
		return xml2;
        end if;

	 --Parseo la Respuesta
        cod_resp1       :=trim(replace(json_field(aux1,'1'),'"',''));
        mensaje_resp1   :=trim(replace(json_field(aux1,'2'),'"',''));
        plan_resp1      :=trim(replace(json_field(aux1,'3'),'"',''));
        glosa1          :=trim(replace(json_field(aux1,'4'),'"',''));
        glosa2          :=trim(replace(json_field(aux1,'5'),'"',''));
        glosa3          :=trim(replace(json_field(aux1,'6'),'"',''));
        glosa4          :=trim(replace(json_field(aux1,'7'),'"',''));
        glosa5          :=trim(replace(json_field(aux1,'8'),'"',''));

        valor_prest1    :=replace(replace(trim(replace(json_field(aux1,'9'),'"','')),'.0',''),', ',',');
        aporte_fin1     :=replace(replace(trim(replace(json_field(aux1,'10'),'"','')),'.0',''),', ',',');
        copago1         :=replace(replace(trim(replace(json_field(aux1,'11'),'"','')),'.0',''),', ',',');
        interno_isa1    :=replace(replace(trim(replace(json_field(aux1,'12'),'"','')),'.0',''),', ',',');
        tipo_bonif1     :=replace(replace(trim(replace(json_field(aux1,'13'),'"','')),'.0',''),', ',',');
        ext_copago1     :=replace(replace(trim(replace(json_field(aux1,'14'),'"','')),'.0',''),', ',',');
        tipo_bonif2     :=replace(replace(trim(replace(json_field(aux1,'15'),'"','')),'.0',''),', ',',');
        ext_copago2     :=replace(replace(trim(replace(json_field(aux1,'16'),'"','')),'.0',''),', ',',');
        tipo_bonif3     :=replace(replace(trim(replace(json_field(aux1,'17'),'"','')),'.0',''),', ',',');
        ext_copago3     :=replace(replace(trim(replace(json_field(aux1,'18'),'"','')),'.0',''),', ',',');
        tipo_bonif4     :=replace(replace(trim(replace(json_field(aux1,'19'),'"','')),'.0',''),', ',',');
        ext_copago4     :=replace(replace(trim(replace(json_field(aux1,'20'),'"','')),'.0',''),', ',',');
        tipo_bonif5     :=replace(replace(trim(replace(json_field(aux1,'21'),'"','')),'.0',''),', ',',');
        ext_copago5     :=replace(replace(trim(replace(json_field(aux1,'22'),'"','')),'.0',''),', ',',');

        xml2:=logapp(xml2,'FUNDACION: RSP_VALORVARI -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1||' -extPlan='||plan_resp1||' -extGlosa1='||glosa1||' -extGlosa2='||glosa2||' -extGlosa3='||glosa3||' -extGlosa4='||glosa4||' -extGlosa5='||glosa5||' -extValorPrestacion='||valor_prest1||' -extAporteFinanciador='||aporte_fin1||' -extCopago='||copago1||' -extInternoIsa='||interno_isa1||' -extTipoBonif1='||tipo_bonif1||' -extCopago1='||ext_copago1||' -extTipoBonif2='||tipo_bonif2||' -extCopago2='||ext_copago2||'-extTipoBonif3='||tipo_bonif3||' -extCopago3='||ext_copago3||' -extTipoBonif4='||tipo_bonif4||' -extCopago4='||ext_copago4||' -extTipoBonif5='||tipo_bonif5||' -extCopago5='||ext_copago5);

        if glosa1='null' then glosa1=''; end if;
        if glosa2='null' then glosa2=''; end if;
        if glosa3='null' then glosa3=''; end if;
        if glosa4='null' then glosa4=''; end if;
        if glosa5='null' then glosa5=''; end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
        --Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        xml2:=put_campo(xml2,'EXTPLAN',plan_resp1);
        xml2:=put_campo(xml2,'EXTGLOSA1',glosa1);
        xml2:=put_campo(xml2,'EXTGLOSA2',glosa2);
        xml2:=put_campo(xml2,'EXTGLOSA3',glosa3);
        xml2:=put_campo(xml2,'EXTGLOSA4',glosa4);
        xml2:=put_campo(xml2,'EXTGLOSA5',glosa5);

        xml2:=put_campo(xml2,'EXTVALORPRESTACION',valor_prest1);
        xml2:=put_campo(xml2,'EXTAPORTEFINANCIADOR',aporte_fin1);
        xml2:=put_campo(xml2,'EXTCOPAGO',copago1);
	--Este campo viene como arreglo numerico, se traspasa como arreglo texto
        xml2:=put_campo(xml2,'EXTINTERNOISA',replace(replace(replace(interno_isa1,'[','["'),']','"]'),',','","'));
        xml2:=put_campo(xml2,'EXTTIPOBONIF1',tipo_bonif1);
        xml2:=put_campo(xml2,'EXTCOPAGO1',ext_copago1);
        xml2:=put_campo(xml2,'EXTTIPOBONIF2',tipo_bonif2);
        xml2:=put_campo(xml2,'EXTCOPAGO2',ext_copago2);
        xml2:=put_campo(xml2,'EXTTIPOBONIF3',tipo_bonif3);
        xml2:=put_campo(xml2,'EXTCOPAGO3',ext_copago3);
        xml2:=put_campo(xml2,'EXTTIPOBONIF4',tipo_bonif4);
        xml2:=put_campo(xml2,'EXTCOPAGO4',ext_copago4);
        xml2:=put_campo(xml2,'EXTTIPOBONIF5',tipo_bonif5);
        xml2:=put_campo(xml2,'EXTCOPAGO5',ext_copago5);

        return xml2;
end;
$$
LANGUAGE plpgsql;
