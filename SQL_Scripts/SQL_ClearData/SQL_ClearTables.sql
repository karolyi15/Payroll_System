-- disable all constraints
EXEC sp_MSForEachTable "ALTER TABLE ? NOCHECK CONSTRAINT all"

-- delete data in all tables
EXEC sp_MSForEachTable "DELETE FROM ?"

-- enable all constraints
exec sp_MSForEachTable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"
-- if some of the tables have identity columns we may want to reseed them
EXEC sp_MSForEachTable "DBCC CHECKIDENT ( '?', RESEED, 0)"