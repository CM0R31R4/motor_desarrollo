
DELETE FROM cias_seguros WHERE codigo = '11';

INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'Confirmacion', 'http://10.150.73.119/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'ConfirmacionBono3', 'http://10.150.73.119/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'ConfirmacionBonoExt', 'http://10.150.73.119/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'Conciliacion', 'http://10.150.73.119/I-med/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'Anulacion', 'http://10.150.73.119/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'AnulacionBono3', 'http://10.150.73.119/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'AnulacionBonoExt', 'http://10.150.73.119/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'Certificacion', 'http://10.150.73.119/I-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');