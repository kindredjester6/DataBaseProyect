CREATE TABLE [dbo].[ClasesdeArticulos](
    [Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](124) NOT NULL
 CONSTRAINT [PK_ClasesdeArticulos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT [UQ_Nombre_ClasesdeArticulos] UNIQUE ([Nombre]) -- Restricción UNIQUE en la columna "Nombre"
) ON [PRIMARY]
GO