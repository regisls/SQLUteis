SELECT 
    dbid,
	DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
	--dbid = 25
GROUP BY 
    dbid, loginame
