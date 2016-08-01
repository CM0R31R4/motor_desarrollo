DROP TABLE mail_cias cascade;
CREATE TABLE mail_cias (
    codigo      integer,
    nombre      character varying,
    mail_cia    character varying default 'operaciones@acepta.com'
    --mail_cia  character varying default 'jcossio@i-med.cl'
);

CREATE INDEX mail_cias_01 ON mail_cias USING btree (codigo);


INSERT INTO mail_cias VALUES (11, 'ServMed CCHC');

INSERT INTO mail_cias VALUES (12, 'Metlife', 'mroman@metlife.cl,ccornejo@metlife.cl,jcabeza@metlife.cl,wurbina@metlife.cl,mrodriguezd@metlife.cl');
--INSERT INTO mail_cias VALUES (12, 'Metlife');

INSERT INTO mail_cias VALUES (13, 'BCI');

INSERT INTO mail_cias VALUES (14, 'Sura(Mpro)');

INSERT INTO mail_cias VALUES (15, 'Vida Security(Trassa)');

INSERT INTO mail_cias VALUES (16, 'MetLife(Trassa)');

INSERT INTO mail_cias VALUES (17, 'EuroAmerica');

INSERT INTO mail_cias VALUES (18, 'Vida Security');

INSERT INTO mail_cias VALUES (19, 'Consorcio(Mpro)');

INSERT INTO mail_cias VALUES (20, 'ING(Trassa)');

INSERT INTO mail_cias VALUES (21, 'Consorcio(Trassa)');

INSERT INTO mail_cias VALUES (22, 'CruzdelSur(Trassa)');

INSERT INTO mail_cias VALUES (24, 'CruzdelSur(Faraggi)');

INSERT INTO mail_cias VALUES (25, 'ChiCon(Faraggi)');

INSERT INTO mail_cias VALUES (26, 'Corp Vida(Trassa)');

INSERT INTO mail_cias VALUES (27, 'BCI(Mpro)');

INSERT INTO mail_cias VALUES (28, 'Bice Vida');

INSERT INTO mail_cias VALUES (29, 'BCI(Trassa)');

INSERT INTO mail_cias VALUES (30, 'Chicon(Trassa)');

INSERT INTO mail_cias VALUES (31, 'EuroAmerica(Trassa)');

INSERT INTO mail_cias VALUES (32, 'InterAmericana(Trassa)');

INSERT INTO mail_cias VALUES (33, 'CorpVida(Faraggi)');

INSERT INTO mail_cias VALUES (34, 'BCI(Faraggi)');

INSERT INTO mail_cias VALUES (35, 'InterAmericana(Mpro)');

INSERT INTO mail_cias VALUES (36, 'CCAF(Metlife)');

INSERT INTO mail_cias VALUES (37, 'MetLife(Mpro)');

INSERT INTO mail_cias VALUES (38, 'Chilena Consolidada');

INSERT INTO mail_cias VALUES (39, 'Sermecoop');

INSERT INTO mail_cias VALUES (40, 'Chubb(Trassa)');

INSERT INTO mail_cias VALUES (41, 'CCAF(Mpro)');

INSERT INTO mail_cias VALUES (42, 'Sura(Faraggi)');

INSERT INTO mail_cias VALUES (42, 'Sura(Faraggi)');

INSERT INTO mail_cias VALUES (43, 'ChiCon(Mpro)');

INSERT INTO mail_cias VALUES (44, 'Vida Camara');

INSERT INTO mail_cias VALUES (45, 'Integramedica(Faraggi)');

INSERT INTO mail_cias VALUES (46, 'MOK Assist(Mpro)');

INSERT INTO mail_cias VALUES (47, 'Vida Camara(Mpro)');

INSERT INTO mail_cias VALUES (48, 'Magallanes(Trassa)');

INSERT INTO mail_cias VALUES (49, 'BBVA(Trassa)');

INSERT INTO mail_cias VALUES (51, 'BBVA(Faraggi)');

INSERT INTO mail_cias VALUES (52, 'Vida Security(Faraggi)');

INSERT INTO mail_cias VALUES (53, 'Vida Camara(Faraggi)');

INSERT INTO mail_cias VALUES (56, 'Magallanes(Faraggi)');

INSERT INTO mail_cias VALUES (57, 'Colmena(Faraggi)');

--INSERT INTO mail_cias VALUES (58, 'CruzBlanca');

INSERT INTO mail_cias VALUES (91, 'Consorcio(Imed)');

INSERT INTO mail_cias VALUES (93, 'Sura(Imed)');

INSERT INTO mail_cias VALUES (100, 'Liq-Pruebas(Imed)');

INSERT INTO mail_cias VALUES (101, 'CCAF(Imed)');

INSERT INTO mail_cias VALUES (102, 'Ben Salud(Imed)');

INSERT INTO mail_cias VALUES (103, 'Gea Chile(Imed)');

INSERT INTO mail_cias VALUES (104, 'CruzBlanca(Imed)');

INSERT INTO mail_cias VALUES (105, 'Caja Andes');

INSERT INTO mail_cias VALUES (122, 'Metlife_QA');

