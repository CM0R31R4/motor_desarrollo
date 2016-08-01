CREATE OR REPLACE FUNCTION traductor_in_cerobtpaquete_masvida(varchar)
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
	xml2:=proc_parser_input_cerobtpaquete(xml2);

	--Preparo la llamada al SP
	declare_params:='DECLARE @CtaCodError char(1)
		DECLARE @CtaMensajeError char(60)
		DECLARE @CtaCorrRegistro	numeric(4)
		DECLARE @CtaCodIntervenPtd	char(12)
		DECLARE @CtaDescIntervenPtd	char(120)
		DECLARE @CtaCodIntervenHom	char(12)
		DECLARE @CtaNroIntenven		int
		DECLARE @CtaCodPaquete		char(12)
		DECLARE @CtaDescPaquete		char(120)
		DECLARE @CtaCodPaqueteHom	char(12)
		DECLARE @CtaTipoGrupo		int
		DECLARE @CtaMtoTotalIsapre	numeric(10)
		DECLARE @CtaMtoBonificado	numeric(10)
		DECLARE @CtaMtoCopago		numeric(10)
		DECLARE @CtaCodPrestRev		char(12)
		DECLARE @CtaTipoRevalorizacion	char(1) ';

	--Por ahora en duro
	--||get_campo('CTACODFINANCIADOR',xml2)||
	exec_sp:= 'EXECUTE dbo.CEROBTPAQUETE '||88||',
			['||get_campo('CTARUTCONVENIO',xml2)||'],
			['||get_campo('CTANUMCTA',xml2)||'],
			'||get_campo('CTANUMCOBRO',xml2)||', @CtaCodError OUTPUT, @CtaMensajeError OUTPUT, @CtaCorrRegistro OUTPUT, @CtaCodIntervenPtd OUTPUT, @CtaDescIntervenPtd OUTPUT, @CtaCodIntervenHom OUTPUT, @CtaNroIntenven OUTPUT, @CtaCodPaquete OUTPUT, @CtaDescPaquete OUTPUT, @CtaCodPaqueteHom OUTPUT, @CtaTipoGrupo OUTPUT, @CtaMtoTotalIsapre OUTPUT, @CtaMtoBonificado OUTPUT, @CtaMtoCopago OUTPUT, @CtaCodPrestRev OUTPUT, @CtaTipoRevalorizacion OUTPUT ';

	out_params:='SELECT @CtaCodError as CtaCodError, @CtaMensajeError as CtaMensajeError, @CtaCorrRegistro as CtaCorrRegistro, @CtaCodIntervenPtd as CtaCodIntervenPtd, @CtaDescIntervenPtd as CtaDescIntervenPtd, @CtaCodIntervenHom as CtaCodIntervenHom, @CtaNroIntenven as CtaNroIntenven, @CtaCodPaquete as CtaCodPaquete, @CtaDescPaquete as CtaDescPaquete, @CtaCodPaqueteHom as CtaCodPaqueteHom, @CtaTipoGrupo as CtaTipoGrupo, @CtaMtoTotalIsapre as CtaMtoTotalIsapre, @CtaMtoBonificado as CtaMtoBonificado, @CtaMtoCopago as CtaMtoCopago, @CtaCodPrestRev as CtaCodPrestRev, @CtaTipoRevalorizacion as CtaTipoRevalorizacion ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_cerobtpaquete_masvida(varchar)
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
	des_inter_ptd1	varchar ='';
	cod_inter_hom1	varchar ='';
	nro_inten1	varchar ='';
	cod_paquet1	varchar ='';
	des_paquet1	varchar ='';
	cod_paquet_hom1	varchar ='';
	tip_grupo1	varchar ='';
	mto_tot_isap1	varchar ='';
	mto_bonif1	varchar ='';
	mto_copag1	varchar ='';
	cod_prest_rev1	varchar ='';
	tipo_rev1	varchar ='';

	--Variables Aux
        corr_reg_aux1       varchar;
        cod_inter_ptd_aux1  varchar;
        des_inter_ptd_aux1  varchar;
        cod_inter_hom_aux1  varchar;
        nro_inten_aux1      varchar;
        cod_paquet_aux1     varchar;
        des_paquet_aux1     varchar;
        cod_paquet_hom_aux1 varchar;
        tip_grupo_aux1      varchar;
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
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));


	while true loop
	       	corr_reg_aux1       :=trim(get_campo('CTACORRREGISTRO_'||i::varchar,xml2));
	        cod_inter_ptd_aux1  :=trim(get_campo('CTACODINTERVENPTD_'||i::varchar,xml2));
        	des_inter_ptd_aux1  :=trim(get_campo('CTADESCINTERVENPTD_'||i::varchar,xml2));
	        cod_inter_hom_aux1  :=trim(get_campo('CTACODINTERVENHOM_'||i::varchar,xml2));
	        nro_inten_aux1      :=trim(get_campo('CTANROINTENVEN_'||i::varchar,xml2));
        	cod_paquet_aux1     :=trim(get_campo('CTACODPAQUETE_'||i::varchar,xml2));
	        des_paquet_aux1     :=trim(get_campo('CTADESCPAQUETE_'||i::varchar,xml2));
        	cod_paquet_hom_aux1 :=trim(get_campo('CTACODPAQUETEHOM_'||i::varchar,xml2));
	        tip_grupo_aux1      :=trim(get_campo('CTATIPOGRUPO_'||i::varchar,xml2));
        	mto_tot_isap_aux1   :=trim(get_campo('CTAMTOTOTALISAPRE_'||i::varchar,xml2));
	        mto_bonif_aux1      :=trim(get_campo('CTAMTOBONIFICADO_'||i::varchar,xml2));
        	mto_copag_aux1      :=trim(get_campo('CTAMTOCOPAGO_'||i::varchar,xml2));
	        cod_prest_rev_aux1  :=trim(get_campo('CTACODPRESTREV_'||i::varchar,xml2));
        	tipo_rev_aux1       :=trim(get_campo('CTATIPOREVALORIZACION_'||i::varchar,xml2));	
	
		--Si viene al menos uno de estos, obtiene 1er grupo reg.
                if length(corr_reg_aux1)>0 or length(cod_inter_ptd_aux1)>0 or length(des_inter_ptd_aux1)>0 or
		   length(cod_inter_hom_aux1)>0 or length(nro_inten_aux1)>0 or length(cod_paquet_aux1)>0 or 
		   length(des_paquet_aux1)>0 or length(cod_paquet_hom_aux1)>0 or length(tip_grupo_aux1)>0 or 
		   length(mto_tot_isap_aux1)>0 or length(mto_bonif_aux1)>0 or length(mto_copag_aux1)>0 or 
		   length(cod_prest_rev_aux1)>0 or length(tipo_rev_aux1)>0 then

                        --Si hay valor. Concateno
                        corr_reg1       :=corr_reg1||corr_reg_aux1||',';
                        cod_inter_ptd1  :=cod_inter_ptd1||cod_inter_ptd_aux1||',';
                        des_inter_ptd1  :=des_inter_ptd1||des_inter_ptd_aux1||',';
                        cod_inter_hom1  :=cod_inter_hom1||cod_inter_hom_aux1||',';
                        nro_inten1      :=nro_inten1||nro_inten_aux1||',';
			cod_paquet1 	:=cod_paquet1||cod_paquet_aux1||',';
                        des_paquet1 	:=des_paquet1||des_paquet_aux1||',';
                        cod_paquet_hom1 :=cod_paquet_hom1||cod_paquet_hom_aux1||',';
                        tip_grupo1   	:=tip_grupo1||tip_grupo_aux1||',';
                        mto_tot_isap1   :=mto_tot_isap1||mto_tot_isap_aux1||',';
                        mto_bonif1      :=mto_bonif1||mto_bonif_aux1||',';
                        mto_copag1      :=mto_copag1||mto_copag_aux1||',';
                        cod_prest_rev1  :=cod_prest_rev1||cod_prest_rev_aux1||',';
                        tipo_rev1       :=tipo_rev1||tipo_rev_aux1||',';
                else
                        ----Quito la ultima coma (ya que no volvera al ciclo) y se sale
                        if length(corr_reg1)>0 or length(cod_inter_ptd1)>0 or length(des_inter_ptd1)>0 or 
			   length(cod_inter_hom1)>0 or length(nro_inten1)>0 or length(cod_paquet1)>0 or 
			   length(des_paquet1)>0 or length(cod_paquet_hom1)>0 or length(tip_grupo1)>0 or 
			   length(mto_tot_isap1)>0 or length(mto_bonif1)>0 or length(mto_copag1)>0 or 
			   length(cod_prest_rev1)>0 or length(tipo_rev1)>0 then

                                corr_reg1       :=substring(corr_reg1,1,length(corr_reg1)-1);
                                cod_inter_ptd1  :=substring(cod_inter_ptd1,1,length(cod_inter_ptd1)-1);
                                des_inter_ptd1  :=substring(des_inter_ptd1,1,length(des_inter_ptd1)-1);
                                cod_inter_hom1  :=substring(cod_inter_hom1,1,length(cod_inter_hom1)-1);
                                nro_inten1      :=substring(nro_inten1,1,length(nro_inten1)-1);
                                cod_paquet1     :=substring(cod_paquet1,1,length(cod_paquet1)-1);
                                des_paquet1     :=substring(des_paquet1,1,length(des_paquet1)-1);
                                cod_paquet_hom1 :=substring(cod_paquet_hom1,1,length(cod_paquet_hom1)-1);
                                tip_grupo1     	:=substring(tip_grupo1,1,length(tip_grupo1)-1);
                                mto_tot_isap1   :=substring(mto_tot_isap1,1,length(mto_tot_isap1)-1);
                                mto_bonif1      :=substring(mto_bonif1,1,length(mto_bonif1)-1);
                                mto_copag1      :=substring(mto_copag1,1,length(mto_copag1)-1);
                                cod_prest_rev1  :=substring(cod_prest_rev1,1,length(cod_prest_rev1)-1);
                                tipo_rev1       :=substring(tipo_rev1,1,length(tipo_rev1)-1);

                        end if;
                        exit;
                end if;
                i:=i+1;
        end loop;

	--Parseo respuesta
	cod_resp1	:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_resp1	:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));
	
	raise notice 'JCC_cerobtpaquete_Receive CtaCodError=% - CtaMensajeError=%',cod_resp1,msj_resp1;
	raise notice 'JCC_cerobtpaquete_Receive corr_reg1=% - cod_inter_ptd1=%',corr_reg1,cod_inter_ptd1;

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
	xml2:=put_campo(xml2,'CTACORRREGISTRO',		corr_reg1);
	xml2:=put_campo(xml2,'CTACODINTERVENPTD',	cod_inter_ptd1);
	xml2:=put_campo(xml2,'CTADESCINTERVENPTD',	des_inter_ptd1);
	xml2:=put_campo(xml2,'CTACODINTERVENHOM',	cod_inter_hom1);
	xml2:=put_campo(xml2,'CTANROINTENVEN',		nro_inten1);
	xml2:=put_campo(xml2,'CTACODPAQUETE',		cod_paquet1);
	xml2:=put_campo(xml2,'CTADESCPAQUETE',		des_paquet1);
	xml2:=put_campo(xml2,'CTACODPAQUETEHOM',	cod_paquet_hom1);
	xml2:=put_campo(xml2,'CTATIPOGRUPO',		tip_grupo1);
	xml2:=put_campo(xml2,'CTAMTOTOTALISAPRE',	mto_tot_isap1);
	xml2:=put_campo(xml2,'CTAMTOBONIFICADO',	mto_bonif1);
	xml2:=put_campo(xml2,'CTAMTOCOPAGO',		mto_copag1);
	xml2:=put_campo(xml2,'CTACODPRESTREV',		cod_prest_rev1);
	xml2:=put_campo(xml2,'CTATIPOREVALORIZACION',	tipo_rev1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

