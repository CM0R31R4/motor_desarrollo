CREATE OR REPLACE FUNCTION bono3.traductor_in_bencertif_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	declare_params	varchar;
        exec_sp		varchar;
	select1		varchar;
        out_params  	varchar;
        exec_end  	varchar;
	cod_fin1 	varchar;
        rut_ben1	varchar;
        dig_ben1	varchar;
        dig_aux1	varchar;
        fecha_actual1 	varchar;
/*
      @extCodFinanciador              int
    , @extRutBeneficiario             char(12)
    , @extFechaActual                 datetime
    , @extApellidoPat                 char(30)        Output
    , @extApellidoMat                   char(30)        Output
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
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
        --rut_ben1        :=split_part(ltrim(get_campo('EXTRUTBENEFICIARIO',xml2),'0'),'-',1);   --Largo12
        rut_ben1        :=get_campo('EXTRUTBENEFICIARIO',xml2);   --Largo12
        --Fecha Actual, debe ser hoy si o si. Formato YYYYMMDD
        fecha_actual1   :=replace(coalesce(nullif(get_campo('EXTFECHAACTUAL',xml2),''),'0'),'-','');

        --rut_ben1:=lpad(rut_ben1,10,'0')||'-'||motor_modulo11(rut_ben1);
	--xml2:=put_campo(xml2,'ERROR_RUT','SI');
        
	--Valida formato del Rut
	rut_ben1:=motor_formato_rut(rut_ben1);
	if (rut_ben1='0') or (rut_ben1='')  then
		xml2:=put_campo(xml2,'ERROR_RUT','SI');
		return xml2;
	end if;
	--Envia y guarda lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_ben1);
	
	declare_params:='DECLARE @extCodFinanciador numeric (5);
                DECLARE @extRutBeneficiario char (12);
                DECLARE @extFechaActual datetime;
                DECLARE @extApellidoPat char (30);
                DECLARE @extApellidoMat char (30);
                DECLARE @extNombres char (40);
                DECLARE @extSexo char (1);
                DECLARE @extFechaNacimi char (8);
                DECLARE @extCodEstBen char (1);
                --DECLARE @extDescEstado char (15);
                DECLARE @extDescEstado char (30);
                DECLARE @extRutCotizante char (12);
                DECLARE @extNomCotizante char (40);
                DECLARE @extDirPaciente char (40);
                DECLARE @extGlosaComuna char (30);
                DECLARE @extGlosaCiudad char (30);
                DECLARE @extPrevision char (1);
                DECLARE @extGlosa char (40);
                DECLARE @extPlan char (15);
                DECLARE @extDescuentoxPlanilla char (1);
                DECLARE @extMontoExcedente numeric (10);

                DECLARE @extRutAcompanante char (12);
                DECLARE @extNombreAcompanante char (40); ';
               	--DECLARE @rutAcom VARCHAR(8000);
                --DECLARE @nomAcom VARCHAR(8000); ';
        
	--CREATE TABLE #Result(extRutAcompanante char (12),extNombreAcompanante char (40)); ';

	exec_sp:= 'EXEC dbo.MASBenCertif '||cod_fin1||',['||rut_ben1||'] ,['||fecha_actual1||'], @extApellidoPat OUTPUT,@extApellidoMat OUTPUT,@extNombres OUTPUT, @extSexo OUTPUT,@extFechaNacimi OUTPUT,@extCodEstBen OUTPUT,@extDescEstado OUTPUT,@extRutCotizante OUTPUT, @extNomCotizante OUTPUT,@extDirPaciente OUTPUT,@extGlosaComuna OUTPUT,@extGlosaCiudad OUTPUT, @extPrevision OUTPUT,@extGlosa OUTPUT,@extPlan OUTPUT,@extDescuentoxPlanilla OUTPUT,@extMontoExcedente OUTPUT; ';
	--exec_sp:= 'INSERT INTO #Result EXEC dbo.MASBenCertif '||cod_fin1||',['||rut_ben1||'] ,['||fecha_actual1||'], @extApellidoPat OUTPUT,@extApellidoMat OUTPUT,@extNombres OUTPUT, @extSexo OUTPUT,@extFechaNacimi OUTPUT,@extCodEstBen OUTPUT,@extDescEstado OUTPUT,@extRutCotizante OUTPUT, @extNomCotizante OUTPUT,@extDirPaciente OUTPUT,@extGlosaComuna OUTPUT,@extGlosaCiudad OUTPUT, @extPrevision OUTPUT,@extGlosa OUTPUT,@extPlan OUTPUT,@extDescuentoxPlanilla OUTPUT,@extMontoExcedente OUTPUT; ';
	--select1:= ' select @rutAcom = COALESCE(@rutAcom + ",","") + res.extRutAcompanante, @nomAcom = COALESCE(@nomAcom + ",","")+ res.extNombreAcompanante from #Result res; ';

	/*Ejemplo*/
	--exec dbo.MASBenCertif 88, '001227910-8', '20101124', @extApellidoPat output, @extApellidoMat output, @extNombres output, @extSexo output, @extFechaNacimi output, @extCodEstBen output, @extDescEstado output, @extRutCotizante output, @extNomCotizante output, @extDirPaciente output, @extGlosaComuna output, @extGlosaCiudad output, @extPrevision output, @extGlosa output, @extPlan output, @extDescuentoxPlanilla output, @extMontoExcedente output;

	out_params:='SELECT @extApellidoPat as extApellidoPat, @extApellidoMat as extApellidoMat ,@extNombres as extNombres , @extSexo as extSexo ,@extFechaNacimi as extFechaNacimi ,@extCodEstBen as extCodEstBen , @extDescEstado as extDescEstado,@extRutCotizante as extRutCotizante, @extNomCotizante as extNomCotizante,@extDirPaciente as extDirPaciente , @extGlosaComuna as extGlosaComuna ,@extGlosaCiudad as extGlosaCiudad , @extPrevision as extPrevision ,@extGlosa as extGlosa,@extPlan as extPlan, @extDescuentoxPlanilla as extDescuentoxPlanilla ,@extMontoExcedente as extMontoExcedente, @extRutAcompanante as extRutAcompanante, @extNombreAcompanante as extNombreAcompanante; '; 
	--exec_end:='Drop Table #Result;';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        --xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||select1||out_params||exec_end);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_bencertif_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	i               integer ='1';
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
	rut_acompa1	varchar ='';
	nom_acompa1	varchar ='';
	rut_aux1        varchar;
        nom_aux1        varchar;

begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	while true loop
                rut_aux1        :=trim(get_campo('EXTRUTACOMPANANTE_'||i::varchar,xml2));
                nom_aux1        :=trim(get_campo('EXTNOMBREACOMPANANTE_'||i::varchar,xml2));
                if length(rut_aux1)>0 or length(nom_aux1)>0 then
                        rut_acompa1:=rut_acompa1||rut_aux1||'"'||','||'"';
                        nom_acompa1:=nom_acompa1||nom_aux1||'"'||','||'"';
                else
			--Quito la ultima coma (ya que no volvera al ciclo) y se sale
			if length(rut_acompa1)>0 or length(nom_acompa1)>0 then
				rut_acompa1    :='"'||substring(rut_acompa1,1,length(rut_acompa1)-2);
        	        	nom_acompa1    :='"'||substring(nom_acompa1,1,length(nom_acompa1)-2);
			end if;
                        exit;
                end if;
                i:=i+1;
        end loop;
	
	--Parseo la Respuesta
	apell_pat1	:=trim(get_campo('EXTAPELLIDOPAT_'||i::varchar,xml2));
	apell_mat1	:=trim(get_campo('EXTAPELLIDOMAT_'||i::varchar,xml2));
	nombre1		:=trim(get_campo('EXTNOMBRES_'||i::varchar,xml2));
	sexo1		:=trim(get_campo('EXTSEXO_'||i::varchar,xml2));
	fecha_nac1	:=trim(get_campo('EXTFECHANACIMI_'||i::varchar,xml2));
	cod_est_ben1	:=trim(get_campo('EXTCODESTBEN_'||i::varchar,xml2));
	desc_estado1	:=trim(get_campo('EXTDESCESTADO_'||i::varchar,xml2));
	rut_cotiza1	:=trim(get_campo('EXTRUTCOTIZANTE_'||i::varchar,xml2));
	nom_cotiza1	:=trim(get_campo('EXTNOMCOTIZANTE_'||i::varchar,xml2));
	direccion1	:=trim(get_campo('EXTDIRPACIENTE_'||i::varchar,xml2));
	glosa_comuna1	:=trim(get_campo('EXTGLOSACOMUNA_'||i::varchar,xml2));
	glosa_ciudad1	:=trim(get_campo('EXTGLOSACIUDAD_'||i::varchar,xml2));
	prevision1	:=trim(get_campo('EXTPREVISION_'||i::varchar,xml2));
	glosa1		:=trim(get_campo('EXTGLOSA_'||i::varchar,xml2));
	plan1		:=trim(get_campo('EXTPLAN_'||i::varchar,xml2));
	dscto_planilla1	:=trim(get_campo('EXTDESCUENTOXPLANILLA_'||i::varchar,xml2));
	monto_exec1	:=trim(get_campo('EXTMONTOEXCEDENTE_'||i::varchar,xml2));

	raise notice 'JCC_BENCERTIF_Receive extApellidoPat=% - extApellidoMat=% - extNombres=% - extSexo=% - extFechaNacimi=% - extCodEstBen=% - rut_acompa1=% - nom_acompa1=% ',apell_pat1,apell_mat1,nombre1,sexo1,fecha_nac1,cod_est_ben1,rut_acompa1,nom_acompa1;

	xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG','');
	xml2:=put_campo(xml2,'EXTAPELLIDOPAT',apell_pat1);
        xml2:=put_campo(xml2,'EXTAPELLIDOMAT',apell_mat1);
        xml2:=put_campo(xml2,'EXTNOMBRES',nombre1);
        xml2:=put_campo(xml2,'EXTSEXO',sexo1);
	
	--Si es un beneficiario certificado
        if cod_est_ben1<>'C' then
                --Resp OK fecha_nac viene asi 19661020
                --fecha_nac1:=to_char(to_date(fecha_nac1,'DD Mon YY'),'YYYYMMDD');
        --else
                --fecha_nac1:=to_char(to_date(fecha_nac1,'YYYY-MM-DD'),'YYYYMMDD');
                fecha_nac1:='';
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Rechazado');
        	xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
        end if;	
        
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
        xml2:=put_campo(xml2,'EXTDESCUENTOXPLANILLA',dscto_planilla1);
        xml2:=put_campo(xml2,'EXTMONTOEXCEDENTE',monto_exec1);
        xml2:=put_campo(xml2,'EXTRUTACOMPANANTE','['||rut_acompa1||']');
        xml2:=put_campo(xml2,'EXTNOMBREACOMPANANTE','['||nom_acompa1||']');

	--Guarda me mensaje en base
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',glosa1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
