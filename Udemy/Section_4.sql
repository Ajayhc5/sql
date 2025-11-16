--use [70-461]
--go 
--create table tblemployee
--(EmployeeNumber int, EmplayeeName nvarchar)
DECLARE @myvr as int = 2147483647 
set @myvr = @myvr + 8
select @myvr as myvariable --Arithmetic overflow error converting expression to data type int, value = 2147483647.

DECLARE @myvar as int = 2

select @myvar as myvariable

set @myvar = @myvar * 4+1

select @myvar as myvariable




--DECLARE @myvar2 as tinyint = 256
--set @myvar2 =  @myvar2 + 3.5
--select @myvar2 as myvariable --Arithmetic overflow error for data type tinyint, value = 256.

DECLARE @myvar2 as tinyint = 250
set @myvar2 =  @myvar2 + 3.5
select @myvar2 as myvariable


--DECLARE @myvar3 as smallint = 32768
--set @myvar3 =  @myvar3 + 3.5
--select @myvar3 as myvariable --Arithmetic overflow error for data type smallint, value = 32768.

DECLARE @myvar3 as smallint = 32760
set @myvar3 =  @myvar3 + 3.5
select @myvar3 as myvariable


DECLARE @myc1 as int = 2147483647, @Myc2 as tinyint = 250, @myc3 as smallint = 32760
set @myc1 =  @myc1 -1 
set @Myc2 = @Myc2-1
set @Myc3 = @Myc3-1
select @myc1 as intgr, @Myc2 as tnyint, @Myc3 as smlint


--Non-integer numbers
DECLARE @myer as numeric(18,2) -- or decimal(7,2)
set @myer = 1234567891011121.31
select @myer


DECLARE @myar AS smallmoney = 214748.3647
set @myar = @myar- 0.1
select @myar as myVariable 


DECLARE @mycr AS money=922337203685477.5807
set @mycr = @mycr- 0.1
select @mycr as myVariable 


DECLARE @myvar1 as float = 2
set @myvar1 =  @myvar1 + 3.5
select @myvar1 as myvariable

--Mathematical functions
--Initialise a variable, give it a data type and an initial value

DECLARE @mymtf as numeric(7,2) = 3

SELECT POWER(@mymtf,3) -- 27
SELECT SQUARE(@mymtf) -- 9
SELECT POWER(@mymtf,0.5) -- square root of 3
SELECT SQRT(@mymtf) -- square root of 3

GO

DECLARE @mymtfc as numeric(7,2) = 16.345

SELECT FLOOR(@mymtfc) -- this equals 12
SELECT CEILING(@mymtfc) -- this equals 13
SELECT ROUND(@mymtfc,-1) as myRound -- this equals 10

GO

SELECT PI() as myPI
SELECT EXP(1) as e

DECLARE @myvar AS NUMERIC(7,2) = -456

SELECT ABS(@myvar) as myABS, SIGN(@myvar) as mySign -- This equals 456 and -1.

GO

SELECT RAND(345) -- A random number, based on the initial seed

