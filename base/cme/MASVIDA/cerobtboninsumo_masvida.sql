CREATE OR REPLACE FUNCTION traductor_in_cerobtboninsumo_masvida(varchar)
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
	xml2:=proc_parser_input_cerobtboninsumo(xml2);
	if get_campo('ERR',xml2)='S' then
                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CME');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error parser_input_'||get_campo('TX_WS',xml2));
                return xml2;
        end if;

	--Preparo la llamada al SP
	declare_params:='DECLARE @CtaCodError char(1)
		DECLARE @CtaMensajeError char(60)
		DECLARE @CtaCorrRegistro	numeric(4)
		DECLARE @CtaCodIntervenPtd	char(12)
		DECLARE @CtaCodIntervenHom	char(12)
		DECLARE @CtaNroIntenven		int
		DECLARE @CtaTipoDet		int
		DECLARE @CtaUrgencia		char(1)
		DECLARE @CtaCodInsumo		char(15)
		DECLARE @CtaDescInsumo		char(120)
		DECLARE @CtaMtoTotalIsapre	numeric(10)
		DECLARE @CtaMtoBonificado	numeric(10)
		DECLARE @CtaMtoCopago		numeric(10)
		DECLARE @CtaCodPrestRev		char(12)
		DECLARE @CtaTipoRevalorizacion	char(1) ';

	--Por ahora en duro
	--||get_campo('CTACODFINANCIADOR',xml2)||
	exec_sp:= 'EXECUTE dbo.cerobtboninsumo '||88||',
			['||get_campo('CTARUTCONVENIO',xml2)||'],
			['||get_campo('CTANUMCTA',xml2)||'],
			'||get_campo('CTANUMCOBRO',xml2)||', @CtaCodError OUTPUT, @CtaMensajeError OUTPUT, @CtaCorrRegistro OUTPUT, @CtaCodIntervenPtd OUTPUT, @CtaCodIntervenHom OUTPUT, @CtaNroIntenven OUTPUT, @CtaTipoDet OUTPUT, @CtaUrgencia OUTPUT, @CtaCodInsumo OUTPUT, @CtaDescInsumo OUTPUT, @CtaMtoTotalIsapre OUTPUT, @CtaMtoBonificado OUTPUT, @CtaMtoCopago OUTPUT, @CtaCodPrestRev OUTPUT, @CtaTipoRevalorizacion OUTPUT ';

	out_params:='SELECT @CtaCodError as CtaCodError, @CtaMensajeError as CtaMensajeError, @CtaCorrRegistro as CtaCorrRegistro, @CtaCodIntervenPtd as CtaCodIntervenPtd, @CtaCodIntervenHom as CtaCodIntervenHom, @CtaNroIntenven as CtaNroIntenven, @CtaTipoDet as CtaTipoDet, @CtaUrgencia as CtaUrgencia, @CtaCodInsumo as CtaCodInsumo, @CtaDescInsumo as CtaDescInsumo, @CtaMtoTotalIsapre as CtaMtoTotalIsapre, @CtaMtoBonificado as CtaMtoBonificado, @CtaMtoCopago as CtaMtoCopago, @CtaCodPrestRev as CtaCodPrestRev, @CtaTipoRevalorizacion as CtaTipoRevalorizacion ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_cerobtboninsumo_masvida(varchar)
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
	nro_inten1	varchar ='';
	tipo_det1	varchar ='';
	urgencia1	varchar ='';
	cod_insumo1	varchar ='';
	des_insumo1	varchar ='';
	mto_tot_isap1	varchar ='';
	mto_bonif1	varchar ='';
	mto_copag1	varchar ='';
	cod_prest_rev1	varchar ='';
	tipo_rev1	varchar ='';

	--Variables Aux
        corr_reg_aux1       varchar;
        cod_inter_ptd_aux1  varchar;
        cod_inter_hom_aux1  varchar;
        nro_inten_aux1      varchar;
        tipo_det_aux1       varchar;
        urgencia_aux1       varchar;
        cod_insumo_aux1     varchar;
        des_insumo_aux1     varchar;
        mto_tot_isap_aux1   varchar;
        mto_bonif_aux1      varchar;
        mto_copag_aux1      varchar;
        cod_prest_rev_aux1  varchar;
        tipo_rev_aux1       varchar;

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',clock_timestamp()::varchar);

	while true loop	
		corr_reg_aux1		:=trim(get_campo('CTACORRREGISTRO_'||i::varchar,xml2));
		cod_inter_ptd_aux1	:=trim(get_campo('CTACODINTERVENPTD_'||i::varchar,xml2));
		cod_inter_hom_aux1	:=trim(get_campo('CTACODINTERVENHOM_'||i::varchar,xml2));
		nro_inten_aux1		:=trim(get_campo('CTANROINTENVEN_'||i::varchar,xml2)); 
		tipo_det_aux1		:=trim(get_campo('CTATIPODET_'||i::varchar,xml2));
		urgencia_aux1		:=trim(get_campo('CTAURGENCIA_'||i::varchar,xml2));
		cod_insumo_aux1		:=trim(get_campo('CTACODINSUMO_'||i::varchar,xml2));
		des_insumo_aux1		:=trim(get_campo('CTADESCINSUMO_'||i::varchar,xml2));
		mto_tot_isap_aux1	:=trim(get_campo('CTAMTOTOTALISAPRE_'||i::varchar,xml2));
		mto_bonif_aux1		:=trim(get_campo('CTAMTOBONIFICADO_'||i::varchar,xml2));
		mto_copag_aux1		:=trim(get_campo('CTAMTOCOPAGO_'||i::varchar,xml2));
		cod_prest_rev_aux1	:=trim(get_campo('CTACODPRESTREV_'||i::varchar,xml2));
		tipo_rev_aux1		:=trim(get_campo('CTATIPOREVALORIZACION_'||i::varchar,xml2));

		--Si viene al menos uno de estos, obtiene 1er grupo reg.
                if length(corr_reg_aux1)>0 or length(cod_inter_ptd_aux1)>0 or length(cod_inter_hom_aux1)>0 or
                   length(nro_inten_aux1)>0 or length(tipo_det_aux1)>0 or length(urgencia_aux1)>0 or length(cod_insumo_aux1)>0 or 
		   length(des_insumo_aux1)>0 or length(mto_tot_isap_aux1)>0 or length(mto_bonif_aux1)>0 or 
		   length(mto_copag_aux1)>0 or length(cod_prest_rev_aux1)>0 or length(tipo_rev_aux1)>0 then

                        --Si hay valor. Concateno
                        corr_reg1       :=corr_reg1||corr_reg_aux1||',';
                        cod_inter_ptd1  :=cod_inter_ptd1||cod_inter_ptd_aux1||',';
                        cod_inter_hom1  :=cod_inter_hom1||cod_inter_hom_aux1||',';
                        nro_inten1 	:=nro_inten1||nro_inten_aux1||',';
                        tipo_det1 	:=tipo_det1||tipo_det_aux1||',';
                        urgencia1 	:=urgencia1||urgencia_aux1||',';
                        cod_insumo1 	:=cod_insumo1||cod_insumo_aux1||',';
                        des_insumo1	:=des_insumo1||des_insumo_aux1||',';
                        mto_tot_isap1 	:=mto_tot_isap1||mto_tot_isap_aux1||',';
                        mto_bonif1 	:=mto_bonif1||mto_bonif_aux1||',';
                        mto_copag1 	:=mto_copag1||mto_copag_aux1||',';
                        cod_prest_rev1 	:=cod_prest_rev1||cod_prest_rev_aux1||',';
                        tipo_rev1	:=tipo_rev1||tipo_rev_aux1||',';
                else
                        ----Quito la ultima coma (ya que no volvera al ciclo) y se sale
                        if length(corr_reg1)>0 or length(cod_inter_ptd1)>0 or length(cod_inter_hom1)>0 or
                           length(nro_inten1)>0 or length(tipo_det1)>0 or length(urgencia1)>0 or length(cod_insumo1)>0 or 
			   length(des_insumo1)>0 or length(mto_tot_isap1)>0 or length(mto_bonif1)>0 or
                           length(mto_copag1)>0 or length(cod_prest_rev1)>0 or length(tipo_rev1)>0 then

                                corr_reg1       :=substring(corr_reg1,1,length(corr_reg1)-1);
                                cod_inter_ptd1  :=substring(cod_inter_ptd1,1,length(cod_inter_ptd1)-1);
                                cod_inter_hom1  :=substring(cod_inter_hom1,1,length(cod_inter_hom1)-1);
                                nro_inten1  	:=substring(nro_inten1,1,length(nro_inten1)-1);
                                tipo_det1 	:=substring(tipo_det1,1,length(tipo_det1)-1);
                                urgencia1  	:=substring(urgencia1,1,length(urgencia1)-1);
                                cod_insumo1 	:=substring(cod_insumo1,1,length(cod_insumo1)-1);
                                des_insumo1     :=substring(des_insumo1,1,length(des_insumo1)-1);
                                mto_tot_isap1   :=substring(mto_tot_isap1,1,length(mto_tot_isap1)-1);
                                mto_bonif1      :=substring(mto_bonif1,1,length(mto_bonif1)-1);
                                mto_copag1    	:=substring(mto_copag1,1,length(mto_copag1)-1);
                                cod_prest_rev1  :=substring(cod_prest_rev1,1,length(cod_prest_rev1)-1);
                                tipo_rev1      	:=substring(tipo_rev1,1,length(tipo_rev1)-1);

                        end if;
                        exit;
                end if;
                i:=i+1;
        end loop;

	--Parseo respuesta
	cod_resp1	:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_resp1	:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));

	raise notice 'JCC_cerobtboninsumo_Receive CtaCodError=% - CtaMensajeError=%',cod_resp1,msj_resp1;
	raise notice 'JCC_cerobtboninsumo_Receive corr_reg1=% - cod_inter_ptd1=%',corr_reg1,cod_inter_ptd1;

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

	--Valores Opcionales (O/C)
