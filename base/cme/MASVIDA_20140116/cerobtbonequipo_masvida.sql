CREATE OR REPLACE FUNCTION traductor_in_cerobtbonequipo_masvida(varchar)
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
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Llamo a la funcion input de parseo de datos.
	xml2:=proc_parser_input_cerobtbonequipo(xml2);

	--Preparo la llamada al SP
	declare_params:='DECLARE @CtaCodError char(1)
		DECLARE @CtaMensajeError char(60)
		DECLARE @CtaCorrRegistro	numeric(4)
		DECLARE @CtaCodIntervenPtd	char(12)
		DECLARE @CtaCodIntervenHom	char(12)
		DECLARE @CtaCodPrestPtd		char(12)
		DECLARE @CtaItemPrestPtd	char(3)
		DECLARE @CtaCodPrestHom		char(12)
		DECLARE @CtaItemPrestHom	char(3)
		DECLARE @CtaNroIntenven		tinyint
		DECLARE @CtaRutProfesional	char(12)
		DECLARE @CtaTipoProfesional	numeric(3)
		DECLARE @CtaMtoTotalIsapre	numeric(10)
		DECLARE @CtaMtoBonificado	numeric(10)
		DECLARE @CtaMtoCopago		numeric(10)
		DECLARE @CtaCodPrestRev		char(12) 
		DECLARE @CtaItemPrestRev	char(3) 
		DECLARE @CtaTipoRevalorizacion	char(1) ';

	--Por ahora en duro
	--||get_campo('CTACODFINANCIADOR',xml2)||
	exec_sp:= 'EXECUTE dbo.CEROBTBONEQUIPO '||88||',
			['||get_campo('CTARUTCONVENIO',xml2)||'],
			['||get_campo('CTANUMCTA',xml2)||'],
			'||get_campo('CTANUMCOBRO',xml2)||', @CtaCodError OUTPUT, @CtaMensajeError OUTPUT, @CtaCorrRegistro OUTPUT, @CtaCodIntervenPtd OUTPUT, @CtaCodIntervenHom OUTPUT, @CtaCodPrestPtd OUTPUT, @CtaItemPrestPtd OUTPUT, @CtaCodPrestHom OUTPUT, @CtaItemPrestHom OUPUT, @CtaNroIntenven OUTPUT, @CtaRutProfesional OUTPUT, @CtaTipoProfesional OUTPUT, @CtaMtoTotalIsapre OUTPUT, @CtaMtoBonificado OUTPUT, @CtaMtoCopago OUTPUT, @CtaCodPrestRev OUTPUT, @CtaItemPrestRev OUTPUT, @CtaTipoRevalorizacion OUTPUT ';

	out_params:='SELECT @CtaCodError as CtaCodError, @CtaMensajeError as CtaMensajeError, @CtaCorrRegistro as CtaCorrRegistro, @CtaCodIntervenPtd as CtaCodIntervenPtd, @CtaCodIntervenHom as CtaCodIntervenHom, @CtaCodPrestPtd as CtaCodPrest, @CtaItemPrestPtd as CtaItemPrestPtd, @CtaCodPrestHom as CtaCodPrestHom, @CtaItemPrestHom as CtaItemPrestHom, @CtaNroIntenven as CtaNroIntenven, @CtaRutProfesional as CtaRutProfesional, @CtaTipoProfesional as CtaTipoProfesional, @CtaMtoTotalIsapre as CtaMtoTotalIsapre, @CtaMtoBonificado as CtaMtoBonificado, @CtaMtoCopago as CtaMtoCopago, @CtaCodPrestRev as CtaCodPrestRev, @CtaItemPrestRev as CtaItemPrestRev, @CtaTipoRevalorizacion as CtaTipoRevalorizacion ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_cerobtbonequipo_masvida(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	cod_resp1	varchar;
	msj_resp1	varchar;

	--Valores Opcionales (O/C)	
	corr_reg1	varchar ='';
	cod_inter_ptd1	varchar ='';
	cod_inter_hom1	varchar ='';
	cod_prest_ptd1	varchar ='';
	item_prest_ptd1	varchar ='';
	cod_prest_hom1	varchar ='';
	item_prest_hom1	varchar ='';
	nro_inter1	varchar ='';
	rut_pro1	varchar ='';
	tip_pro1	varchar ='';
	mto_tot_isa1	varchar ='';
	mto_bon1	varchar ='';
	mto_cop1	varchar ='';
	cod_prest_rev1	varchar ='';
	item_prest_rev1	varchar ='';
	tip_reval1	varchar ='';

	--Variables Aux
	corr_reg_aux1       varchar;
        cod_inter_ptd_aux1  varchar;
        cod_inter_hom_aux1  varchar;
        cod_prest_ptd_aux1  varchar;
        item_prest_ptd_aux1 varchar;
        cod_prest_hom_aux1  varchar;
        item_prest_hom_aux1 varchar;
        nro_inter_aux1      varchar;
        rut_pro_aux1        varchar;
        tip_pro_aux1        varchar;
        mto_tot_isa_aux1    varchar;
        mto_bon_aux1        varchar;
        mto_cop_aux1        varchar;
        cod_prest_rev_aux1  varchar;
        item_prest_rev_aux1 varchar;
        tip_reval_aux1      varchar;

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	while true loop
		corr_reg_aux1		:=trim(get_campo('CTACORRREGISTRO_'||i::varchar,xml2));
		cod_inter_ptd_aux1	:=trim(get_campo('CTACODINTERVENPTD_'||i::varchar,xml2));
		cod_inter_hom_aux1 	:=trim(get_campo('CTACODINTERVENHOM_'||i::varchar,xml2));
		cod_prest_ptd_aux1	:=trim(get_campo('CTACODPRESTPTD_'||i::varchar,xml2));
		item_prest_ptd_aux1	:=trim(get_campo('CTAITEMPRESTPTD_'||i::varchar,xml2)); 
		cod_prest_hom_aux1	:=trim(get_campo('CTACODPRESTHOM_'||i::varchar,xml2));
		item_prest_hom_aux1	:=trim(get_campo('CTAITEMPRESTHOM_'||i::varchar,xml2));
		nro_inter_aux1		:=trim(get_campo('CTANROINTENVEN_'||i::varchar,xml2));
		rut_pro_aux1		:=trim(get_campo('CTARUTPROFESIONAL_'||i::varchar,xml2));
		tip_pro_aux1		:=trim(get_campo('CTATIPOPROFESIONAL_'||i::varchar,xml2));
		mto_tot_isa_aux1	:=trim(get_campo('CTAMTOTOTALISAPRE_'||i::varchar,xml2));
		mto_bon_aux1		:=trim(get_campo('CTAMTOBONIFICADO_'||i::varchar,xml2));
		mto_cop_aux1		:=trim(get_campo('CTAMTOCOPAGO_'||i::varchar,xml2));
		cod_prest_rev_aux1	:=trim(get_campo('CTACODPRESTREV_'||i::varchar,xml2));
		item_prest_rev_aux1	:=trim(get_campo('CTAITEMPRESTREV_'||i::varchar,xml2));
		tip_reval_aux1		:=trim(get_campo('CTATIPOREVALORIZACION_'||i::varchar,xml2));
		
		--Si viene al menos uno de estos, obtiene 1er grupo reg.
                if length(corr_reg_aux1)>0 or length(cod_inter_ptd_aux1)>0 or length(cod_inter_hom_aux1)>0 or 
		   length(cod_prest_ptd_aux1)>0 or length(item_prest_ptd_aux1)>0 or length(cod_prest_hom_aux1)>0 or 
		   length(item_prest_hom_aux1)>0 or length(nro_inter_aux1)>0 or length(rut_pro_aux1)>0 or length(tip_pro_aux1)>0 or 
		   length(mto_tot_isa_aux1)>0 or length(mto_bon_aux1)>0 or length(mto_cop_aux1)>0 or length(cod_prest_rev_aux1)>0 or
		   length(item_prest_rev_aux1)>0 or length(tip_reval_aux1)>0 then 

			--Si hay valor. Concateno
			corr_reg1	:=corr_reg1||corr_reg_aux1||',';
			cod_inter_ptd1	:=cod_inter_ptd1||cod_inter_ptd_aux1||',';
			cod_inter_hom1	:=cod_inter_hom1||cod_inter_hom_aux1||',';
			cod_prest_ptd1	:=cod_prest_ptd1||cod_prest_ptd_aux1||',';
			item_prest_ptd1	:=item_prest_ptd1||item_prest_ptd_aux1||',';
			cod_prest_hom1	:=cod_prest_hom1||cod_prest_hom_aux1||',';
			item_prest_hom1	:=item_prest_hom1||item_prest_hom_aux1||',';
			nro_inter1	:=nro_inter1||nro_inter_aux1||',';
			rut_pro1	:=rut_pro1||rut_pro_aux1||',';
			tip_pro1	:=tip_pro1||tip_pro_aux1||',';
			mto_tot_isa1	:=mto_tot_isa1||mto_tot_isa_aux1||',';
			mto_bon1	:=mto_bon1||mto_bon_aux1||',';
			mto_cop1	:=mto_cop1||mto_cop_aux1||',';
			cod_prest_rev1	:=cod_prest_rev1||cod_prest_rev_aux1||',';
			item_prest_rev1	:=item_prest_rev1||item_prest_rev_aux1||',';
			tip_reval1	:=tip_reval1||tip_reval_aux1||',';
		else 
			----Quito la ultima coma (ya que no volvera al ciclo) y se sale
	                if length(corr_reg1)>0 or length(cod_inter_ptd1)>0 or length(cod_inter_hom1)>0 or
	                   length(cod_prest_ptd1)>0 or length(item_prest_ptd1)>0 or length(cod_prest_hom1)>0 or
        	           length(item_prest_hom1)>0 or length(nro_inter1)>0 or length(rut_pro1)>0 or length(tip_pro1)>0 or
			   length(mto_tot_isa1)>0 or length(mto_bon1)>0 or length(mto_cop1)>0 or length(cod_prest_rev1)>0 or
	                   length(item_prest_rev1)>0 or length(tip_reval1)>0 then
				
				corr_reg1	:=substring(corr_reg1,1,length(corr_reg1)-1);
				cod_inter_ptd1	:=substring(cod_inter_ptd1,1,length(cod_inter_ptd1)-1);
				cod_inter_hom1	:=substring(cod_inter_hom1,1,length(cod_inter_hom1)-1);
				cod_prest_ptd1	:=substring(cod_prest_ptd1,1,length(cod_prest_ptd1)-1);
				item_prest_ptd1	:=substring(item_prest_ptd1,1,length(item_prest_ptd1)-1);
				cod_prest_hom1	:=substring(cod_prest_hom1,1,length(cod_prest_hom1)-1);
				item_prest_hom1	:=substring(item_prest_hom1,1,length(item_prest_hom1)-1);
				nro_inter1	:=substring(nro_inter1,1,length(nro_inter1)-1);
				rut_pro1	:=substring(rut_pro1,1,length(rut_pro1)-1);
				tip_pro1	:=substring(tip_pro1,1,length(tip_pro1)-1);
				mto_tot_isa1	:=substring(mto_tot_isa1,1,length(mto_tot_isa1)-1);
				mto_bon1	:=substring(mto_bon1,1,length(mto_bon1)-1);
				mto_cop1	:=substring(mto_cop1,1,length(mto_cop1)-1);
				cod_prest_rev1	:=substring(cod_prest_rev1,1,length(cod_prest_rev1)-1);
				item_prest_rev1	:=substring(item_prest_rev1,1,length(item_prest_rev1)-1);
				tip_reval1	:=substring(tip_reval1,1,length(tip_reval1)-1);

                        end if;
                        exit;
                end if;
                i:=i+1;
        end loop;

	--Parseo respuesta
	cod_resp1	:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_resp1	:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));

	raise notice 'JCC_cerobtbonequipo_Receive CtaCodError=% - CtaMensajeError=%',cod_resp1,msj_resp1;
	raise notice 'JCC_cerobtbonequipo_Receive corr_reg1=% - cod_inter_ptd1=%',corr_reg1,cod_inter_ptd1;

        /*xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;

	xml2:=put_campo(xml2,'CTACODERROR',cod_resp1);
        xml2:=put_campo(xml2,'CTAMENSAJEERROR',msj_resp1);*/

	xml2:=put_campo(xml2,'ERR',cod_resp1);
        xml2:=put_campo(xml2,'GLOSA',msj_resp1);

	--Valores Opcionales (O/C)
	/*xml2:=put_campo(xml2,'CTACORRREGISTRO',corr_reg1);
	xml2:=put_campo(xml2,'CTACODINTERVENPTD',cod_inter_ptd1);
	xml2:=put_campo(xml2,'CTACODINTERVENHOM',cod_inter_hom1);
	
	xml2:=put_campo(xml2,'CTACODPRESTPTD',	cod_prest_ptd1);
	xml2:=put_campo(xml2,'CTAITEMPRESTPTD',	item_prest_ptd1);
	xml2:=put_campo(xml2,'CTACODPRESTHOM',	cod_prest_hom1);
	xml2:=put_campo(xml2,'CTAITEMPRESTHOM',	item_prest_hom1);
	xml2:=put_campo(xml2,'CTANROINTENVEN',	nro_inter1);
	xml2:=put_campo(xml2,'CTARUTPROFESIONAL',rut_pro1);
	xml2:=put_campo(xml2,'CTATIPOPROFESIONAL',tip_pro1);
	xml2:=put_campo(xml2,'CTAMTOTOTALISAPRE',mto_tot_isa1);
	xml2:=put_campo(xml2,'CTAMTOBONIFICADO',mto_bon1);
	xml2:=put_campo(xml2,'CTAMTOCOPAGO',	mto_cop1);
	xml2:=put_campo(xml2,'CTACODPRESTREV',	cod_prest_rev1);
	xml2:=put_campo(xml2,'CTAITEMPRESTREV',	item_prest_rev1);
	xml2:=put_campo(xml2,'CTATIPOREVALORIZACION',tip_reval1);*/

        return xml2;
end;
$$
LANGUAGE plpgsql;

