#!/bin/bash

# Configurações do MariaDB
USUARIO="root"
SENHA="sua_senha"
HOST="localhost"
BANCO="information_schema"

# Arquivo de saída
DATA=$(date +"%Y%m%d_%H%M%S")
ARQUIVO_SAIDA="diagnostico_mariadb_$DATA.txt"

echo "Iniciando diagnóstico do MariaDB..."

# Execução das queries
mysql -u"$USUARIO" -p"$SENHA" -h"$HOST" < diagnostico_mariadb.sql > "$ARQUIVO_SAIDA"

# Estatísticas do sistema
{
  echo -e "\n\n--- USO DE CPU E MEMÓRIA ---"
  top -b -n 1 | head -15

  echo -e "\n\n--- USO DE DISCO ---"
  df -h

  echo -e "\n\n--- USO DE PROCESSO DO MYSQL ---"
  ps aux | grep mysqld | grep -v grep
} >> "$ARQUIVO_SAIDA"

echo "Diagnóstico concluído! Verifique o arquivo: $ARQUIVO_SAIDA"
