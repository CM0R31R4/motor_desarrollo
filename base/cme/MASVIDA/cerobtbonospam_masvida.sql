CREATE OR REPLACE FUNCTION traductor_in_cerobtbonospam_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	declare_params	varchar;
        exec_sp		varchar;
        out_params  	varchar;

begin
        xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',clock_timestamp()::varchar);

	--Llamo a la funcion input de parseo de datos.
	xml2:=proc_parser_input_cerobtbonospam(xml2);
	if get_campo('ERR',xml2)='S' then
                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CME');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error parser_input_'||get_campo('TX_WS',xml2));
                return xml2;
        end if;

	--Preparo la llamada al SP
	declare_params:='DECLARE @CtaSucVenta	numeric (10)
	DECLARE @CtaRutConvenio		numeric (12)
	DECLARE @CtaRutTratante		numeric (12)
	DECLARE @CtaNomTratante		numeric (40)
	DECLARE @CtaEspecialidad	numeric (10)
	DECLARE @CtaRutBeneficiario	numeric (12)
	DECLARE @CtaApellidoPat		numeric (30)
	DECLARE @CtaApellidoMat		numeric (30)
	DECLARE @CtaNombres		numeric (40)
	DECLARE @CtaSexo		numeric (1)
	DECLARE @CtaFechaNacimi		datetime
	DECLARE @CtaRutCotizante	numeric (12)
	DECLARE @CtaNomCotizante	numeric (40)
	DECLARE @CtaDirPaciente		numeric (40)
	DECLARE @CtaGlosaComuna		numeric (30)
	DECLARE @CtaGlosaCiudad		numeric (30)
	DECLARE @CtaPlan		numeric (15)
	DECLARE @CtaFechaEmision	datetime
	DECLARE @CtaGlosa1		numeric (50)
	DECLARE @CtaGlosa2		numeric (50)
	DECLARE @CtaGlosa3		numeric (50)
	DECLARE @CtaGlosa4		numeric (50)
	DECLARE @CtaGlosa5		numeric (50)
	DECLARE @CtaCodError		numeric (1)
	DECLARE @CtaMensajeError	numeric (30)

	DECLARE @CtaFoliosBono		numeric (10)
	DECLARE @CtaCodPrestacion	numeric (12)
	DECLARE @CtaItemPrestacion	numeric (03)
	DECLARE @CtaGlosaPrestacion	numeric (120)
	DECLARE @CtaCantidadPtd		numeric (3) 
	DECLARE @CtaRecargoHora		numeric (01)
	DECLARE @CtaValorPrestacion	numeric (12)
	DECLARE @CtaAporteFinanciador	numeric (12)
	DECLARE @CtaCopago		numeric (12)
	DECLARE @CtaInternoIsa		numeric (15)
	DECLARE @CtaTipoBonif1		tinyint
	DECLARE @CtaCopago1		numeric (12)
	DECLARE @CtaTipoBonif2		tinyint
	DECLARE @CtaCopago2		numeric (12)
	DECLARE @CtaTipoBonif3		tinyint
	DECLARE @CtaCopago3		numeric (12)
	DECLARE @CtaTipoBonif4		tinyint
	DECLARE @CtaCopago4		numeric (12)
	DECLARE @CtaTipoBonif5		tinyint
	DECLARE @CtaCopago5		numeric (12)';

	--Por ahora en duro
	--||get_campo('CTACODFINANCIADOR',xml2)||
	exec_sp:= 'EXECUTE dbo.cerobtbonospam '||88||',
			'||get_campo('CTANUMCOBRO',xml2)||',
			['||get_campo('CTANUMCTA',xml2)||'],
			['||get_campo('CTARUTCONVENIO',xml2)||'], @CtaSucVenta OUTPUT, @CtaRutConvenio OUTPUT, @CtaRutTratante OUTPUT, @CtaNomTratante OUTPUT, @CtaEspecialidad OUTPUT, @CtaRutBeneficiario OUTPUT, @CtaApellidoPat OUTPUT, @CtaApellidoMat OUTPUT, @CtaNombres OUTPUT, @CtaSexo OUTPUT, @CtaFechaNacimi OUTPUT, @CtaRutCotizante OUTPUT, @CtaNomCotizante OUTPUT, @CtaDirPaciente OUTPUT, @CtaGlosaComuna UTPUT, @CtaGlosaCiudad OUTPUT, @CtaPlan OUTPUT, @CtaFechaEmision OUTPUT, @CtaGlosa1 OUTPUT, @CtaGlosa2 OUTPUT, @CtaGlosa3 OUTPUT, @CtaGlosa4 OUTPUT, @CtaGlosa5 OUTPUT, @CtaCodError OUTPUT, @CtaMensajeError OUTPUT, @CtaFoliosBono OUTPUT, @CtaCodPrestacion OUTPUT, @CtaItemPrestacion OUTPUT, @CtaGlosaPrestacion OUTPUT, @CtaCantidadPtd OUTPUT, @CtaRecargoHora OUTPUT, @CtaValorPrestacion OUTPUT, @CtaAporteFinanciador OUTPUT, @CtaCopago OUTPUT, @CtaInternoIsa OUTPUT, @CtaTipoBonif1 OUTPUT, @CtaCopago1 OUTPUT, @CtaTipoBonif2 OUTPUT, @CtaCopago2 OUTPUT, @CtaTipoBonif3 OUTPUT, @CtaCopago3 OUTPUT, @CtaTipoBonif4 OUTPUT, @CtaCopago4 OUTPUT, @CtaTipoBonif5 OUTPUT, @CtaCopago5 OUTPUT '; 

	out_params:='SELECT @CtaSucVenta as CtaSucVenta, @CtaRutConvenio as CtaRutConvenio, @CtaRutTratante as CtaRutTratante, @CtaNomTratante as CtaNomTratante, @CtaEspecialidad as CtaEspecialidad, @CtaRutBeneficiario as CtaRutBeneficiario, @CtaApellidoPat as CtaApellidoPat, @CtaApellidoMat as CtaApellidoMat, @CtaNombres as CtaNombres, @CtaSexo as taSexo, @CtaFechaNacimi as CtaFechaNacimi, @CtaRutCotizante as CtaRutCotizante, @CtaNomCotizante as taNomCotizante, @CtaDirPaciente as CtaDirPaciente, @CtaGlosaComuna as CtaGlosaComuna, @CtaGlosaCiudad as taGlosaCiudad, @CtaPlan as CtaPlan, @CtaFechaEmision as CtaFechaEmision, @CtaGlosa1 as CtaGlosa1, @CtaGlosa2 as taGlosa2, @CtaGlosa3 as CtaGlosa3, @CtaGlosa4 as CtaGlosa4, @CtaGlosa5 as CtaGlosa5, @CtaCodError as CtaCodError, @CtaMensajeError as CtaMensajeError OUTPUT, @CtaFoliosBono as CtaFoliosBono, @CtaCodPrestacion as taCodPrestacion, @CtaItemPrestacion as CtaItemPrestacion, @CtaGlosaPrestacion as CtaGlosaPrestacion, @CtaCantidadPtd as taCantidadPtd, @CtaRecargoHora as CtaRecargoHora, @CtaValorPrestacion as CtaValorPrestacion, @CtaAporteFinanciador s CtaAporteFinanciador, @CtaCopago as CtaCopago, @CtaInternoIsa as CtaInternoIsa, @CtaTipoBonif1 as CtaTipoBonif1, @CtaCopago1 as CtaCopago1, @CtaTipoBonif2 as CtaTipoBonif2, @CtaCopago2 as CtaCopago2, @CtaTipoBonif3 as CtaTipoBonif3, @CtaCopago3 as CtaCopago3, @CtaTipoBonif4 as CtaTipoBonif4, @CtaCopago4 as CtaCopago4, @CtaTipoBonif5 as taTipoBonif5, @CtaCopago5 as CtaCopago5 ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

