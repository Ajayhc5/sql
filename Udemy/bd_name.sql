select @@version
SELECT @@SERVERNAME

--DESKTOP-MUUV9KR\MSSQLSERVER2022.70-461 (DESKTOP-MUUV9KR\User(53))

SELECT 
    SERVERPROPERTY('ProductVersion') AS ProductVersion,
    SERVERPROPERTY('ProductLevel') AS ProductLevel,
    SERVERPROPERTY('Edition') AS Edition,
    SERVERPROPERTY('EngineEdition') AS EngineEdition,
    SERVERPROPERTY('MachineName') AS MachineName,
    SERVERPROPERTY('IsClustered') AS IsClustered,
    SERVERPROPERTY('Collation') AS Collation
;


SELECT 
    session_id,
    login_name,
    program_name,
    host_name,
    client_interface_name
FROM sys.dm_exec_sessions
WHERE session_id = @@SPID;