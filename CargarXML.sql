USE warehouse
GO
CREATE PROCEDURE [dbo].[CargarXML]
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
INSERT INTO [dbo].[Usuarios]
           ([Nombre]/*Inserta en la tabla TipoDocIdent*/
		   ,[Pasw])
SELECT Nombre, Pasw
FROM OPENXML (@hdoc, '/root/Usuarios/Usuario' , 1)/*Lee los contenidos del XML y para eso necesita un identificador,el 
PATH del nodo y el 1 que sirve para retornar solo atributos*/
WITH(/*Dentro del WITH se pone el nombre y el tipo de los atributos a retornar*/
	Id INT '@Id', 
    Nombre VARCHAR(100) '@Nombre',
	Pasw VARCHAR(100) '@Password'
    )
	--32
--Insertar las clasesdeartículos del XML
INSERT INTO [dbo].[ClasesdeArticulos]
           ([Nombre]/*Inserta en la tabla TipoDocIdent*/)
SELECT Nombre
FROM OPENXML (@hdoc, '/root/ClasesdeArticulos/ClasesdeArticulo' , 1)/*Lee los contenidos del XML y para eso necesita un identificador,el 
PATH del nodo y el 1 que sirve para retornar solo atributos*/
WITH(/*Dentro del WITH se pone el nombre y el tipo de los atributos a retornar*/
	Id INT '@Id', 
    Nombre VARCHAR(100) '@Nombre'
    )

--Insertar los artículos del XML
INSERT INTO [dbo].[Articulo]
           ([Nombre]/*Inserta en la tabla TipoDocIdent*/
		   ,[ClasedeArticulo]
		   ,[Precio])   
SELECT Nombre, ClasedeArticulo, Precio
FROM OPENXML (@hdoc, '/root/Articulos/Articulo' , 1)/*Lee los contenidos del XML y para eso necesita un identificador,el 
PATH del nodo y el 1 que sirve para retornar solo atributos*/
WITH(/*Dentro del WITH se pone el nombre y el tipo de los atributos a retornar*/
	Id INT '@Id', 
    Nombre VARCHAR(100) '@Nombre',
	ClasedeArticulo VARCHAR(100) '@ClasesdeArticulo',
	Precio MONEY '@precio'
    )
 
EXEC sp_xml_removedocument @hdoc/*Remueve el documento XML de la memoria*/

DECLARE @return_value INT

EXEC @return_value = CargarXML
    @inRutaXML = 'C:\Users\mcalero\Documents\SQL Server Management Studio\DatosXML.xml'

SELECT @return_value