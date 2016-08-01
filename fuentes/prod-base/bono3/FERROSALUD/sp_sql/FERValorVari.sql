locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
1> 2> Text

CREATE Proc [dbo].[FERValorVari] (@extCodFinanciador  Numeric(3,0),
              @extHomNumeroConvenio  CHAR(15),
              @extHomLugarConvenio   CHAR(10),
              @extSucVenta           CHAR(10),
              @extRutConvenio        CHAR(12)
,
              @extRutTratante        CHAR(12),
              @extEspecialidad       CHAR(10),
              @extRutSolicitante     CHAR(12),
              @extRutBeneficiario    CHAR(12),
              @extTratamiento        CHAR(1),
              @extC
odigoDiagnostico  CHAR(10),
              @extNivelConvenio      TINYINT,
              @extUrgencia           CHAR(1),
              @extLista1             CHAR(255),
              @extLista2             CHAR(255),
              @extLista3             CH
AR(255),
              @extLista4             CHAR(255),
              @extLista5             CHAR(255),
              @extLista6             CHAR(255),
              @extLista7             CHAR(255),
              @extNumPrestaciones    TINYINT,
        
      @extCodError           CHAR(1)  Output,
              @extMensajeError       CHAR(60) Output,
              @extplan               char(20) Output,
              @ExtGlosa1             Char(50) Output,
              @ExtGlosa2             Char(50) O
utput,
              @ExtGlosa3             Char(50) Output,
              @ExtGlosa4             Char(50) Output,
              @ExtGlosa5             Char(50) Output
             )

/*---------------------------------------------------------------------
----------
- Nombre SP        : FERValorVari
- Desarrollado por : Juan Videla
- Fecha Creacion   : 03 / 01 / 2006
- Objetivo         : Servicio que toma todas las prestaciones asociadas a un
             acto de venta y las envía al financiador en un solo
 evento
--------------------------------------------------------------------------------*/
AS
DECLARE @extRespuesta         CHAR(1)
DECLARE @JextCodError         CHAR(1)
DECLARE @JextMensajeError     CHAR(30)
DECLARE @cont                 INTEGER
DECLARE 
@extNivel             NUMERIC(12,0)
DECLARE @ValorTota             NUMERIC(8,0)
DECLARE @Nivel002              NUMERIC(8,0)
DECLARE @Nivel003              NUMERIC(8,0)
DECLARE @extCodPrestacion      CHAR(10)
DECLARE @extJpresta            CHAR(10)
DECLARE
 @CPresta1              CHAR(7)
DECLARE @CPresta2              CHAR(7)
DECLARE @CPresta3              CHAR(7)
DECLARE @Pref                  NUMERIC(12,0)
DECLARE @plan_afil             CHAR(20)
DECLARE @pl_segu               CHAR(20)
DECLARE @plan_jvo   
           CHAR(20)