/*
CREATE OR REPLACE FUNCTION traductor_out_cerobtbonospam_masvida(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	j               integer ='1';
	cod_resp1	varchar;
	msj_resp1	varchar;
	
	suc_venta1	varchar;	
	rut_con1	varchar;	
	rut_tra1	varchar;	
	nom_tra1	varchar;	
	especialidad1	varchar;
	rut_ben1	varchar;	
	ape_pat1	varchar;
	ape_mat1	varchar;
	nombres1	varchar;
	sexo1		varchar;
	fec_nac1	varchar;
	rut_cot1	varchar;
	nom_cot1	varchar;
	dir_pac1	varchar;
	glo_cmna1	varchar;
	glo_cdad1	varchar;
	plan1		varchar;
	fec_emi1	varchar;
	glosa1		varchar;
	glosa2		varchar;
	glosa3		varchar;
	glosa4		varchar;
	glosa5		varchar;

	--Valores Opcionales (O/C)
	folios_bon1	varchar ='';
	cod_prest1	varchar ='';
	item_prest1	varchar ='';
	glo_prest1	varchar ='';
	cant_ptd1	varchar ='';
	rec_hrs1	varchar ='';
	val_prest1	varchar ='';
	apor_fin1	varchar ='';
	copago1		varchar ='';
	int_isa1	varchar ='';
	tip_bon1	varchar =''; --1 a 5
	cta_cop1	varchar =''; --1 a 5

	--Variables Aux
	folios_aux1	varchar;
        cod_aux1      	varchar;
        item_aux1     	varchar;
        glo_aux1      	varchar;
        cant_aux1       varchar;
        rec_aux1        varchar;
        val_aux1      	varchar;
        apor_aux1       varchar;
        copago_aux1    	varchar;
        int_aux1        varchar;
        bon_aux1        varchar; --1 a 5
        cop_aux1        varchar; --1 a 5

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',clock_timestamp()::varchar);

	while true loop
		--valor_prest1      :=replace(trim(get_campo('@CTAVALORPRESTACION_'||i::varchar,xml2)),'@','');
		folios_aux1     :=trim(get_campo('CTAFOLIOSBONO_'||i::varchar,xml2));
	        cod_aux1      	:=trim(get_campo('CTACODPRESTACION_'||i::varchar,xml2));
        	item_aux1     	:=trim(get_campo('CTAITEMPRESTACION_'||i::varchar,xml2));
	        glo_aux1      	:=trim(get_campo('CTAGLOSAPRESTACION_'||i::varchar,xml2));
        	cant_aux1       :=trim(get_campo('CTACANTIDADPTD_'||i::varchar,xml2));
	        rec_aux1        :=trim(get_campo('CTARECARGOHORA_'||i::varchar,xml2));
        	val_aux1      	:=trim(get_campo('CTAVALORPRESTACION_'||i::varchar,xml2));
	        apor_aux1       :=trim(get_campo('CTAAPORTEFINANCIADOR_'||i::varchar,xml2));
	        item_aux1     	:=trim(get_campo('CTACOPAGO_'||i::varchar,xml2));
        	int_aux1        :=trim(get_campo('CTAINTERNOISA_'||i::varchar,xml2));
	
		--Si viene al menos uno de estos, obtiene 1er grupo reg.
		if length(folios_aux1)>0 or length(cod_aux1)>0 or length(item_aux1)>0 or length(glo_aux1)>0  or
		   length(cant_aux1)>0 or length(rec_aux1)>0 or length(val_aux1)>0 or length(apor_aux1)>0 or 
		   length(item_aux1)>0 or length(int_aux1)>0 then 
		   --length(bon_aux1)>0 or length(cop_aux1)>0 then
                        
			j:=1;
                        --Si hay valor. Concateno
                        folios_bon1    	:=folios_bon1||folios_aux1||',';
                        cod_prest1     	:=cod_prest1||cod_aux1||',';
                        item_prest1     :=item_prest1||item_aux1||',';
                        glo_prest1    	:=glo_prest1||glo_aux1||',';
                        cant_ptd1    	:=cant_ptd1||cant_aux1||',';
                        rec_hrs1    	:=rec_hrs1||rec_aux1||',';
                        val_prest1    	:=val_prest1||val_aux1||',';
                        apor_fin1    	:=apor_fin1||apor_aux1||',';
                        copago1    	:=copago1||item_aux1||',';
                        int_isa1    	:=int_isa1||int_aux1||',';

                        --Para el 2do grupo de reg
                        --En el sgte ciclo, solo vienen 5 iteraciones. Obteniendo dos registros x cada iteracion
                        while (j<6) loop
                                bon_aux1:=trim(get_campo('@CTATIPOBONIF'||j::varchar||'_'||i::varchar,xml2));
                                cop_aux1:=trim(get_campo('@CTACOPAGO'||j::varchar||'_'||i::varchar,xml2));

                                --Si viene al menos uno de estos, se obtienen todos.
                                if length(bon_aux1)>0 or length(cop_aux1)>0 then

                                        --Saco la data que tiene el XML
                                        tip_bon1:=get_campo('CTATIPOBONIF'||j::varchar,xml2);
                                        cta_cop1:=get_campo('CTACOPAGO'||j::varchar,xml2);

                                        --Concatena los datos XML + SP
                                        if length(tip_bon1)>0 or length(cta_cop1)>0 then
                                                bon_aux1:=tip_bon1||','||bon_aux1;
                                                cop_aux1:=cta_cop1||','||cop_aux1;
                                        end if;
                                        xml2:=put_campo(xml2,'CTATIPOBONIF'||j::varchar,bon_aux1);
                                        xml2:=put_campo(xml2,'CTACOPAGO'||j::varchar,cop_aux1);
                                else
                                        raise notice 'JCC_ELSE CTATIPOBONIF%_%=% ** CTACOPAGO%_%=%',j,i,bon_aux1,j,i,cop_aux1;
                                end if;
                                --Aumenta contador 2do grupo
                                j:=j+1;
                        end loop;
                        --Limpio variables aux.
                        bon_aux1:='';
                        cop_aux1='';
                else
                        --Quito la ultima coma (ya que no volvera al ciclo) y se sale
                        if length(folios_bon1)>0 or length(cod_prest1)>0 or length(item_prest1)>0 or length(glo_prest1)>0 or 
			   length(cant_ptd1)>0 or length(rec_hrs1)>0 or length(val_prest1)>0 or length(apor_fin1)>0 or
			   length(copago1)>0 or length(int_isa1)>0 then

                                folios_bon1    	:=substring(folios_bon1,1,length(folios_bon1)-1);
                                cod_prest1     	:=substring(cod_prest1,1,length(cod_prest1)-1);
                                item_prest1    	:=substring(copago1,1,length(item_prest1)-1);
                                glo_prest1	:=substring(glo_prest1,1,length(glo_prest1)-1);
                                cant_ptd1	:=substring(glo_prest1,1,length(cant_ptd1)-1);
                                rec_hrs1	:=substring(glo_prest1,1,length(rec_hrs1)-1);
                                val_prest1	:=substring(glo_prest1,1,length(val_prest1)-1);
                                apor_fin1	:=substring(glo_prest1,1,length(apor_fin1)-1);
                                copago1		:=substring(glo_prest1,1,length(copago1)-1);
                                int_isa1	:=substring(glo_prest1,1,length(int_isa1)-1);
                        end if;
                        exit;
                end if;
                --Aumenta contador 1er grupo
                i:=i+1;
        end loop;	
	
	--Parseo respuesta
	cod_resp1	:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_resp1	:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));
	
	suc_venta1      :=trim(get_campo('CTASUCVENTA_'||i::varchar,xml2));
        rut_con1        :=trim(get_campo('CTARUTCONVENIO_'||i::varchar,xml2));
        rut_tra1        :=trim(get_campo('CTARUTTRATANTE_'||i::varchar,xml2));
        nom_tra1        :=trim(get_campo('CTANOMTRATANTE_'||i::varchar,xml2));
        especialidad1   :=trim(get_campo('CTAESPECIALIDAD_'||i::varchar,xml2));
        rut_ben1        :=trim(get_campo('CTARUTBENEFICIARIO_'||i::varchar,xml2));
        ape_pat1        :=trim(get_campo('CTAAPELLIDOPAT_'||i::varchar,xml2));
        ape_mat1        :=trim(get_campo('CTAAPELLIDOMAT_'||i::varchar,xml2));
        nombres1        :=trim(get_campo('CTANOMBRES_'||i::varchar,xml2));
        sexo1           :=trim(get_campo('CTASEXO_'||i::varchar,xml2));
        fec_nac1        :=trim(get_campo('CTAFECHANACIMI_'||i::varchar,xml2));
        rut_cot1        :=trim(get_campo('CTARUTCOTIZANTE_'||i::varchar,xml2));
        nom_cot1        :=trim(get_campo('CTANOMCOTIZANTE_'||i::varchar,xml2));
        dir_pac1        :=trim(get_campo('CTADIRPACIENTE_'||i::varchar,xml2));
        glo_cmna1       :=trim(get_campo('CTAGLOSACOMUNA_'||i::varchar,xml2));
        glo_cdad1       :=trim(get_campo('CTAGLOSACIUDAD_'||i::varchar,xml2));
        plan1           :=trim(get_campo('CTAPLAN_'||i::varchar,xml2));
        fec_emi1        :=trim(get_campo('CTAFECHAEMISION_'||i::varchar,xml2));
        glosa1          :=trim(get_campo('CTAGLOSA1_'||i::varchar,xml2));
        glosa2          :=trim(get_campo('CTAGLOSA2_'||i::varchar,xml2));
        glosa3          :=trim(get_campo('CTAGLOSA3_'||i::varchar,xml2));
        glosa4          :=trim(get_campo('CTAGLOSA4_'||i::varchar,xml2));
        glosa5          :=trim(get_campo('CTAGLOSA5_'||i::varchar,xml2));
		
	raise notice 'JCC_cerobtbonospam_Receive CtaCodError=% - CtaMensajeError=%',cod_resp1,msj_resp1;
	raise notice 'JCC_cerobtbonospam_Receive corr_reg1=% - cod_inter_ptd1=%',corr_reg1,cod_inter_ptd1;

--        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'CTACODERROR',cod_resp1);
--        xml2:=put_campo(xml2,'CTAMENSAJEERROR',msj_resp1);

	xml2:=put_campo(xml2,'ERR',cod_resp1);
        xml2:=put_campo(xml2,'GLOSA',msj_resp1);
	
	xml2:=put_campo(xml2,'CTASUCVENTA',		suc_venta1);
	xml2:=put_campo(xml2,'CTARUTCONVENIO',		rut_con1);
	xml2:=put_campo(xml2,'CTARUTTRATANTE',		rut_tra1);
	xml2:=put_campo(xml2,'CTANOMTRATANTE',		nom_tra1);
	xml2:=put_campo(xml2,'CTAESPECIALIDAD',		especialidad1);
	xml2:=put_campo(xml2,'CTARUTBENEFICIARIO',	rut_ben1);
	xml2:=put_campo(xml2,'CTAAPELLIDOPAT',		ape_pat1);
	xml2:=put_campo(xml2,'CTAAPELLIDOMAT',		ape_mat1);
	xml2:=put_campo(xml2,'CTANOMBRES',		nombres1);
	xml2:=put_campo(xml2,'CTASEXO',			sexo1);
	xml2:=put_campo(xml2,'CTAFECHANACIMI',		fec_nac1);
	xml2:=put_campo(xml2,'CTARUTCOTIZANTE',		rut_cot1);
	xml2:=put_campo(xml2,'CTANOMCOTIZANTE',		nom_cot1);
	xml2:=put_campo(xml2,'CTADIRPACIENTE',		dir_pac1);
	xml2:=put_campo(xml2,'CTAGLOSACOMUNA',		glo_cmna1);
	xml2:=put_campo(xml2,'CTAGLOSACIUDAD',		glo_cdad1);
	xml2:=put_campo(xml2,'CTAPLAN',			plan1);
	xml2:=put_campo(xml2,'CTAFECHAEMISION',		fec_emi1);
	xml2:=put_campo(xml2,'CTAGLOSA1',		glosa1);
	xml2:=put_campo(xml2,'CTAGLOSA2',		glosa2);
	xml2:=put_campo(xml2,'CTAGLOSA3',		glosa3);
	xml2:=put_campo(xml2,'CTAGLOSA4',		glosa4);
	xml2:=put_campo(xml2,'CTAGLOSA5',		glosa5);

	
	--Valores Opcionales (O/C)
	xml2:=put_campo(xml2,'CTAFOLIOSBONO',		'['||folios_bon1||']');
	xml2:=put_campo(xml2,'CTACODPRESTACION',	'['||cod_prest1||']');
	xml2:=put_campo(xml2,'CTAITEMPRESTACION',	'['||item_prest1||']');
	xml2:=put_campo(xml2,'CTAGLOSAPRESTACION',	'['||glo_prest1||']');
	xml2:=put_campo(xml2,'CTACANTIDADPTD',		'['||cant_ptd1||']');
	xml2:=put_campo(xml2,'CTARECARGOHORA',		'['||rec_hrs1||']');
	xml2:=put_campo(xml2,'CTAVALORPRESTACION',	'['||val_prest1||']');
	xml2:=put_campo(xml2,'CTAAPORTEFINANCIADOR',	'['||apor_fin1||']');
	xml2:=put_campo(xml2,'CTACOPAGO',		'['||copago1||']');
	xml2:=put_campo(xml2,'CTAINTERNOISA',		'['||int_isa1||']');

	--Completo los tag con []. Reset del contador.
        j:=1;
        while (j<6) loop
               	--bonif_aux1:=get_campo('EXTTIPOBONIF'||j::varchar,xml2);
                --ext_cop_aux1:=get_campo('EXTCOPAGO'||j::varchar,xml2);
                xml2:=put_campo(xml2,'CTATIPOBONIF'||j::varchar,'['||get_campo('CTATIPOBONIF'||j::varchar,xml2)||']');
                xml2:=put_campo(xml2,'CTACOPAGO'||j::varchar,'['||get_campo('CTACOPAGO'||j::varchar,xml2)||']');
                j:=j+1;
        end loop;

        return xml2;
end;
$$
LANGUAGE plpgsql;
*/
