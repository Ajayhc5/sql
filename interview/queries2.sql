-- display from each city male count, female count, total count?
select City, male_count, Female_count, male_count+Female_count as "total count" from
(select City, count(case when gender='M' then 1 end) male_count, 
count(case when gender='F' then 1 end) Female_count 
from OriginalData group by city)er;


-- display numbers with out zero(0) and input 100, 2020, 3010, output 00100, 02020, 03010?
SELECT ID, CAST(REPLACE(CAST(ID AS VARCHAR), '0', '') AS INT) AS TransformedID FROM IdTable;
SELECT REPLACE(ID , 0, '')AS TransformedID FROM IdTable;

SELECT RIGHT('00000' + CAST(id AS VARCHAR), 5) AS PaddedId FROM IdTable;

SELECT RIGHT(REPLICATE('0', 5) + CAST(id AS VARCHAR), 5) AS PaddedString FROM IdTable;

-- display previous salary , next salary
Select empno,ename,sal,
lag(sal,1,0) over(order by sal)as prv_market,
lead(sal,1,sal) over(order by sal)as next_market
from emp;

-- Display the columns having yellow?
select * from ColorsTable;

select Name1, Name2, Name3 from 
(select Name1, ROW_NUMBER() over(order by (select 1))rn from ColorsTable where Name1 = 'yellow' )er
left join 
(select Name2, ROW_NUMBER() over(order by (select 1))rn from ColorsTable where Name2 = 'yellow')es on er.rn=es.rn
left join 
(select Name3, ROW_NUMBER() over(order by (select 1))rn from ColorsTable where Name3 = 'yellow')ef on er.rn=ef.rn

select * from 
(select (select tb.Name1 from ColorsTable tb join ColorsTable tb1 on tb.Name1=tb1.Name1 and tb.Name1='yellow') Name1, (select tb.Name2 from ColorsTable tb join ColorsTable tb1 on tb.Name2=tb1.Name2 and tb.Name2='yellow')Name2, (select tb.Name3 from ColorsTable tb join ColorsTable tb1 on tb.Name3=tb1.Name3 and tb.Name3='yellow')Name3) ert ;


select row_id,updatedJobRole as job_role,skills from
(select * ,
FIRST_VALUE(job_role) over (partition by flag2 order by row_id) as updatedJobRole
from
(select * , sum(case when job_role is null then 0 else 1 end ) over (order by row_id) as flag2 from jobSkills) 
x)y;

-- display max and min sal employee name each deptno?
select edr.deptno, edr.min_sal_ename, min_sal, eds.max_sal_ename, max_sal from 
(select  deptno, sal min_sal, case when min_sal_ename=1 then ename end as min_sal_ename from(
select *, DENSE_RANK()over(partition by deptno order by sal) min_sal_ename from  emp) er where --case when min_sal_ename=1 then ename end is not null
min_sal_ename=1) edr
 inner join 
(select  deptno, sal max_sal, case when max_sal_ename=1 then ename end as max_sal_ename from(
select *,  DENSE_RANK()over(partition by deptno order by sal desc) max_sal_ename from  emp) er where max_sal_ename=1 
--case when max_sal_ename=1 then ename end is not null
 ) eds on edr.DEPTNO=eds.DEPTNO;

select  deptno, max(case when min_sal_ename=1 then ename end) as min_sal_ename, max(case when max_sal_ename=1 then ename end) as max_sal_ename from(
select *, DENSE_RANK()over(partition by deptno order by sal) min_sal_ename, DENSE_RANK()over(partition by deptno order by sal desc) max_sal_ename from  emp) er group by deptno;

select distinct deptno, FIRST_VALUE(ename) over(partition by deptno order by sal)min_sal_ename, FIRST_VALUE(ename) over(partition by deptno order by sal desc)max_sal_ename from emp;


--display the last 4 digit of card number?
select * from cards_hidenumbersby_star;

select card_number, '*****'+substring(er_card_number, LEN(er_card_number)-2, 3) from (
select card_number, cast(card_number as varchar(10))er_card_number from cards_hidenumbersby_star)wer;

select card_number, REPLICATE('*', LEN(card_number) - 4) + RIGHT(card_number, 4) AS MaskedContactNo from cards_hidenumbersby_star;