DECLARE @bienestar              CHAR(1)
DECLARE @JextValorprestacion   NUMERIC(12,0)
DECLARE @JextAporteFinanciador NUMERIC(12,0)
--DECLARE @extinternolsa        CHAR(15)
DECLARE @Jextcopago            NUMERIC(12,0)
DECLARE @JExtTipoBo
nif1        NUMERIC(12,0)       ---- TINYINT
DECLARE @JExtCopagol           NUMERIC(12,0)
DECLARE @extBonifica           NUMERIC(12,0)
DECLARE @extTope              NUMERIC(12,2)
DECLARE @extMoneda              NUMERIC(12,0)
DECLARE @VALOR_UF             
NUMERIC(12,2)
DECLARE @VALOR_UAFS           NUMERIC(12,2)
DECLARE @variableprestador    CHAR(10)
DECLARE @RutTitular           NUMERIC(12,0)
DECLARE @valorpresta          CHAR(12)
DECLARE @query                CHAR(255)
DECLARE @CONSULTA             CHAR(
255)
DECLARE @sw                   NUMERIC(2,0)
DECLARE @extCant              int
DECLARE @extSec1              char(2)
DECLARE @extSec2              int
-------------------------------------------
DECLARE @extAporFinTotal      NUMERIC(12,0)
DECLARE @extV
alPresTotal      NUMERIC(12,0)
DECLARE @extcopagoTotal       NUMERIC(12,0)
DECLARE @extBienestarTotal    NUMERIC(12,0)
DECLARE @extBonanestecia      NUMERIC(12,0)
DECLARE @extValanestecia      NUMERIC(12,0)
DECLARE @extNivGes            NUMERIC(3,0)
DECLA
RE @extNivUrg            NUMERIC(3,0)
DECLARE @extNivPref           NUMERIC(3,0)
DECLARE @extMinimoFonasa      NUMERIC(12,0)
DECLARE @plan_pref            NUMERIC(1,0)
-------------------------------------------
declare @TopeCopago     Numeric(10,0)
decla
re @PrestaPref     Numeric(10,0)
DECLARE @RPrestador     Numeric(10,0)
declare @extTra         char(1)
declare @xfechaimed     Char(8)
declare @xano           Numeric(4,0)
declare @xmes           Numeric(2,0)
declare @xmenjvo        char(20)
-- NIVELES
DE
CLARE @extNivuhab    NUMERIC(3,0)
DECLARE @extNivuhale   NUMERIC(3,0)
DECLARE @extNivurgle   NUMERIC(3,0)
--declare @valor_uf       numeric (9,2)
--declare @valor_uafs     numeric (9,2)
-------------------------------------------
declare @xrpre          N
umeric(2,0)
-------------------------------------------
select @xfechaimed = convert(char(8),getdate(),112)
select @xano = convert(numeric(8),substring(@xfechaimed,1,4))
select @xmes = convert(numeric(8),substring(@xfechaimed,5,2))

select @VALOR_UAFS = 0

select @VALOR_UF   = 0
Select @xrpre      = 0
select @JextValorprestacion=0
Select @JextAporteFinanciador=0
Select @extAporFinTotal=0
Select @extValPresTotal=0
Select @extcopagoTotal=0
Select @extBienestarTotal=0
Select @extBonanestecia=0
Select @extVala
nestecia=0
Select @RPrestador = 0

--- Extrae Valor UAFS ---
select @VALOR_UAFS = t_bufas.valor_uf
    from t_bufas
    where @xano=t_bufas.fec_ano and t_bufas.fec_mes=0
 
--- Extrae Valor UF del mes ---
Select @VALOR_UF = t_bufas.valor_uf
    from t_bufa
s
    where @xano=t_bufas.fec_ano and t_bufas.fec_mes=@xmes


  If @VALOR_UF = 0
     begin
         SELECT @extCodError = 'N'
         SELECT @extMensajeError = 'UF no Ingresada'
         Return
     End
   
  If @VALOR_UAFS = 0
     begin
         SELEC
T @extCodError = 'N'
         SELECT @extMensajeError = 'UF no Ingresada'
         Return
     End

-------------------------------------------

Select  @JextCodError      = ''
Select  @JextMensajeError  = ''

---TOTALES---
Select @extValPresTotal = 0
Sel
ect @extAporFinTotal = 0
Select @extcopagoTotal = 0
Select @extBienestarTotal= 0
Select @extBonanestecia = 0
Select @extValanestecia = 0

----  Campo de activacion de codigo de diagnostico ---
--Select @extTratamiento = 'N'
select @extTra  = 'N'
Select @e
xtSec1 = ' '
Select @extSec2 = 0

-------------------------------------------

create table #tmpSALIDA(
extValorPrestacion numeric(12,0) null,
extAporteFinanciador numeric(12,0) null,
extcopago       numeric(12,0) null,
extinternolsa   char(15) null,
ExtT
ipoBonif1   tinyint null,-- = 3 (Cuando tiene Bienestar)
ExtCopago1      numeric(12,0) null,
ExtTipoBonif2   tinyint null,
ExtCopago2      numeric(12,0) null,
ExtTipoBonif3   tinyint null,
ExtCopago3      numeric(12,0) null,
ExtTipoBonif4   tinyint null,

ExtCopago4      numeric(12,0) null,
ExtTipoBonif5   tinyint null,
ExtCopago5      numeric(12,0) null
)

