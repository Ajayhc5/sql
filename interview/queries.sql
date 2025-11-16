-- Max Salary
select * from (select e.*, dense_rank() over(order by sal desc) rn from emp e)er where rn=2;
select max(sal) from emp ;

-- same salary 
select * from emp where sal in(select sal from EMP group by sal having count(*)>1);
select distinct e.EMPNO, e.ENAME, e.JOB, e.MGR, e.SAL, e.COMM, e.DEPTNO, e.Hiredate from emp e cross join emp m where e.sal=m.sal and e.ename!=m.ename

select distinct e.EMPNO, e.ENAME, e.JOB, e.MGR, e.SAL,  m.EMPNO, m.ENAME, m.JOB, m.MGR, m.SAL from emp e cross join emp m where e.sal=m.sal and e.ename!=m.ename


-- Max Salary of each department
select e.EMPNO, e.ENAME, e.JOB, e.MGR, e.SAL, e.COMM, e.DEPTNO, e.Hiredate from emp e
inner join 
(select deptno, max(sal) max_sal from emp group by deptno) em on e.DEPTNO = em.DEPTNO and e.SAL=em.max_sal;

select EMPNO, ENAME, JOB, MGR, SAL, COMM, DEPTNO, Hiredate from (select e.*, dense_rank() over(partition by deptno order by sal desc) rn from emp e) em where rn =1 ;

-- Max Salary of managers from each department
select * from (select e.*, DENSE_RANK() over(partition by deptno order by sal desc) rn from emp e where e.empno in(select mgr from emp))er where rn=1

select * from(
select distinct e.EMPNO, e.ENAME, e.JOB, e.MGR, e.SAL, e.COMM, e.DEPTNO, e.Hiredate,  DENSE_RANK() over(partition by e.deptno order by e.sal desc)rn from emp e inner join emp m on e.empno=m.MGR)er where rn =1


-- Top 5 Salary
select * from (select e.*, dense_rank() over(order by sal desc) rn from emp e)er where rn<=5;


-- Last 5 Salary
select * from (select e.*, dense_rank() over(order by sal) rn from emp e)er where rn<=5;

with cte as(select e.*, DENSE_RANK() over(order by sal desc)rn from emp e)
select * from cte where rn >(select max(rn)-5 from cte)


-- Display Top 50% records
SELECT TOP 50 PERCENT * FROM emp;


-- Display Bottom 50% records
WITH CTE AS (SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum, COUNT(*) OVER () AS TotalRows FROM emp)
SELECT * FROM CTE WHERE RowNum > TotalRows / 2;


-- Display Top 5 records
select * from(select e.*, row_number() over(ORDER BY (SELECT NULL)) rn from emp e) er where rn<=5;

select Top 5 * from emp;


-- Display Last 5 records
with cte as(select e.*, ROW_NUMBER() over(order by (select 1)) rn from emp e)
select * from cte where rn >(select max(rn)-5 from cte)

select * from 
(SELECT e.*, ROW_NUMBER() OVER (ORDER BY empno DESC) AS RowNum FROM emp e)er where RowNum <= 5 ORDER BY RowNum DESC;


-- Display Even number
select * from(select e.*, row_number() over(ORDER BY (SELECT 1)) rn from emp e)et where (rn%2)=0

-- Display Odd number
select * from(select e.*, row_number() over(ORDER BY (SELECT 1)) rn from emp e)et where (rn%2)=1

-- Display positive and negative values from emp

select * from (select e.*, case when e.sal>= 3000 and e.comm is null then -100 else 100 end commis from emp e)negative where commis <0;
select * from (select e.*, case when e.sal>= 3000 and e.comm is null then -100 else 100 end commis from emp e)positive where commis >0;

with cter as(select e.*, case when e.sal>= 3000 and e.comm is null then -100 else 100 end commis from emp e)
select *, case when commis<0 then commis else 0 end negative_values,  case when commis>0 then commis else 0 end positive_values from cter;


-- Name & Number display in seperate column

select case when IdEname like '%[0-9]%' then IdEname else null end as id, 
 case when IdEname like '%[A-Za-z]%' then IdEname else null end as userName from SplitNameID;

