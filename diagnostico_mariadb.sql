-- 1. Queries mais pesadas (performance_schema)
SELECT 'TOP QUERIES' AS section;
SELECT 
    DIGEST_TEXT,
    COUNT_STAR AS exec_count,
    ROUND(SUM_TIMER_WAIT/1000000000000, 2) AS total_time_sec,
    ROUND(AVG_TIMER_WAIT/1000000000000, 2) AS avg_time_sec
FROM performance_schema.events_statements_summary_by_digest
ORDER BY total_time_sec DESC
LIMIT 10;

-- 2. Sessões mais pesadas
SELECT 'SESSIONS ATIVAS' AS section;
SELECT 
    ID, USER, HOST, DB, COMMAND, TIME, STATE, INFO
FROM information_schema.PROCESSLIST
WHERE COMMAND != 'Sleep'
ORDER BY TIME DESC
LIMIT 10;

-- 3. Tamanho das tabelas
SELECT 'TABELAS MAIORES' AS section;
SELECT 
    table_schema, 
    table_name, 
    ROUND((data_length + index_length) / 1024 / 1024, 2) AS size_mb
FROM information_schema.tables
ORDER BY size_mb DESC
LIMIT 10;

-- 4. Tamanho por database
SELECT 'DATABASES MAIORES' AS section;
SELECT 
    table_schema, 
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS size_mb
FROM information_schema.tables
GROUP BY table_schema
ORDER BY size_mb DESC;

-- 5. Tablespaces InnoDB
SELECT 'TABLESPACES INNODB' AS section;
SELECT 
    table_schema,
    table_name,
    ROUND(data_length / 1024 / 1024, 2) AS data_mb,
    ROUND(index_length / 1024 / 1024, 2) AS index_mb,
    ROUND(data_free / 1024 / 1024, 2) AS free_mb
FROM information_schema.tables
WHERE engine = 'InnoDB'
ORDER BY data_mb DESC;