declare @status integer
declare @estadob  integer
select @status = 0
SELECT @cont = 0
SELECT @extNivel = 0
SELECT @extNivGes  = 0
SELECT @extNivUrg  = 
0
SELECT @extNivPref = 0
SELECT @extNivuhab = 0
SELECT @extNivuhale = 0
SELECT @extNivurgle = 0
SELECT @extMinimoFonasa = 0
Select @estadob = 0
Select @plan_pref = 0

  BEGIN TRAN
    --1. Buscar el Nivel del Prestador en la Tabla T_Bmedico.
    --IF conv
ert(NUMERIC(10,0),substring(@extRutConvenio,1,10)) <> convert(NUMERIC(10,0),@extHomNumeroConvenio)
    select @extHomNumeroConvenio = replace (@extHomNumeroConvenio,"    "," ")
    IF convert(NUMERIC(10,0),substring(@extRutConvenio,1,10)) <> convert(NUMER
IC(10,0),@extHomNumeroConvenio)
        BEGIN --- se busca con estas condiciones
            SELECT @extNivel = a.NIVEL,
                   @extNivUrg = a.NIVEL_URG,
                   @extNivuhab = a.nivel_uhab,
                   @extNivuhale = a.niv_uh
a_le,
                   @extNivurgle = a.niv_urg_le,
                   @extNivPref = a.NIVEL_PREF,
                   @extNivGes  = a.NIVEL_GES,
                   @estadob = a.estado
                FROM T_Bmedico a
                WHERE (replace(str(a
.RUT,10),' ','0')  = substring(@extRutConvenio,1,10))
                    AND a.Cod_Rut = convert(NUMERIC(10,0), @extHomNumeroConvenio)
                  -- and (replace(str(a.Cod_Rut,10),' ','0') = @extHomNumeroConvenio)
                  -- select @extN
ivel,substring(@extRutConvenio,1,10), @extHomNumeroConvenio
            Select @PrestaPref = convert(NUMERIC(10,0),@extHomNumeroConvenio)
        END
    ELSE IF  convert(NUMERIC(10,0),substring(@extRutConvenio,1,10)) = convert(NUMERIC(10,0),@extHomNumero
Convenio)
        BEGIN --- se busca con estas candiciones
         SELECT @extNivel = a.NIVEL,
                @extNivUrg = a.NIVEL_URG,
                @extNivuhab = a.nivel_uhab,
                @extNivuhale = a.niv_uha_le,
                @extNivurgle
 = a.niv_urg_le,
                @extNivPref = a.NIVEL_PREF,
                @extNivGes  = a.NIVEL_GES,
                @estadob = a.estado
              FROM T_Bmedico a
              WHERE (replace(str(a.RUT,10),' ','0')  = substring(@extRutConvenio,1,1
0))
                    AND a.Rut_Cob = convert(NUMERIC(10,0), @extHomNumeroConvenio) AND  a.Cod_rut=0
                -- select @extNivel, substring(@extRutConvenio,1,10), @extHomNumeroConvenio
            --Select @PrestaPref = convert(NUMERIC(10,0),@ex
tHomNumeroConvenio)
            Select @PrestaPref = 0
         END

    If @extnivel=0 and convert(NUMERIC(10,0),substring(@extRutConvenio,1,10)) = convert(NUMERIC(10,0),@extHomNumeroConvenio)
        BEGIN --- se busca con estas candiciones
            
SELECT @extNivel = a.NIVEL,
                   @extNivUrg = a.NIVEL_URG,
                   @extNivuhab = a.nivel_uhab,
                   @extNivuhale = a.niv_uha_le,
                   @extNivurgle = a.niv_urg_le,
                   @extNivPref = a.NIVE
L_PREF,
                   @extNivGes  = a.NIVEL_GES,
                   @estadob = a.estado
            FROM T_Bmedico a
                  WHERE (replace(str(a.RUT,10),' ','0')  = substring(@extRutConvenio,1,10))
                    AND a.Cod_Rut = conve
rt(NUMERIC(10,0), @extHomNumeroConvenio) AND a.Cod_rut<>0
                  -- and (replace(str(a.Cod_Rut,10),' ','0') = @extHomNumeroConvenio)
                  -- select @extNivel,substring(@extRutConvenio,1,10), @extHomNumeroConvenio
           Select 
@PrestaPref = convert(NUMERIC(10,0),@extHomNumeroConvenio)
         END

    If @extNivel = 0 or @estadob<>1
        begin
                Rollback Tran
                SELECT @extCodError = 'N'
                SELECT @extMensajeError = 'Prestador No Exis