--	xml2:=put_campo(xml2,'CTACORRREGISTRO',		corr_reg1);
	xml2:=put_campo(xml2,'CTACODINTERVENPTD',	cod_inter_ptd1);
	xml2:=put_campo(xml2,'CTACODINTERVENHOM',	cod_inter_hom1);
	xml2:=put_campo(xml2,'CTANROINTENVEN',		nro_inten1);
	xml2:=put_campo(xml2,'CTATIPODET',		tipo_det1);
	xml2:=put_campo(xml2,'CTAURGENCIA',		urgencia1);
	xml2:=put_campo(xml2,'CTACODINSUMO',		cod_insumo1);
	xml2:=put_campo(xml2,'CTADESCINSUMO',		des_insumo1);
	xml2:=put_campo(xml2,'CTAMTOTOTALISAPRE',	mto_tot_isap1);
	xml2:=put_campo(xml2,'CTAMTOBONIFICADO',	mto_bonif1);
	xml2:=put_campo(xml2,'CTAMTOCOPAGO',		mto_copag1);
	xml2:=put_campo(xml2,'CTACODPRESTREV',		cod_prest_rev1);
--	xml2:=put_campo(xml2,'CTATIPOREVALORIZACION',	tipo_rev1)/

        return xml2;
end;
$$
LANGUAGE plpgsql;

