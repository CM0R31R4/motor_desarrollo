locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
49
(1 row affected)
text
Create Procedure dbo.CGCValidaCat
      @extCodFinanciador              int
    , @extRutConvenio                 char(12)
    , @extRutTratante                 char(12)
    , @extRutSolicitante              char(12)
    , @extRutBeneficiario             char(12)
    , @extRutCotizante                char(12)
    , @extCodigoHomologo              char(12)
    , @extItem                        char(2)
    , @extCodigoDiagnostico           char(10)
    , @extCodModalidad                char(2)
    , @extCodTipAtencion              char(2)
    , @extFechaNacimiento             datetime
    , @extCodSexo                     char(1)
    , @extFechaInicio                 datetime
    , @extFechaTermino                datetime
    , @extFrecPrestDia                int
    , @extListaPrestacA               char(255)
    , @extListaPrestacB               char(255)
    , @extListaPrestacC               char(255)
    , @extListaPrestacD               char(255)
    , @extListaPrestacE               char(255)
    , @extListaPrestacF               char(255)
    , @extIndVideo                    char(1)
    , @extIndBilateral                char(1)
    , @extRecargoFueraHora            char(1)
    , @extIndReembolso                char(1)
    , @extIndPrograma          	      char(1)
    , @extCodAplicacion               char(2)
    , @extCodRegion                   char(3)
    , @extCodSucur                    char(10)
    , @extTipoPrestador               char(1)
    , @extCodEspecialidades           char(255)
    , @extCodProfesiones              char(255)
    , @extAnosAntiguedad              char(2)
    , @extRespuestaCAT                char(1)         Output
    , @extMensajeCAT                  char(100)       Output
As
Begin
    Select @extRespuestaCAT = ' '
   
 Select @extMensajeCAT = ' '
    Declare @SRV_ReturnStatus               int
      , @fld_cotrut                     char(11)
      , @fld_benrut                     char(11)
      , @fld_bencorrel                  tinyint
      , @fld_medrut             	char(11)
      , @fld_prestacod                  int
      , @fld_cant                       smallint
      , @fld_agruitemcod                smallint
      , @fld_subagruitemcod             char(1)
      , @fld_especcod                   smallint
      , @fld_anestesia                  char(1)
      , @fld_gpfns                      smallint
      , @fld_prestatipo                 tinyint
      , @fld_prestasubtipo              char(1)
      , @fld_prestacod2                 varchar(15)
      , @fld_medaux                     char(11)
      , @xi                             smallint
      , @xfin                           tinyint
      , @xListaPrestac                  char(255)
      , @xcodate                        int
      , @xlista         		char(1)
      , @xentero                        int
      , @xdv                            char(1)
      , @xcontador                      smallint
      , @xconta_cons                    smallint
      , @xconta_anes                    smallint
      , @xconta_hon                     smallint
      , @xconta_tot                     smallint
      , @xfecha                         datetime
      , @xorigen                        tinyint
      , @ges_idn                        int
      , @der_idn                        int
      , @fld_funfolio                   int
      , @fld_funcorrel                  smallint
      , @porcen                         tinyint
      , @xmarcaporcen                   tinyint
      , @xrdscodigo           		varchar(6)
      , @xrdssi                         tinyint
      , @xinspeccion                    tinyint
    Select @SRV_ReturnStatus = 0
    
create table #codate (codigo     int ,cantidad   tinyint)
create index idx_validacat on #codate (codigo)

if @extRutConvenio = "0081698901-9"
   select @extRutConvenio = "0081698900-0"
select @fld_medrut = right(@extRutConvenio,11)
select @extRutConvenio = right(@extRutConvenio,11)
if @extRutConvenio != "079611460-6"
begin
   if not exists(select 1 From BAMB_PEC where pec_rut = @extRutConvenio)
   begin
      select @extRespuestaCAT  = "N", @extMensajeCAT  = "No existe convenio para el Prestador"
    GoTo CGCValidaCat_Exit
   end
end
select @xfecha = getdate()
select @fld_cotrut = right(@extRutCotizante,11)
select @extRutBeneficiario = right(@extRutBeneficiario,11)
Select @fld_bencorrel   = fld_bencorrel
                         From BEN
Where fld_benrut = @extRutBeneficiario      AND
      fld_beninivigfec <= @xfecha AND
      fld_benfinvigfec >= @xfecha
if @@rowcount = 0
begin
    select @extRespuestaCAT = "N", @extMensajeCAT = "No se pudo Reobtener Datos del Beneficiario"
    GoTo CGCValidaCat_Exit
