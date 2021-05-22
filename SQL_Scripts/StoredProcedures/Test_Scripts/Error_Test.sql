-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 20/05/2021
-- Description:	Insert Error Payroll System Test
-- =============================================

-- Inserting New Error
DECLARE @insertState AS INT

EXEC @insertState = Payroll.dbo.Error_InsertError

	@error_number = "011",
	@error_severity = '0',
	@error_state = 'Test',
	@error_message = 'This is a Error Test',
	@error_line = '0'

-- Check Error Table
SELECT 
Error.number AS Number,
Error.severity AS Severity,
Error.state AS State,
Error.message AS Message,
Error.line AS Line

FROM Payroll.dbo.Error;

