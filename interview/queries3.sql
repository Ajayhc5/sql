CREATE TABLE emp_tbl (
 id DATETIME, 
 empid INT
);

INSERT INTO emp_tbl VALUES 
('2024-01-13 09:25:00', 10),
('2024-01-13 19:35:00', 10),
('2024-01-16 09:10:00', 10),
('2024-01-16 18:10:00', 10),
('2024-02-11 09:07:00', 10),
('2024-02-11 19:20:00', 10),
('2024-02-17 08:40:00', 17),
('2024-02-17 18:04:00', 17),
('2024-03-23 09:20:00', 10),
('2024-03-23 18:30:00', 10);


select sum(DATEDIFF(HOUR, 0, id)), empid from (
select convert(TIME, id) id , empid from emp_tbl where DATENAME(WEEKDAY, id) in ('Saturday', 'Sunday'))erd group by empid




select empid, sum(cast(cast(HoursWorked as varchar)+'.'+cast(MinutesWorked as varchar) as DECIMAL(10, 3))) tot from (
SELECT 
    empid,
    CAST(id AS DATE) AS work_date,
    MIN(id) AS InTime,
    MAX(id) AS OutTime,
    DATEDIFF(MINUTE, MIN(id), MAX(id)) / 60 AS HoursWorked,
    DATEDIFF(MINUTE, MIN(id), MAX(id)) % 60 AS MinutesWorked
FROM emp_tbl
WHERE DATENAME(WEEKDAY, id) IN ('Saturday', 'Sunday')
GROUP BY empid, CAST(id AS DATE)
)er group by empid;


--select * from emp_tbl


WITH EmployeeHours AS (
    SELECT empid,DATEPART(WEEKDAY, id) AS weekday, CAST(id AS TIME) AS start_time, LEAD(CAST(id AS TIME)) OVER (PARTITION BY empid ORDER BY id) AS end_time
    FROM emp_tbl
)
SELECT
    empid,
    sum(CASE WHEN weekday IN (1, 7) THEN DATEDIFF(minute, start_time, end_time) / 60.0 ELSE 0 END) AS Total_Weekend_Wrk_Hrs
FROM EmployeeHours where (CASE WHEN weekday IN (1, 7) THEN DATEDIFF(minute, start_time, end_time) / 60.0 ELSE 0 END)>0 
GROUP BY empid;


select DATEPART(WEEKDAY, id) AS weekdayr FROM emp_tbl
select DATENAME(WEEKDAY, id) AS weekdayr FROM emp_tbl



select empid, SUM(CASE WHEN weekday IN (1, 7) THEN DATEDIFF(minute, start_time, end_time) / 60.0 ELSE 0 END) AS Total_Weekend_Wrk_Hrs from(
SELECT empid,DATEPART(WEEKDAY, id) AS weekday, CAST(id AS TIME) AS start_time, LEAD(CAST(id AS TIME)) OVER (PARTITION BY empid ORDER BY id) AS end_time FROM emp_tbl) ert where (CASE WHEN weekday IN (1, 7) THEN DATEDIFF(minute, start_time, end_time) / 60.0 ELSE 0 END)>0 GROUP BY empid;

drop table FSTname;
CREATE TABLE FSTname (
 customer_name varchar(20)
);

INSERT INTO FSTname VALUES 
('Ankit Bansal'),
('Vishal Pratap Sing'),
('Michel '),
('Raj veer shetty');

select * from FSTname ;
select case when customer_name is not null then SUBSTRING(customer_name, 1, CHARINDEX(' ', customer_name)-1) else null end fst_nm from FSTname;
select case when customer_name is not null then SUBSTRING(customer_name, CHARINDEX(' ', customer_name)+1, CHARINDEX(' ', customer_name, CHARINDEX(' ', customer_name)+1)-CHARINDEX(' ', customer_name)-1) else null end fst_nm from FSTname;


select REVERSE(SUBSTRING(REVERSE(customer_name), 1, CHARINDEX(' ', REVERSE(customer_name)) - 1)) from FSTname;

