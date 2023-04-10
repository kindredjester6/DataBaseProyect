USE [warehouse]
GO
/****** Object:  Table [dbo].[Articulo]    Script Date: 4/10/2023 11:38:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articulo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[IdClaseArticulo] [int] NULL,
	[Nombre] [varchar](128) NOT NULL,
	[Precio] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClaseArticulo]    Script Date: 4/10/2023 11:38:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClaseArticulo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DBErrors]    Script Date: 4/10/2023 11:38:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBErrors](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](100) NULL,
	[ErrorNumber] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorLine] [int] NULL,
	[ErrorProcedure] [varchar](max) NULL,
	[ErrorMessage] [varchar](max) NULL,
	[ErrorDateTime] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventLog]    Script Date: 4/10/2023 11:38:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LogDescription] [varchar](2000) NOT NULL,
	[PostIdUser] [int] NOT NULL,
	[PostIP] [varchar](64) NOT NULL,
	[PostTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 4/10/2023 11:38:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](16) NOT NULL,
	[Password] [varchar](16) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articulo]  WITH CHECK ADD  CONSTRAINT [FK_Articulo_ClaseArticulo] FOREIGN KEY([IdClaseArticulo])
REFERENCES [dbo].[ClaseArticulo] ([id])
GO
ALTER TABLE [dbo].[Articulo] CHECK CONSTRAINT [FK_Articulo_ClaseArticulo]
GO
/****** Object:  StoredProcedure [dbo].[psInsertarArticulo]    Script Date: 4/10/2023 11:38:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name> Oscar Campos 
-- Create date: <Create Date,,> 4:00 am
-- Description:	<Description,,> Insertar articulo
-- =============================================
CREATE PROCEDURE [dbo].[psInsertarArticulo]

	 @inNombreArticulo varchar(124)
	,@inIdClaseArticulo int
	,@inPrecioArticulo money
	,@inUserId INT					-- usuario persona que esta insertando desde UI
	,@inIP VARCHAR(64)				-- ip desde donde corre el UI que inserta
	,@outVal int output

AS
BEGIN

	BEGIN TRY
	declare @hora datetime;
	set @hora = CURRENT_TIMESTAMP;
	  DECLARE @LogDescription VARCHAR(2000)='{"TipoAccion":' --<Un Tipo de accion> Description=<Valor del Descripcion>}

	IF (@inNombreArticulo not like '(!/^\s/)') AND (@inNombreArticulo !='')
		BEGIN
			IF NOT EXISTS (select Nombre from Articulo A where A.Nombre = @inNombreArticulo)
				BEGIN

					SET @LogDescription = 
					CONCAT (@LogDescription
					,' "Insertar articulo exitoso"', ', '
					, ' "Description": ','['
					, '"', @inIdClaseArticulo, '"',', '
					, '"', @inNombreArticulo, '"',']', '}');
					
					BEGIN TRANSACTION tInsertArticulo 

						INSERT [dbo].[Articulo] (
									  [Nombre]
									, [IdClaseArticulo]
									, [Precio])
									VALUES (
									@inNombreArticulo
									,@inIdClaseArticulo
									,@inPrecioArticulo
									);

						INSERT [dbo].[EventLog] (
							[LogDescription]
							, [PostIdUser]
							, [PostIP]
							, [PostTime])
						VALUES (
							@LogDescription
							, @inUserId
							, @inIP
							, @hora);

					-- salvamos en evento log el evento de actualizar el articulo
					COMMIT TRANSACTION tUpdateArticulo
					
					SET @outVal = 2;

					RETURN 2;
				END
			ELSE 
				BEGIN
					set @outVal = 3;
					SET @LogDescription = @LogDescription
					+'Insertar articulo no exitosa';
					RETURN 3;
				END
		END
	ELSE
		BEGIN
			set @outVal = 1;
			RETURN 1;
		END

	END TRY

	BEGIN CATCH
	IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION tUpdateArticulo; -- se deshacen los cambios realizados
		END;
		INSERT INTO [dbo].[DBErrors]	VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
		);

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spOrdenAlfabetico]    Script Date: 4/10/2023 11:38:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spOrdenAlfabetico]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT A.Id
	  ,A.Nombre
	  ,B.Nombre as Clase
	  , A.Precio
	  from Articulo A 
	  LEFT JOIN ClaseArticulo B
	  ON A.IdClaseArticulo 
	  = B.id
	  ORDER BY A.Nombre 
END
GO
/****** Object:  StoredProcedure [dbo].[spValUsuario]    Script Date: 4/10/2023 11:38:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spValUsuario] 
	-- Add the parameters for the stored procedure here
	@inUsuario varchar(16)
	,@inPassword varchar(16)
	,@inIP varchar(64)
	,@outVal int output

AS
BEGIN
	BEGIN TRY
	SET NOCOUNT ON;
	declare @hora datetime;
	DECLARE @LogDescription VARCHAR(2000)='{"TipoAccion":' --<Un Tipo de accion> Description=<Valor del Descripcion>}

	IF EXISTS (select UserName from Usuario U where LOWER(U.UserName) = LOWER(@inUsuario))
		BEGIN
			SET @outVal = 1;

			SET @LogDescription = @LogDescription+'Login exitoso'
			SET @hora = CURRENT_TIMESTAMP;
			INSERT [dbo].[EventLog] (
				[LogDescription]
				, [PostIdUser]
				, [PostIP]
				, [PostTime])
			VALUES (
				@LogDescription
				, @inUsuario
				, @inIP
				, @hora);

			RETURN
		END
	ELSE
	SET @outVal = 2;
	SET @LogDescription = @LogDescription + 'Login no exitoso'
	SET @hora = CURRENT_TIMESTAMP;
			INSERT [dbo].[EventLog] (
				[LogDescription]
				, [PostIdUser]
				, [PostIP]
				, [PostTime])
			VALUES (
				@LogDescription
				, @inUsuario
				, @inIP
				, @hora);
	RETURN

	SET NOCOUNT OFF;
	END TRY

	BEGIN CATCH
	IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		BEGIN
			ROLLBACK TRANSACTION tUpdateArticulo; -- se deshacen los cambios realizados
		END;
		INSERT INTO [dbo].[DBErrors]	VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
		);

	END CATCH
END
GO