-- display the 1ST , MIDDEL, LAST, DOMINE, SERVICE  NAME OF EMAIL?
select * from Email_substr;
select EMAIL, SUBSTRING(EMAIL, 1,CHARINDEX('.', EMAIL)-1) from Email_substr;
select EMAIL, SUBSTRING(EMAIL,CHARINDEX('.', EMAIL)+1, CHARINDEX('.', EMAIL, CHARINDEX('.', EMAIL)+1)-CHARINDEX('.', EMAIL)-1) from Email_substr;
select EMAIL, SUBSTRING(EMAIL, CHARINDEX('.', EMAIL, CHARINDEX('.', EMAIL)+1)+1, CHARINDEX('@', EMAIL)-CHARINDEX('.', EMAIL, CHARINDEX('.', EMAIL)+1)-1) from Email_substr;
select EMAIL, SUBSTRING(EMAIL,  CHARINDEX('@', EMAIL)+1, CHARINDEX('.', EMAIL,  CHARINDEX('@', EMAIL)+1) - CHARINDEX('@', EMAIL)-1) from Email_substr;
select EMAIL, SUBSTRING(EMAIL, CHARINDEX('.', EMAIL,  CHARINDEX('@', EMAIL))+1, LEN(email)-charindex('.', EMAIL,  CHARINDEX('@', EMAIL))) from Email_substr;

select left(email, charindex('.', email)-1) from Email_substr;
select right(email, len(email)-charindex('.', EMAIL,  CHARINDEX('@', EMAIL))) as esr from Email_substr;

select EMAIL, SUBSTRING(email, 1, charindex('.', EMAIL)-1) Frist_name from Email_substr;
select EMAIL, SUBSTRING(email, charindex('.', EMAIL)+1, CHARINDEX('.', EMAIL, CHARINDEX('.', EMAIL)+1)-charindex('.', EMAIL)-1) Scend_name from Email_substr;
select EMAIL, SUBSTRING(email,  CHARINDEX('.', EMAIL, CHARINDEX('.', EMAIL)+1)+1, CHARINDEX('@', EMAIL)-CHARINDEX('.', EMAIL, CHARINDEX('.', EMAIL)+1)-1) third_name from Email_substr;
select EMAIL, SUBSTRING(email,  CHARINDEX('@', EMAIL)+1, CHARINDEX('.', EMAIL, CHARINDEX('@', EMAIL)+1)-CHARINDEX('@', EMAIL)-1) gname_name from Email_substr;
select EMAIL, SUBSTRING(email, CHARINDEX('.', EMAIL, CHARINDEX('@', EMAIL)+1)+1, len(EMAIL)-CHARINDEX('.', EMAIL, CHARINDEX('@', EMAIL)+1)) gname_name from Email_substr;


-- write a query to find the count of letter 'a' in string "sapna patil" ? 
SELECT SUM(LEN('EMPNAME') - LEN(REPLACE('EMPNAME', 'E', ''))) AS Total_E_Count;
SELECT LEN('EMPNAME') - LEN(REPLACE('EMPNAME', 'E', '')) AS Total_E_Count;
SELECT ename , LEN(ename) - LEN(REPLACE(upper(ename), 'A', '')) AS Total_E_Count from emp;

with name_cte as 
(select top(len('EMPNAME')) ROW_NUMBER() over(order by (select 1)) rn from emp),
chars as(select substring('EMPNAME', rn, 1) as ch from name_cte)
select ch as characters, count(*) char_cnt from chars where ch = 'A' group by ch;

-- Delete the duplicate records?
select * from delete_duplicate;
insert into delete_duplicate values('2')

BEGIN TRANSACTION;

with dlt_dupl as(select ids, ROW_NUMBER() over(partition by ids order by ids) rwn from delete_duplicate)
delete from dlt_dupl where rwn>1;

ROLLBACK;


SELECT ids, ROW_NUMBER() OVER (partition by ids order by ids) as row_num INTO #dulp_del FROM delete_duplicate;

select * from #dulp_del;

BEGIN TRANSACTION;
delete from #dulp_del where row_num>1
ROLLBACK;