select customer_name,
    PARSENAME(REPLACE(customer_name, ' ', '.'), 3) AS first_name,
    CASE 
        WHEN LEN(PARSENAME(REPLACE(customer_name, ' ', '.'), 2)) = 0 
             THEN NULL 
        ELSE PARSENAME(REPLACE(customer_name, ' ', '.'), 2) 
    END AS middle_name,
    PARSENAME(REPLACE(customer_name, ' ', '.'), 1) AS last_name from FSTname;

select customer_name, case when customer_name is not null then SUBSTRING(customer_name, 1, CHARINDEX(' ', customer_name)-1) else null end  AS first_name, 
CASE WHEN LEN(customer_name) - LEN(REPLACE(customer_name, ' ', '')) = 1 THEN NULL WHEN LEN(customer_name) - LEN(REPLACE(customer_name, ' ', '')) = 0 THEN NULL ELSE LTRIM(RTRIM(SUBSTRING(customer_name, CHARINDEX(' ', customer_name) + 1, LEN(customer_name) - CHARINDEX(' ', customer_name) - CHARINDEX(' ', REVERSE(customer_name)) ))) END AS middle_name, 
PARSENAME(REPLACE(customer_name, ' ', '.'), 1) AS last_name from FSTname;



create table numbers (n int);
insert into numbers values (1),(2),(3),(4),(5)
insert into numbers values (9)


WITH NumberRepeater AS (
    -- Select each number from the table, and start with a repeat count of 1
SELECT n AS original_value, 1 AS repeat_count FROM numbers 
UNION ALL 
SELECT original_value, repeat_count + 1 FROM NumberRepeater WHERE repeat_count < original_value
)
-- Final result to get the repeated numbers
SELECT original_value, repeat_count FROM NumberRepeater ORDER BY original_value, repeat_count;


SELECT n FROM numbers
CROSS APPLY (SELECT TOP (n) 1 AS repeat FROM master..spt_values) AS Repeater
ORDER BY n;


with cte as(
 select top (select max(n) from numbers) row_number() over(order by(select null))as n from sys.all_objects)
 select n1.n, n2.n from numbers n1 left join cte n2 on n1.n>=n2.n

create table student_tests
(
 test_id int,
 marks int
);
insert into student_tests values(100, 55);
insert into student_tests values(101, 55);
insert into student_tests values(102, 60);
insert into student_tests values(103, 58);
insert into student_tests values(104, 40);
insert into student_tests values(105, 50);

select * from student_tests;

select test_id, marks from 
(select test_id, marks, marks-lag(marks) over(order by (select null)) diff from student_tests)er where diff>=0;



create table salary_lnk
(
 emp_id int,
 emp_name varchar(30),
 base_salary int
);
insert into salary_lnk values(1, 'Rohan', 5000);
insert into salary_lnk values(2, 'Alex', 6000);
insert into salary_lnk values(3, 'Maryam', 7000);


drop table if exists income_lnk;
create table income_lnk
(
 id int,
 income varchar(20),
 percentage int
);
insert into income_lnk values(1,'Basic', 100);
insert into income_lnk values(2,'Allowance', 4);
insert into income_lnk values(3,'Others', 6);


drop table if exists deduction_lnk;
create table deduction_lnk
(
 id int,
 deduction varchar(20),
 percentage int
);
insert into deduction_lnk values(1,'Insurance', 5);
insert into deduction_lnk values(2,'Health', 6);
insert into deduction_lnk values(3,'House', 4);

select * from salary_lnk

select * from income_lnk

select * from deduction_lnk

select emp_id, emp_name, trans_type, amount from 
(select a.emp_id, a.emp_name, b.income as trans_type, (a.base_salary * b.percentage)/100 as amount, row_number() over(order by a.emp_id) rn from salary_lnk a cross join income_lnk b 
union all 
select a.emp_id, a.emp_name, c.deduction as trans_type, (a.base_salary * c.percentage)/100 as amount, row_number() over(order by a.emp_id) rn from salary_lnk a cross join deduction_lnk c) as emp_transaction order by emp_id;




