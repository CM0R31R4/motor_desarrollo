-- Liquidador 108 - Caja 18 (Imed)
DELETE FROM cias_seguros WHERE codigo = '108';

INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


