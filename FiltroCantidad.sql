CREATE PROCEDURE fArticulo
    @FArticulo NVARCHAR(255) = NULL,
    @FPrecio NVARCHAR(255) = NULL,
	@FClasedeArticulo NVARCHAR(255) = NULL,
	@FCantidad INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

	IF @FCantidad IS NOT NULL AND @FCantidad > 0
	BEGIN
		SELECT TOP (@FCantidad) a.Nombre, a.ClasedeArticulo, a.Precio
		FROM dbo.Articulo a
		WHERE (ISNULL(@FArticulo, '') = '' OR a.Nombre LIKE '%'+@FArticulo+'%')
		AND (ISNULL(@FPrecio, '') = '' OR a.Precio LIKE '%'+@FPrecio+'%')
		AND (ISNULL(@FClasedeArticulo, '') = '' OR a.ClasedeArticulo LIKE '%'+@FClasedeArticulo+'%');
	END
	ELSE
	BEGIN
		SELECT a.Nombre, a.ClasedeArticulo, a.Precio
		FROM dbo.Articulo a
		WHERE (ISNULL(@FArticulo, '') = '' OR a.Nombre LIKE '%'+@FArticulo+'%')
		AND (ISNULL(@FPrecio, '') = '' OR a.Precio LIKE '%'+@FPrecio+'%')
		AND (ISNULL(@FClasedeArticulo, '') = '' OR a.ClasedeArticulo LIKE '%'+@FClasedeArticulo+'%')
		AND (ISNULL(@FCantidad, 0) = 0 OR @FCantidad = '');
	END

    SET NOCOUNT OFF;
END
--Nombre, Precio, Clase, Cantidad
EXEC fArticulo '','' ,'', ''