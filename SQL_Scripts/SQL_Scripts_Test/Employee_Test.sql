-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 20/05/2021
-- Description:	Employee Payroll System Test
-- =============================================

DECLARE 
	@insertState AS INT,
	@updateState AS INT,
	@deleteState AS INT,
	@listState AS INT,
	@filterState AS INT


-- Insert Employee
EXEC @insertState = Payroll.dbo.Employee_InsertEmployee
	@name = 'Gunther Karolyi',
	@birthdate = '12-15-1997',
	@identification = '116940776',
	@idJob = 1,
	@idDepartment = 1,
	@idIdentificationType = 1


-- Update Employee
EXEC @updateState = Payroll.dbo.Employee_UpdateEmployee
	@name = 'Gunther Karolyi',
	@birthdate = '15-12-1997',
	@identification = '116940776',
	@idJob = 1,
	@idDepartment = 4,
	@idIdentificationType = 1


-- DeleteEmployee
EXEC @deleteState = Payroll.dbo.Employee_DeleteEmployee
	@name = 'Jessica Gutierrez'


-- List Employee
DECLARE 
	@employeeList AS TABLE(id INT, name VARCHAR(64), birthdate DATE, identification VARCHAR(64), 
	idJob INT, idDepartment INT, idIdentificationType INT)

INSERT INTO @employeeList (id, name, birthdate, identification, idJob, idDepartment, idIdentificationType)
	EXEC @listState = Payroll.dbo.Employee_ListEmployee

SELECT *
FROM @employeeList


-- Filter EmployeE
DECLARE 
	@employeeFilter AS TABLE(id INT, name VARCHAR(64), birthdate DATE, identification VARCHAR(64), 
	idJob INT, idDepartment INT, idIdentificationType INT)

INSERT INTO @employeeFilter
	EXEC Payroll.dbo.Employee_FilterEmployee
		@wildcard = 'Gu'

SELECT *
FROM @employeeFilter


-- Check Employee Table
SELECT 
	Employee.name,
	Employee.birthdate,
	Employee.identification,
	Employee.idJob,
	Employee.idDepartment,
	Employee.idIdentificationType

FROM Payroll.dbo.Employee