with "salary report" as ( 
select a.emp_id, a.emp_name, b.income as trans_type, (a.base_salary * b.percentage)/100 as amount, row_number() over(order by a.emp_id) rn from salary_lnk a cross join income_lnk b 
union all 
select a.emp_id, a.emp_name, c.deduction as trans_type, (a.base_salary * c.percentage)/100 as amount, row_number() over(order by a.emp_id) rn from salary_lnk a cross join deduction_lnk c)
select emp_name, sum(case when trans_type='Basic' then amount end) as Basic, 
sum(case when trans_type='Allowance' then amount end) as Allowance, 
sum(case when trans_type='Others' then amount end) as Others, 
sum(case when trans_type='Insurance' then amount end) as Insurance, 
sum(case when trans_type='Health' then amount end) as Health, 
sum(case when trans_type='House' then amount end) as House, 
sum(case when trans_type='Basic' then amount end) + sum(case when trans_type='Allowance' then amount end) + sum(case when trans_type='Others' then amount end) as Gross, 
sum(case when trans_type='Insurance' then amount end) + sum(case when trans_type='Health' then amount end) + sum(case when trans_type='House' then amount end) as Total_Deduction 
from "salary report" group by emp_name order by gross


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    DishName VARCHAR(50),
    RestaurantID VARCHAR(10),
    Quantity INT,
    OrderDate DATE
);

INSERT INTO Orders (OrderID, DishName, RestaurantID, Quantity, OrderDate)
VALUES 
    (1, 'Burger', 'R101', 2, '2025-01-01'),
    (2, 'Pasta', 'R101', 1, '2025-01-02'),
    (3, 'Burger', 'R101', 1, '2025-01-03'),
    (4, 'Pizza', 'R102', 3, '2025-01-01'),
    (5, 'Burger', 'R101', 4, '2025-01-04'),
    (6, 'Pasta', 'R101', 2, '2025-01-05');

-- 1_ Write an SQL query to find the top 5 most-ordered dishes from a given restaurant.

select distinct RestaurantID from 
(select *, count(DishName) over(partition by RestaurantID order by RestaurantID) most_ordered from Orders) er where most_ordered =5

select distinct DishName, RestaurantID, most_ordered from (select *, sum(Quantity) over(partition by RestaurantID, DishName order by RestaurantID) most_ordered from Orders) er where most_ordered >=5


CREATE TABLE Zomato_Orders (
    OrderID INT PRIMARY KEY,
    UserID VARCHAR(10),
    DishName VARCHAR(50),
    OrderDate DATE,
    Amount INT
);
INSERT INTO Zomato_Orders (OrderID, UserID, DishName, OrderDate, Amount)
VALUES 
    (1, 'U123', 'Burger', '2025-01-01', 200),
    (2, 'U123', 'Pasta', '2025-01-10', 150),
    (3, 'U124', 'Pizza', '2024-12-20', 300),
    (4, 'U123', 'Salad', '2024-12-30', 100),
    (5, 'U124', 'Burger', '2025-01-15', 250);

select * from Zomato_Orders where OrderDate between DATEADD(day, -30, SYSDATETIME()) and SYSDATETIME()

select  SYSDATETIME()


CREATE TABLE zom_tbl (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderTime DATETIME,
    Amount DECIMAL(10,2)
);
INSERT INTO zom_tbl (OrderID, CustomerName, OrderTime, Amount) 
VALUES 
(101, 'Rahul', '2025-02-19 09:00:00', 500),
(102, 'Priya', '2025-02-19 08:55:00', 300),
(103, 'Amit', '2025-02-19 09:20:00', 450);

SELECT * FROM zom_tbl;

SELECT * , DATEADD(HOUR, -1, GETDATE()) dtg , GETDATE() crtm
FROM zom_tbl
WHERE OrderTime between DATEADD(HOUR, -1, GETDATE()) and GETDATE();


CREATE TABLE Transactions (
    Person VARCHAR(10),
    Amt INT,
    StartDt DATE,
    EndDt DATE
);

INSERT INTO Transactions (Person, Amt, StartDt, EndDt)
VALUES
    ('S1', 100, '2021-01-01', '2021-12-31'),
    ('S2', 50, '2021-01-12', '2021-02-28'),
    ('S2', 200, '2021-03-01', '2021-03-25');

select * from Transactions;

