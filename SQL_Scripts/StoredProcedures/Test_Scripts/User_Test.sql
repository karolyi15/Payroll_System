-- =============================================
-- Author:		Gunther Karolyi
-- Create date: 21/05/2021
-- Description:	Delete User Payroll System Test
-- =============================================

DECLARE @insertState AS INT
DECLARE @deleteState AS INT

-- Inserting New User
EXEC @insertState = Payroll.dbo.User_InsertUser

    @username = 'karolyi97',
    @password = 'admin'
    

-- Check User Table Data
SELECT
    SystemUser.username AS Username,
    SystemUser.password AS Password,
    SystemUser.visible AS Active

FROM Payroll.dbo.SystemUser;

-- Delete User From Table
EXEC @deleteState = Payroll.dbo.User_DeleteUser
    @username = "karolyi15"


-- Check User Table Data
SELECT
    SystemUser.username AS Username,
    SystemUser.password AS Password,
    SystemUser.visible AS Active

FROM Payroll.dbo.SystemUser;