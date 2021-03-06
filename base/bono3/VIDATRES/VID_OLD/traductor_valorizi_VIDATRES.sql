CREATE OR REPLACE FUNCTION bono3.traductor_in_valorizi_vidatres(varchar)
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
	rut_tratante1	varchar;
	especialidad1	varchar;
	rut_solic1	varchar;
	rut_benef1	varchar;
	tratamiento1	varchar;
	cod_diag1	varchar;
	nivel_conv1	varchar;
	urgencia1	varchar;	
	lista1		varchar;
	lista2		varchar;
	lista3		varchar;
	lista4		varchar;
	lista5		varchar;
	lista6		varchar;
	num_prestad1	varchar;

/* 
	extCodFinanciador       IN NUMBER,
        extHomNumeroConvenio    IN VARCHAR2,
        extHomLugarConvenio     IN VARCHAR2,
        extSucVenta             IN VARCHAR2,
        extRutConvenio          IN VARCHAR2,
        extRutTratante          IN VARCHAR2,
        extEspecialidad         IN VARCHAR2,
        extRutSolicitante       IN VARCHAR2,
        extRutBeneficiario      IN VARCHAR2,
        extTratamiento          IN VARCHAR2,    -- N / S
        extCodigoDiagnostico    IN VARCHAR2,
        extNivelConvenio        IN NUMBER,      -- 1,2,3
        extUrgencia             IN VARCHAR2,    -- N / S
        extLista1               IN VARCHAR2,    -- '0000101001|A(2)|B(15)|C|D(2)|'
                                                -- AA: H=Honorario; P=Pabellon; A=Anestesia
                                                -- B : Decodificar factores ?
                                                -- C : Recargo Hora = S o N
                                                -- D : Cantidad
        extLista2               IN VARCHAR2,
        extLista3               IN VARCHAR2,
        extLista4               IN VARCHAR2,
        extLista5               IN VARCHAR2,
        extLista6               IN VARCHAR2,
        extNumPrestaciones      IN NUMBER,
        extCodError             Out VARCHAR2,      -- N->error o S->no hay error
        extMensajeError         Out VARCHAR2,
        extPlan                 Out VARCHAR2,
        extGlosa1               Out VARCHAR2,
        extGlosa2               Out VARCHAR2,
        extGlosa3               Out VARCHAR2,
        extGlosa4               Out VARCHAR2,
        extGlosa5               Out VARCHAR2,
        Col_extValorPrestacion          Out extValorPrestacion_arr
        ,Col_extAporteFinanciador       Out extAporteFinanciador_arr
        ,Col_extCopago                  Out extCopago_arr
        ,Col_extInternoIsa              Out extInternoIsa_arr
        ,Col_extTipoBonif1              Out extTipoBonif1_arr
        ,Col_extCopago1                 Out extCopago1_arr
        ,Col_extTipoBonif2              Out extTipoBonif2_arr
        ,Col_extCopago2                 Out extCopago2_arr
        ,Col_extTipoBonif3              Out extTipoBonif3_arr
        ,Col_extCopago3                 Out extCopago3_arr
        ,Col_extTipoBonif4              Out extTipoBonif4_arr
        ,Col_extCopago4                 Out extCopago4_arr
        ,Col_extTipoBonif5              Out extTipoBonif5_arr
        ,Col_extCopago5                 Out extCopago5_arr

*/
	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
        num_conv1	:= coalesce(nullif(get_campo('EXTHOMNUMEROCONVENIO',xml2),''),'0');
        --num_conv1	:= coalesce(nullif(split_part(get_campo('EXTHOMNUMEROCONVENIO',xml2),'-',1),''),'0');/*NO DEBE VENIR "-"*/
        lugar_conv1	:= coalesce(nullif(get_campo('EXTHOMLUGARCONVENIO',xml2),''),'0');
        suc_venta1	:= coalesce(nullif(get_campo('EXTSUCVENTA',xml2),''),'0');
        rut_conv1	:= split_part(ltrim(get_campo('EXTRUTCONVENIO',xml2),'0'),'-',1);
        rut_tratante1	:= split_part(ltrim(get_campo('EXTRUTTRATANTE',xml2),'0'),'-',1);
        especialidad1	:= coalesce(nullif(get_campo('EXTESPECIALIDAD',xml2),''),'0');
        rut_solic1	:= split_part(ltrim(get_campo('EXTRUTSOLICITANTE',xml2),'0'),'-',1);
        rut_benef1	:= split_part(ltrim(get_campo('EXTRUTBENEFICIARIO',xml2),'0'),'-',1);
        tratamiento1	:= coalesce(nullif(get_campo('EXTTRATAMIENTO',xml2),''),'0');
        cod_diag1	:= coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0');
        nivel_conv1	:= coalesce(nullif(get_campo('EXTNIVELCONVENIO',xml2),''),'0');
        urgencia1	:= coalesce(nullif(get_campo('EXTURGENCIA',xml2),''),'0');
        lista1		:= coalesce(nullif(get_campo('EXTLISTA1',xml2),''),'0');
        lista2		:= coalesce(nullif(get_campo('EXTLISTA2',xml2),''),'0');
        lista3          := coalesce(nullif(get_campo('EXTLISTA3',xml2),''),'0');
        lista4          := coalesce(nullif(get_campo('EXTLISTA4',xml2),''),'0');
       	lista5          := coalesce(nullif(get_campo('EXTLISTA5',xml2),''),'0');
        lista6          := coalesce(nullif(get_campo('EXTLISTA6',xml2),''),'0');
        num_prestad1	:= coalesce(nullif(get_campo('EXTNUMPRESTACIONES',xml2),''),'0');

        --Fomato Rut
        /*rut_conv1	:=lpad(rut_conv1,10,'0');
        rut_tratante1	:=lpad(rut_tratante1,10,'0');
        rut_solic1	:=lpad(rut_solic1,10,'0');*/
	if length(rut_conv1)>'0' then rut_conv1         :=lpad(rut_conv1,10,'0')||'-'||motor_modulo11(rut_conv1);end if;
        if length(rut_tratante1)>'0' then rut_tratante1 :=lpad(rut_tratante1,10,'0')||'-'||motor_modulo11(rut_tratante1);end if;
        if length(rut_solic1)>'0' then rut_solic1       :=lpad(rut_solic1,10,'0')||'-'||motor_modulo11(rut_solic1);end if;
        if length(rut_benef1)>'0' then rut_benef1       :=lpad(rut_benef1,10,'0')||'-'||motor_modulo11(rut_benef1);end if;
	--rut_benef1	:=lpad(rut_benef1,10,'0');
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	xml2:=put_campo(xml2,'INPUT','["INFOMEDICA.VIDVALORIZI_PKG.VIDVALORIZI", [ "$o$STRING", '||cod_fin1||','||chr(34)||num_conv1||chr(34)||','||chr(34)||lugar_conv1||chr(34)||','||chr(34)||suc_venta1||chr(34)||','||chr(34)||rut_conv1||chr(34)||','||chr(34)||rut_tratante1||chr(34)||','||chr(34)||especialidad1||chr(34)||','||chr(34)||rut_solic1||chr(34)||','||chr(34)||rut_benef1||chr(34)||','||chr(34)||tratamiento1||chr(34)||','||chr(34)||cod_diag1||chr(34)||','||nivel_conv1||','||chr(34)||urgencia1||chr(34)||','||chr(34)||lista1||chr(34)||','||chr(34)||lista2||chr(34)||','||chr(34)||lista3||chr(34)||','||chr(34)||lista4||chr(34)||','||chr(34)||lista5||chr(34)||','||chr(34)||lista6||chr(34)||','||num_prestad1||',"$o$STRING","$o$STRING","$o$STRING","$o$STRING","$o$STRING","$o$STRING","$o$STRING","$o$STRING","$o$NUMBER[12]","$o$NUMBER[12]","$o$NUMBER[12]","$o$STRING[15]","$o$NUMBER[2]","$o$NUMBER[12]","$o$NUMBER[2]","$o$NUMBER[12]","$o$NUMBER[2]","$o$NUMBER[12]","$o$NUMBER[2]","$o$NUMBER[12]","$o$NUMBER[2]","$o$NUMBER[12]" ]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_valorizi_vidatres(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	aux1	varchar;
	resp1	varchar;
	
	cod_resp1       varchar;
        mensaje_resp1   varchar;	
        plan_resp1   	varchar;	
        glosa1   	varchar;	
        glosa2   	varchar;	
        glosa3   	varchar;	
        glosa4 		varchar;	
        glosa5 		varchar;	

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
                        --xml2:=put_campo(xml2,'ERRORMSG','Error Generico');
                        xml2:=put_campo(xml2,'ERRORMSG',aux1);
                end if;
                return xml2;
        end if;	

	 --Parseo la Respuesta
        cod_resp1	:=trim(replace(json_field(aux1,'1'),'"',''));
        mensaje_resp1	:=trim(replace(json_field(aux1,'2'),'"',''));
        plan_resp1	:=trim(replace(json_field(aux1,'3'),'"',''));
	glosa1		:=trim(replace(json_field(aux1,'4'),'"',''));
	glosa2		:=trim(replace(json_field(aux1,'5'),'"',''));
	glosa3		:=trim(replace(json_field(aux1,'6'),'"',''));
	glosa4		:=trim(replace(json_field(aux1,'7'),'"',''));
	glosa5		:=trim(replace(json_field(aux1,'8'),'"',''));
	
	valor_prest1	:=trim(replace(json_field(aux1,'9'),'"',''));
	aporte_fin1	:=trim(replace(json_field(aux1,'10'),'"',''));
	copago1		:=trim(replace(json_field(aux1,'11'),'"',''));
	interno_isa1	:=trim(replace(json_field(aux1,'12'),'"',''));
	tipo_bonif1	:=trim(replace(json_field(aux1,'13'),'"',''));
	ext_copago1	:=trim(replace(json_field(aux1,'14'),'"',''));
	tipo_bonif2	:=trim(replace(json_field(aux1,'15'),'"',''));
	ext_copago2	:=trim(replace(json_field(aux1,'16'),'"',''));
	tipo_bonif3	:=trim(replace(json_field(aux1,'17'),'"',''));
	ext_copago3	:=trim(replace(json_field(aux1,'18'),'"',''));
	tipo_bonif4	:=trim(replace(json_field(aux1,'19'),'"',''));
	ext_copago4	:=trim(replace(json_field(aux1,'20'),'"',''));
	tipo_bonif5	:=trim(replace(json_field(aux1,'21'),'"',''));
	ext_copago5	:=trim(replace(json_field(aux1,'22'),'"',''));

	raise notice 'JCC_VALORVARI_Receive extCodError=% - extMensajeError=% - extPlan=% - extGlosa1=% ',cod_resp1,mensaje_resp1,plan_resp1,glosa1;

	if glosa1='null' then glosa1=''; end if;
	if glosa2='null' then glosa2=''; end if;
	if glosa3='null' then glosa3=''; end if;
	if glosa4='null' then glosa4=''; end if;
	if glosa5='null' then glosa5=''; end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        xml2:=put_campo(xml2,'EXTPLAN',plan_resp1);
        xml2:=put_campo(xml2,'EXTGLOSA1',glosa1);
        xml2:=put_campo(xml2,'EXTGLOSA2',glosa2);
        xml2:=put_campo(xml2,'EXTGLOSA3',glosa3);
        xml2:=put_campo(xml2,'EXTGLOSA4',glosa4);
        xml2:=put_campo(xml2,'EXTGLOSA5',glosa5);
		
		/*<extValorPrestacion>[18746.0]</extValorPrestacion>
	    	<extAporteFinanciador>[13122.0]</extAporteFinanciador>
		<extCopago>[5624.0]</extCopago>*/ 

	xml2:=put_campo(xml2,'EXTVALORPRESTACION',split_part(valor_prest1,'.',1));
        xml2:=put_campo(xml2,'EXTAPORTEFINANCIADOR',split_part(aporte_fin1,'.',1));
        xml2:=put_campo(xml2,'EXTCOPAGO',split_part(copago1,'.',1));
        xml2:=put_campo(xml2,'EXTINTERNOISA',split_part(interno_isa1,'.',1));
        xml2:=put_campo(xml2,'EXTTIPOBONIF1',split_part(tipo_bonif1,'.',1));
        xml2:=put_campo(xml2,'EXTCOPAGO1',split_part(ext_copago1,'.',1));
        xml2:=put_campo(xml2,'EXTTIPOBONIF2',split_part(tipo_bonif2,'.',1));
        xml2:=put_campo(xml2,'EXTCOPAGO2',split_part(ext_copago2,'.',1));
        xml2:=put_campo(xml2,'EXTTIPOBONIF3',split_part(tipo_bonif3,'.',1));
        xml2:=put_campo(xml2,'EXTCOPAGO3',split_part(ext_copago3,'.',1));
        xml2:=put_campo(xml2,'EXTTIPOBONIF4',split_part(tipo_bonif4,'.',1));
        xml2:=put_campo(xml2,'EXTCOPAGO4',split_part(ext_copago4,'.',1));
        xml2:=put_campo(xml2,'EXTTIPOBONIF5',split_part(tipo_bonif5,'.',1));
        xml2:=put_campo(xml2,'EXTCOPAGO5',split_part(ext_copago5,'.',1));

        return xml2;
end;
$$
LANGUAGE plpgsql;