te en Convenio '
                Return
        End

    select @RPrestador = convert(NUMERIC(10,0),substring(@extRutConvenio,1,10))
       
    -- print "nivel"
    -- print @extNivel
    -- print "preferente " 
    -- print @PrestaPref
    -- print "pre
stador" 
    -- print @RPrestador
    -------------------------------------------------------------------------
    --3.-Buscar plan afiliado y servicio de Bienestar en la tabla  T_Bafimov
    select @plan_afil = null
    select @pl_segu   = null
    SELE
CT @RutTitular = T_BCargas.RUT_AFIL
    FROM T_BCargas
        WHERE replace(str(T_BCargas.RUT_CAR,10),' ','0') = substring(@extRutBeneficiario,1,10)

    SELECT @pl_segu = T_Bafimov.PL_SEG_EFE,
           @plan_afil= T_Bafimov.PLAN_AFIL,
           @bien
estar = T_Bafimov.BIENESTAR,
           @plan_pref = T_Bafimov.PLAN_PREFE
    FROM T_Bafimov
        WHERE T_Bafimov.RUT_AFIL = @RutTitular
        -- WHERE replace(str(T_Bafimov.RUT_AFIL,10),' ','0') = substring(@RutTitular,1,10)

    --- If @plan_pref =
 2 AND @extNivPref>0
    If @extNivPref>0
       SELECT @extNivel = @extNivPref
       
    If @extUrgencia= 'S' 
      begin
		declare	@DefaultDateFirst int

		set @DefaultDateFirst = @@datefirst



		set datefirst 1      
		declare @diasemana int       
		--declare @cmes varchar(20)
		select @diasemana = datepart(dw,getdate())


		--select 'dia de la semana', @xmes

		-- declare @horaI char(40)
		declare @horaC int
		select @horaC = substring(convert(char(5), getdate(), 8),1,2)
		-- select convert(char(5), getdate(), 8), convert(char(5), getdate(), 108)

		--select 'hora',@horaC,convert(char(5), getdate(), 108)

		-- select @horaI = 'Normal'

        

        -- select @extNivel = @extNivuhale

         

		if @plan_pref <> 2

		  begin

	        select @extNivel = @extNivuhale

			if @diasemana <= 5 and (@horaC <8 or @horaC>=20)

				select @extNivel = @extNivurgle

   

			if @diasemana = 6 and (@horaC <8 or @horaC>=14)

				select @extNivel = @extNivurgle

			

			if @diasemana = 7    

				select @extNivel = @extNivurgle

           end
           
		if @plan_pref = 2

		  begin

	        select @extNivel = @extNivuhab

			if @diasemana <= 5 and (@horaC <8 or @horaC>=20)

				select @extNivel = @extNivUrg 

   

			if @diasemana = 6 and (@horaC <8 or @horaC>=14)

				select @extNivel = @extNivUrg 

			

			if @diasemana = 7    

				select @extNivel = @extNivUrg 

           end          
           
         -- select @extNivel 
      end
      
     
            
    If @plan_afil IS NULL
        begin
           Rollback Tran
           SELECT @extCodError = 'N'
           SELECT @extMensajeError = 'Error. No E
xiste Benefeciario ' + @extRutBeneficiario
           Return
        End

        SELECT @plan_jvo = @plan_afil

        If ltrim(rtrim(@pl_segu)) <> ''
            select @plan_afil = @pl_segu
 
        declare @iCont integer
        declare @szLista cha
r(255)
        declare @contLin integer
        declare @posi integer
        select @szLista = ''
        select @iCont = 1
        select @posi=1
        select @contLin = 1
       Select @extCant = 1
        WHILE @iCont <= 7
             BEGIN
       
         Select @szLista = Case @iCont
                    when 1 then isnull(@extLista1,'')
                      when 2 then isnull(@extLista2,'')
                      when 3 then isnull(@extLista3,'')
                    when 4 then isnull(@extLista4,
'')
                    when 5 then isnull(@extLista5,'')
                      when 6 then isnull(@extLista6,'')
                      when 7 then isnull(@extLista7,'')
                    Else ''
              End

                IF ltrim(rtrim(@szList
a)) <> ''
                    BEGIN
                        WHILE @contLin <=5
                                 BEGIN
                                   IF SUBSTRING(@szLista,@posi,10) <> '' --or @posi <= 193
                                     BEGIN
   
                                     select @extCant = SUBSTRING(@szLista,32+@posi,2)
                                        select @extSec1 = SUBSTRING(@szLista,11+@posi,2)
                                     
                                        Se