end
select @fld_prestacod  = isnull(convert(int,@extCodigoHomologo),0)
select @fld_cant       = isnull(@extFrecPrestDia,1)
if @fld_prestacod = 0
begin
    select @extRespuestaCAT = "N", @extMensajeCAT = "Ultima Prestación indicada es Cero (inconsistente)"
    GoTo CGCValidaCat_Exit
end
if @fld_cant = 0
begin
    select @extRespuestaCAT = "N", @extMensajeCAT = "Cantidad de Prestaciones indicada es Cero (inconsistente)"
    GoTo CGCValidaCat_Exit
end
if @fld_prestacod in (903001, 903002, 903003, 903008, 903009, 913001, 913002, 913008)
   select @xorigen = 3    else
   select @xorigen = 2
if @extRutConvenio = "079611460-6"      
select @xorigen = 3
select @extRespuestaCAT = "", @extMensajeCAT = "", @fld_agruitemcod = 0
select @fld_subagruitemcod = "", @fld_especcod = 0, @fld_gpfns = 0, @fld_prestacod2 = ""

Exec Suc_Valida_Rest_2 @xorigen, @fld_cotrut, @fld_bencorrel, @xfecha, @fld_medrut, @fld_prestacod, @fld_prestacod2, @fld_cant, @fld_agruitemcod output, @fld_subagruitemcod output, @fld_especcod output, @fld_gpfns output, @extRespuestaCAT output, @extMensajeCAT output 

if @extRespuest aCAT = "N"
    GoTo CGCValidaCat_Exit
If @fld_agruitemcod  in (2,3,4,11) and (@extRutSolicitante < "0000047000-0" OR @extRutSolicitante > "0050000000-0")
begin
   select @extRespuestaCAT   = "N", @extMensajeCAT  = "Rut Medico 'Derivado Por' No Valido"
   
 GoTo CGCValidaCat_Exit
end
if @fld_agruitemcod not in (2,3)
   Insert into #codate (codigo, cantidad) Values (@fld_prestacod, @fld_cant)
select @xconta_tot = 1, @xconta_cons = 0, @xconta_hon = 0, @xconta_anes = 0
if @fld_agruitemcod = 1
   select @xconta_cons = 1
if @fld_agruitemcod = 5
   select @xconta_hon = 1
select @fld_anestesia = isnull(fld_anestesia,"N") from CDT where fld_prestacod = @fld_prestacod
if @fld_anestesia = "S"
    select @xconta_anes = 1
