DELETE FROM cias_seguros WHERE codigo = '27';

INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'Certificacion', 'http://10.90.10.8/capacitacionbci/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'Conciliacion', 'http://10.90.10.8/capacitacionbci/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'Anulacion', 'http://10.90.10.8/capacitacionbci/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'AnulacionBono3', 'http://10.90.10.8/capacitacionbci/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'AnulacionBonoExt', 'http://10.90.10.8/capacitacionbci/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'Confirmacion', 'http://10.90.10.8/capacitacionbci/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'ConfirmacionBono3', 'http://10.90.10.8/capacitacionbci/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'ConfirmacionBonoExt', 'http://10.90.10.8/capacitacionbci/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');


