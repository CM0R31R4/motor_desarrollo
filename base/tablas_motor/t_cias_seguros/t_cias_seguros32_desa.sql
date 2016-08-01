DELETE FROM cias_seguros WHERE codigo = '32';

INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


