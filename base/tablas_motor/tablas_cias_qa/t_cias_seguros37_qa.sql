DELETE FROM cias_seguros WHERE codigo = '37';
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'Confirmacion', 'http://10.90.10.8/ws_met_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'ConfirmacionBono3', 'http://10.90.10.8/ws_met_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'ConfirmacionBonoExt', 'http://10.90.10.8/ws_met_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'Anulacion', 'http://10.90.10.8/ws_met_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'AnulacionBono3', 'http://10.90.10.8/ws_met_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'AnulacionBonoExt', 'http://10.90.10.8/ws_met_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'Conciliacion', 'http://10.90.10.8/ws_met_prod/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'Certificacion', 'http://10.90.10.8/ws_met_prod/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