lect @extSec2 = 0
                                     
                                        If @extSec1 = 'H'     ----and @extTratamiento = 'S'
                                           Select @extSec2 = 25
                                        Els
e if @extSec1 = 'A'     ----and @extTratamiento = 'S'
                                           Select @extSec2 = 40
                                        Else if @extSec1 = 'P'     ----and @extTratamiento = 'S'
                                        
   Begin
                                             Select @extSec2 = T_Arancel.sec  From T_Arancel
                                                 Where T_Arancel.codi_aranc = convert(NUMERIC(8,0),@extCodPrestacion) and T_arancel.sec >0 and T_arancel.
sec <=15
                                           End
                                       
                                        ---- print "hola"
                                        ---- print @extSec2
                                     
   
                                     ---- print SUBSTRING(@szLista,32+@posi,2)
                                        -- -- print @posi
                                        ---- print SUBSTRING(@szLista,@posi,10)
                              
       
                      -- variable donde guarda el nivel a buscar del prestador        
                             Select @variableprestador = 'Nivel' + replace(str(@extNivel,3),' ','0')
                             SELECT @extCodPrestacion   = substring
(@szLista,@posi,10)
                             SELECT @extJpresta = replace( substring(@szLista,@posi,10),' ','0')
                             Select @TopeCopago = 0
                            
                            If @extSec2=0 or @extSec2>=15

                               Begin
                                  SELECT @ValorTota       = T_Arancel.VALOR_TOTA,
                                         @nivel002        = T_Arancel.nivel002,
                                         @nivel003     
   = T_Arancel.nivel003,
                                         @extMinimoFonasa = T_Arancel.nivel239,
                                         @extTra          = T_arancel.diagnos
                                        FROM T_Arancel
                 
                       WHERE T_Arancel.CODI_ARANC = convert(NUMERIC(8,0),@extCodPrestacion)
                                           and T_Arancel.Sec = @extSec2

                               End
                            Else If @extSec2>0 and @ext
Sec2<15
                               Begin
                                   SELECT @ValorTota          = T_Arancel.VALOR_TOTA,
                                          @nivel002           = T_Arancel.nivel002,
                                        
  @nivel003           = T_Arancel.nivel003,
                                          @extMinimoFonasa    = T_Arancel.nivel239,
                                          @extTra             = T_arancel.diagnos
                                       FROM T
_Arancel
                                       WHERE T_Arancel.Codi_aranc        = @extSec2
                               End
                                     
                            If @ValorTota=0
                                begin
       
                             Rollback Tran
                                    SELECT @extCodError = 'N'
                                    SELECT @extMensajeError = 'Valor del arancel Ferrosalud no Existe para esta Prestación'
                          
          select @extplan   = @plan_afil
                                    select @ExtGlosa1 = ''
                                    select @ExtGlosa2 = ''
                                    select @ExtGlosa3 = ''
                                    s
elect @ExtGlosa4 = ''
                                    select @ExtGlosa5 = ''
                                    return
                                End
                                
                            If @extTratamiento = 'N' and @extT
