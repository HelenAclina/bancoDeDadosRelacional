# 🗄️ bancoDeDadosRelacional

Repositório da disciplina de **Banco de Dados Relacionais** — desenvolvimento
SQL, modelagem de dados (Entidade-Relacionamento), normalização e consultas
complexas com foco em integridade e performance.

## 📂 Estrutura

```
📁 sql/                  → scripts de modelagem e consultas de estudo
│  └── petshop_modelagem.sql   → modelagem completa de um pet shop (apoio ao projeto PetClean)
```

## 📝 Conteúdos estudados

- [x] Modelagem ER — entidades, atributos e relacionamentos
- [x] SQL — DDL (`CREATE`, `ALTER`) e DML (`INSERT`, `SELECT`, `UPDATE`, `DELETE`)
- [ ] Normalização (1FN, 2FN, 3FN)
- [ ] Joins e subconsultas
- [ ] Funções de agregação e agrupamento
- [ ] Índices e performance de consultas

## ▶️ Como executar os scripts

Requisito: MySQL 8+ (ou MariaDB).

```bash
mysql -u root -p < sql/petshop_modelagem.sql
```

Ou, dentro do cliente MySQL:
```sql
SOURCE sql/petshop_modelagem.sql;
```

## 🧠 O script `petshop_modelagem.sql` demonstra

- Chaves primárias e estrangeiras (`PRIMARY KEY` / `FOREIGN KEY`)
- Restrições de integridade (`UNIQUE`, `CHECK`, `NOT NULL`, `ENUM`)
- Relacionamentos 1:N com `ON DELETE CASCADE`
- Consultas com `JOIN` e funções de agregação

## 🎓 Contexto

Disciplina da graduação em Desenvolvimento de Software Multiplataforma (Fatec Mauá).
