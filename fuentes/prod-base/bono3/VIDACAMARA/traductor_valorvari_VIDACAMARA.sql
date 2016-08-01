CREATE OR REPLACE FUNCTION traductor_in_valorvari_vidacamara(varchar)
returns varchar as
$$
declare
        
	xml1    alias for $1;
        xml2    varchar;

	declare_params  varchar;
        out_params      varchar;
        insert1         varchar;
        exec_sp         varchar;
        exec_end        varchar;
        select1         varchar;

        cod_fin1        varchar;
        num_conv1       varchar;
        lugar_conv1     varchar;
        suc_venta1      varchar;
        rut_conv1       varchar;
        rut_tratante1   varchar;
        especialidad1   varchar;
        rut_solic1      varchar;
        rut_benef1      varchar;
        tratamiento1    varchar;
        cod_diag1       varchar;
        nivel_conv1     varchar;
        urgencia1       varchar;
        lista1          varchar;
        lista2          varchar;
        lista3          varchar;
        lista4          varchar;
        lista5          varchar;
        lista6          varchar;
        lista7          varchar;
        num_prestad1    varchar;

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
	--num_conv1       :=split_part(get_campo('EXTHOMNUMEROCONVENIO',xml2),'-',1);	--NO DEBE VENIR "-"
	num_conv1       :=get_campo('EXTHOMNUMEROCONVENIO',xml2);	--ACEPTA "-"
        lugar_conv1     :=get_campo('EXTHOMLUGARCONVENIO',xml2);       -- char(10),
        suc_venta1      :=get_campo('EXTSUCVENTA',xml2);               -- char(10),
        rut_conv1       :=get_campo('EXTRUTCONVENIO',xml2);        -- char(12),
        rut_tratante1   :=get_campo('EXTRUTTRATANTE',xml2);        -- char(12),
        especialidad1   :=get_campo('EXTESPECIALIDAD',xml2);           -- char(10), -- FR-16877
        rut_solic1      :=get_campo('EXTRUTSOLICITANTE',xml2);     -- char(12),
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);    -- char(12),
        tratamiento1    :=get_campo('EXTTRATAMIENTO',xml2);            -- char(1),
        cod_diag1       :=get_campo('EXTCODIGODIAGNOSTICO',xml2);      -- char(10),
        nivel_conv1     :=get_campo('EXTNIVELCONVENIO',xml2);  -- tinyint,
        urgencia1       :=get_campo('EXTURGENCIA',xml2);       -- char(1),
        lista1          :=get_campo('EXTLISTA1',xml2);         -- char(255),
        lista2          :=get_campo('EXTLISTA2',xml2);         -- char(255),
        lista3          :=get_campo('EXTLISTA3',xml2);         -- char(255),
        lista4          :=get_campo('EXTLISTA4',xml2);         -- char(255),
        lista5          :=get_campo('EXTLISTA5',xml2);         -- char(255),
        lista6          :=get_campo('EXTLISTA6',xml2);         -- char(255),
        lista7          :=get_campo('EXTLISTA7',xml2);         -- char(255),
        num_prestad1    :=get_campo('EXTNUMPRESTACIONES',xml2);-- tinyint,

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
	
     	declare_params:='DECLARE @extCodFinanciador numeric (5)
                DECLARE @extHomNumeroConvenio char(15)
                DECLARE @extHomLugarConvenio  char(10)
                DECLARE @extSucVenta          char(10)
                DECLARE @extRutConvenio       char(12)
                DECLARE @extRutTratante       char(12)
                DECLARE @extEspecialidad      char(10)
                DECLARE @extRutSolicitante    char(12)
                DECLARE @extRutBeneficiario   char(12)
                DECLARE @extTratamiento       char(1)
                DECLARE @extCodigoDiagnostico char(10)
                DECLARE @extNivelConvenio     numeric(1)
                DECLARE @extUrgencia          char(1)
                DECLARE @extLista1            char(255)
                DECLARE @extLista2            char(255)
                DECLARE @extLista3            char(255)
                DECLARE @extLista4            char(255)
                DECLARE @extLista5            char(255)
                DECLARE @extLista6            char(255)
                DECLARE @extLista7            char(255)
                DECLARE @extNumPrestaciones   numeric(1)
                DECLARE @extCodError     char(1)
                DECLARE @extMensajeError char(30)
                DECLARE @extPlan         char(15)
                DECLARE @extGlosa1       char(50)
                DECLARE @extGlosa2       char(50)
                DECLARE @extGlosa3       char(50)
                DECLARE @extGlosa4       char(50)
                DECLARE @extGlosa5       char(50) ';

        exec_sp:= 'execute dbo.SMDValorVari '||cod_fin1||',"'||num_conv1||'","'||lugar_conv1||'","'||suc_venta1||'","'||rut_conv1||'","'||rut_tratante1||'","'||especialidad1||'", "'||rut_solic1||'","'||rut_benef1||'","'||tratamiento1||'","'||cod_diag1||'",'||nivel_conv1||',"'||urgencia1||'","'||lista1||'","'||lista2||'","'||lista3||'","'||lista4||'","'||lista5||'","'||lista6||'","'||lista7||'",'||num_prestad1||', @extCodError output, @extMensajeError output, @extPlan output,@extGlosa1 output, @extGlosa2 output, @extGlosa3 output, @extGlosa4 output, @extGlosa5 output '; 
     	
	out_params:='select @extCodError as extCodError, @extMensajeError as extMensajeError, @extPlan as extPlan, @extGlosa1 as extGlosa1, @extGlosa2 as extGlosa2, @extGlosa3 as extGlosa3, @extGlosa4 as extGlosa4, @extGlosa5 as extGlosa5 ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params); 
	return xml2;

