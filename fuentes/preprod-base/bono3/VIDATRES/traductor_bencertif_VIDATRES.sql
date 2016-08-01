CREATE OR REPLACE FUNCTION traductor_in_bencertif_vidatres(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	cod_fin1 	varchar;
        rut_ben1	varchar;
        fecha_actual1 	varchar;
        l_array 	varchar;
/*
      @extCodFinanciador              int
    , @extRutBeneficiario             char(12)
    , @extFechaActual                 datetime
    , @extApellidoPat                 char(30)        Output
    , @extApellidoMat                 char(30)        Output
    , @extNombres                     char(40)        Output
    , @extSexo                        char(1)         Output
    , @extFechaNacimi                 datetime        Output
    , @extCodEstBen                   char(1)         Output
    , @extDescEstado                  char(15)        Output
    , @extRutCotizante                char(12)        Output
    , @extNomCotizante                char(40)        Output
    , @extDirPaciente                 char(40)        Output
    , @extGlosaComuna                 char(30)        Output
    , @extGlosaCiudad                 char(30)        Output
    , @extPrevision                   char(1)         Output
    , @extGlosa                       char(40)        Output
    , @extPlan                        char(15)        Output
    , @extDescuentoxPlanilla          char(1)         Output
    , @extMontoExcedente              numeric(10,0)   Output
*/
	
begin
        xml2:=xml1;
	l_array:=40;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--fecha_actual1	:=to_char((get_campo('EXTFECHAACTUAL',xml2))::date, 'DD-MON-YYYY');	--23-JUL-2013
	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_ben1        :=get_campo('EXTRUTBENEFICIARIO',xml2);
        fecha_actual1   :=to_char(get_campo('EXTFECHAACTUAL',xml2)::date, 'DD-MON-YY');

	--Valida formato del Rut
        /*rut_ben1:=motor_formato_rut(rut_ben1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_ben1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
	--rut_ben1:=split_part(rut_ben1,'-',1);
        xml2    :=put_campo(xml2,'RUT_BASE',rut_ben1);

	xml2:=put_campo(xml2,'SQLINPUT','["INFOMEDICA.VIDBENCERTIF_PKG.VIDBENCERTIF", [ "$o$STRING", '||cod_fin1||','||chr(34)||rut_ben1||chr(34)||','||chr(34)||fecha_actual1||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$NUMBER", "$o$STRING['||l_array||']", "$o$STRING['||l_array||']" ]]'||chr(10)||chr(10));

	--xml2:=put_campo(xml2,'SQLINPUT','["IMEDSOF.CONBENCERTIF_PKG.CONBENCERTIF", [ "$o$STRING", '||extCodFinanciador||','||chr(34)||extRutBeneficiario||chr(34)||','||chr(34)||extFechaActual||chr(34)||', "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$NUMBER", "$o$STRING['||l_array||']", "$o$STRING['||l_array||']" ]]'||chr(10)||chr(10));
		
	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_bencertif_vidatres(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	aux1            varchar;
        resp1           varchar;

	apell_pat1	varchar;
	apell_mat1	varchar;
	nombre1		varchar;
	sexo1		varchar;
	fecha_nac1	varchar;
	cod_est_ben1	varchar;
	desc_estado1	varchar;
	rut_cotiza1	varchar;
	nom_cotiza1	varchar;
	direccion1	varchar;
	glosa_comuna1	varchar;
	glosa_ciudad1	varchar;
	prevision1	varchar;
	glosa1		varchar;
	plan1		varchar;
	dscto_planilla1	varchar;
	monto_exec1	varchar;
	rut_acompa1	varchar;
	nom_acompa1	varchar;
	ano1		varchar;
	ano_now1	varchar;
begin
        xml2:=xml1;
	xml2  	:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  	:=put_campo(xml2,'CODIGO_RESP','1');
        xml2  	:=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2  	:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Paseo la respuesta
	resp1:=replace(get_campo('SQLOUTPUT',xml2),chr(10),'');
	--Si no esta el tag result es porque hay error
        aux1:=json_field(resp1,'result');
        if aux1 is null then
                --Vemos si hay error del ORACLE
                aux1:=json_field(resp1,'ora-msg');
                if aux1 is not null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                --Otro Error
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
			xml2:=put_campo(xml2,'ERRORMSG','VidaTres:Error_Bencertif');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
                return xml2;
        end if;
		
	apell_pat1	:=trim(replace(json_field(aux1,'1'),'"',''));
	apell_mat1	:=trim(replace(json_field(aux1,'2'),'"',''));	
	nombre1		:=trim(replace(json_field(aux1,'3'),'"',''));
	sexo1		:=trim(replace(json_field(aux1,'4'),'"',''));
	fecha_nac1	:=trim(replace(json_field(aux1,'5'),'"',''));
	cod_est_ben1	:=trim(replace(json_field(aux1,'6'),'"',''));
	desc_estado1	:=trim(replace(json_field(aux1,'7'),'"',''));
	rut_cotiza1	:=trim(replace(json_field(aux1,'8'),'"',''));
	nom_cotiza1	:=trim(replace(json_field(aux1,'9'),'"',''));
	direccion1	:=trim(replace(json_field(aux1,'10'),'"',''));
	glosa_comuna1	:=trim(replace(json_field(aux1,'11'),'"',''));
	glosa_ciudad1	:=trim(replace(json_field(aux1,'12'),'"',''));
	prevision1	:=trim(replace(json_field(aux1,'13'),'"',''));
	glosa1		:=trim(replace(json_field(aux1,'14'),'"',''));
	plan1		:=trim(replace(json_field(aux1,'15'),'"',''));
	dscto_planilla1	:=trim(replace(json_field(aux1,'16'),'"',''));
	monto_exec1	:=trim(replace(json_field(aux1,'17'),'"',''));
	rut_acompa1	:=trim(replace(json_field(aux1,'18'),'", "','","'));
	nom_acompa1	:=trim(replace(json_field(aux1,'19'),'", "','","'));

	xml2:=logapp(xml2,'VIDATRES: RSP_BENCERTIF -> extApellidoPat='||apell_pat1||' -extApellidoMat='||apell_mat1||' -extNombres='||nombre1||' -extSexo='||sexo1||' -extFechaNacimi='||fecha_nac1||' -extCodEstBen='||cod_est_ben1||' -extDescEstado='||desc_estado1||' -extRutCotizante='||rut_cotiza1||' -extNomCotizante='||nom_cotiza1||' -extDirPaciente='||direccion1||' -extGlosaComuna='||glosa_comuna1||' -extGlosaCiudad='||glosa_ciudad1||' -extPrevision='||prevision1||' -extGlosa='||glosa1||' -extPlan='||plan1||' -extDescuentoxPlanilla='||dscto_planilla1||' -extMontoExcedente='||monto_exec1||' -extRutAcompanante='||rut_acompa1||' -extNombreAcompanante='||nom_acompa1);

        cod_est_ben1    :=trim(replace(json_field(aux1,'6'),'"',''));
	--Beneficiario Certificado
        if (cod_est_ben1='C') or (cod_est_ben1='G') or (cod_est_ben1='S') then
		--Resp OK fecha_nac viene asi 12-AUG-13 - 01-JAN-32
                fecha_nac1:=to_char(to_date(fecha_nac1,'DD Mon YY'),'YYYYMMDD');
                xml2:=put_campo(xml2,'ERRORMSG','');
        else
                --Resp viene con error/rechazo, fecha_nac viene asi 1900/01/01
                --fecha_nac1:=to_char(to_date(fecha_nac1,'YYYY-MM-DD'),'YYYYMMDD');
                fecha_nac1:='';
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Rechazado');
                xml2:=put_campo(xml2,'ERRORMSG',trim(replace(json_field(aux1,'0'),'"','')));
        end if;


	if glosa_comuna1='null' then glosa_comuna1=''; end if;
        if glosa_ciudad1='null' then glosa_ciudad1=''; end if;
        if direccion1='null' then direccion1=''; end if;
        if glosa1='null' or glosa1='no' then glosa1=''; end if;
	
	--Cuando fecha 01-JAN-32 = 20320101
	if length(fecha_nac1)>0 then
                ano1:=substring(fecha_nac1,1,4);
                ano_now1:=split_part(now()::varchar,'-','1');
                if ano1 > ano_now1 then
                        ano1 :=(ano1::integer - 100)::varchar;
                        fecha_nac1:= ano1 || substring(fecha_nac1,5,4);
                end if;
        end if;
	
	xml2:=put_campo(xml2,'ERRORCOD','0');
        --xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
	xml2:=put_campo(xml2,'EXTAPELLIDOPAT',apell_pat1);
        xml2:=put_campo(xml2,'EXTAPELLIDOMAT',apell_mat1);
        xml2:=put_campo(xml2,'EXTNOMBRES',nombre1);
        xml2:=put_campo(xml2,'EXTSEXO',sexo1);
        xml2:=put_campo(xml2,'EXTFECHANACIMI',fecha_nac1);
        xml2:=put_campo(xml2,'EXTCODESTBEN',cod_est_ben1);
        xml2:=put_campo(xml2,'EXTDESCESTADO',desc_estado1);
        xml2:=put_campo(xml2,'EXTRUTCOTIZANTE',rut_cotiza1);
        xml2:=put_campo(xml2,'EXTNOMCOTIZANTE',nom_cotiza1);
        xml2:=put_campo(xml2,'EXTDIRPACIENTE',direccion1);
        xml2:=put_campo(xml2,'EXTGLOSACOMUNA',glosa_comuna1);
        xml2:=put_campo(xml2,'EXTGLOSACIUDAD',glosa_ciudad1);
        xml2:=put_campo(xml2,'EXTPREVISION',prevision1);
        xml2:=put_campo(xml2,'EXTGLOSA',glosa1);
        xml2:=put_campo(xml2,'EXTPLAN',plan1);
        xml2:=put_campo(xml2,'EXTDESCUENTOXPLANILLA',replace(dscto_planilla1,'.0',''));
        xml2:=put_campo(xml2,'EXTMONTOEXCEDENTE',replace(monto_exec1,'.0',''));
        xml2:=put_campo(xml2,'EXTRUTACOMPANANTE',rut_acompa1);
        xml2:=put_campo(xml2,'EXTNOMBREACOMPANANTE',nom_acompa1);

	--Guarda me mensaje en base
	xml2:=put_campo(xml2,'EXTMENSAJEERROR',glosa1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