select IIF(IdEname like '%[0-9]%', IdEname, IIF(IdEname like '%[0-9]%', IdEname, null)) id from SplitNameID;

SELECT CASE WHEN ISNUMERIC(IdEname) = 1 THEN IdEname ELSE NULL END AS Number,
    CASE WHEN ISNUMERIC(IdEname) = 0 THEN IdEname ELSE NULL END AS userName FROM SplitNameID;

with numeric_tb as(
SELECT IdEname AS Id, ROW_NUMBER() OVER(ORDER BY TRY_CAST(IdEname AS INT)) AS rn FROM SplitNameID WHERE TRY_CAST(IdEname AS INT) IS NOT NULL),
nonnumeric_table as (
SELECT IdEname AS Ename, ROW_NUMBER() OVER(ORDER BY IdEname) AS rn FROM SplitNameID WHERE TRY_CAST(IdEname AS INT) IS NULL)
select Id, Ename from numeric_tb a inner join nonnumeric_table b on a.rn=b.rn

select case when IdEname like '%[0-9]%' then IdEname end as id, ROW_NUMBER() OVER(ORDER BY (select 1)) AS rn  FROM SplitNameID where (case when IdEname like '%[0-9]%' then IdEname end)  is not null;


-- Create one more table with existing table
SELECT * INTO EMP_dupl FROM emp;
select * from EMP_dupl


-- Delete the Duplicate
delete from emp where empno in(select empno from emp group by EMPNO having count(*)>1);

delete from EMP_dupl where JOB in (select JOB from EMP_dupl group by JOB having count(*)>4);


-- Display String 'APPLE' in vertical
SELECT SUBSTRING('APPLE', Number, 1) AS sty 
FROM (SELECT 1 AS Number UNION ALL
      SELECT 2 UNION ALL
      SELECT 3 UNION ALL
      SELECT 4 UNION ALL
      SELECT 5) AS Numbers WHERE Number <= LEN('APPLE');

SELECT SUBSTRING('APPLE', Number, 1) AS sty FROM master..spt_values
WHERE type = 'P' AND Number BETWEEN 1 AND LEN('APPLE');

SELECT * FROM master..spt_values WHERE type = 'P';

WITH Tally AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Number FROM sys.objects)
SELECT SUBSTRING('APPLE', Number, 1) AS sty FROM Tally WHERE Number <= LEN('APPLE');

WITH Tally AS (SELECT top(LEN('APPLE')) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Number FROM sys.objects)
SELECT SUBSTRING('APPLE', Number, 1) AS sty FROM Tally; -- WHERE Number <= LEN('APPLE');

-- inner join, left join, right join, full outer join count
select * from ers
select * from  grs
select * from ers e inner join grs g on e.id=g.ids;
select * from ers e left join grs f on e.id=f.ids;
select * from ers e right join grs f on e.id=f.ids;
select * from ers e full outer join grs f on e.id=f.ids;
select * from ers e cross join grs f ;


-- display male as M and female F 
select * from EMPDATA ;
insert into EMPDATA values ('JONY', 'MALE', 'SALES', '9193458625', 'Delhi')

delete from EMPDATA where EMPNAME ='JONY'
select *, case when gender = 'MALE' then 'M' 
when gender = 'FEMALE' then 'F' else 'T' end as gender from EMPDATA;

select CITY, sum(case when gender='MALE' then 1 else 0 end) ml_cnt, sum(case when gender='FEMALE' then 1 else 0 end) fml_cnt from EMPDATA group by CITY

SELECT *, IIF(gender = 'MALE', 'M', IIF(gender = 'FEMALE', 'F', 'T')) AS gender FROM EMPDATA;


-- display sal + comm
select sal + isnull(comm, 0) total_sal from emp


-- sum of sal by deptno where sal>2000 and joining year 81
select EMPNO, ENAME, JOB, MGR, SAL, COMM, DEPTNO, Hiredate, sum(sal) over(partition by deptno) from emp where sal>2000 and 
FORMAT(hiredate, 'MM-yy') between '01-81' and '12-82'
--year(hiredate)='1981'


