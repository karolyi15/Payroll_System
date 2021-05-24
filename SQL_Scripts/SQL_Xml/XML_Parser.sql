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
-- //	CATALOGS
-- //
--/////////////////////////////////////////////////////////

-- Insert Jobs Into Table
INSERT INTO Payroll.dbo.Job (name, paymentPerHour, visible)
SELECT
   
   Node_Job.value('@Nombre','VARCHAR(64)'),
   Node_Job.value('@SalarioXHora','FLOAT'),
   1

FROM 
	@xmlFile.nodes('Datos/Catalogos/Puestos/Puesto') as xmlFile(Node_Job);


-- Insert Departments Into Table
INSERT INTO Payroll.dbo.Department (id, name, visible)
SELECT
   
   Node_Department.value('@Id','INT'),
   Node_Department.value('@Nombre','VARCHAR(64)'),
   1

FROM 
	@xmlFile.nodes('Datos/Catalogos/Departamentos/Departamento') as xmlFile(Node_Department);


-- Insert Identification Type Into Table
INSERT INTO Payroll.dbo.IdentificationType (id, name, visible)
SELECT
   
   Node_IdentificationType.value('@Id','INT'),
   Node_IdentificationType.value('@Nombre','VARCHAR(64)'),
   1

FROM 
	@xmlFile.nodes('Datos/Catalogos/Tipos_de_Documento_de_Identificacion/TipoIdDoc') as xmlFile(Node_IdentificationType);


-- Insert Schedule Type Into Table
INSERT INTO Payroll.dbo.ScheduleType (id, name, startTime, endTime, visible)
SELECT
   
   Node_ScheduleType.value('@Id','INT'),
   Node_ScheduleType.value('@Nombre','VARCHAR(64)'),
   Node_ScheduleType.value('@HoraEntrada','TIME(7)'),
   Node_ScheduleType.value('@HoraSalida','TIME(7)'),
   1

FROM 
	@xmlFile.nodes('Datos/Catalogos/TiposDeJornada/TipoDeJornada') as xmlFile(Node_ScheduleType);


-- Insert Payroll Movement Type Into Table
INSERT INTO Payroll.dbo.PayrollMovementType (id, name, visible)
SELECT
   
   Node_ScheduleType.value('@Id','INT'),
   Node_ScheduleType.value('@Nombre','VARCHAR(64)'),
   1

FROM 
	@xmlFile.nodes('Datos/Catalogos/TiposDeMovimiento/TipoDeMovimiento') as xmlFile(Node_ScheduleType);


-- Insert Deduction Type Into Table
INSERT INTO Payroll.dbo.DeductionType (id, name, mandatory, percentage, value, visible)
SELECT
   
   Node_DeductionType.value('@Id','INT'),
   Node_DeductionType.value('@Nombre','VARCHAR(64)'),
   Node_DeductionType.value('@Obligatorio','VARCHAR(64)'),
   Node_DeductionType.value('@Porcentual','VARCHAR(64)'),
   Node_DeductionType.value('@Valor','FLOAT'),
   1

FROM 
	@xmlFile.nodes('Datos/Catalogos/Deducciones/TipoDeDeduccion') as xmlFile(Node_DeductionType);


-- /////////////////////////////////////////////////////////
-- //
-- //	NON - CATALOGS
-- //
--/////////////////////////////////////////////////////////

-- Insert System User Into Table
INSERT INTO Payroll.dbo.SystemUser (username, password, visible)
SELECT
   
   Node_SystemUser.value('@username','VARCHAR(64)'),
   Node_SystemUser.value('@pwd','VARCHAR(64)'),
   1

FROM 
	@xmlFile.nodes('Datos/Usuarios/Usuario') as xmlFile(Node_SystemUser);


