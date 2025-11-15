/*
    00_exportar_diccionario_de_datos.sql

    Genera en la salida estándar (stdout) un JSON UTF-8 con el
    diccionario de datos (comentarios de tablas, columnas, constraints,
    triggers y funciones) del esquema public.

    Para guardar el archivo en el directorio actual:

      psql -U postgres -d fca_auditorios \
           -f 00_exportar_diccionario_de_datos.sql \
           -o diccionario_datos.json
*/

\pset format unaligned
\pset tuples_only on
\pset footer off
\pset pager off
\encoding UTF8

WITH

-- Tablas del esquema public
tablas AS (
    SELECT
        n.nspname                         AS schema_name,
        c.relname                         AS table_name,
        obj_description(c.oid, 'pg_class') AS table_comment
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE c.relkind IN ('r','p','v','m','f')
      AND n.nspname = 'public'
    ORDER BY c.relname
),

-- Columnas
columnas AS (
    SELECT
        n.nspname                                          AS schema_name,
        c.relname                                          AS table_name,
        a.attname                                          AS column_name,
        pg_catalog.format_type(a.atttypid, a.atttypmod)    AS data_type,
        col_description(a.attrelid, a.attnum)             AS column_comment
    FROM pg_attribute a
    JOIN pg_class c      ON c.oid = a.attrelid
    JOIN pg_namespace n  ON n.oid = c.relnamespace
    WHERE a.attnum > 0
      AND NOT a.attisdropped
      AND n.nspname = 'public'
    ORDER BY c.relname, a.attnum
),

-- Constraints
restricciones AS (
    SELECT
        n.nspname                                          AS schema_name,
        c.relname                                          AS table_name,
        con.conname                                        AS constraint_name,
        CASE con.contype
            WHEN 'p' THEN 'PRIMARY KEY'
            WHEN 'f' THEN 'FOREIGN KEY'
            WHEN 'u' THEN 'UNIQUE'
            WHEN 'c' THEN 'CHECK'
            WHEN 'x' THEN 'EXCLUSION'
            ELSE con.contype::text
        END                                                AS constraint_type,
        obj_description(con.oid, 'pg_constraint')          AS constraint_comment
    FROM pg_constraint con
    JOIN pg_class c      ON c.oid = con.conrelid
    JOIN pg_namespace n  ON n.oid = c.relnamespace
    WHERE n.nspname = 'public'
    ORDER BY c.relname, con.conname
),

-- Triggers
disparadores AS (
    SELECT
        n.nspname                                          AS schema_name,
        c.relname                                          AS table_name,
        tg.tgname                                          AS trigger_name,
        obj_description(tg.oid, 'pg_trigger')              AS trigger_comment
    FROM pg_trigger tg
    JOIN pg_class c      ON c.oid = tg.tgrelid
    JOIN pg_namespace n  ON n.oid = c.relnamespace
    WHERE n.nspname = 'public'
      AND NOT tg.tgisinternal
    ORDER BY c.relname, tg.tgname
),

-- Funciones
funciones AS (
    SELECT
        n.nspname                                          AS schema_name,
        p.proname                                          AS function_name,
        pg_get_function_arguments(p.oid)                   AS argument_types,
        pg_get_function_result(p.oid)                      AS return_type,
        obj_description(p.oid, 'pg_proc')                  AS function_comment
    FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'public'
    ORDER BY p.proname
)

SELECT jsonb_pretty(
    jsonb_build_object(
        'database',      current_database(),
        'schema',        'public',
        'generated_at',  now(),
        'tables', (
            SELECT jsonb_agg(
                jsonb_build_object(
                    'table_name',    t.table_name,
                    'table_comment', t.table_comment,
                    'columns', (
                        SELECT jsonb_agg(
                            jsonb_build_object(
                                'column_name', c.column_name,
                                'data_type',   c.data_type,
                                'comment',     c.column_comment
                            )
                            ORDER BY c.column_name
                        )
                        FROM columnas c
                        WHERE c.schema_name = t.schema_name
                          AND c.table_name  = t.table_name
                    ),
                    'constraints', (
                        SELECT jsonb_agg(
                            jsonb_build_object(
                                'constraint_name',  r.constraint_name,
                                'constraint_type',  r.constraint_type,
                                'comment',          r.constraint_comment
                            )
                            ORDER BY r.constraint_name
                        )
                        FROM restricciones r
                        WHERE r.schema_name = t.schema_name
                          AND r.table_name  = t.table_name
                    ),
                    'triggers', (
                        SELECT jsonb_agg(
                            jsonb_build_object(
                                'trigger_name',  d.trigger_name,
                                'comment',       d.trigger_comment
                            )
                            ORDER BY d.trigger_name
                        )
                        FROM disparadores d
                        WHERE d.schema_name = t.schema_name
                          AND d.table_name  = t.table_name
                    )
                )
                ORDER BY t.table_name
            )
            FROM tablas t
        ),
        'functions', (
            SELECT jsonb_agg(
                jsonb_build_object(
                    'function_name',  f.function_name,
                    'argument_types', f.argument_types,
                    'return_type',    f.return_type,
                    'comment',        f.function_comment
                )
                ORDER BY f.function_name
            )
            FROM funciones f
        )
    )
);
