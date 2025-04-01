# 🧠 Diagnóstico de Performance - MariaDB

Este repositório contém scripts para realizar uma análise detalhada da performance de um banco de dados **MariaDB**, com foco em identificar:

- ⚡ Queries mais pesadas
- 💾 Consumo de disco
- 🧠 Uso de memória
- ⚙️ Uso de CPU
- 👥 Sessões ativas pesadas
- 🧱 Tamanho de tablespaces

---

## 📁 Arquivos

- `diagnostico_mariadb.sql`: Contém queries SQL para diagnóstico detalhado do banco de dados.
- `executar_diagnostico.sh`: Script shell para automatizar a execução das queries e coletar estatísticas do sistema operacional.
- `diagnostico_mariadb_<data>.txt`: Arquivo gerado com o resultado da análise.

---

## ✅ Requisitos

Antes de utilizar o script, certifique-se de que os seguintes requisitos estão atendidos:

### 🔧 1. Acesso ao MariaDB via terminal

- O script usa o cliente `mysql` para conectar ao banco.
- É necessário ter as credenciais (`usuário`, `senha`, `host`) e permissões de leitura no banco.

### 📦 2. Ativar `performance_schema`

O `performance_schema` é fundamental para consultar estatísticas detalhadas de queries.

#### Como verificar se está ativo:
```sql
SHOW VARIABLES LIKE 'performance_schema';

#### Em alguns casos, também é necessário ativar os consumidores do performance_schema:

UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE '%statements%';

 O que a query faz?
Ela habilita o armazenamento de eventos relacionados a instruções SQL, para que você consiga visualizar:

Quais queries estão sendo executadas
Quantas vezes
Qual tempo médio e total
Uso de recursos