ra='S'
                                begin
                                   Rollback Tran
                                   SELECT @extCodError = 'N'
                                   SELECT @extMensajeError = 'Falta Tratamiento Medico'
            
                       select @extplan   = @plan_afil
                                   select @ExtGlosa1 = ''
                                   select @ExtGlosa2 = ''
                                   select @ExtGlosa3 = ''
                           
        select @ExtGlosa4 = ''
                                   select @ExtGlosa5 = ''
                                   return
                                End
                           
                            Select @JextValorprestacion = 0

                            DECLARE @mycol numeric(8,0)
                            SET @mycol = CONVERT( NUMERIC(8,0),@extCodPrestacion)
                            exec sp_valor_presta @mycol,@variableprestador, @extSec2, @JextValorprestacion output
   
                         
                            If @JextValorprestacion = 0
                                begin
                                      Rollback Tran
                                      SELECT @extCodError = 'N'
                   
         SELECT @extMensajeError = 'Prestación sin valor o no convenida con el prestador'
                                      select @extplan   = @plan_afil
                                      select @ExtGlosa1 = ''
                                   
   select @ExtGlosa2 = ''
                                      select @ExtGlosa3 = ''
                                      select @ExtGlosa4 = ''
                                      select @ExtGlosa5 = ''
                                      Return
 
                               End

                            --4 VerIFicar si la atencion es preferencial o no
                            SELECT @Pref = 0
                            IF @JextValorprestacion <= @ValorTota
                              
  SELECT @Pref = 1
                            ELSE IF @JextValorprestacion <= @Nivel002
                                SELECT @Pref = 2
                            ELSE IF @JextValorprestacion <= @Nivel003
                                SELECT @Pref = 
3
                            -- select @JextValorprestacion, @pref
                           
                           Select @xrpre = @Pref
                           Select @extCodprestacion = replace(str(T_Bon_rela.codi_aranc,10),' ','0')
         
                         from T_Bon_rela
                                  where T_Bon_rela.cod_presta=convert(NUMERIC(8,0),@extCodPrestacion)

                            ---- print '@extJpresta'
                            ---- print @extJpresta
       
                     ---- print '@extCodPrestacion'
                            ---- print @extCodPrestacion
                            ---- print @extRutConvenio
                            ---- print @extHomNumeroConvenio
                           
  
                         If @extSec2>0 and @extSec2<15
                               Select @extCodprestacion = '000DP     '
                         
                            --- Rutina de funcion "nuevoca2",del sistema de calculo de bonos
          
                  -- -- print 'Paso nuevoca2'

                           select @sw = 0
			   If @extJpresta>3
                              begin
                                 Exec sp_nuevoca2 @extJpresta,
                                            
 @plan_afil,
                                             @PrestaPref,
                                             @RPrestador,
                                             @extBonifica   output,
                                             @extTope     
  output,
                                             @extMoneda     output,
                                             @TopeCopago    output,
                                             @sw            output
                                          
   
                                    -- print "nueva2 "
                                    -- print @extBonifica
                               end
                             
                        -- llamar a subrutina de calculo ---
            
            --5 Buscar % de bonIFicacion, topes y moneda en tabla T_Bon_Ambu  
                        
                            --- Busca Bonificacion por rut prestador preferencial
                            If @sw = 0 
                             
 Begin
                                 ---- print 'Paso nuevoca3'
                                 Exec sp_nuevoca3 @extJpresta,
                                                  @plan_afil,
                                                  @PrestaPref,

                                                  @RPrestador,
                                                  @Pref,
                                                  @extBonifica   output,
                                                  @extTope    
   output,
                                                  @extMoneda     output,
                                                  @TopeCopago    output,
                                                  @sw            output
                          
          -- print "nueva3 "
                                    -- print @extBonifica

                              End
                         
                            --- Busca Bonifica por prestador y codigo homologo
                            
If @sw = 0 
                              Begin
                                 ---- print 'Paso nuevocal'
                                 Select @Pref = @xrpre
                                 Exec sp_nuevocal @extCodPrestacion,
                       
                           @plan_afil,
                                                  @PrestaPref,
                                                  @RPrestador,
                                                  @Pref,
                                 
                 @extBonifica   output,
                                                  @extTope       output,
                                                  @extMoneda     output,
                                                  @TopeCopago    outp
ut,
                                                  @sw            output
                                                  
                                    -- print "nuevacal " 
                                    -- print @extBonifica
            
                  End
                               
                                --select @xmenjvo = "valores"
                                ---- print @xmenjvo
                                ---- print @extCodPrestacion
                          
      ---- print @plan_afil
                                ---- print @extNivel
                                ---- print @JextValorprestacion
                                ---- print @PrestaPref
                                ---- print @Pref
      
                          ---- print @extBonifica
                                ---- print @extMoneda
                                ---- print @pl_segu
                                ---- print @plan_jvo
                                ---- print @sw


                              If @extBonifica=0 or @sw=0
                                begin
                                  Rollback Tran
                                  SELECT @extCodError = 'N'
                                  SELECT @extMensa
