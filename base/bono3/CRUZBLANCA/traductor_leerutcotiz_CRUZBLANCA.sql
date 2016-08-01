CREATE OR REPLACE FUNCTION traductor_in_leerutcotiz_cruzblanca(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	declare_params	varchar;
        out_params  	varchar;
        insert1  	varchar;
        exec_sp		varchar;
        exec_end  	varchar;
	select1		varchar;

	cod_fin1 	varchar;
	rut_cotiz1	varchar;
/*
 @extCodFinanciador     smallint,
 @extRutCotizante       char(12),
 @extNomCotizante       char(40)  output,
 @extCodError           char(1)   output,
 @extMensajeError       char(30)  output
 @ExtCorrBenef	        Integer(3) output
 @extRutBeneficiario	char(12) output
 @extApellidoPat	char(30) output
 @extApellidoMat	char(30) output
 @extNombres		char(40) output
 @extCodEstBen		char(1)  output
 @extDescEstado		char(15) output

*/	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));	

	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
        rut_cotiz1      :=get_campo('EXTRUTCOTIZANTE',xml2);

        --Valida formato del Rut
        rut_cotiz1      :=motor_formato_rut(rut_cotiz1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_cotiz1='') then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_cotiz1);

	declare_params:='DECLARE @extCodFinanciador numeric (5)
	        DECLARE @extRutCotizante char(12)
	        DECLARE @extNomCotizante char(40)
        	DECLARE @extCodError char(1)
		DECLARE @extMensajeError char(30)
		DECLARE @extCorrBenef integer
		DECLARE @extRutBeneficiario char(12)
		DECLARE @extApellidoPat char(30)
		DECLARE @extApellidoMat char(30)
		DECLARE @extNombres char(40)
		DECLARE @extCodEstBen char(1)
		DECLARE @extDescEstado char(15) ';

	exec_sp:= 'execute prestacion..INGLeeRutCotiz '||cod_fin1||',"'||rut_cotiz1||'", @extNomCotizante OUTPUT, @extCodError OUTPUT, @extMensajeError OUTPUT ';
	/*Ejemplo*/ 
	--exec_sp:= exec prestacion..INGLeeRutCotiz 78, '0005308213-0', @extNomCotizante output, @extCodError output, @extMensajeError output;
	--select1:= ' select extCorrBenef, extRutBeneficiario, extApellidoPat, extApellidoMat, extNombres, extCodEstBen, extDescEstado from tempdb02..ILR_GrupoContrato where spid = @@spid ';

	--out_params:='select @extNomCotizante as extNomCotizante, @extCodError as extCodError, @extMensajeError as extMensajeError ';
	out_params:='select @extNomCotizante as extNomCotizante, @extCodError as extCodError, @extMensajeError as extMensajeError,@extCorrBenef as extCorrBenef, @extRutBeneficiario as extRutBeneficiario, @extApellidoPat as extApellidoPat, @extApellidoMat as extApellidoMat, @extNombres as extNombres, @extCodEstBen as extCodEstBen, @extDescEstado as extDescEstado '; 

        --xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||select1||out_params);
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
		
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_leerutcotiz_cruzblanca(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar ='1';
	i		integer;
	nombre_cotiz1	varchar;
	cod_resp1	varchar;
	mensaje_resp1	varchar;

	corr_benef1     varchar ='';
        rut_benef1      varchar ='';
        apell_pat1      varchar ='';
        apell_mat1      varchar ='';
        nombres1        varchar ='';
        cod_est_benef1  varchar ='';
        desc_estado1    varchar ='';

        --Variables Acum
        corr_aux1       varchar;
        rut_aux1        varchar;
        pat_aux1        varchar;
        mat_aux1        varchar;
        nom_aux1        varchar;
        cod_aux1        varchar;
        desc_aux1       varchar;	

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	while true loop
                corr_aux1       :=trim(get_campo('EXTCORRBENEF_'||i::varchar,xml2));      	--EXTCORRBENEF
                rut_aux1        :=trim(get_campo('EXTRUTBENEFICIARIO_'||i::varchar,xml2));      --EXTRUTBENEFICIARIO
                pat_aux1        :=trim(get_campo('EXTAPELLIDOPAT_'||i::varchar,xml2));     	--EXTAPELLIDOPAT
                mat_aux1        :=trim(get_campo('EXTAPELLIDOMAT_'||i::varchar,xml2));     	--EXTAPELLIDOMAT
                nom_aux1        :=trim(get_campo('EXTNOMBRES_'||i::varchar,xml2));     		--EXTNOMBRES
                cod_aux1        :=trim(get_campo('EXTCODESTBEN_'||i::varchar,xml2));      	--EXTCODESTBEN
                desc_aux1       :=trim(get_campo('EXTDESCESTADO_'||i::varchar,xml2));      	--EXTDESCESTADO

                --Estos valores podrian no venir en la respuesta
                if length(corr_aux1)>0 or length(rut_aux1)>0 or length(pat_aux1)>0 or length(mat_aux1)>0 or length(nom_aux1)>0 or length(cod_aux1)>0 or length(desc_aux1)>0 then
                        corr_benef1     :=corr_benef1||corr_aux1||',';
                        rut_benef1      :=rut_benef1||rut_aux1||',';
                        apell_pat1      :=apell_pat1||pat_aux1||',';
                        apell_mat1      :=apell_mat1||mat_aux1||',';
                        nombres1        :=nombres1||nom_aux1||',';
                        cod_est_benef1  :=cod_est_benef1||cod_aux1||',';
                        desc_estado1    :=desc_estado1||desc_aux1||',';
                else
                        --Quito la ultima coma (ya que no volvera al ciclo) y se sale
                        if length(corr_benef1)>0 or length(rut_benef1)>0 or length(apell_pat1)>0 or length(apell_mat1)>0 or length(nombres1)>0 or length(cod_est_benef1)>0 or length(desc_estado1)>0 then
                                corr_benef1     :=substring(corr_benef1,1,length(corr_benef1)-1);
                                rut_benef1      :=substring(rut_benef1,1,length(rut_benef1)-1);
                                apell_pat1      :=substring(apell_pat1,1,length(apell_pat1)-1);
                                apell_mat1      :=substring(apell_mat1,1,length(apell_mat1)-1);
                                nombres1        :=substring(nombres1,1,length(nombres1)-1);
                                cod_est_benef1  :=substring(cod_est_benef1,1,length(cod_est_benef1)-1);
                                desc_estado1    :=substring(desc_estado1,1,length(desc_estado1)-1);
                        end if;
                        exit;
                end if;
                i:=i+1;
        end loop;

        --Parseo el 2do Select
        nombre_cotiz1   :=trim(get_campo('EXTNOMCOTIZANTE_'||i::varchar,xml2));
        cod_resp1       :=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
        mensaje_resp1   :=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));

	 xml2:=logapp(xml2,'CRUZBLANCA: RSP_LEERUTCOTIZ -> extNombreCotiz1='||nombre_cotiz1||' -extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1||' -extCorrBenef1='||corr_benef1||' -extRutBenef1='||rut_benef1||' -extApellPat1='||apell_pat1||' -extApellMat1='||apell_mat1||' -extNombres1='||nombres1||' -extCodEstBenef1='||cod_est_benef1||' -extDescEstado1='||desc_estado1);

        --raise notice 'JCC_LEERUTCOTIZ_Receive extNomCotizante=% - extCodError=% - extMensajeError=% - extApellidoPat=% ',nombre_cotiz1,cod_resp1,mensaje_resp1,apell_pat1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTNOMCOTIZANTE',nombre_cotiz1);
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

        xml2:=put_campo(xml2,'EXTCORRBENEF',corr_benef1);
        xml2:=put_campo(xml2,'EXTRUTBENEFICIARIO',rut_benef1);
        xml2:=put_campo(xml2,'EXTAPELLIDOPAT',apell_pat1);
        xml2:=put_campo(xml2,'EXTAPELLIDOMAT',apell_mat1);
        xml2:=put_campo(xml2,'EXTNOMBRES',nombres1);
        xml2:=put_campo(xml2,'EXTCODESTBEN',cod_est_benef1);
        xml2:=put_campo(xml2,'EXTDESCESTADO',desc_estado1);

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTNOMCOTIZANTE',xml2)||', '||
                                        get_campo('EXTCODERROR',xml2)||', '||get_campo('EXTMENSAJEERROR',xml2)||', '||
                                        get_campo('EXTCORRBENEF',xml2)||', '||get_campo('EXTRUTBENEFICIARIO',xml2)||', '||
                                        get_campo('EXTAPELLIDOPAT',xml2)||', '||get_campo('EXTAPELLIDOMAT',xml2)||', '||
                                        get_campo('EXTNOMBRES',xml2)||', '||get_campo('EXTCODESTBEN',xml2)||', '||
                                        get_campo('EXTDESCESTADO',xml2)||'}');


        return xml2;
end;
$$
LANGUAGE plpgsql;