-- display the manager of dept
select distinct em.ENAME as mgr_name, em.sal as mgr_sal, dp.DNAME from emp em
join emp rm on em.EMPNO=rm.MGR 
join DEPT dp on em.DEPTNO=dp.DEPTNO 


-- display the name who is going to retering on 31-dec-2024
select * from emp where  DATEADD(YEAR, 43, Hiredate) between '2024-12-01' and '2024-12-31'

-- display name whose salary more than manager 
select em.empno, em.ENAME, em.SAL, rm.ENAME as mgr_name, rm.SAL as mgr_sal, rm.MGR from emp em
join emp rm on em.MGR=rm.EMPNO and em.SAL>rm.SAL;

select em.empno, em.ENAME, em.SAL, rm.empno,rm.ENAME as mgr_name, rm.SAL as mgr_sal, rm.MGR from emp em
join emp rm on em.MGR=rm.EMPNO and em.SAL>rm.SAL;

-- display last 2 character of ename
select SUBSTRING(ENAME, LEN(ENAME) - 1, 2), ENAME from emp
select RIGHT(ename, 2), ename from emp


--  Latest updated record
Select max(hiredate) Latest from emp


-- Display whose salary is more than scott
select * from emp where SAL > (select sal from emp where ename='SCOTT')


-- Display the name of employee bigns with vowel
select ename from emp where ename LIKE '[AEIOUaeiou]%'
select ename from emp where substring(ename, 1,1) in('A', 'E', 'I', 'O', 'U')

select ename from emp where ename LIKE '%[AEIOUaeiou]%'


-- Dispaly name 1st letter space and full name
select SUBSTRING(ename, 1,1) + ' '+ename from emp;
select concat( SUBSTRING(ename, 1, 1), ' ', ename) from emp;
select concat(ename, ' ', SUBSTRING(ename, len(ename)-1,2) ) from emp;


-- diplay the employee join on sunday
SELECT * FROM Emp WHERE DATENAME(WEEKDAY, Hiredate) = 'Sunday';
select *, DATENAME(WEEKDAY, Hiredate) daynames, datepart(WEEK, Hiredate) weeknumber, DATEPART(WEEKDAY, Hiredate) FROM Emp;

-- display the birth day 
SELECT DATENAME(WEEKDAY, '1988-10-27') AS DayName;


--DISPLAY THE EMPLOYEE WHOSE NAME STRTS WITH AND ENDS WITH SAME CHARACTER?
select * from emp where SUBSTRING(ENAME, 1,1) = SUBSTRING(ENAME, len(ename)-0, 1)
select *, SUBSTRING(ENAME, 1,1) st, SUBSTRING(ENAME, len(ename)-0, 1) lst from emp
select * from emp where left(ename, 1)=RIGHT(ENAME, 1)


-- DISPLAY dname  WHERE MAXMUM NUMBER OF EMPLOYEE WORKS?
select * from(SELECT d.dname,count(*) cnt, DENSE_RANK() over(order by count(*) desc) rn from emp e,dept d
where e.deptno=d.deptno group by d.dname) trsr 


-- DISPLAY THE ENAME,DNAME,SAL FROM EMPLOYEE WHOSE  SAL AND COMM MATCHES WITH SAL AND  COMM OF THE EMPLOYEE WORKING IN LOC DALLES
select e.ename,d.dname,e.sal, d.LOC from emp e,dept d
where e.deptno=d.deptno and exists (select sal,isnull(comm,0) comm from emp e join dept d
on e.deptno=d.deptno and d.loc='DALLAS')


-- DISPLAY THE ENAME,DNAME,Deptno FROM EMPLOYEE and dept where deptno not in emp table
select e.ename, e.DEPTNO edeptno, d.DEPTNO ddeptno, d.DNAME from emp e 
right join 
dept d on e.DEPTNO=d.DEPTNO where e.deptno is null

select *, ename, case when ROW_NUMBER() over(order by (select 1))%2=0 then lag(ENAME, 1) over(order by ename) else  lead(ENAME, 1, ename) over(order by ename) end out_pt from emp

select *, sum(sal) over(order by empno) from emp
