-- ============================================================
--  ESTUDO DE MODELAGEM RELACIONAL — Sistema de Pet Shop
--  Apoio ao projeto PetClean (PHP + MySQL) | MySQL 8+
--  Demonstra: PK/FK, integridade, ENUM, CHECK, JOIN e agregação
-- ============================================================

CREATE DATABASE IF NOT EXISTS petclean
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE petclean;

-- ------------------------------------------------------------
-- CLIENTE  (dono dos pets)
-- ------------------------------------------------------------
CREATE TABLE cliente (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  nome        VARCHAR(120)  NOT NULL,
  telefone    VARCHAR(20)   NOT NULL,
  email       VARCHAR(120)  UNIQUE,
  criado_em   TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- PET  (1 cliente : N pets)
-- ------------------------------------------------------------
CREATE TABLE pet (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id   INT           NOT NULL,
  nome         VARCHAR(80)   NOT NULL,
  especie      ENUM('cachorro','gato','outro') NOT NULL DEFAULT 'cachorro',
  porte        ENUM('pequeno','medio','grande'),
  nascimento   DATE,
  FOREIGN KEY (cliente_id) REFERENCES cliente (id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- SERVICO  (banho, tosa, consulta...)
-- ------------------------------------------------------------
CREATE TABLE servico (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  nome         VARCHAR(80)   NOT NULL UNIQUE,
  preco        DECIMAL(8,2)  NOT NULL CHECK (preco >= 0),
  duracao_min  INT           NOT NULL DEFAULT 60
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- AGENDAMENTO  (N pets : N servicos, via tabela associativa)
-- ------------------------------------------------------------
CREATE TABLE agendamento (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  pet_id       INT      NOT NULL,
  servico_id   INT      NOT NULL,
  data_hora    DATETIME NOT NULL,
  status       ENUM('agendado','concluido','cancelado') NOT NULL DEFAULT 'agendado',
  observacoes  TEXT,
  criado_em    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  UNIQUE KEY ux_agenda (pet_id, data_hora),          -- impede duplo agendamento do mesmo pet
  FOREIGN KEY (pet_id)     REFERENCES pet (id)      ON DELETE CASCADE,
  FOREIGN KEY (servico_id) REFERENCES servico (id)  ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================
--  DADOS DE EXEMPLO
-- ============================================================
INSERT INTO cliente (nome, telefone, email) VALUES
  ('Maria Silva',  '1199999-0001', 'maria@email.com'),
  ('João Souza',   '1199999-0002', 'joao@email.com');

INSERT INTO pet (cliente_id, nome, especie, porte, nascimento) VALUES
  (1, 'Rex',  'cachorro', 'medio',   '2022-03-15'),
  (1, 'Mimi', 'gato',     'pequeno', '2021-07-20'),
  (2, 'Thor', 'cachorro', 'grande',  '2020-11-02');

INSERT INTO servico (nome, preco, duracao_min) VALUES
  ('Banho',            50.00,  60),
  ('Tosa',             70.00,  90),
  ('Banho e Tosa',    100.00, 120);

INSERT INTO agendamento (pet_id, servico_id, data_hora, status) VALUES
  (1, 3, '2026-09-10 10:00:00', 'agendado'),
  (3, 1, '2026-09-11 14:00:00', 'agendado'),
  (2, 2, '2026-09-05 09:00:00', 'concluido');

-- ============================================================
--  CONSULTAS DE ESTUDO
-- ============================================================

-- 1) Agenda do dia com JOIN em 4 tabelas
SELECT a.data_hora, p.nome AS pet, c.nome AS cliente, s.nome AS servico, s.preco
FROM agendamento a
JOIN pet      p ON p.id = a.pet_id
JOIN cliente  c ON c.id = p.cliente_id
JOIN servico  s ON s.id = a.servico_id
WHERE a.status = 'agendado'
ORDER BY a.data_hora;

-- 2) Faturamento por serviço (agregação)
SELECT s.nome, COUNT(*) AS total, SUM(s.preco) AS receita
FROM agendamento a
JOIN servico s ON s.id = a.servico_id
WHERE a.status = 'concluido'
GROUP BY s.nome
ORDER BY receita DESC;

-- 3) Clientes com mais de 1 pet (subconsulta)
SELECT nome, telefone
FROM cliente
WHERE id IN (
  SELECT cliente_id FROM pet GROUP BY cliente_id HAVING COUNT(*) > 1
);
