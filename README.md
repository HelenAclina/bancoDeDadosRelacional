# Modelagem de Banco de Dados Relacional

> Estudos de modelagem relacional e SQL — disciplina de Banco de Dados (Fatec Mauá), aplicada a um caso prático de pet shop.

## Sobre o projeto

Modelagem completa de um banco relacional para **pet shop** — o mesmo domínio do projeto [PetClean](https://github.com/HelenAclina/petclean), servindo de referência para a futura integração da aplicação com banco de dados.

O script cobre do DDL às consultas analíticas: criação de tabelas com integridade referencial, restrições de domínio, dados de exemplo e três consultas de estudo.

## Conteúdo

```
sql/
└── petshop_modelagem.sql   # DDL completo (4 tabelas) + dados + consultas de estudo
```

## O que o script demonstra

- Chaves primárias e estrangeiras (`PRIMARY KEY` / `FOREIGN KEY`) com `ON DELETE CASCADE` e `RESTRICT`
- Restrições de integridade: `UNIQUE`, `CHECK`, `NOT NULL`, `ENUM`
- Relacionamento N:N via tabela associativa (`agendamento`) com chave única composta para impedir duplo agendamento
- **Consulta 1** — JOIN em 4 tabelas (agenda do dia com pet, cliente e serviço)
- **Consulta 2** — agregação com `GROUP BY` (faturamento por serviço)
- **Consulta 3** — subconsulta com `HAVING` (clientes com mais de um pet)

## Como executar

Requisito: MySQL 8+ (ou MariaDB).

```bash
mysql -u root -p < sql/petshop_modelagem.sql
```

## Autora

**Helen Aclina** · [@HelenAclina](https://github.com/HelenAclina)
