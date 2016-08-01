DELETE FROM cias_seguros WHERE codigo = '39';

INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'Conciliacion', 'http://10.0.0.114/~imed/nusoap/Imed/wsConciliacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'Certificacion', 'http://10.0.0.114/~imed/nusoap/Imed/wsCertificacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'Confirmacion', 'http://10.0.0.114/~imed/nusoap/Imed/wsConfirmacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'ConfirmacionBono3', 'http://10.0.0.114/~imed/nusoap/Imed/wsConfirmacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'ConfirmacionBonoExt', 'http://10.0.0.114/~imed/nusoap/Imed/wsConfirmacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'Anulacion', 'http://10.0.0.114/~imed/nusoap/Imed/wsAnulacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'AnulacionBono3', 'http://10.0.0.114/~imed/nusoap/Imed/wsAnulacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'AnulacionBonoExt', 'http://10.0.0.114/~imed/nusoap/Imed/wsAnulacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


