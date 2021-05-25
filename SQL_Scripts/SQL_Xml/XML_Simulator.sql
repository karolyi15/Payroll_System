-- /////////////////////////////////////////////////////////
-- //
-- //	XML FILE PROCESSING
-- //
--/////////////////////////////////////////////////////////

-- Load XML File Into a Single Row Table
DECLARE @xmlFile AS XML

SELECT 
	@xmlFile = BulkColumn 
FROM OPENROWSET(BULK 'C:\Users\karol\IdeaProjects\PayrollSystem\SQL_Scripts\SQL_Xml\Datos_Tarea2.xml', SINGLE_BLOB) AS xmlFile 


-- /////////////////////////////////////////////////////////
-- //
-- //	SIMULATING OPERATIONS
-- //
--/////////////////////////////////////////////////////////

DECLARE 
	@totalOperations AS INT,
	@currentOperation AS INT,
	@xmlOperation AS XML;

-- Creates Temporary Operations Table
SELECT 
	ROW_NUMBER() OVER(ORDER BY xmlFile.Node_Operation.value('@Fecha','DATE') ASC) AS id,
	xmlFile.Node_Operation.query('.') AS operation INTO #Operations
	
FROM @xmlFile.nodes('Datos/Operaciones/Operacion') AS xmlFile(Node_Operation);


SELECT
	@currentOperation = 1,
	@totalOperations =  COUNT(#Operations.id)

FROM #Operations;

-- Simulate Operations By Date
WHILE @currentOperation <= 3
BEGIN
	
	SELECT
	@xmlOperation =(

		SELECT 
			#Operations.operation
		FROM #Operations
		WHERE #Operations.id = @currentOperation
	)


	EXEC Payroll.dbo.Operation_SimulateOperation
		@operation = @xmlOperation


	SET @currentOperation = @currentOperation+1

END

-- Deletes Temporary Operations Table
DROP TABLE #Operations
	