select @fld_prestatipo    = @fld_agruitemcod
select @fld_prestasubtipo = @fld_subagruitemcod
select @xcontador         = 0
select @xi = 0, @xfin = 0, @xlista = "A", @xListaPrestac  = @extListaPrestacA
select @fld_prestacod  = isnull(convert(int,substring(@xListaPrestac,(@xi*33+1),10)),0)
select @fld_cant       = isnull(convert(tinyint,substring(@xListaPrestac,(@xi*33+15),2)),0)
While (@fld_prestacod != 0) AND (@xfin = 0)
Begin
   if @fld_prestacod in (903001, 903002, 903003, 903008, 903009, 913001, 913002, 913008)
      select @xorigen = 3       else

      select @xorigen = 2
   if @extRutConvenio = "079611460-6"         select @xorigen = 3
   select @extRespuestaCAT = "", @extMensajeCAT = "", @fld_agruitemcod = 0
   select @fld_subagruitemcod = "", @fld_especcod = 0, @fld_gpfns = 0, @fld_prestacod2 = ""
   Exec Suc_Valida_Rest_2 @xorigen, @fld_cotrut, @fld_bencorrel, @xfecha, @fld_medrut, @fld_prestacod, @fld_prestacod2, @fld_cant, @fld_agruitemcod output, @fld_subagruitemcod output, @fld_especcod output, @fld_gpfns output, @extRespuestaCAT output, @extMensajeCAT output 

   if @extRespuestaCAT = "N"
    GoTo CGCValidaCat_Exit
   if @fld_agruitemcod not in (2,3)
   begin
      insert into #codate (codigo, cantidad) Values (@fld_prestacod, @fld_cant)
   end
   If @fld_agruitemcod  in (2,3,4,11) and (@extRutSolicitante < "0000047000-0" OR @extRutSolicitante > "0050000000-0")
   begin
      select @extRespuestaCAT   = "N", @extMensajeCAT  = "Rut Medico 'Derivado Por' No Valido"
    GoTo CGCValidaCat_Exit
   end
   if (@fld_agruitemcod    != @fld_prestatipo    ) OR
      (@fld_subagruitemcod != @fld_prestasubtipo)
      select @xcontador = @xcontador + 1
   select @fld_anestesia = isnull(fld_anestesia,"N") from CDT where fld_prestacod = @fld_prestacod
   if @fld_anestesia = "S"
      select @xconta_anes = 1
   if @fld_agruitemcod = 1
      select @xconta_cons = @xconta_cons + 1
   if @fld_agruitemcod = 5
      select @xconta_hon = @xconta_hon + 1
   select @xconta_tot = @xconta_tot + 1
   select @xi         = @xi + 1
   If @fld_prestacod in (903001, 903002, 903003, 903008, 903009, 913001, 913002, 913008)
   begin
      Select @ges_idn = ges_idn
      From GES_CASO
      Where ges_rutben = @extRutBeneficiario  and
            ges_rutcot = @extRutCotizante     and
            ps_idn = 34                       and
            ges_estado = "T"                  and
            getdate() between ges_vigini and ges_vigfin
      If @@rowcount = 0
      Begin
         select @extRespuestaCAT   = "N", @extMensajeCAT  = "Caso Ges Auge No Vigente"
    GoTo CGCValidaCat_Exit
      End
      Select @der_idn = der_idn
      From GES_DERIVACION
      Where ges_idn = @ges_idn          and
            der_estado in ("E")         and
            is_idn in (3402, 3404, 3405, 3406, 3407)
      If @@rowcount > 0
      Begin
          select @extRespuestaCAT   = "N", @extMensajeCAT  = "Derivación Ges Auge No Vigente"
    GoTo CGCValidaCat_Exit
      End
   End
   if @xi = 7
   begin
      if @xlista = "A"
      begin
         select @xlista = "B", @xListaPrestac = @extListaPrestacB
      end
      else
      begin
         if @xlista = "B"
         begin
            select @xlista = "C", @xListaPrestac = @extListaPrestacC
         end
         else
         begin
            if @xlista = "C"
     
       begin
               select @xlista = "D", @xListaPrestac = @extListaPrestacD
            end
            else
            begin
               if @xlista = "D"
               begin
                  select @xlista = "E", @xListaPrestac  = @extListaPrestacE
               end
               else
               begin
                  if @xlista = "E"
                  begin
                     select @xlista = "F", @xListaPrestac = @extListaPrestacF
                  end
                  else
   
               begin
                     if @xlista = "F"
                        select @xfin = 1
                  end
               end
            end
         end
      end
      select @xi  = 0
   end
   select @fld_prestacod  = isnull(convert(int,substring(@xListaPrestac,(@xi*33+1),10)),0)
   select @fld_cant       = isnull(convert(tinyint,substring(@xListaPrestac,(@xi*33+15),2)),0)
End
if @xconta_cons > 1
begin
   select @extRespuestaCAT   = "N", @extMensajeCAT  = "No puede haber más de una consulta por Acto de Venta"
    GoTo CGCValidaCat_Exit
end
if @xconta_anes = 1 and @xconta_tot > 2
begin
   select @extRespuestaCAT = "N", @extMensajeCAT = "Solo se permite una Prestación adicional a la Anestesia"
    GoTo CGCValidaCat_Exit
end
if @xconta_anes = 1 and @xconta_hon != 2
begin
   select @extRespuestaCAT = "N", @extMensajeCAT = "Prestación inválida para dar Anestesia"
    GoTo CGCValidaCat_Exit
end

IF @fld_agruitemcod = 11 AND @xorigen = 2
BEGIN
    IF (convert(int,@extCodigoHomologo) = 601029 )

    BEGIN
            IF  EXISTS(SELECT 1 
                         FROM #codate 
                        WHERE ((codigo = 601002)  OR  (codigo BETWEEN 601004 AND 601028) OR (codigo BETWEEN 601030 AND 601099) ))
            BEGIN
                select @extRespuestaCAT = "N", @extMensajeCAT = "Prestación no puede tener codigos 6010?? asociados"
                GoTo CGCValidaCat_Exit
            END
    
    END
    ELSE  BEGIN
        IF (convert(int,@extCodigoHomologo) NOT IN (601001,601003))
        BEGIN
            IF  EXISTS(SELECT 1 
                         FROM #codate 
                        WHERE (codigo =601029))
            BEGIN
                select @extRespuestaCAT = "N", @extMensajeCAT = "Prestación no puede tener códigos 6010** asociados"
                GoTo CGCValidaCat_Exit
            END
        END
    END    
END

select @extRespuestaCAT = "S"
CGCValidaCat_Exit:
    If @SRV_ReturnStatus >= 60000
    Begin
        Return 0
    End
    Else Begin
        Return 1
    End
End
     
(49 rows affected)
(return status = 0)
1> 