jeError = 'Para esta prestación no existe Bonificación del Plan'
                                  select @extplan   = @plan_afil
                                  select @ExtGlosa1 = ''
                                  select @ExtGlosa2 = ''
           
                       select @ExtGlosa3 = ''
                                  select @ExtGlosa4 = ''
                                  select @ExtGlosa5 = ''
                                  Return
                                End

                 
              If @extMoneda=0
                                begin
                                      Rollback Tran
                                       SELECT @extCodError = 'N'
                                       SELECT @extMensajeError = 'Para
 esta prestación no existe Tipo de Moneda del Plan'
                                        select @extplan   = @plan_afil
                                        select @ExtGlosa1 = ''
                                        select @ExtGlosa2 = ''
      
                                  select @ExtGlosa3 = ''
                                        select @ExtGlosa4 = ''
                                        select @ExtGlosa5 = ''
                                       return
                          
      End
                             
                            --6 Cálculo de la BonIFicación y monto del copago.
                            ---- print @extBonifica
                            ---- print @extTope
                            --SELECT
 @VALOR_UF = 18239.55 -- Agosto 2006  hay q' leer el valor de la uf desde una tabla
                            --SELECT @VALOR_UF = 18336.38 -- Septiembre 2006 hay q' leer el valor de la uf desde una tabla
                            --SELECT @VALOR_UAFS
 = 17974.81  -- Valor UAFS
                            --SELECT @VALOR_UF   = 18338.73  --uf de febrero
                            --SELECT @VALOR_UAFS = 18336.38  -- Valor UAFS

                            SELECT @JextValorprestacion   =  @JextValorpres
tacion * @extCant
                            SELECT @JextAporteFinanciador =  FLOOR(Round((@JextValorprestacion * @extBonifica/100),0))      -- (del Paso 2).
                            IF (@extMoneda = 1)
                                   SELECT @extTo
pe = FLOOR(round( CONVERT(Numeric(12,0),@VALOR_UF * @extTope) ,0)* @extCant)
                            IF (@extMoneda = 2) --(del Paso 5, signIFica que el plan tiene fijada la moneda en Veces Arancel)
                                SELECT @extTope = FL
OOR(round( CONVERT(Numeric(12,0),@ValorTota * @extTope),0) * @extCant)
                            IF (@extMoneda = 5) --(del Paso 5, signIFica que es un plan en UAFS)
                                SELECT @extTope = FLOOR(round( CONVERT(Numeric(12,0),@V
ALOR_UAFS * @extTope),0) * @extCant)
                            IF @JextAporteFinanciador > @extTope and @extTope > 0
                                SELECT @JextAporteFinanciador = @extTope

                            SELECT @Jextcopago = (@JextValorpr
estacion - @JextAporteFinanciador)

                            --d. VerIFica si el afiliado tiene Bienestar:
                            IF @bienestar = 'S' and @extTratamiento = 'N'   -- (del paso 3)
                                    SELECT @JExtCopag
ol = FLOOR(round( @ValorTota * 0.35,0)*@extCant )       --- (Fonasa Nivel 1) * 35%
                            ELSE
                                    SELECT @JExtCopagol = 0

                            -- Bienestar
                            IF @biene
star = 'S' and @extTratamiento = 'N'
                                BEGIN
                                     IF @Jextcopago >= @JExtCopagol
                                        BEGIN
                                           SELECT @Jextcopago = @J
extcopago - @JExtCopagol
                                           SELECT @JextAporteFinanciador = @JextAporteFinanciador + @JExtCopagol
                                        END
                                     ELSE
                               
         BEGIN
                                           SELECT @JextAporteFinanciador = @JextAporteFinanciador + @Jextcopago
                                           SELECT @JExtCopagol = @Jextcopago
                                           SELECT @
Jextcopago = 0
                                        END
                                END

                               If @extSec1 = 'H' and @extTratamiento = 'S'
                                 Begin
                                    Select @e
