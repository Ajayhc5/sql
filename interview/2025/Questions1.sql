-- ACL DIGITAL
CREATE TABLE AmountsText (
    Amount VARCHAR(20)
);

INSERT INTO AmountsText (Amount) VALUES
('10$'),
('100$'),
('1000$');


select sum(amt) as total_amount from 
(select cast(replace(cast(amount as varchar),'$', '' ) as int) as amt from AmountsText) er

select sum(amt) as total_amount from 
(select cast(replace(amount,'$', '' ) as int) as amt from AmountsText) er

select sum(cast(left(Amount, len(amount)-1) as int)) as amt from AmountsText;
select substring(amount, 1, len(amount)-1) as amt from AmountsText;

CREATE TABLE Countries (
    CountryName VARCHAR(50)
);

INSERT INTO Countries (CountryName) VALUES
('INDIA'),
('ENGLAND'),
('SOUTH AFRICA'),
('AUSTRELIA'),  -- likely a typo
('NZ');

select c.CountryName, d.CountryName from Countries c cross join Countries d where c.CountryName < d.CountryName order by c.CountryName, d.CountryName;

select * from emp where SAL in(select sal from emp group by sal having count(*)>1);


CREATE TABLE sub_ps (
    sl INT,
    sub VARCHAR(10),
    result CHAR(1)
);

INSERT INTO sub_ps (sl, sub, result) VALUES
(1, 'a', 'p'),
(1, 'b', 'f'),
(2, 'a', 'p'),
(2, 'b', 'p'),
(3, 'a', 'p'),
(3, 'b', 'f');

select sl, case when sub_a ='p' and sub_b='p' then 'p' else 'f' end result from 
(select sl, case when sum(case when sub='a' and result = 'p' then 1 else 0 end) = 1 then 'p' else 'f' end sub_a, case when sum(case when sub='b' and result = 'p' then 1 else 0 end) = 1 then 'p' else 'f' end sub_b from sub_ps group by sl)er

select sl, case when sum(case when result='f' then 1 else 0 end )>0 then 'f' else 'p' end result from sub_ps group by sl;

CREATE TABLE student_results (
    name VARCHAR(50),
    marks CHAR(1)
);

INSERT INTO student_results (NAME, MARKS) VALUES
('AJAY', 'P'),
('AMAR', 'F'),
('ARUNA', 'P'),
('NIDHI', 'P'),
('AISHU', 'F');

select  case when marks = 'P' then 'PASS' else 'FAIL' end as result, count(*) as NUMBER from student_results group by  case when marks = 'P' then 'PASS' else 'FAIL' end;

--Bengalore, how many letters are repeated..
select * into Interview_2025.dbo.emp from
Sample_70_461.dbo.emp;

with ctes as
(select top(len('Bengalore')) ROW_NUMBER() over(order by (select 1)) rn from emp),
characters as (select SUBSTRING('Bengalore', rn, 1) as ch from ctes)
select ch AS Character, COUNT(*) AS Count FROM characters GROUP BY ch ORDER BY ch;


with ctes as
(select top(len('Bengalore')) ROW_NUMBER() over(order by (select 1)) rn from emp),
characters as (select SUBSTRING('Bengalore', rn, 1) as ch from ctes)
select ch AS Character, COUNT(*) AS Count FROM characters where ch='e' GROUP BY ch ORDER BY ch;


CREATE TABLE Transactions (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    DebCredit INT
);
INSERT INTO Transactions (DebCredit)
VALUES 
    (50),
    (60),
    (-50),
    (-80),
    (-100);

select sum(case when DebCredit>0 then DebCredit else 0 end) positive_value, 
sum(case when DebCredit<0 then DebCredit else 0 end) nagetive_value from Transactions;


----- Altimetrik
-- 1st character in upper and remaining in lower
CREATE TABLE Persons (
    Name VARCHAR(50)
);

-- Step 2: Insert the values
INSERT INTO Persons (Name) VALUES
('maHesh'),
('surEsh'),
('vasu'),
('praSanth');

select upper(substring(name, 1, 1))+lower(substring(name, 2, len(name))) as name from Persons


