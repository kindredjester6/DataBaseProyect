USE [warehouse]
GO
/****** Object:  Table [dbo].[Articulo]    Script Date: 4/12/2023 11:19:06 PM ******/
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
/****** Object:  Table [dbo].[ArticuloXml]    Script Date: 4/12/2023 11:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticuloXml](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](126) NOT NULL,
	[ClasesdeArticulo] [varchar](126) NOT NULL,
	[precio] [money] NOT NULL,
 CONSTRAINT [PK_ArticuloXml] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClaseArticulo]    Script Date: 4/12/2023 11:19:06 PM ******/
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
/****** Object:  Table [dbo].[DBErrors]    Script Date: 4/12/2023 11:19:06 PM ******/
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
/****** Object:  Table [dbo].[EventLog]    Script Date: 4/12/2023 11:19:06 PM ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 4/12/2023 11:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](16) NOT NULL,
	[Clave] [varchar](16) NOT NULL,
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
/****** Object:  StoredProcedure [dbo].[psInsertarArticulo]    Script Date: 4/12/2023 11:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name> Oscar Campos 
-- Create date: <Create Date,,>
-- Description:	<Description,,> Insertar articulo
-- =============================================
CREATE PROCEDURE [dbo].[psInsertarArticulo]

	 @inNombreArticulo varchar(124)
	,@inIdClaseArticulo int
	,@inPrecioArticulo money
	,@inUserId varchar(16)					-- usuario persona que esta insertando desde UI
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
					,  @inIdClaseArticulo,', '
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
						select top(1) @LogDescription as LogDescription
							,U.id as PostIdUser
							, @inIP as PostIP
							, @hora as PostTime
							from Usuario U where U.Nombre = @inUserId

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
/****** Object:  StoredProcedure [dbo].[spCargarXML]    Script Date: 4/12/2023 11:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spCargarXML]
    -- Parametro de entrada
    @inRutaXML NVARCHAR(500)
AS

DECLARE @Datos xml/*Declaramos la variable Datos como un tipo XML*/

	-- Para cargar el archivo con una variable, CHAR(39) son comillas simples
DECLARE @Comando NVARCHAR(500)= 'SELECT @Datos = D FROM OPENROWSET (BULK '  + CHAR(39) + @inRutaXML + CHAR(39) + ', SINGLE_BLOB) AS Datos(D)' -- comando que va a ejecutar el sql dinamico
--10
DECLARE @Parametros NVARCHAR(500)
SET @Parametros = N'@Datos xml OUTPUT' --parametros del sql dinamico

EXECUTE sp_executesql @Comando, @Parametros, @Datos OUTPUT -- ejecutamos el comando que hicimos dinamicamente
    
DECLARE @hdoc int /*Creamos hdoc que va a ser un identificador*/
    
EXEC sp_xml_preparedocument @hdoc OUTPUT, @Datos/*Toma el identificador y a la variable con el documento y las asocia*/

--Insertar los usuarios del XML    20
INSERT INTO [dbo].[Usuario]
			([Nombre]/*Inserta en la tabla TipoDocIdent*/
			,[Clave])
SELECT Nombre
	  ,Clave
FROM OPENXML (@hdoc, '/root/Usuarios/Usuario' , 1)/*Lee los contenidos del XML y para eso necesita un identificador,el 
PATH del nodo y el 1 que sirve para retornar solo atributos*/
WITH(/*Dentro del WITH se pone el nombre y el tipo de los atributos a retornar*/
	Nombre VARCHAR(16)
	,[Clave] VARCHAR(16) '@Password'
	)
	--32

--Insertar las clasesdeartículos del XML
INSERT INTO [dbo].[ClaseArticulo]
			([Nombre]/*Inserta en la tabla TipoDocIdent*/)
SELECT Nombre
FROM OPENXML (@hdoc, '/root/ClasesdeArticulos/ClasesdeArticulo' , 1)/*Lee los contenidos del XML y para eso necesita un identificador,el 
PATH del nodo y el 1 que sirve para retornar solo atributos*/
WITH(/*Dentro del WITH se pone el nombre y el tipo de los atributos a retornar*/
	Nombre VARCHAR(100) '@Nombre'
	)