WITH DateRange AS (
    SELECT 
        Person, 
        Amt / NULLIF(DATEDIFF(DAY, StartDt, EndDt) + 1, 0) AS DailyAmt, 
        StartDt, 
        EndDt
    FROM Transactions
),
Aggregated AS (
    SELECT 
        Person, 
        SUM(DailyAmt * (DATEDIFF(DAY, StartDt, EndDt) + 1)) / 365 AS AvgAnnualAmt
    FROM DateRange
    GROUP BY Person
)
SELECT * ,
    Person, 
    CAST(ROUND(AvgAnnualAmt * 365, 0) AS INT) AS Amt
FROM Aggregated;



CREATE TABLE A_tbl (
    A_clm INT
);

CREATE TABLE B_tbl (
    B_clm INT
);


INSERT INTO A_tbl (A_clm) VALUES (1), (1), (NULL), (1);

INSERT INTO B_tbl (B_clm) VALUES (1), (NULL), (1), (2);


SELECT *, count(*) over() FROM A_tbl A INNER JOIN B_tbl B ON A.A_clm = B.B_clm;

SELECT *, count(*) over() FROM A_tbl A LEFT JOIN B_tbl B ON A.A_clm = B.B_clm;

SELECT *, count(*) over() FROM A_tbl A RIGHT JOIN B_tbl B ON A.A_clm = B.B_clm;

SELECT *, count(*) over() FROM A_tbl A FULL OUTER JOIN B_tbl B ON A.A_clm = B.B_clm;

SELECT *, count(*) over() FROM A_tbl A CROSS JOIN B_tbl B ;


CREATE TABLE Product_tbl (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(20)
);

CREATE TABLE Sales_tbl (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Product_tbl(ProductID)
);


INSERT INTO Product_tbl (ProductID, ProductName, Category) VALUES
(1, 'Laptop A', 'Laptop'),
(2, 'Laptop B', 'Laptop'),
(3, 'Camera X', 'Camera'),
(4, 'Camera Y', 'Camera');

INSERT INTO Sales_tbl (SaleID, ProductID, SaleDate, Quantity) VALUES
(101, 1, '2024-06-10', 5),
(102, 2, '2024-06-15', 3),
(103, 3, '2024-04-20', 7),
(104, 3, '2024-05-05', 4),
(105, 4, '2024-06-30', 6);


select * from Product_tbl 
select * from Sales_tbl

select Category, sum(quantity) as Quantity from 
(select a.productname, a.category, b.quantity from Product_tbl a inner join Sales_tbl b on a.ProductID=b.ProductID where Month(SaleDate) =6) er group by Category


CREATE TABLE NumberData (
    NUMBER DECIMAL(10, 3)
);
INSERT INTO NumberData (NUMBER) VALUES
(10.3),
(12.56),
(14.889),
(20);

SELECT NUMBER, SUBSTRING(CAST(NUMBER AS VARCHAR), 1, CHARINDEX('.', CAST(NUMBER AS VARCHAR))-1) SINT, SUBSTRING(CAST(NUMBER AS VARCHAR), CHARINDEX('.', CAST(NUMBER AS VARCHAR))+1, LEN(NUMBER)-CHARINDEX('.', CAST(NUMBER AS VARCHAR))+1) DC FROM NumberData

SELECT NUMBER, FLOOR(NUMBER) AS INT, CAST( CASE WHEN CHARINDEX('.', CAST(NUMBER AS VARCHAR)) > 0 THEN   SUBSTRING(CAST(NUMBER AS VARCHAR), CHARINDEX('.', CAST(NUMBER AS VARCHAR))+1, LEN(NUMBER)-CHARINDEX('.', CAST(NUMBER AS VARCHAR))+1) ELSE '0' END AS INT ) AS DC FROM NumberData;

SELECT NUMBER, FLOOR(NUMBER) AS INT, CAST( CASE WHEN CHARINDEX('.', CAST(NUMBER AS VARCHAR)) > 0 THEN RIGHT(CAST(NUMBER AS VARCHAR), LEN(CAST(NUMBER AS VARCHAR)) - CHARINDEX('.', CAST(NUMBER AS VARCHAR))) ELSE '0' END AS INT ) AS DC FROM NumberData;

select cast(NUMBER as int)  from NumberData

