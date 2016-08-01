DELETE FROM cias_seguros WHERE codigo = '48';

INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.22/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.22/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.22/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.22/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.22/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.22/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.22/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.22/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


