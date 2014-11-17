CREATE SCHEMA IF NOT EXISTS buykart DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE buykart ;

-- -----------------------------------------------------
-- Table buykart.t_perfil
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS buykart.t_perfil (
  tpf_id INT NOT NULL AUTO_INCREMENT,
  tpf_perfil VARCHAR(45) NULL,
  PRIMARY KEY (tpf_id))
;

Insert into t_perfil (tpf_perfil) Values('Administrador');
Insert into t_perfil (tpf_perfil) Values('Usuário');
-- -----------------------------------------------------
-- Table buykart.t_login
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS buykart.t_login (
  tlg_id INT NOT NULL AUTO_INCREMENT,
  tlg_login VARCHAR(45) NULL,
  tlg_senha VARCHAR(45) NULL,
  tlg_ultimo_login TIMESTAMP NULL,
  PRIMARY KEY (tlg_id))
;
INSERT INTO `t_login` (`tlg_id`, `tlg_login`, `tlg_senha`, `tlg_ultimo_login`) VALUES
(1, 'admin', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL);

-- -----------------------------------------------------
-- Table buykart.t_usuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS buykart.t_usuario (
  tu_id INT NOT NULL AUTO_INCREMENT,
  tu_nome VARCHAR(45) NULL,
  tu_email VARCHAR(45) NULL,
  tu_cpf VARCHAR(45) NOT NULL,
  tpf_id INT NOT NULL,
  tlg_id INT NOT NULL,
  PRIMARY KEY (tu_id),
  UNIQUE INDEX tu_cpf_UNIQUE (tu_cpf ASC),
  INDEX fk_t_usuario_t_perfil_idx (tpf_id ASC),
  INDEX fk_t_usuario_t_login1_idx (tlg_id ASC),
  CONSTRAINT fk_t_usuario_t_perfil
    FOREIGN KEY (tpf_id)
    REFERENCES buykart.t_perfil (tpf_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_t_usuario_t_login1
    FOREIGN KEY (tlg_id)
    REFERENCES buykart.t_login (tlg_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table buykart.t_compra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS buykart.t_compra (
  tcomp_id INT NOT NULL AUTO_INCREMENT,
  tcomp_especificacao Varchar(100) Not Null,
  tcomp_data TIMESTAMP NULL,
  tu_id INT Not Null,
  PRIMARY KEY (tcomp_id),
  INDEX fk_t_compra_t_usuario1_idx (tu_id ASC),
    FOREIGN KEY (tu_id)
    REFERENCES buykart.t_usuario (tu_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table buykart.t_categoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS buykart.t_categoria (
  tcat_id INT NOT NULL AUTO_INCREMENT,
  tcat_categoria VARCHAR(45) NULL,
  tcat_descricao VARCHAR(100) NULL,
  tu_id INT NOT NULL,
  PRIMARY KEY (tcat_id),
  INDEX fk_t_categoria_t_usuario1_idx (tu_id ASC),
  CONSTRAINT fk_t_categoria_t_usuario1
    FOREIGN KEY (tu_id)
    REFERENCES buykart.t_usuario (tu_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table buykart.t_subcategoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS buykart.t_subcategoria (
  tsub_id INT NOT NULL AUTO_INCREMENT,
  tsub_nome VARCHAR(45) NULL,
  tsub_descricao VARCHAR(100) NULL,
  tcat_id INT NOT NULL,
  tu_id INT NOT NULL,
  PRIMARY KEY (tsub_id),
  INDEX fk_t_subcategoria_t_categoria1_idx (tcat_id ASC),
  INDEX fk_t_subcategoria_t_usuario1_idx (tu_id ASC),
  CONSTRAINT fk_t_subcategoria_t_categoria1
    FOREIGN KEY (tcat_id)
    REFERENCES buykart.t_categoria (tcat_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_t_subcategoria_t_usuario1
    FOREIGN KEY (tu_id)
    REFERENCES buykart.t_usuario (tu_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table buykart.t_produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS buykart.t_produto (
  tpr_id INT NOT NULL AUTO_INCREMENT,
  tpr_nome VARCHAR(45) NULL,
  tpr_preco FLOAT NULL,
  tpr_tamanho VARCHAR(45) NULL,
  tsub_id INT NOT NULL,
  tu_id INT NOT NULL,
  PRIMARY KEY (tpr_id),
  INDEX fk_t_produto_t_subcategoria1_idx (tsub_id ASC),
  INDEX fk_t_produto_t_usuario1_idx (tu_id ASC),
  CONSTRAINT fk_t_produto_t_subcategoria1
    FOREIGN KEY (tsub_id)
    REFERENCES buykart.t_subcategoria (tsub_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_t_produto_t_usuario1
    FOREIGN KEY (tu_id)
    REFERENCES buykart.t_usuario (tu_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table buykart.t_usuario_compra_produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS buykart.t_usuario_compra_produto (
  t_usuario_tu_id INT NOT NULL,
  t_produto_tpr_id INT NOT NULL,
  tucp_id INT NOT NULL AUTO_INCREMENT,
  tucp_quantidade Int NULL,
  tcomp_id INT NOT NULL,
  INDEX fk_t_usuario_realiza_compra_t_usuario1_idx (t_usuario_tu_id ASC),
  INDEX fk_t_usuario_realiza_compra_t_produto1_idx (t_produto_tpr_id ASC),
  PRIMARY KEY (tucp_id),
  INDEX fk_t_usuario_compra_produto_t_compra1_idx (tcomp_id ASC),
  CONSTRAINT fk_t_usuario_realiza_compra_t_usuario1
    FOREIGN KEY (t_usuario_tu_id)
    REFERENCES buykart.t_usuario (tu_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_t_usuario_realiza_compra_t_produto1
    FOREIGN KEY (t_produto_tpr_id)
    REFERENCES buykart.t_produto (tpr_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_t_usuario_compra_produto_t_compra1
    FOREIGN KEY (tcomp_id)
    REFERENCES buykart.t_compra (tcomp_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -------------------------------------------------------------------
-- View de Subcategorias ------------------------------------------
-- -------------------------------------------------------------------
Drop view if exists v_subcategoria;
Create view v_subcategoria As 
Select sub.tsub_id, sub.tsub_nome, sub.tsub_descricao, cat.tcat_id, cat.tcat_categoria, sub.tu_id
from t_subcategoria as sub 
Inner Join t_categoria as cat On cat.tcat_id = sub.tcat_id;

-- -------------------------------------------------------------------
-- View de Produtos ------------------------------------------
-- -------------------------------------------------------------------
Drop view if exists v_usuario_compra_produto;
Drop view if exists v_produto;
Create view v_produto As 
Select prod.tpr_id, prod.tpr_nome, prod.tpr_preco, prod.tpr_tamanho, sub.tsub_id,sub.tsub_nome, cat.tcat_id, cat.tcat_categoria, prod.tu_id
from t_produto as prod
Inner Join t_subcategoria as sub On sub.tsub_id = prod.tsub_id
Inner Join t_categoria as cat On cat.tcat_id = sub.tcat_id;

-- -------------------------------------------------------------------
-- View de Compras ------------------------------------------
-- -------------------------------------------------------------------
Drop view if exists v_usuario_compra_produto;
Create view v_usuario_compra_produto As 
Select ucp.t_usuario_tu_id,
       ucp.t_produto_tpr_id,
       ucp.tucp_id,
       ucp.tcomp_id,
       ucp.tucp_quantidade,
       comp.tu_id,
       comp.tcomp_data,
       comp.tcomp_especificacao,
       prod.tpr_id, 
       prod.tpr_nome, 
       prod.tpr_preco, 
       prod.tpr_tamanho, 
       prod.tsub_id,
       prod.tsub_nome, 
       prod.tcat_id, 
       prod.tcat_categoria, 
       usu.tu_nome,
       usu.tu_email,
       usu.tu_cpf,
       usu.tpf_id,
       usu.tlg_id,
       prod.tpr_preco*ucp.tucp_quantidade as subtotal,
       
from t_usuario_compra_produto as ucp
Right Join v_produto as prod On prod.tpr_id =ucp.t_produto_tpr_id
Right Join t_usuario as usu On usu.tu_id = ucp.t_usuario_tu_id
Right Join t_compra as comp On comp.tcomp_id = ucp.tcomp_id;

Drop view if exists v_compra;
Create view v_compra as
Select  t_compra.tcomp_id, 
        t_compra.tcomp_especificacao, 
        t_compra.tcomp_data,
        t_compra.tu_id, 
(Select sum(subtotal) From v_usuario_compra_produto as cpu Where cpu.tcomp_id = t_compra.tcomp_id) as valor_total
From t_compra;