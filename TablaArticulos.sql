USE warehouse
GO
CREATE TABLE [dbo].[Articulo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](124) NOT NULL,
	[ClasedeArticulo] [varchar](124) NOT NULL,
	[Precio] [money] NOT NULL
 CONSTRAINT [PK_Articulo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[ordenAlfabetico]    Script Date: 3/8/2023 6:49:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ordenAlfabetico]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT A.Id, A.Nombre, A.ClasedeArticulo, A.Precio  FROM Articulo A ORDER BY A.Nombre 
END
GO
/****** Object:  StoredProcedure [dbo].[psInsertarArticulo]    Script Date: 3/8/2023 6:49:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[psInsertarArticulo]
	@nombreArticulo varchar(124)
	,@clasedeArticulo varchar(124)
	,@precioArticulo money
AS
BEGIN
	IF (@nombreArticulo not like '(!/^\s/)') AND (@nombreArticulo !='')
		BEGIN
			IF NOT EXISTS (select Nombre from Articulo A where A.Nombre = @nombreArticulo)
				BEGIN

					select 2 validacion;

					insert [dbo].[Articulo] (
						  [Nombre]
						, [ClasedeArticulo]
						, [Precio])
						
						VALUES (
						@nombreArticulo
						,@clasedeArticulo
						,@precioArticulo
						);
				END
			ELSE 
				BEGIN
					select 3 validacion;
				END
		END
	ELSE
		BEGIN
			select 1 validacion;
		END

END
GO
USE [master]
GO
ALTER DATABASE [warehouse] SET  READ_WRITE 
GO