xtValanestecia = @JextValorprestacion
                                    Select @extBonanestecia = @JextValorprestacion
                                 End
                               If @extSec1 = 'A' and @extTratamiento = 'S' and @Jextcopago = 0
  
                               Begin
                                    Select @JextValorprestacion = round( @extValanestecia * 0.10,0)
                                    SELECT @JextAporteFinanciador = round( @extBonanestecia * 0.10,0)
                
                    SELECT @JExtCopagol = 0
                                    SELECT @Jextcopago = 0
                                 End

                               If @TopeCopago>0
                                  Begin
                          
          If (@JextValorprestacion - @TopeCopago)>=0
                                       Begin
                                         Select @JextAporteFinanciador = @JextValorprestacion - @TopeCopago
                                         Select @
JExtcopago = @TopeCopago
                                       End
                                    ELSE
                                       Begin
                                         Select @JextAporteFinanciador = 0
                          
               Select @JExtcopago = @JextValorprestacion
                                       End
                                  End
             
                              SELECT @plan_afil = @plan_jvo
                             
             
           --- Valida que no sea menor al Minimo Fonasa
                              If @JextAporteFinanciador < @extMinimoFonasa
                                 Begin
                                    Select @JextAporteFinanciador = @extMinimoFonasa

                                    Select @JExtcopago = @JextValorprestacion - @extMinimoFonasa
                                 End
                        
                           ---- print "minimo fonasa"
                           ---- print @ext
MinimoFonasa
                           ---- print "Tope copago"
                           ---- print @TopeCopago


                                   ---    Insert into #tmpsalida values (isnull(@extCodError,''),isnull(@extMensajeError,''),isnull(@plan_
afil,''),'','','','','',isnull(@JextValorprestacion,0),isnull(@JextAporteFinanciador,0),isnull(@Jextcopago,0),isnull(@JExtCopagol,0),0,0,0,0,0,0,0,0,0)
                                if @status = 0
                                   Insert into #tmpsalid
a values (isnull(@JextValorprestacion,0),isnull(@JextAporteFinanciador,0),isnull(@Jextcopago,0),'',0,0,0,0,0,0,0,0,0,0)
                                else
                                   insert into #tmpSALIDA values(isnull(@JextValorprestacion,0),is
null(@JextAporteFinanciador,0),isnull(@Jextcopago,0),'',0,0,0,0,0,0,0,0,0,0)

                        select @JextValorprestacion = 0
                        Select @JextAporteFinanciador = 0
                        select @Jextcopago = 0
                
        Select @JExtCopagol = 0
                        select @status = 1
                        select @posi = @posi + 48
                        --select @contLin = @contLin + 1
                END
                    select @contLin = @contLin + 1
  
              END
            end

            Select @szLista = ''
            select @posi=1
            select @contLin = 1
            Select @iCont = @iCont + 1
            select @JextValorprestacion = 0
            Select @JextAporteFinanciador = 0

            select @Jextcopago = 0
            Select @JExtCopagol = 0
        End
 
        IF @@Error <> 0
               BEGIN
                 Rollback Tran
                 SELECT @extCodError = 'N'
                 SELECT @extMensajeError = 'Error 
en la Bonificacion'
                 Return
               END
         ELSE
            BEGIN
                SELECT @extCodError = 'S'
                select @extMensajeError = ' '
                select @extplan   = @plan_afil
                select @E
xtGlosa1 = ''
                select @ExtGlosa2 = ''
                select @ExtGlosa3 = ''
                select @ExtGlosa4 = ''
                select @ExtGlosa5 = ''
            END

            select  extValorPrestacion as 'extValorPrestacion',
    
        extAportefinanciador AS 'extAportefinanciador',
            extcopago AS 'extcopago',
            extinternolsa AS 'extinternolsa',
            ExtTipoBonif1 AS 'ExtTipoBonif1',
            ExtCopago1 AS 'ExtCopago1',
            ExtTipoBonif2  AS
 'ExtTipoBonif2',
            ExtCopago2 AS 'ExtCopago2',
            ExtTipoBonif3 AS 'ExtTipoBonif3',
            ExtCopago3 AS 'ExtCopago3',
            ExtTipoBonif4 AS 'ExtTipoBonif4',
            ExtCopago4 AS 'ExtCopago4',
            ExtTipoBonif5
 AS 'ExtTipoBonif5',
            ExtCopago5 AS 'ExtCopago5'
               from #tmpSALIDA
               
       COMMIT TRAN
RETURN
(168 rows affected)
(return status = 0)
1> 