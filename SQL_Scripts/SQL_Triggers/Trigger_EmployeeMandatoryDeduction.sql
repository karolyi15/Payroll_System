-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 24/05/2021
-- Description:	Trigger Inserting Employee 
-- =============================================

CREATE OR ALTER TRIGGER Trigger_EmployeeMandatoryDeduction
ON Employee
AFTER INSERT 
AS		

INSERT INTO Deduction (idDeductionType, idEmployee, value, visible)
SELECT
	1,
	inserted.id,
	0.095,
	1
FROM inserted
	
