DELETE FROM cias_seguros WHERE codigo = '17';

INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'Conciliacion', 'http://10.10.2.20/Imed/WsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'Confirmacion', 'http://10.10.2.20/Imed/WsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'ConfirmacionBono3', 'http://10.10.2.20/Imed/WsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'ConfirmacionBonoExt', 'http://10.10.2.20/Imed/WsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'Certificacion', 'http://10.10.2.20/Imed/WsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'Anulacion', 'http://10.10.2.20/Imed/WsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'AnulacionBono3', 'http://10.10.2.20/Imed/WsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'AnulacionBonoExt', 'http://10.10.2.20/Imed/WsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');