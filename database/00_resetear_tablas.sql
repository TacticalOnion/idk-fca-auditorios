---------------------------------------------------------
/*
    script: resetear tablas
    descripcion:
        - Vacía todas las tablas del esquema 'public' sin eliminarlas
        - Reinicia los IDs autoincrementales y elimina datos dependientes
*/
---------------------------------------------------------
-- script
---------------------------------------------------------
DO
$$
BEGIN
    EXECUTE (
        SELECT string_agg(
            'TRUNCATE TABLE ' || quote_ident(tablename) || ' RESTART IDENTITY CASCADE;',
            ' '
        )
        FROM pg_tables
        WHERE schemaname = 'public'
    );
END;
$$;