--Insertar los artículos del XML
INSERT INTO [dbo].[ArticuloXml]
			([Nombre]/*Inserta en la tabla TipoDocIdent*/
			,[ClasesdeArticulo] 
			,[precio])   
SELECT [Nombre]
	, [ClasesdeArticulo] /*FROM Articulo A JOIN ClaseArticulo AS CA ON CA.Nombre = A.IdClaseArticulo*/
	,[precio]
FROM OPENXML (@hdoc, '/root/Articulos/Articulo' , 1)/*Lee los contenidos del XML y para eso necesita un identificador,el 
PATH del nodo y el 1 que sirve para retornar solo atributos*/
WITH(/*Dentro del WITH se pone el nombre y el tipo de los atributos a retornar*/
	Nombre VARCHAR(126)
	, ClasesdeArticulo varchar(126)
	, precio MONEY
	);

EXEC sp_xml_removedocument @hdoc/*Remueve el documento XML de la memoria*/


INSERT INTO Articulo(Nombre, IdClaseArticulo, precio)
SELECT A.Nombre, AX.id, A.precio 
FROM ArticuloXml A
LEFT JOIN ClaseArticulo AX ON AX.Nombre = A.ClasesdeArticulo
/*
DECLARE @return_value INT

EXEC @return_value = spCargarXML
	@inRutaXML = 'C:\Users\Oscar Campos Argueda\Documents\DatosXML_ejemplo.xml'

SELECT @return_value
*/
GO
/****** Object:  StoredProcedure [dbo].[spConsultarNumCA]    Script Date: 4/12/2023 11:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spConsultarNumCA] /*CA = Clase Articulo*/
	@Nombre varchar (15) output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE contact_cursor CURSOR FOR  
	SELECT top(1) CA.id from ClaseArticulo CA
	WHERE CA.Nombre LIKE @Nombre

	declare @idClaseArticulo int;
	OPEN contact_cursor; 

	FETCH FROM contact_cursor into @idClaseArticulo; 
	CLOSE contact_cursor;
	DEALLOCATE contact_cursor;  

	/*SELECT Top(1) CA.id from ClaseArticulo CA Right JOIN Articulo A on CA.Nombre = @Nombre*/

	return @idClaseArticulo
	/*
	SELECT A.Id
	  ,A.Nombre
	  ,B.Nombre as Clase
	  , A.Precio
	  from Articulo A 
	  LEFT JOIN ClaseArticulo B
	  ON A.IdClaseArticulo 
	  = B.id
	  ORDER BY A.Nombre 
	  */
