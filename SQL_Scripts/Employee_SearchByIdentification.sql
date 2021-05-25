-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 24/05/2021
-- Description:	Operation Simulation 
-- =============================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION Employee_SearchByIdentification(@identification VARCHAR(64))
RETURNS INT 
AS
BEGIN 
	RETURN(
		SELECT
			Employee.id
		FROM Payroll.dbo.Employee
		WHERE Employee.identification = @identification
			)
END
GO