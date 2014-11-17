-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 05-Nov-2014 às 02:13
-- Versão do servidor: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: buykart
--
CREATE DATABASE IF NOT EXISTS buykart DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE buykart;

-- --------------------------------------------------------

--
-- Estrutura da tabela t_categoria
--

DROP TABLE IF EXISTS t_categoria;
CREATE TABLE IF NOT EXISTS t_categoria (
  tcat_id int(11) NOT NULL AUTO_INCREMENT,
  tcat_categoria varchar(45) DEFAULT NULL,
  tcat_descricao varchar(100) DEFAULT NULL,
  tu_id int(11) NOT NULL,
  PRIMARY KEY (tcat_id),
  KEY fk_t_categoria_t_usuario1_idx (tu_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela t_categoria
--

INSERT INTO t_categoria (tcat_id, tcat_categoria, tcat_descricao, tu_id) VALUES
(1, 'Alimentos', 'Produtos de consumo pessoal', 1),
(2, 'Produtos de Limpeza', 'Produtos de limpeza genéricos', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela t_compra
--

DROP TABLE IF EXISTS t_compra;
CREATE TABLE IF NOT EXISTS t_compra (
  tcomp_id int(11) NOT NULL AUTO_INCREMENT,
  tcomp_data timestamp NULL DEFAULT NULL,
  tcomp_valor_total float DEFAULT NULL,
  PRIMARY KEY (tcomp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela t_login
--

DROP TABLE IF EXISTS t_login;
CREATE TABLE IF NOT EXISTS t_login (
  tlg_id int(11) NOT NULL AUTO_INCREMENT,
  tlg_login varchar(45) DEFAULT NULL,
  tlg_senha varchar(45) DEFAULT NULL,
  tlg_ultimo_login timestamp NULL DEFAULT NULL,
  PRIMARY KEY (tlg_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela t_login
--

INSERT INTO t_login (tlg_id, tlg_login, tlg_senha, tlg_ultimo_login) VALUES
(1, 'admin', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela t_perfil
--

DROP TABLE IF EXISTS t_perfil;
CREATE TABLE IF NOT EXISTS t_perfil (
  tpf_id int(11) NOT NULL AUTO_INCREMENT,
  tpf_perfil varchar(45) DEFAULT NULL,
  PRIMARY KEY (tpf_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela t_perfil
--

INSERT INTO t_perfil (tpf_id, tpf_perfil) VALUES
(1, 'Administrador'),
(2, 'Usuário');

-- --------------------------------------------------------

--
-- Estrutura da tabela t_produto
--

DROP TABLE IF EXISTS t_produto;
CREATE TABLE IF NOT EXISTS t_produto (
  tpr_id int(11) NOT NULL AUTO_INCREMENT,
  tpr_nome varchar(45) DEFAULT NULL,
  tpr_preco float DEFAULT NULL,
  tpr_tamanho varchar(45) DEFAULT NULL,
  tsub_id int(11) NOT NULL,
  tu_id int(11) NOT NULL,
  PRIMARY KEY (tpr_id),
  KEY fk_t_produto_t_subcategoria1_idx (tsub_id),
  KEY fk_t_produto_t_usuario1_idx (tu_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela t_produto
--

INSERT INTO t_produto (tpr_id, tpr_nome, tpr_preco, tpr_tamanho, tsub_id, tu_id) VALUES
(1, 'Arroz', 2, '1kg', 1, 1),
(2, 'Creme Dental', 3, '50g', 2, 1),
(3, 'Café', 3.25, '250g', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela t_subcategoria
--

DROP TABLE IF EXISTS t_subcategoria;
CREATE TABLE IF NOT EXISTS t_subcategoria (
  tsub_id int(11) NOT NULL AUTO_INCREMENT,
  tsub_nome varchar(45) DEFAULT NULL,
  tsub_descricao varchar(100) DEFAULT NULL,
  tcat_id int(11) NOT NULL,
  tu_id int(11) NOT NULL,
  PRIMARY KEY (tsub_id),
  KEY fk_t_subcategoria_t_categoria1_idx (tcat_id),
  KEY fk_t_subcategoria_t_usuario1_idx (tu_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela t_subcategoria
--

INSERT INTO t_subcategoria (tsub_id, tsub_nome, tsub_descricao, tcat_id, tu_id) VALUES
(1, 'Cesta Básica', 'Alimentos de consumo básico', 1, 1),
(2, 'Higiene Pessoal', 'Produtos de higiene pessoal, sabonetes, creme dental, etc.', 2, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela t_usuario
--

DROP TABLE IF EXISTS t_usuario;
CREATE TABLE IF NOT EXISTS t_usuario (
  tu_id int(11) NOT NULL AUTO_INCREMENT,
  tu_nome varchar(45) DEFAULT NULL,
  tu_email varchar(45) DEFAULT NULL,
  tu_cpf varchar(45) NOT NULL,
  tpf_id int(11) NOT NULL,
  tlg_id int(11) NOT NULL,
  PRIMARY KEY (tu_id),
  UNIQUE KEY tu_cpf_UNIQUE (tu_cpf),
  KEY fk_t_usuario_t_perfil_idx (tpf_id),
  KEY fk_t_usuario_t_login1_idx (tlg_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela t_usuario
--

INSERT INTO t_usuario (tu_id, tu_nome, tu_email, tu_cpf, tpf_id, tlg_id) VALUES
(1, 'stefano', 'stefanoazevedo@facebook.com', '123456789', 2, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela t_usuario_compra_produto
--

DROP TABLE IF EXISTS t_usuario_compra_produto;
CREATE TABLE IF NOT EXISTS t_usuario_compra_produto (
  t_usuario_tu_id int(11) NOT NULL,
  t_produto_tpr_id int(11) NOT NULL,
  tucp_id int(11) NOT NULL,
  tcomp_id int(11) NOT NULL,
  PRIMARY KEY (tucp_id),
  KEY fk_t_usuario_realiza_compra_t_usuario1_idx (t_usuario_tu_id),
  KEY fk_t_usuario_realiza_compra_t_produto1_idx (t_produto_tpr_id),
  KEY fk_t_usuario_compra_produto_t_compra1_idx (tcomp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view v_produto
--
DROP VIEW IF EXISTS v_produto;
CREATE TABLE IF NOT EXISTS v_produto (
tpr_id int(11)
,tpr_nome varchar(45)
,tpr_preco float
,tpr_tamanho varchar(45)
,tsub_id int(11)
,tsub_nome varchar(45)
,tcat_id int(11)
,tcat_categoria varchar(45)
,tu_id int(11)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view v_subcategoria
--
DROP VIEW IF EXISTS v_subcategoria;
CREATE TABLE IF NOT EXISTS v_subcategoria (
tsub_id int(11)
,tsub_nome varchar(45)
,tsub_descricao varchar(100)
,tcat_id int(11)
,tcat_categoria varchar(45)
,tu_id int(11)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view v_usuario_compra_produto
--
DROP VIEW IF EXISTS v_usuario_compra_produto;
CREATE TABLE IF NOT EXISTS v_usuario_compra_produto (
t_usuario_tu_id int(11)
,t_produto_tpr_id int(11)
,tucp_id int(11)
,tcomp_id int(11)
,tcomp_data timestamp
,tcomp_valor_total float
,tpr_id int(11)
,tpr_nome varchar(45)
,tpr_preco float
,tpr_tamanho varchar(45)
,tsub_id int(11)
,tsub_nome varchar(45)
,tcat_id int(11)
,tcat_categoria varchar(45)
,tu_id int(11)
,tu_nome varchar(45)
,tu_email varchar(45)
,tu_cpf varchar(45)
,tpf_id int(11)
,tlg_id int(11)
);
-- --------------------------------------------------------

--
-- Structure for view v_produto
--
DROP TABLE IF EXISTS v_produto;

CREATE ALGORITHM=UNDEFINED DEFINER=root@localhost SQL SECURITY DEFINER VIEW v_produto AS select prod.tpr_id AS tpr_id,prod.tpr_nome AS tpr_nome,prod.tpr_preco AS tpr_preco,prod.tpr_tamanho AS tpr_tamanho,sub.tsub_id AS tsub_id,sub.tsub_nome AS tsub_nome,cat.tcat_id AS tcat_id,cat.tcat_categoria AS tcat_categoria,prod.tu_id AS tu_id from ((t_produto prod join t_subcategoria sub on((sub.tsub_id = prod.tsub_id))) join t_categoria cat on((cat.tcat_id = sub.tcat_id)));

-- --------------------------------------------------------

--
-- Structure for view v_subcategoria
--
DROP TABLE IF EXISTS v_subcategoria;

CREATE ALGORITHM=UNDEFINED DEFINER=root@localhost SQL SECURITY DEFINER VIEW v_subcategoria AS select sub.tsub_id AS tsub_id,sub.tsub_nome AS tsub_nome,sub.tsub_descricao AS tsub_descricao,cat.tcat_id AS tcat_id,cat.tcat_categoria AS tcat_categoria,sub.tu_id AS tu_id from (t_subcategoria sub join t_categoria cat on((cat.tcat_id = sub.tcat_id)));

-- --------------------------------------------------------

--
-- Structure for view v_usuario_compra_produto
--
DROP TABLE IF EXISTS v_usuario_compra_produto;

CREATE ALGORITHM=UNDEFINED DEFINER=root@localhost SQL SECURITY DEFINER VIEW v_usuario_compra_produto AS select ucp.t_usuario_tu_id AS t_usuario_tu_id,ucp.t_produto_tpr_id AS t_produto_tpr_id,ucp.tucp_id AS tucp_id,comp.tcomp_id AS tcomp_id,comp.tcomp_data AS tcomp_data,comp.tcomp_valor_total AS tcomp_valor_total,prod.tpr_id AS tpr_id,prod.tpr_nome AS tpr_nome,prod.tpr_preco AS tpr_preco,prod.tpr_tamanho AS tpr_tamanho,prod.tsub_id AS tsub_id,prod.tsub_nome AS tsub_nome,prod.tcat_id AS tcat_id,prod.tcat_categoria AS tcat_categoria,usu.tu_id AS tu_id,usu.tu_nome AS tu_nome,usu.tu_email AS tu_email,usu.tu_cpf AS tu_cpf,usu.tpf_id AS tpf_id,usu.tlg_id AS tlg_id from (((t_usuario_compra_produto ucp join v_produto prod on((prod.tpr_id = ucp.t_produto_tpr_id))) join t_usuario usu on((usu.tu_id = ucp.t_usuario_tu_id))) join t_compra comp on((comp.tcomp_id = ucp.tcomp_id)));

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela t_categoria
--
ALTER TABLE t_categoria
  ADD CONSTRAINT fk_t_categoria_t_usuario1 FOREIGN KEY (tu_id) REFERENCES t_usuario (tu_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela t_produto
--
ALTER TABLE t_produto
  ADD CONSTRAINT fk_t_produto_t_subcategoria1 FOREIGN KEY (tsub_id) REFERENCES t_subcategoria (tsub_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_t_produto_t_usuario1 FOREIGN KEY (tu_id) REFERENCES t_usuario (tu_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela t_subcategoria
--
ALTER TABLE t_subcategoria
  ADD CONSTRAINT fk_t_subcategoria_t_categoria1 FOREIGN KEY (tcat_id) REFERENCES t_categoria (tcat_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_t_subcategoria_t_usuario1 FOREIGN KEY (tu_id) REFERENCES t_usuario (tu_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela t_usuario
--
ALTER TABLE t_usuario
  ADD CONSTRAINT fk_t_usuario_t_perfil FOREIGN KEY (tpf_id) REFERENCES t_perfil (tpf_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_t_usuario_t_login1 FOREIGN KEY (tlg_id) REFERENCES t_login (tlg_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela t_usuario_compra_produto
--
ALTER TABLE t_usuario_compra_produto
  ADD CONSTRAINT fk_t_usuario_realiza_compra_t_usuario1 FOREIGN KEY (t_usuario_tu_id) REFERENCES t_usuario (tu_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_t_usuario_realiza_compra_t_produto1 FOREIGN KEY (t_produto_tpr_id) REFERENCES t_produto (tpr_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_t_usuario_compra_produto_t_compra1 FOREIGN KEY (tcomp_id) REFERENCES t_compra (tcomp_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