END
GO
/****** Object:  StoredProcedure [dbo].[spFArticulo]    Script Date: 4/12/2023 11:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name> Oscar Campos 
-- Create date: <Create Date,,>
-- Description:	<Description,,> Insertar articulo
-- =============================================
CREATE PROCEDURE [dbo].[spFArticulo]
    @FArticulo NVARCHAR(255) = NULL
	,@FClaseArticulo INT = NULL
	,@FCantidad INT = NULL
	,@inUserId varchar(16)
	,@inIP varchar(64)
AS
BEGIN
	BEGIN TRY	
		SET NOCOUNT ON;
		declare @hora datetime;
		set @hora = CURRENT_TIMESTAMP;
		declare @LogDescription VARCHAR(2000)='{"TipoAccion":'
		IF @FCantidad IS NOT NULL AND @FCantidad > 0
			BEGIN
				set @LogDescription =concat(@LogDescription  
				+ '"Consulta por cantidad"'
				+ ', "Description":'
				,@FCantidad,'}')
				SELECT TOP (@FCantidad) a.id
				, a.Nombre
				, b.Nombre as IdClaseArticulo
				, a.Precio
				FROM dbo.Articulo a 
				LEFT JOIN ClaseArticulo B
				ON a.IdClaseArticulo 
				= B.id
				ORDER BY A.Nombre 
			END
		ELSE
			BEGIN
				if @FClaseArticulo != 0
					begin
						set @LogDescription =concat(@LogDescription  
						+ '"Consulta por clase de articulo"'
						+ ', "Description":'
						,@FClaseArticulo,'}')
					end
				else
					begin
						set @LogDescription =concat(@LogDescription  
						+ '"Consulta por Nombre"'
						+ ', "Description":'
						,'"',@FArticulo,'"','}')
					end
				SELECT a.id, a.Nombre, b.Nombre as IdClaseArticulo, a.Precio
				FROM dbo.Articulo a LEFT JOIN ClaseArticulo B
				ON a.IdClaseArticulo 
				= B.id
				WHERE (ISNULL(@FArticulo, '') = '' OR a.Nombre LIKE '%'+@FArticulo +'%')
				AND (ISNULL(@FClaseArticulo, '') = '' OR a.IdClaseArticulo = @FClaseArticulo)
				AND (ISNULL(@FCantidad, 0) = 0 OR @FCantidad = '') ORDER BY A.Nombre 
			END

		INSERT [dbo].[EventLog] (
							[LogDescription]
							, [PostIdUser]
							, [PostIP]
							, [PostTime])
				select top(1) @LogDescription as LogDescription
			,U.id as PostIdUser
			, @inIP as PostIP
			, @hora as PostTime
			from Usuario U where U.Nombre = @inUserId
	--Nombre, Precio, Clase, Cantidad

	SET NOCOUNT OFF;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
			INSERT INTO [dbo].[DBErrors]	VALUES (
				SUSER_SNAME()
				,ERROR_NUMBER()
				,ERROR_STATE()
				,ERROR_SEVERITY()
				,ERROR_LINE()
				,ERROR_PROCEDURE()
				,ERROR_MESSAGE()
				,GETDATE()
			);

	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spLogout]    Script Date: 4/12/2023 11:19:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spLogout]
	-- Add the parameters for the stored procedure here
	@inUserId int
	, @inIP varchar(64)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure 
	declare @hora datetime;
	set @hora = CURRENT_TIMESTAMP;
	declare @LogDescription VARCHAR(2000)='{"TipoAccion":'+'"Logout"'

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

END
GO
/****** Object:  StoredProcedure [dbo].[spOrdenAlfabetico]    Script Date: 4/12/2023 11:19:06 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spValUsuario]    Script Date: 4/12/2023 11:19:06 PM ******/
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

	IF EXISTS (SELECT 1 FROM Usuario U WHERE U.Nombre = @inUsuario AND U.Clave = @inPassword)
		BEGIN
			SET @outVal = 1;
			select @outVal as validacion

			SET @LogDescription = @LogDescription+'"Login exitoso"}'
			SET @hora = CURRENT_TIMESTAMP;

			INSERT into [dbo].[EventLog] (
				LogDescription
				, PostIdUser
				, PostIP
				, PostTime)
			select top(1) @LogDescription as LogDescription
			,U.id as PostIdUser
			, @inIP as PostIP
			, @hora as PostTime
			from Usuario U where U.Nombre = @inUsuario
			/*VALUES (
				@LogDescription
				, @inUsuario
				, @inIP
				, @hora);
				*/
			RETURN
		END
	ELSE
		SET @outVal = 2;
		SET @LogDescription = @LogDescription + '"Login no exitoso"}'
		SET @hora = CURRENT_TIMESTAMP;
				INSERT [dbo].[EventLog] (
					LogDescription
					, PostIdUser
					, PostIP
					, PostTime)
				select top(1) @LogDescription as LogDescription
				,0 as PostIdUser
				, @inIP as PostIP
				, @hora as PostTime
	RETURN

	SET NOCOUNT OFF;
	END TRY

	BEGIN CATCH
	IF @@TRANCOUNT>0  -- error sucedio dentro de la transaccion
		INSERT INTO [dbo].[DBErrors]	VALUES (
			SUSER_SNAME()
			,ERROR_NUMBER()
			,ERROR_STATE()
			,ERROR_SEVERITY()
			,ERROR_LINE()
			,ERROR_PROCEDURE()
			,ERROR_MESSAGE()
			,GETDATE()
		);

	END CATCH
END
GO
