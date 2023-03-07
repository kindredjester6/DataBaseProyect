USE [master]
GO
/****** Object:  Database [warehouse]    Script Date: 3/6/2023 11:34:06 PM ******/
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
/****** Object:  Table [dbo].[Articulo]    Script Date: 3/6/2023 11:34:06 PM ******/
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
/****** Object:  StoredProcedure [dbo].[psInsertarArticulo]    Script Date: 3/6/2023 11:34:06 PM ******/
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
					insert [dbo].[Articulo] (
						  [Nombre]
						, [Precio])
						VALUES (
						@nombreArticulo
						,@precioArticulo
						);
					RETURN 2;
				END
			ELSE 
				BEGIN
					RETURN 3;
				END
		END
	ELSE
		BEGIN
			RETURN 1
		END

END
GO
USE [master]
GO
ALTER DATABASE [warehouse] SET  READ_WRITE 
GO
