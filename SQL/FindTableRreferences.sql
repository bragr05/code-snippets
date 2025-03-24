SELECT DISTINCT
    o.name AS ObjectName,
    o.type_desc AS ObjectType,
    OBJECT_SCHEMA_NAME (o.object_id) AS SchemaName
FROM
    DataBase.sys.sql_modules m
    INNER JOIN DataBase.sys.objects o ON m.object_id = o.object_id
WHERE
    m.definition LIKE '%DataBase.Schema.Name%'
    AND o.type IN ('P', 'FN', 'IF', 'TF', 'V') -- P: Stored Procedures, FN: Functions, IF: Inline Functions, TF: Table Functions, V: Views
ORDER BY
    o.type_desc,
    o.name;