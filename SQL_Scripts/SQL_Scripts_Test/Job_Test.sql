-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 22/05/2021
-- Description:	Test Jobs Payroll System
-- =============================================

DECLARE 
	@inName AS VARCHAR(64),
	@inPaymentPerHour FLOAT,

	@insertState AS INT,
	@updateState AS INT, 
	@deleteState AS INT, 
	@ListState AS INT 

SELECT
	@inName = 'Secretaria',
	@inPaymentPerHour = 100000.00

-- Insert Job
EXEC @insertState = Payroll.dbo.Job_InsertJob
	@name = @inName,
	@paymentPerHour = @inPaymentPerHour


-- Update Job
EXEC @updateState = Payroll.dbo.Job_UpdateJob
	@name = @inName,
	@paymentPerHour = 200000.00


-- Delete Job
EXEC @deleteState = Payroll.dbo.Job_DeleteJob
	@name = @inName


-- List Job
DECLARE 
	@jobList AS TABLE(id INT, name VARCHAR(64), paymentPerHour FLOAT)

INSERT INTO @jobList(id, name, paymentPerHour)
	EXEC Payroll.dbo.Job_ListJob

SELECT *
FROM @jobList;


--Check Table Data
SELECT
	Job.name AS Name,
	Job.paymentPerHour AS 'Payment-Hour',
	Job.visible AS Active
	
FROM Payroll.dbo.Job;
