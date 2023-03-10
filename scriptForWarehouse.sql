USE [master]
GO
/****** Object:  Database [warehouse]    Script Date: 3/8/2023 6:49:44 AM ******/
CREATE DATABASE [warehouse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'warehouse', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\warehouse.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'warehouse_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\warehouse_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [warehouse] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [warehouse].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [warehouse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [warehouse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [warehouse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [warehouse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [warehouse] SET ARITHABORT OFF 
GO
ALTER DATABASE [warehouse] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [warehouse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [warehouse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [warehouse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [warehouse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [warehouse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [warehouse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [warehouse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [warehouse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [warehouse] SET  ENABLE_BROKER 
GO
ALTER DATABASE [warehouse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [warehouse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [warehouse] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [warehouse] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [warehouse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [warehouse] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [warehouse] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [warehouse] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [warehouse] SET  MULTI_USER 
GO
ALTER DATABASE [warehouse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [warehouse] SET DB_CHAINING OFF 
GO
ALTER DATABASE [warehouse] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [warehouse] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [warehouse] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [warehouse] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [warehouse] SET QUERY_STORE = OFF
GO
USE [warehouse]
GO
/****** Object:  Table [dbo].[Articulo]    Script Date: 3/8/2023 6:49:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articulo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](124) NOT NULL,
	[Precio] [money] NOT NULL,
 CONSTRAINT [PK_Articulo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Articulo] ON 

INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (1, N'a', 5.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (2, N'avio', 5.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (3, N'Oscar', 566.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (4, N'9', 111.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (5, N'oscarrrrr', 6000.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (6, N'Oscarr', 500.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (7, N'Perfume', 1500.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (8, N'Ventilador', 750.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (9, N'Celular', 2500.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (10, N'microondas', 1750.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (35, N'ca', 500.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (36, N'motosierra', 500.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (37, N' ', 500.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (38, N'a', 1000.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (39, N'E', 1000.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (40, N'avio', 5000.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (41, N'ho', 77.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (42, N'9', 9.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (43, N'7', 7.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (44, N'3', 3.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (45, N'Oscarrr', 500.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (46, N'oscarrrrrrrrrrrrrrrrr', 5000.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (47, N'vovov', 5050505.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (48, N'eccccc', 600.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (49, N'algooo', 5000.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (50, N'oso', 500.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (51, N'Oscarrrrrrrrrrrrrrrrrr', 4.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (52, N'OscarAndresCamposArguedas', 4.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (53, N'91', 44.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (54, N'ososososososooosos', 11.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (55, N'oscarrrrrrr', 5.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (56, N'roorkfork', 5.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (57, N'eeerrrr', 333.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (58, N'aloosososo', 11.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (59, N'aaaaaa', 2.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (60, N'aaaaaaaa', 4.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (61, N'avior', 1.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (62, N'aviore', 22.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (63, N'aviorex', 2.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (64, N'aviorititi', 33.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (65, N'osos', 4.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (66, N'avioss', 0.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (67, N'Osca', 2.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (68, N'1111111', 22.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (69, N'es', 100.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (70, N'ess', 12.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (71, N'esa', 21.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (72, N'eds', 30.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (73, N'esad', 20.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (74, N'esasf', 1.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (75, N'exisos', 22.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (76, N'wefd', 1.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (77, N'wasdf', 1.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (78, N'decdv', 3.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (79, N'asxz', 12.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (80, N'mkmk', 9.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (81, N'asfde', 12.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (82, N'yh', 7.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (83, N'jujuj', 3.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (84, N'op', 90.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (85, N'poo', 99.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (86, N'popo', 8.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (87, N'vdvv', 3.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (88, N'cscsc', 3.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (89, N'wreerg', 234.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (90, N'eefrrg', 34.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (91, N'5tt', 5.0000)
INSERT [dbo].[Articulo] ([Id], [Nombre], [Precio]) VALUES (92, N'erttt', 432.0000)
SET IDENTITY_INSERT [dbo].[Articulo] OFF
GO
/****** Object:  StoredProcedure [dbo].[ordenAlfabetico]    Script Date: 3/8/2023 6:49:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ordenAlfabetico]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT A.Id, A.Nombre, A.Precio  FROM Articulo A ORDER BY A.Nombre 
END
GO
/****** Object:  StoredProcedure [dbo].[psInsertarArticulo]    Script Date: 3/8/2023 6:49:44 AM ******/
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

	@nombreArticulo varchar(124)
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
						, [Precio])
						VALUES (
						@nombreArticulo
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
