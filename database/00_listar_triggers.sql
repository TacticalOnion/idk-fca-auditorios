---------------------------------------------------------
/*
nombre: vw_triggers_documentacion
descripcion:
    Vista que muestra los triggers existentes en la base de datos
    junto con su documentación y la definición de la función asociada.
*/
---------------------------------------------------------
CREATE OR REPLACE VIEW public.vw_triggers_documentacion AS
SELECT
  t.tgname AS trigger_name,
  c.relname AS table_name,
  p.proname AS function_name,
  d.description AS trigger_description,
  pg_get_functiondef(p.oid) AS function_definition
FROM pg_trigger t
JOIN pg_class c ON t.tgrelid = c.oid
JOIN pg_proc p ON t.tgfoid = p.oid
LEFT JOIN pg_description d ON t.oid = d.objoid
WHERE NOT t.tgisinternal
ORDER BY table_name, trigger_name;

-- visualizar la vista
SELECT * FROM public.vw_triggers_documentacion;