end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_valorvari_vidacamara(varchar)
returns varchar as
$$
declare
	xml1  	alias for $1;
        xml2    varchar;
	i               integer ='1';
        j               integer ='1';
	cod_resp1       varchar;
        mensaje_resp1   varchar;
        plan_resp1      varchar;
        glosa1          varchar;
        glosa2          varchar;
        glosa3          varchar;
        glosa4          varchar;
        glosa5          varchar;
	
	/*Datos que no siempre podrian venir en la respuesta del financiador*/
        valor_prest1    varchar ='';
        aporte_fin1     varchar ='';
        copago1         varchar ='';
        interno_isa1    varchar ='';        --Interno Isapre
        tipo_bonif1     varchar ='';
        ext_copago1     varchar ='';

        --Variables Aux
        valor_aux1      varchar;
        aporte_aux1     varchar;
        copago_aux1     varchar;
        interno_aux1    varchar;
	bonif_aux1      varchar;
        ext_cop_aux1    varchar;

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	 --Si viene al menos uno de estos, obtiene 1er grupo reg.
        while true loop
                valor_aux1      :=trim(get_campo('EXTVALORPRESTACION_'||i::varchar,xml2));
                aporte_aux1     :=trim(get_campo('EXTAPORTEFINANCIADOR_'||i::varchar,xml2));
                copago_aux1     :=trim(get_campo('EXTCOPAGO_'||i::varchar,xml2));
                interno_aux1    :=trim(get_campo('EXTINTERNOISA_'||i::varchar,xml2));

                if length(valor_aux1)>0 or length(aporte_aux1)>0 or length(copago_aux1)>0 or length(interno_aux1)>0  then
                        j:=1;
                        --Si hay valor. Concateno
                        valor_prest1    :=valor_prest1||valor_aux1||',';
                        aporte_fin1     :=aporte_fin1||aporte_aux1||',';
                        copago1         :=copago1||copago_aux1||',';
                        interno_isa1    :=interno_isa1||interno_aux1||',';

                        --Para el 2do grupo de reg
                	--En el sgte ciclo, solo vienen 5 iteraciones. Obteniendo dos registros x cada iteracion
                        while (j<6) loop
                                bonif_aux1:=trim(get_campo('EXTTIPOBONIF'||j::varchar||'_'||i::varchar,xml2));
                                ext_cop_aux1:=trim(get_campo('EXTCOPAGO'||j::varchar||'_'||i::varchar,xml2));

                                --Si viene al menos uno de estos, se obtienen todos
                                if length(bonif_aux1)>0 or length(ext_cop_aux1)>0 then

                                        --Saco la data que tiene el XML
                                        tipo_bonif1:=get_campo('EXTTIPOBONIF'||j::varchar,xml2);
                                        ext_copago1:=get_campo('EXTCOPAGO'||j::varchar,xml2);

                                        --Concatena los datos XML + SP
                                        if length(tipo_bonif1)>0 or length(ext_copago1)>0 then
                                                bonif_aux1:=tipo_bonif1||','||bonif_aux1;
                                                ext_cop_aux1:=ext_copago1||','||ext_cop_aux1;
                                        end if;
                                        xml2:=put_campo(xml2,'EXTTIPOBONIF'||j::varchar,bonif_aux1);
                                        xml2:=put_campo(xml2,'EXTCOPAGO'||j::varchar,ext_cop_aux1);
                                else
                                        xml2:=logapp(xml2,'VIDACAMARA: RSP_VALORVARI -> Falla Obtencion 2doGrupo del Recordset - CodMotor= '||get_campo('CODIGO_MOTOR',xml2));
                                end if;
                                --Aumenta contador 2do grupo
                                j:=j+1;
                        end loop;
                        --Limpio variables aux.
                        bonif_aux1:='';
                        ext_cop_aux1='';
		else
                        --Quito la ultima coma (ya que no volvera al ciclo) y se sale
                        if length(valor_prest1)>0 or length(aporte_fin1)>0 or length(copago1)>0 or length(interno_isa1)>0  then
                                valor_prest1    :=substring(valor_prest1,1,length(valor_prest1)-1);
                                aporte_fin1     :=substring(aporte_fin1,1,length(aporte_fin1)-1);
                                copago1         :=substring(copago1,1,length(copago1)-1);
                                interno_isa1    :=substring(interno_isa1,1,length(interno_isa1)-1);
                        end if;
                        exit;
                end if;
                --Aumenta contador 1er grupo
                i:=i+1;
        end loop;

        --Parseo Respuesta
        cod_resp1       :=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
        mensaje_resp1   :=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));
        plan_resp1      :=trim(get_campo('EXTPLAN_'||i::varchar,xml2));

        --Parseo Respuesta
        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTCODERROR',     cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR', mensaje_resp1);
        xml2:=put_campo(xml2,'EXTPLAN',         plan_resp1);
        xml2:=put_campo(xml2,'EXTGLOSA1',       trim(get_campo('EXTGLOSA1_'||i::varchar,xml2)));
        xml2:=put_campo(xml2,'EXTGLOSA2',       trim(get_campo('EXTGLOSA2_'||i::varchar,xml2)));
        xml2:=put_campo(xml2,'EXTGLOSA3',       trim(get_campo('EXTGLOSA3_'||i::varchar,xml2)));
        xml2:=put_campo(xml2,'EXTGLOSA4',       trim(get_campo('EXTGLOSA4_'||i::varchar,xml2)));
        xml2:=put_campo(xml2,'EXTGLOSA5',       trim(get_campo('EXTGLOSA5_'||i::varchar,xml2)));

        /*xml2:=put_campo(xml2,'EXTGLOSA1',       trim(get_campo('EXTGLOSA1',xml2)));
        xml2:=put_campo(xml2,'EXTGLOSA2',       trim(get_campo('EXTGLOSA2',xml2)));
        xml2:=put_campo(xml2,'EXTGLOSA3',       trim(get_campo('EXTGLOSA3',xml2)));
        xml2:=put_campo(xml2,'EXTGLOSA4',       trim(get_campo('EXTGLOSA4',xml2)));
        xml2:=put_campo(xml2,'EXTGLOSA5',       trim(get_campo('EXTGLOSA5',xml2)));*/
        
	xml2:=put_campo(xml2,'EXTVALORPRESTACION','['||valor_prest1||']');
        xml2:=put_campo(xml2,'EXTAPORTEFINANCIADOR','['||aporte_fin1||']');
        xml2:=put_campo(xml2,'EXTCOPAGO','['||copago1||']');
        xml2:=put_campo(xml2,'EXTINTERNOISA','["'||replace(interno_isa1,',','","')||'"]');

        xml2:=logapp(xml2,'VIDACAMARA: RSP_VALORVARI -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1||' -extPlan='||plan_resp1||' -extGlosa1='||get_campo('EXTGLOSA1',xml2)||' -extGlosa2='||get_campo('EXTGLOSA2',xml2)||' -extGlosa3='||get_campo('EXTGLOSA3',xml2)||' -extGlosa4='||get_campo('EXTGLOSA4',xml2)||' -extGlosa5='||get_campo('EXTGLOSA5',xml2)||' -extValorPrestacion='||get_campo('EXTVALORPRESTACION',xml2)||' -extAporteFinanciador='||get_campo('EXTAPORTEFINANCIADOR',xml2)||' -extCopago='||get_campo('EXTCOPAGO',xml2)||' -extInternoIsa='||get_campo('EXTINTERNOISA',xml2)||' -extTipoBonif1='||get_campo('EXTTIPOBONIF1',xml2)||' -extCopago1='||get_campo('EXTCOPAGO1',xml2)||' -extTipoBonif2='||get_campo('EXTTIPOBONIF2',xml2)||' -extCopago2='||get_campo('EXTCOPAGO2',xml2)||'-extTipoBonif3='||get_campo('EXTTIPOBONIF3',xml2)||' -extCopago3='||get_campo('EXTCOPAGO3',xml2)||' -extTipoBonif4='||get_campo('EXTTIPOBONIF4',xml2)||' -extCopago4='||get_campo('EXTCOPAGO4',xml2)||' -extTipoBonif5='||get_campo('EXTTIPOBONIF5',xml2)||' -extCopago5='||get_campo('EXTCOPAGO5',xml2));

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTCODERROR',xml2)||', '||
                                        get_campo('EXTMENSAJEERROR',xml2)||', '||get_campo('EXTPLAN',xml2)||', '||
                                        get_campo('EXTGLOSA1',xml2)||', '||get_campo('EXTGLOSA2',xml2)||', '||
                                        get_campo('EXTGLOSA3',xml2)||', '||get_campo('EXTGLOSA4',xml2)||', '||
                                        get_campo('EXTGLOSA5',xml2)||', '||get_campo('EXTVALORPRESTACION',xml2)||', '||
                                        get_campo('EXTAPORTEFINANCIADOR',xml2)||', '||get_campo('EXTCOPAGO',xml2)||', '||
                                        get_campo('EXTINTERNOISA',xml2));

	--Completo los tag con []. Reset del contador.
        j:=1;
        while (j<6) loop
                bonif_aux1:=get_campo('EXTTIPOBONIF'||j::varchar,xml2);
                ext_cop_aux1:=get_campo('EXTCOPAGO'||j::varchar,xml2);
                xml2:=put_campo(xml2,'EXTTIPOBONIF'||j::varchar,'['||get_campo('EXTTIPOBONIF'||j::varchar,xml2)||']');
                xml2:=put_campo(xml2,'EXTCOPAGO'||j::varchar,'['||get_campo('EXTCOPAGO'||j::varchar,xml2)||']');
	
		xml2:=put_campo(xml2,'SQLOUTPUT',get_campo('SQLOUTPUT',xml2)||', '||
                                                get_campo('EXTTIPOBONIF'||j::varchar,xml2)||', '||get_campo('EXTCOPAGO'||j::varchar,xml2));
                j:=j+1;
        end loop;

	xml2:=put_campo(xml2,'SQLOUTPUT',get_campo('SQLOUTPUT',xml2)||'}');	

        return xml2;
end;
$$
LANGUAGE plpgsql;