CREATE TABLE Player (
    PlayerID INT PRIMARY KEY,
    PlayerName VARCHAR(50)
);

CREATE TABLE PlayerSession (
    PlayerID INT,
    SessionDate DATE,
    SessionID INT,
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);


INSERT INTO Player (PlayerID, PlayerName) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

INSERT INTO PlayerSession (PlayerID, SessionDate, SessionID) VALUES
(1, '2025-05-01', 102),
(1, '2025-05-01', 103),
(1, '2025-05-01', 101),  -- Alice
(1, '2025-05-02', 102),
(2, '2025-05-01', 101),  -- Bob (same session as Alice on 5/1)
(2, '2025-05-03', 103),  -- Bob second session
(3, '2025-05-02', 102),  -- Charlie
(3, '2025-05-03', 103),
(4, '2025-05-01', 101),  -- David
(4, '2025-05-03', 103);  -- David second session

SELECT ps.PlayerID, p.PlayerName, ps.SessionID, ps.SessionDate
FROM PlayerSession ps
JOIN Player p ON ps.PlayerID = p.PlayerID
WHERE ps.PlayerID IN (
    SELECT PlayerID
    FROM PlayerSession
    GROUP BY PlayerID
    HAVING COUNT(DISTINCT SessionID) > 1
);

SELECT * FROM
(SELECT DISTINCT ps.PlayerID, p.PlayerName, ps.SessionDate, COUNT(*) OVER(PARTITION BY ps.PlayerID, ps.SessionDate ORDER BY ps.PlayerID, ps.SessionDate ) RN
FROM PlayerSession ps
JOIN Player p ON ps.PlayerID = p.PlayerID)ER WHERE RN>1


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
GROUP BY STUDENT_NAME order by SUM(MARKS);


CREATE TABLE UserTransactions (
    user_id INT,
    [date] DATE,
    amount INT,
    day_name VARCHAR(20)
);

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


SELECT 
    user_id,
    AVG(amount) AS avg_amount,
    DATEPART(WEEK, CAST([date] AS DATE)) AS week_number
FROM UserTransactions
WHERE day_name = 'Friday'
GROUP BY user_id, DATEPART(WEEK, CAST([date] AS DATE));



-- Create Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

-- Create Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

-- Create Enrollments table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    CONSTRAINT FK_Student FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT FK_Course FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


-- Insert Students
INSERT INTO Students (StudentID, StudentName) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana');

-- Insert Courses
INSERT INTO Courses (CourseID, CourseName) VALUES
(101, 'Mathematics'),
(102, 'Physics'),
(103, 'Chemistry');

-- Insert Enrollments
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(1001, 1, 101),
(1002, 1, 102),
(1003, 2, 103),
(1004, 3, 101),
(1005, 4, 102),
(1006, 4, 103);


SELECT c.CourseID, c.CourseName, COUNT(e.StudentID) AS EnrolledStudentsCount
FROM Courses c 
inner JOIN 
Enrollments e ON c.CourseID = e.CourseID
inner JOIN 
Students s ON e.StudentID = s.StudentID
GROUP BY c.CourseID, c.CourseName ORDER BY EnrolledStudentsCount DESC;


-- Age
select  format(getdate(), 'yyyy')- cast(format(cast('1993-10-27' as date), 'yyyy') as int)  as age ;
select ename, format(getdate(), 'yyyy') crn, cast(format(hiredate, 'yyyy') as int) brn, format(getdate(), 'yyyy')-cast(format(hiredate, 'yyyy') as int) age from emp


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
(select customer_name, transaction_time, LAG(transaction_time) over(order by transaction_time) prv, datediff(SECOND, LAG(transaction_time) over(order by transaction_time), transaction_time) dif from customer_transactions) er where 
datediff(SECOND, prv, transaction_time) = 10


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

select sl, case when sum(case when result='f' then 1 else 0 end) >0 then 'f' else 'p' end reslut from sub_ps group by sl

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

select  case when marks = 'P' then 'PASS' else 'FAIL' end as result, count(*) as NUMBER from student_results group by MARKS


select * from emp where comm is null and ename is null;

select * from emp where comm is null or ename is null;