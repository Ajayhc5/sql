--CREATE DATABASE [70-461];

select 1+1 as addResult
go
select 1*1 as multResult
go
--select 1/0 as multResult
select 1/1 as multResult
go


--1. What is 4 plus 9? Please call the column MyAnswer.
--2. What is 15 minus 26? Please call the column Balance.
--3. What is 24 times 4 plus 3? Please call the column MyResponse.
--4. What is 48 divided by 4? Please call the column Result.
select 4+9 as MyAnswer
go
select 15-26 as Balance
go
select (24*4)+3 as MyResponse
go
select 48/4 as Result
go
SELECT POWER(24, 2) AS Result;
go

DECLARE @myvar as int = 2
-- Increase that value by 1
SET @myvar = @myvar + 1
-- Retrieve that value
SELECT @myvar AS myVariable
