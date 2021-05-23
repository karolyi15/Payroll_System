-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 22/05/2021
-- Description:	Identification type  Test
-- =============================================

DECLARE 
	@insertState AS INT,
	@deleteState AS INT


-- Insert Identification Type
EXEC @insertState = Payroll.dbo.IdentificationType_InsertType
	@id = 1,
	@name= 'cedula'


-- Delete Identification Type
EXEC @deleteState = Payroll.dbo.IdentificationType_DeleteType
	@id = 1
	

-- Check Identification Type Table
SELECT
	@insertState AS InsertCode,
	@deleteState AS DeleteCode,
	IdentificationType.id AS Id,
	IdentificationType.name AS Name,
	IdentificationType.visible AS Active

FROM Payroll.dbo.IdentificationType;