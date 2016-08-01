-- Liquidador 200 - Bienestar Las Lilas (Imed).
DELETE FROM cias_seguros WHERE codigo = '200';

INSERT INTO cias_seguros VALUES ('200', 'Bienestar Las Lilas (Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('200', 'Bienestar Las Lilas (Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('200', 'Bienestar Las Lilas (Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('200', 'Bienestar Las Lilas (Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('200', 'Bienestar Las Lilas (Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('200', 'Bienestar Las Lilas (Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('200', 'Bienestar Las Lilas (Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('200', 'Bienestar Las Lilas (Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

