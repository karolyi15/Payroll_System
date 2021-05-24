-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 20/05/2021
-- Description:	Department Payroll System Test
-- =============================================

DECLARE 
	@insertState AS INT,
	@deleteState AS INT


-- Insert Department
EXEC @insertState = Payroll.dbo.Department_InsertDepartment
	@id = 1,
	@name = 'Prostitucion'


-- Delete Department
EXEC @deleteState = Payroll.dbo.Department_DeleteDepartment
	@id = 1


-- Check Department Table
SELECT 
	@insertState AS InsertCode,
	@deleteState AS DeleteCode,
	Department.id AS Id,
	Department.name AS Name
	Department.visible  AS Active

FROM Payroll.dbo.Department;
