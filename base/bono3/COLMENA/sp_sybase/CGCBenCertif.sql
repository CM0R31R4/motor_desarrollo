locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
36
(1 row affected)
text
Create Procedure CGCBenCertif
      @extCodFinanciador              int
    , @extRutBeneficiario             char(12)
    , @extFechaActual                 datetime
    , @extApellidoPat                 char(30)        Output
    , @extApellidoMat       	 	char(30)        Output
    , @extNombres                     char(40)        Output
    , @extSexo                        char(1)         Output
    , @extFechaNacimi                 datetime        Output
    , @extCodEstBen                   char(1)         Output
    , @extDescEstado                  char(15)        Output
    , @extRutCotizante                char(12)        Output
    , @extNomCotizante                char(40)        Output
    , @extDirPaciente                 char(40)    Output
    , @extGlosaComuna                 char(30)        Output
    , @extGlosaCiudad                 char(30)        Output
    , @extPrevision                   char(1)         Output
    , @extGlosa                       char(40)        Output
    , @extPlan                        char(15)        Output
    , @extDescuentoxPlanilla          char(1)         Output
    , @extMontoExcedente              numeric(10,0)   Output
As
Begin
    Select @extApellidoPat = ' '
    Select @extApellidoMat = ' '
    Select @extNombres = ' '
    Select @extSexo = ' '
    Select @extFechaNacimi = '1900/01/01'
    Select @extCodEstBen = ' '
    Select @extDescEstado = ' '
    Select @extRutCotizante = '0000000000-0'
    Select @extNomCotizante = ' '
    Select @extDirPaciente = ' '
    Select @extGlosaComuna = ' '
    Select @extGlosaCiudad = ' '
    Select @extPrevision = ' '
    Select @extGlosa = ' '
    Select @extPlan = ' '
    Select @extDescuentoxPlanilla = ' '
    Select @extMontoExcedente = 0
    
	Declare
 	@SRV_ReturnStatus               int
      , @extRutAcompanante              char(12)
      , @extNombreAcompanante           char(40)
      , @fld_cotrut                     char(11)
      , @fld_funfolio                   int
      , @fld_funcorrel     smallint
      , @fld_bsenombrecom               varchar(50)
      , @fld_benrut                     char(11)
      , @xfld_conespcod                 smallint
      , @fld_asocrut                    char(11)
      , @fld_conrut               char(11)
      , @fld_bencorrel                  tinyint
      , @not_rutpoder                   char(11)
      , @return_message                 varchar(250)
      , @msg_error                      varchar(250)
      , @not_ruttitu                 char(11)
      , @not_nompoder                   varchar(50)
    
	Select @SRV_ReturnStatus = 0
	declare @xxrut char(12)
	create table #ben
		(RutBen     char(12)    not null
		,NombreBen  char(40)    not null
		)
	create index idx_ben on #ben (RutBen)
	
	select @extFechaActual = getdate()
	select @extCodEstBen    = ""
	select @extDescEstado   = ""
	select @extGlosa        = ""
	select @fld_benrut      = right(@extRutBeneficiario,11)
	select @extRutBeneficiario = right(@extRutBeneficiario,11)

	if @extRutBeneficiario = "000000000-0"
	    begin
	    select @extCodEstBen    = "R"
	    select @extDescEstado   = "No Vigente (0)"
	    select @extGlosa        = "Benef. No Vigente o No existe en Colmena"
	    GoTo CGCBenCertif_Exit
	end
	Select  @fld_cotrut  = fld_cotrut
       		,@fld_funfolio   = fld_funfolio
	       ,@fld_funcorrel  = fld_funcorrel
	       ,@fld_bencorrel  = fld_bencorrel
	       ,@extFechaNacimi = fld_bennacfec
	From BEN
	Where fld_benrut        = @extRutBeneficiario AND
	      fld_beninivigfec <= @extFechaActual     AND
   		fld_benfinvigfec >= @extFechaActual

	if @@rowcount = 0
	    begin
	    select @extCodEstBen    = "R"
	    select @extDescEstado   = "No Vigente (1)"
	    select @extGlosa        = "Benef. No Vigente o No existe en Colmena"
	    GoTo CGCBenCertif_Exit
	end
	Select @xfld_conespcod   = fld_conespcod
	       ,@fld_asocrut     = fld_asocrut
	       ,@fld_conrut      = fld_conrut
	       ,@extNomCotizante = rtrim(fld_cotapepa) + " " + rtrim(fld_cotapema) + " " + rtrim(fld_cotnombre)
	       ,@extPlan         = rtrim(fld_planvig) + " - " + GLS_DESACA
	From CNT, ISAPREDESACA
	Where fld_funfolio  = @fld_funfolio     AND
	      fld_funcorrel = @fld_funcorrel    AND
	      	fld_cntcateg  = COD_DESACA

	if @@rowcount = 0
	    begin
	    select @extCodEstBen    = "R"
	    select @extDescEstado = "No Vigente (3)"
	    select @extGlosa        = "Benef. No Vigente o No existe en Colmena"
		GoTo CGCBenCertif_Exit
	end

	if @extFechaNacimi = "Jan 01 1900"
	    begin
	    select @extCodEstBen    = "X"
	    select @extDescEstado   = "Datos Erroneos"
	    select @extGlosa        = "Benef. con problemas en Fecha Nacimiento"
	    GoTo CGCBenCertif_Exit
	end

	Select @fld_bsenombrecom = fld_bsenombrecom
	From BSE
	Where fld_bserut        = @fld_cotrut   AND
	      fld_bseindividuo  = "A"           AND
	      fld_bseorigen     = 1             AND
	      fld_bsemotivocod  = 8

	if @fld_bsenombrecom != Null
	begin
	    select @extCodEstBen    = "X"
	    select @extDescEstado   = "No Vigente (2)"
	    select @extGlosa        = "Beneficios sólo en Sucursales Colmena"
	    GoTo CGCBenCertif_Exit
	end

	select @extDirPaciente          = space(40)
	select @extGlosaComuna          = space(30)
	select @extGlosaCiudad          = space(30)
	select @extPrevision            = space(1)
	select @extDescuentoxPlanilla   = space(1)
	select @extMontoExcedente       = 0
	select @extRutCotizante         = "0" + @fld_cotrut
	
	select  @extApellidoPat     = fld_benapepa
        ,@extApellidoMat    = fld_benapema
        ,@extNombres        = fld_bennombre
        ,@extSexo           = case when fld_b ensexo  = 1 then "M" when fld_bensexo != 1 then "F" end
	From BEN
	Where fld_benrut        = @extRutBeneficiario AND
	      fld_beninivigfec <= @extFechaActual     AND
	      fld_benfinvigfec >= @extFechaActual

	if @@rowcount = 0
	begin
    	    select @extCodEstBen    = "R"
	    select @extDescEstado   = "No Vigente (4)"
	    select @extGlosa        = "Benef. No Vigente o No existe en Colmena"
	    GoTo CGCBenCertif_Exit
	end

	if @extNombres = "NONATO"
	begin
	   select @extCodEstBen    = "X"
	   select @extDescEstado   = "Datos Erroneos"
	   select @extGlosa        = "Benef. con problemas en su Nombre"
	    GoTo CGCBenCertif_Exit
	end

	select @extCodEstBen    = "C"
	select @extDescEstado   = "Certificado"
	select @extGlosa        = space(40)

	Insert into #ben Select "0" + fld_benrut, rtrim(fld_benapepa) + " " + rtrim(fld_benapema) + " " + rtrim(fld_bennombre)
			 From BEN
			Where fld_funfolio      = @fld_funfolio        AND
			      fld_funcorrel     = @fld_funcorrel       AND
			      fld_beninivigfec <= @extFechaActual      AND
			      fld_benfinvigfec >= @extFechaActual      AND
			      fld_benrut       != @extRutBeneficiario  AND
			      datediff(yy,fld_bennacfec,@extFechaActual) > 17

	if @xfld_conespcod in (4, 24, 34, 124, 234, 1234)
	begin
		if @fld_asocrut != "000000000-0"
	   		begin
		  	select @extRutBeneficiario = @fld_asocrut
			Insert into #ben Select "0" + fld_benrut,rtrim(fld_benapepa) + " " + rtrim(fld_benapema) + " " + rtrim(fld_bennombre)
				      	From BEN
				      	Where fld_benrut  = @extRutBeneficiario AND
			        	    fld_bencorrel     = 0               AND
				            fld_beninivigfec <= @extFechaActual AND
				            fld_benfinvigfec >= @extFechaActual
	   	end
   		else
   	  	begin
	      		if @fld_conrut != "000000000-0"
      				begin
		        	select @extRutBeneficiario = @fld_conrut
		       		Insert into #ben Select "0" + fld_benrut,rtrim(fld_benapepa) + " " + rtrim(fld_benapema) + " " + rtrim(fld_bennombre)
					         From BEN
				        	 Where fld_benrut       = @extRutBeneficiario AND
					               fld_bencorrel     = 0               AND
					               fld_beninivigfec <= @extFechaActual AND
					               fld_benfinvigfec >= @extFechaActual
      			end
   		end
	end

	Declare CUR_NOTARIA cursor for
		select distinct a.not_ruttitu ,a.not_rutpoder ,a.not_nompoder
		From NOTARIA  a , NOTARIA_DETALLE b
		where a.not_ruttitu   = @fld_cotrut
			and   a.not_estado    = 1
			and   ((not_fecpoder <= @extFechaActual AND not_fecter >= @extFechaActual) OR (not_fecter = "Jan 01 1900"))
			and   a.not_ruttitu   = b.not_ruttitu
			and   a.not_rutpoder  = b.not_rutpoder
			and   b.not_benef     = @fld_benrut
			and   b.not_imedbene  = "S"
			and   b.not_estado    = 1
	For Read Only
	Open CUR_NOTARIA fetch CUR_NOTARIA into @not_ruttitu , @not_rutpoder , @not_nompoder
	
	while (@@sqlstatus = 0)
	Begin
   		select @xxrut = "0"+ @not_rutpoder
		if not exists (select 1 from #ben  where RutBen = @xxrut)
   			Begin
      			Insert into #ben Select "0" + @not_rutpoder ,@not_nompoder
   		End
		fetch CUR_NOTARIA into @not_ruttitu , @not_rutpoder, @not_nompoder
	End
	close CUR_NOTARIA
	eallocate cursor CUR_NOTARIA

	Select distinct extRutAcompanante = RutBen,extNombreAcompanante = NombreBen From #ben
	CGCBenCertif_Exit:
	If @SRV_ReturnStatus >= 60000
    	Begin
        	Return 0
    	End
    	Else Begin
        	Return 1
    	End
End                                                                                                                                                                   
(36 rows affected)
(return status = 0)
1> 