CREATE TABLE Seminar_Attendance (
    Emp_ID INT,
    Seminar1_Date DATE NULL,
    Seminar2_Date DATE NULL,
    Seminar3_Date DATE NULL
);

INSERT INTO Seminar_Attendance (Emp_ID, Seminar1_Date, Seminar2_Date, Seminar3_Date) VALUES
(1, '2022-10-01', '2022-11-01', NULL),
(2, NULL, '2022-11-02', NULL),
(3, '2022-11-03', NULL, NULL),
(4, NULL, '2022-11-05', '2022-11-06'),
(5, '2022-12-07', NULL, NULL);

select * from Seminar_Attendance

select Emp_ID, coalesce(Seminar1_Date, Seminar2_Date, Seminar3_Date) as First_Seminar_date from Seminar_Attendance;

select Emp_ID, dt_3 as First_Seminar_date from 
(select Emp_ID, case when Seminar1_Date is not null then Seminar1_Date  
 when Seminar1_Date is null and Seminar2_Date is not null then Seminar2_Date 
 when Seminar1_Date is null and Seminar2_Date is null and Seminar3_Date is not null then Seminar3_Date end as dt_3 from Seminar_Attendance)  er 


CREATE TABLE student_marks (
    STUDENT_NAME VARCHAR(50),
    SUBJECT VARCHAR(50),
    MARKS INT
);

INSERT INTO student_marks (STUDENT_NAME, SUBJECT, MARKS) VALUES
('ravindra', 'maths', 90),
('ravindra', 'science', 60),
('ravindra', 'arts', 70),
('Ramesh', 'maths', 90),
('Ramesh', 'science', 80),
('Ramesh', 'arts', 60);


SELECT 
    STUDENT_NAME,
    SUM(CASE WHEN SUBJECT = 'maths' THEN MARKS ELSE 0 END) AS Maths,
    SUM(CASE WHEN SUBJECT = 'science' THEN MARKS ELSE 0 END) AS Science,
    SUM(CASE WHEN SUBJECT = 'arts' THEN MARKS ELSE 0 END) AS Arts,
    SUM(MARKS) AS TOTAL
FROM student_marks
GROUP BY STUDENT_NAME;

SELECT STUDENT_NAME, [maths] AS Maths, [science] AS Science, [arts] AS Arts, ISNULL([maths], 0) + ISNULL([science], 0) + ISNULL([arts], 0) AS TOTAL
FROM ( SELECT STUDENT_NAME, SUBJECT, MARKS FROM student_marks ) AS SourceTable
PIVOT ( SUM(MARKS) FOR SUBJECT IN ([maths], [science], [arts]) ) AS PivotTable;

SELECT deptno, STRING_AGG(ename, ',') AS employee_names FROM emp GROUP BY deptno;

CREATE TABLE UserTransactions ( user_id INT, [date] DATE, amount INT, day_name VARCHAR(20) );

INSERT INTO UserTransactions (user_id, [date], amount, day_name) VALUES
(1099, '2023-01-01', 288, 'Sunday'),
(1047, '2023-01-04', 803, 'Wednesday'),
(1055, '2023-01-07', 546, 'Saturday'),
(1052, '2023-01-13', 889, 'Friday'),
(1052, '2023-01-13', 596, 'Friday'),
(1095, '2023-01-27', 424, 'Friday'),
(1019, '2023-01-27', 185, 'Friday'),
(1019, '2023-02-03', 995, 'Friday'),
(1023, '2023-02-24', 259, 'Friday');


select user_id, avg(amount) amount, datepart(WEEK, cast([date] as date)) as week_number from UserTransactions group by user_id, datepart(WEEK, cast([date] as date));

-- Herman
CREATE TABLE customer_transactions (
    id INT PRIMARY KEY,
    customer_name VARCHAR(10),
    transaction_time DATETIME,
    transaction_amount INT
);

