locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
14
(1 row affected)
text
create procedure dbo.INGSolicFolios
(
 @extCodFinanciador     smallint,
 @extNumFolios          tinyint,
 @extCodError           char(1)  output,
 @extMensajeError       char(30) output
)
/*
   procedimiento : INGSolicFolios
   Autor         : Cristian Rivas Rivera.
   Parametros I
       @extCodFinanciador     : Código del Financiador
       @extNumFolios          : Número de Folios requeridos por el certificador
   Parametros O
       @extCodError           : Código de Error ('S','N')
                		S = estador exitoso de la transaccion
                		N = fallo o error en transaccion
       @extMensajeError       : Mensaje de Error.
   ------------------------
   |Servicios para C-Salud |
   ------------------------
   Descripción
   Este Servicio retorna tantos folios de bonos asociados a una marca, como los solicitados por
   parametro. Si no se usan por el certificador éstos se pierden.
   Prueba
   declare
   	@extCodError           char(1),
     	@extMensajeError       char(30)
     	exec INGSolicFolios 74, 3, @extCodError output, @extMensajeError  output
   	select * from migracion..ControlFolios
*/
As
declare @Marca        marca,
        @TipoDoc      char(4),
        @Correlativo  int,
        @Iterador     tinyint,
        @ErrorCode    int,
        @SiNo         flag
begin
	create table #EntregaFolios
	(exFoliosDevueltos numeric(10))
	Select @Iterador    =   1
	Select @extCodError = 'S'
	while ((@Iterador <= @extNumFolios)and(@Iterador <= 255)and(@extCodError <> 'N'))
	--// En PRODUCCION la llamada debiera ser esta:Hacia adelante partiendo desde 1.
		exec @ErrorCode = prestacion..ObtieneCorxDoc_Marca @Marca, 'FOBE', @Correlativo output
		if @ErrorCode = 0
     			insert #EntregaFolios values (@Correlativo)
     			exec @ErrorCode = Activa_SoloMarcaING @SiNo output
     			if @SiNo = 'S'
				insert prestacion..Log_Control_Folios
				values (@Correlativo,'IN','BO',getdate(),NULL,'SO',NULL,NULL,NULL,NULL,NULL)
     			else
				insert prestacion..Log_Control_Folios
				values (@Correlativo,@Marca,'BO',getdate(),NULL,'SO',NULL,NULL,NULL,NULL,NULL)
		    		Select @extCodError     = 'S'
     				Select @extMensajeError = ''
			end -- Fin del @SiNo
	   	else
			Select @extCodError     = 'N'
     			Select @extMensajeError = 'TRX DENEGADA (EI:400363) '+ convert(char(10),@ErrorCode)
     			Select @Iterador = @extNumFolios + 1
    		end -- Fin del @ErrorCode=0
   		if @Iterador <= 254 
		Select @Iterador = @Iterador + 1
  	end --Fin de while
	
	if (Select count(*) from #EntregaFolios) <> @extNumFolios
		--// ANULACION DE LOS FOLIOS QUE NO DEBERAN SER USADOS.
		update prestacion..Log_Control_Folios set LcfEstUso_re = 'NU',LcfFecUso_fc = getdate()
  		from prestacion..Log_Control_Folios,#EntregaFolios
	   	where LcfFolEnt_id = exFoliosDevueltos and LcfTipDoc_id = 'BO'
   	
		truncate table #EntregaFolios
	   	Select @extCodError     = 'N'
   		Select @extMensajeError = 'TRX DENEGADA (EI:400364)'
 		return 1
	end --Fin del Count

 	Select exFoliosDevueltos From #EntregaFolios
	if @extCodError = 'S'
		Select @extCodError     = 'S'
		Select @extMensajeError = ''
		return 1
  	end --Fin del @extCodError = 'S'
end --Fin del Begin Inicial

(14 rows affected)
(return status = 0)
1> 
