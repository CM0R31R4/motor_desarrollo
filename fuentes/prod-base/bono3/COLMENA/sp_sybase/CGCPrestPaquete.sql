locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
11
(1 row affected)
text
Create Procedure CGCPrestPaquete
      @extCodFinanciador          smallint
    , @extHomNumeroConvenio       char(15)
    , @extHomLugarConvenio        char(10)
    , @extCodPaquete              char(15)
    , @extCodError                char(1)    Output
    , @extMensajeError            char(30)   Output
As
Begin
    Select @extCodError = ' '
    Select @extMensajeError = ' '
    Declare @SRV_ReturnStatus               int
      , @extCodHomologo                 char(12)
      , @extItemHomologo                char(2)
      , @extCantidad                    int
      , @xconcod                        int
      , @ddp_correl                     tinyint
      , @fld_pscrut                     char(11)
      , @ddp_huella 			char(1)
      , @pqa_idn                        int
      , @pqad_pqaidn                    int
    Select @SRV_ReturnStatus = 0
if convert(int,@extHomNumeroConvenio) = 9999999
   select @extHomNumeroConvenio = "000000000006696"
Select @xconcod  = isnull(convert(int,@extHomNumeroConvenio),0)
if (@xconcod = 0)
begin
    select @extCodError = "N", @extMensajeError = "Numero de Convenio en cero"
    GoTo CGCPrestPaquete_Exit
end
Select @fld_pscrut = pec_rut
From CM_PEC
Where pec_numcon = @xconcod
if @@rowcount = 0
begin
    select @extCodError = "N", @extMensajeError = "No existe Prestador en Colmena"
    GoTo CGCPrestPaquete_Exit
end
select @ddp_correl   = isnull(convert(tinyint,@extHomLugarConvenio),0)
select @ddp_huella = ddp_huella
f
rom   CM_DDP
where  ddp_rut    = @fld_pscrut AND
       ddp_correl = @ddp_correl
if (@@rowcount = 0)
begin
    select @extCodError = "N", @extMensajeError = "No existe Lugar Convenio"
    GoTo CGCPrestPaquete_Exit
end
if @ddp_huella = "N"
begin
    select
 @extCodError = "N", @extMensajeError = "Prestador/ Dir. no Autorizada"
    GoTo CGCPrestPaquete_Exit
end
Select @pqa_idn = pqa_idn
From AMB_PQA
Where pqa_rut    = @fld_pscrut    AND
      pqa_dir    = @ddp_correl    AND
      pqa_codigo = @extCodPaquete

if (@@rowcount = 0)
begin
    select @extCodError = "N", @extMensajeError = "No existe Paquete Ambulatorio"
    GoTo CGCPrestPaquete_Exit
end
select @pqad_pqaidn = @pqa_idn
Select distinct  extCodHomologo  = right("0000000" + convert(varchar(7),pqad_codat
e),7) + "     "
     , extItemHomologo = "0"
      , extCantidad     = pqad_cantid
From AMB_PQAD
Where pqad_pqaidn = @pqad_pqaidn
if (@@rowcount = 0)
begin
    select @extCodError = "N", @extMensajeError = "No existe detalle de PQT.Ambul"
    GoTo CGCPres
tPaquete_Exit
end
select @extCodError = "S", @extMensajeError = ""
CGCPrestPaquete_Exit:
    If @SRV_ReturnStatus >= 60000
    Begin
        Return 0
    End
    Else Begin
        Return 1
    End
End
                                                     
(11 rows affected)
(return status = 0)
1> 
