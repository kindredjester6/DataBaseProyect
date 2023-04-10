CREATE TABLE [dbo].[Usuarios](
    [Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](124) NOT NULL,
    [Pasw] [varchar](124) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE PROCEDURE ConfirmarUsuario
    @NombreUsuario NVARCHAR(255) = NULL,
    @FPasw NVARCHAR(255) = NULL
AS
BEGIN
	SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM Usuarios
        WHERE Nombre = @NombreUsuario AND Pasw = @FPasw
    )
    BEGIN
        PRINT 'Correcto'
    END
    ELSE
    BEGIN
        PRINT 'Incorrecto'
    END
	SET NOCOUNT OFF;
END

EXEC ConfirmarUsuario Adam, '9Ydsy'