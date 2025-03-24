/*
1. Obtener el hash del archivo de la publicación es decir `bd.publish` que se encuentra en carpeta debug posterior a compilar el SqlServerProject
2. Convertir dicho hash en un `varbinary(64)` empleando el algoritmo hash `SHA2_512`
3. Posterior ejecutar el procedimiento `sys.sp_add_trusted_assembly` junto al hash generado anteriormente y una descripción para identificar el DLL de confianza
4. Esto agrega el DLL en confianza para todo el servidor por lo que no se configura individualmente por base de datos
*/

declare @assembly varbinary(max) = 0x
declare @hash varbinary(64) = HASHBYTES('SHA2_512', @assembly);
exec sys.sp_add_trusted_assembly @hash, N'Assembly Name';

-- Saber cuáles DLL se han marcado como confiables se han creado
select * from sys.trusted_assemblies

-- Eliminar un DLL de confianza empleando su hash `varbinary(64)`
DECLARE @hash varbinary(64);
SET @hash = 0x;
exec sp_drop_trusted_assembly @hash
