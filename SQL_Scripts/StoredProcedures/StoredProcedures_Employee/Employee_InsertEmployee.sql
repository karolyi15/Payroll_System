-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 22/05/2021
-- Description:	Insert Employee Payroll System
-- =============================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE Employee_InsertEmployee(
    -- Parameters
    @name VARCHAR(64),
    @birthdate DATE,
    @identification VARCHAR(64), 
    @idJob INT,
    @idDepartment INT,
    @idIdentificationType INT

)
AS
BEGIN
    -- Settings
    SET NOCOUNT ON;

    --Procedure Statements
    BEGIN TRY
        -- Inserts New User Into Table
        INSERT INTO Payroll.dbo.Employee (name, birthdate, identification, idJob, idDepartment, idIdentificationType, visible)
        VALUES (@name, @birthdate, @identification, @idJob, @idDepartment, @idIdentificationType, 1)

    END TRY

    BEGIN CATCH
        -- Get Error Information
        DECLARE
            @number AS VARCHAR(64),
            @severity AS VARCHAR(64),
            @state AS VARCHAR(64),
            @message AS VARCHAR(64),
            @line AS VARCHAR(64)

        SELECT
                @number = CAST(ERROR_NUMBER() AS VARCHAR),
                @severity = CAST(ERROR_SEVERITY() AS VARCHAR),
                @state = CAST(ERROR_STATE() AS VARCHAR),
                @message = CAST(ERROR_MESSAGE() AS VARCHAR),
                @line = CAST(ERROR_LINE() AS VARCHAR)

        -- Reports Error
        EXEC Payroll.dbo.Error_InsertError

             @error_number = @number,
             @error_severity = @severity,
             @error_state = @state,
             @error_message = @message,
             @error_line = @line

    END CATCH

    SET NOCOUNT OFF;

    RETURN
END
GO