INSERT INTO customer_transactions (id, customer_name, transaction_time, transaction_amount)
VALUES 
(1, 'A', '2022-02-21 15:21:10', 533),
(2, 'B', '2022-02-21 15:21:20', 234),
(3, 'D', '2022-02-21 15:21:25', 789),
(4, 'D', '2022-02-21 15:21:45', 34),
(5, 'F', '2022-02-21 15:21:40', 12),
(6, 'A', '2022-02-21 15:22:05', 445),
(7, 'B', '2022-02-21 15:22:15', 236),
(8, 'C', '2022-02-21 15:22:30', 643),
(9, 'F', '2022-02-21 15:22:40', 563),
(10, 'C', '2022-02-21 15:22:59', 876);

select * from customer_transactions
select customer_name from
(select customer_name, transaction_time, isnull(datediff(SECOND, lag(transaction_time, 1) over(order by transaction_time), transaction_time),0) sc_tm from customer_transactions) er where sc_tm=10

select customer_name from
(select customer_name, transaction_time, LAG(transaction_time) over(order by transaction_time) prv, datediff(SECOND, LAG(transaction_time) over(order by transaction_time), transaction_time) dif from customer_transactions) er where 
datediff(SECOND, prv, transaction_time) = 10


--- cpagemini

-- Step 1: Create the table
CREATE TABLE RouteDistance (
    start CHAR(1),
    [end] CHAR(1),
    dist INT
);

-- Step 2: Insert the values
INSERT INTO RouteDistance (start, [end], dist) VALUES
('B', 'H', 400),
('H', 'B', 400),
('M', 'D', 400),
('D', 'M', 400),
('C', 'P', 400),
('P', 'C', 400);


SELECT 
    MIN(start) AS start_point,
    MAX([end]) AS end_point,
    MIN(dist) AS dist
FROM RouteDistance
GROUP BY 
    CASE WHEN start < [end] THEN start ELSE [end] END,
    CASE WHEN start < [end] THEN [end] ELSE start END;

select distinct CASE WHEN start < [end] THEN start ELSE [end] END AS start_point,
    CASE WHEN start < [end] THEN [end] ELSE start END AS end_point, dist from RouteDistance;

WITH Tally AS ( SELECT TOP (LEN('/A@#j(a)-y12')) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n FROM emp ),
Letters AS ( SELECT SUBSTRING('/A@#j(a)-y12', n, 1) AS ch FROM Tally WHERE SUBSTRING('/A@#j(a)-y12', n, 1) LIKE '[A-Za-z]' )
SELECT STRING_AGG(ch, '') AS OnlyAlphabets FROM Letters;

select ename, format(getdate(), 'yyyy')- cast(format(cast(Hiredate as date), 'yyyy') as int) work_exp from emp;

select EMAIL, substring(EMAIL, 1, charindex('.', email)-1) as first_name, 
substring(EMAIL, charindex('.', email)+1, charindex('.', email, charindex('.', email)+1)- charindex('.', email)-1) as sec_name , 
substring(EMAIL, charindex('.', email, charindex('.', email)+1)+1, charindex('@', email)-charindex('.', email, charindex('.', email)+1)-1) as sec_name
from [Email_substr]

select * from [Email_substr];

select EMAIL, SUBSTRING(EMAIL, 1, CHARINDEX('.', EMAIL)-1) fst_name from [Email_substr];
select EMAIL, SUBSTRING(EMAIL, CHARINDEX('.', EMAIL)+1, CHARINDEX('.', EMAIL, CHARINDEX('.', EMAIL)+1)-CHARINDEX('.', EMAIL)-1) fst_name from [Email_substr];
select EMAIL, SUBSTRING(EMAIL, CHARINDEX('.', EMAIL, CHARINDEX('.', EMAIL)+1)+1, CHARINDEX('@', EMAIL)-CHARINDEX('.', EMAIL, CHARINDEX('.', EMAIL)+1)-1) fst_name from [Email_substr];

with cte as 
(select top(len('/A@#j(a)-y12')) ROW_NUMBER() over(order by (select 1)) as rn from emp),
chars as (select substring('/A@#j(a)-y12', rn, 1) as ch from cte where substring('/A@#j(a)-y12', rn, 1) like '[a-zA-Z]')
select STRING_AGG(ch, '') as characters from chars;