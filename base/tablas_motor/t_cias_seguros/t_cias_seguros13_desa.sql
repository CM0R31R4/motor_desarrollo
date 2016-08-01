DELETE FROM cias_seguros WHERE codigo = '13';

INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'Confirmacion', 'http://146.83.244.27/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'ConfirmacionBono3', 'http://146.83.244.27/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'ConfirmacionBonoExt', 'http://146.83.244.27/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'Conciliacion', 'http://146.83.244.27/I-med/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'Anulacion', 'http://146.83.244.27/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'AnulacionBono3', 'http://146.83.244.27/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'AnulacionBonoExt', 'http://146.83.244.27/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'Certificacion', 'http://146.83.244.27/I-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');