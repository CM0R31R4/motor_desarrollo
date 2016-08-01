locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
5
(1 row affected)
text
Create Procedure CGCDatosPrest
      @extCodFinanciador              smallint
    , @extRutConvenio                 char(12)
    , @extCodigoSucur                 char(10)
    , @extEstConvenio                 char(10)        Output
    , @extNivel       		      tinyint         Output
    , @extTipoPrestador               char(1)         Output
    , @extCodEspecialidades           char(255)       Output
    , @extCodProfesiones              char(255)       Output
    , @extAnosAntiguedad              char(2)         Output
As
Begin
    Select @extEstConvenio = ' '
    Select @extNivel = 0
    Select @extTipoPrestador = ' '
    Select @extCodEspecialidades = ' '
    Select @extCodProfesiones = ' '
    Select @extAnosAntiguedad = ' '
    Declare @SRV_ReturnStatus               int
    Select @SRV_ReturnStatus = 0
select @extEstConvenio       = space(10)
select @extNivel             = 0
select @extTipoPrestador     = space(1)
select @extCodEspecialidades = space(255)
select @extCodProfesiones    = space(255)
select @extAnosAntiguedad    = space(2)
CGCDatosPrest_Exit:
    If @SRV_ReturnStatus >= 60000
    Begin
        Return 0
    End
    Else Begin
        Return 1
    End
End
                                                                        
(5 rows affected)
(return status = 0)
1> 
