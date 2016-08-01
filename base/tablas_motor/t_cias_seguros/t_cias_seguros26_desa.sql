DELETE FROM cias_seguros WHERE codigo = '26';

INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');


