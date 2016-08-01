
-- Liquidador 108 - Caja 18(Imed)
DELETE FROM cias_seguros WHERE codigo = '108';
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

--INSERT INTO cias_seguros VALUES ('122', 'Metlife', 'metlife_cert', 'Conciliacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('122', 'Metlife', 'metlife_cert', 'Confirmacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('122', 'Metlife', 'metlife_cert', 'Anulacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('122', 'Metlife', 'metlife_cert', 'Certificacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
