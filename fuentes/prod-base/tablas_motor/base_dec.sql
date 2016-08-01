
drop  table dec.permisos;
drop  table dec.empresas;
drop  table dec.tipodocto;
drop  table dec.qry;
drop  table dec.carpeta;
drop  table dec.carpetadoctos;
drop  table dec.documento;
drop  table dec.firmantes;
drop  table dec.tipdoctostags;
drop  table dec.tagsvalores;
drop  table dec.relaciones;
drop  table dec.tipodoctosfirmantes;
drop  table dec.historia;
-- -----------------------------------------------------
-- table permisos
-- -----------------------------------------------------
create  table dec.permisos (
  id_permiso serial ,
  id_empresa integer not null,
  rol varchar(45) not null ,
  tipo smallint not null ,
  recurso varchar(45) not null ,
  permiso smallint not null ,
  fechadesde timestamp without time zone ,
  fechahasta timestamp without time zone ,
  primary key (id_empresa));
  create index idx_empresa_rol on dec.permisos (id_empresa, rol); 
  create index idx_fechas on dec.permisos (fechadesde, fechahasta);


-- -----------------------------------------------------
-- table empresas
-- -----------------------------------------------------
create  table dec.empresas (
  id_empresa serial ,
  nombre varchar(20) not null ,
  razon_social varchar(45) not null ,
  direccion varchar(100) null ,
  rut varchar(12) not null ,
  telefono varchar(20) null ,
  email varchar(100) not null ,
  primary key (id_empresa) );


-- -----------------------------------------------------
-- table tipodocto
-- -----------------------------------------------------
create  table dec.tipodocto (
  id_tipo serial ,
  descripcion varchar(45) not null ,
  id_empresa integer not null ,
  rol_creador varchar(45) not null ,
  fec_creacion timestamp without time zone not null ,
  id_empresacreacion integer null ,
  xsl_creacion varchar(255) null ,
  xsl_ver varchar(255) null ,
  rol_modificacion varchar(45) not null ,
  fec_modificacion timestamp without time zone not null ,
  idqry_preupload integer null ,
  idqry_postupload integer null ,
  primary key (id_tipo)); 
  create index idx_tipodocto_rol_creacion on dec.tipodocto (id_empresa, rol_creador); 
  create index idx_tipodocto_empresas on dec.tipodocto (id_empresa, id_empresacreacion);


-- -----------------------------------------------------
-- table qry
-- -----------------------------------------------------
create  table dec.qry (
  id_qry serial,
  id_empresa integer not null ,
  nombre varchar(45) null ,
  texto text null ,
  primary key (id_qry) ) ;
  create index idx_empresa on dec.qry(id_empresa);

-- -----------------------------------------------------
-- table carpeta
-- -----------------------------------------------------
create  table dec.carpeta (
  id_carpeta serial ,
  id_empresa integer not null ,
  rol varchar(45) not null ,
  tipo smallint null ,
  titulo varchar(20) null ,
  descripcion varchar(45) null ,
  idqry integer null ,
  xsl varchar(255) null ,
  primary key (id_carpeta));
  create index idx_carpeta_permisos on dec.carpeta (id_empresa, rol);


-- -----------------------------------------------------
-- table carpetadoctos
-- -----------------------------------------------------
create  table dec.carpetadoctos (
  id_carpeta integer not null ,
  id_empresa integer not null ,
  id_docto integer not null ,
  visto smallint null ,
  primary key (id_carpeta, id_empresa, id_docto));


-- -----------------------------------------------------
-- table documento
-- -----------------------------------------------------
create  table dec.documento (
  id_docto serial ,
  descripcion varchar(45) null,
  estado smallint null ,
  fec_emision timestamp without time zone null ,
  fec_modificacion timestamp without time zone null ,
  id_empresaemis integer null ,
  id_tipo integer null ,
  uri varchar(255) null ,
  primary key (id_docto));
  create index idx_documento_tipodocto on dec.documento(id_tipo, id_empresaemis); 


-- -----------------------------------------------------
-- table firmantes
-- -----------------------------------------------------
create  table dec.firmantes (
  id_firmante serial,
  id_docto integer not null ,
  id_empresa integer not null ,
  rol varchar(45) not null ,
  rut varchar(12) null ,
  accion smallint null ,
  fecha timestamp without time zone null ,
  estado smallint null ,
  primary key (id_firmante));
  create index idx_firmantes_documento_rol on dec.firmantes (id_docto, id_empresa,rol,rut);
  create index idx_firmantes_documento_rut on dec.firmantes (id_docto, id_empresa,rut,rol);
  create index idx_firmantes_fecha on dec.firmantes (fecha,estado);


-- -----------------------------------------------------
-- table tipdoctostags
-- -----------------------------------------------------
create  table dec.tipdoctostags (
  id_tag serial ,
  id_tipo integer not null ,
  id_empresa integer not null ,
  nombre varchar(45) null ,
  idqry_validacion integer null ,
  idqry_valor integer null ,
  idqry_visible integer null ,
  primary key (id_tag));
  create index idx_tipodoctotags_tipodocto on dec.tipdoctostags(id_tipo, id_empresa);


-- -----------------------------------------------------
-- table tagsvalores
-- -----------------------------------------------------
create  table dec.tagsvalores (
  id_docto integer not null ,
  id_empresa integer null ,
  id_tag integer null ,
  nombre varchar(45) null ,
  valor text null ,
  primary key (id_docto,id_empresa,id_tag));
  create index idx_tags_tipodocto_empresa on dec.tagsvalores(id_empresa);
  create index idx_tags_tipodocto_idtag on dec.tagsvalores(id_tag);


-- -----------------------------------------------------
-- table relaciones
-- -----------------------------------------------------
create  table dec.relaciones (
  id_docto integer not null ,
  id_empresa integer not null ,
  id_doctorel integer not null ,
  id_empresarel integer not null ,
  fecha timestamp without time zone  null ,
  rol varchar(45) null ,
  rut varchar(12) null ,
  primary key (id_docto,id_empresa,fecha));
  create index idx_relacion_rev on dec.relaciones (id_doctorel,id_empresarel,fecha);

-- -----------------------------------------------------
-- table tipodoctosfirmantes
-- -----------------------------------------------------
create  table dec.tipodoctosfirmantes (
  id_firmante serial ,
  id_tipo integer not null ,
  id_empresa integer not null ,
  rol varchar(45) not null ,
  rut varchar(12) null ,
  tipo_firma smallint null ,
  orden smallint null ,
  idqry_prefirma integer null ,
  idqry_postfirma integer null ,
  idqry_visible integer null ,
  primary key (id_firmante));
  create index idx_tipodoctosfirmantes_tipodocto on dec.tipodoctosfirmantes (id_tipo,id_empresa);


-- -----------------------------------------------------
-- table historia
-- -----------------------------------------------------
create  table dec.historia (
  id_docto integer not null ,
  fecha timestamp without time zone null ,
  accion smallint null ,
  id_empresa_ejecutor integer null ,
  rol_ejecutor varchar(45) null ,
  rut_ejecutor varchar(12) null ,
  id_empresa_oper integer null ,
  rol_oper varchar(45) null ,
  rut_oper varchar(12) null ,
  primary key (id_docto) );
  create index idx_historia_ejecutor on dec.historia(id_empresa_ejecutor,rol_ejecutor,rut_ejecutor);
  create index idx_historia_oper on dec.historia(id_empresa_oper,rol_oper,rut_oper);


