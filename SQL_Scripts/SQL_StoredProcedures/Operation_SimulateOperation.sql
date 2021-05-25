-- =============================================
-- Author:      Gunther Karolyi
-- Create date: 24/05/2021
-- Description: Operation Simulation 
-- =============================================

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE Operation_SimulateOperation(
    -- Parameters
    @operation XML
)
AS
BEGIN
    -- Settings
    SET NOCOUNT ON;

    --Procedure Statements
    BEGIN TRY
        
        --Insert New Employee
        INSERT INTO Payroll.dbo.Employee(name, birthdate, identification, idJob, idDepartment, idIdentificationType, visible)
        SELECT 
            xmlFile.Node_Employee.value('@Nombre','VARCHAR(64)'),
            xmlFile.Node_Employee.value('@FechaNacimiento','DATE'),
            xmlFile.Node_Employee.value('@ValorDocumentoIdentidad','VARCHAR(64)'),
            xmlFile.Node_Employee.value('@idPuesto','INT'),
            xmlFile.Node_Employee.value('@idDepartamento','INT'),
            xmlFile.Node_Employee.value('@idTipoDocumentacionIdentidad','INT'),
            1

        FROM @operation.nodes('Operacion/NuevoEmpleado') AS xmlFile(Node_Employee);


        --Delete Employee
        UPDATE Payroll.dbo.Employee
        SET Employee.visible = 0
        FROM @operation.nodes('Operacion/EliminarEmpleado') AS xmlFile(Node_Employee)
        WHERE Employee.identification = xmlFile.Node_Employee.value('@ValorDocumentoIdentidad','VARCHAR(64)');


        --Insert Deduction
        INSERT INTO Payroll.dbo.Deduction(idDeductionType, idEmployee, value, visible)
        SELECT 
            xmlFile.Node_Deduction.value('@IdDeduccion','INT'),
            Payroll.dbo.Employee_SearchByIdentification(xmlFile.Node_Deduction.value('@ValorDocumentoIdentidad','VARCHAR(64)')),
            xmlFile.Node_Deduction.value('@Monto','FLOAT'),
            1

        FROM @operation.nodes('Operacion/AsociaEmpleadoConDeduccion') AS xmlFile(Node_Deduction);
        


        -- Delete Deduction
        UPDATE Payroll.dbo.Deduction
        SET Deduction.visible = 0
        FROM @operation.nodes('Operacion/DesasociaEmpleadoConDeduccion') AS xmlFile(Node_Deduction)
        WHERE Deduction.idDeductionType = xmlFile.Node_Deduction.value('@IdDeduccion','INT') AND
            Deduction.idEmployee = Payroll.dbo.Employee_SearchByIdentification(xmlFile.Node_Deduction.value('@ValorDocumentoIdentidad','VARCHAR(64)'));


        --Insert Assistance Mark


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