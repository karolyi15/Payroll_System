-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 24/05/2021
-- Description:	Trigger Inserting Employee 
-- =============================================

CREATE TRIGGER Trigger_EmployeeMandatoryDeduction
ON Employee
AFTER INSERT 
AS

DECLARE @idEmployee AS INT

SET
	@idEmployee = (SELECT
					TOP(1) inserted.id
					FROM inserted
					ORDER BY inserted.id DESC)

INSERT INTO Deduction (idDeductionType, idEmployee, visible)
	VALUES(1, @idEmployee , 1)
