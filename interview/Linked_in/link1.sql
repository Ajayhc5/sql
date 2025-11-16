create table student_tests
( test_id int, marks int);
insert into student_tests values(100, 55);
insert into student_tests values(101, 55);
insert into student_tests values(102, 60);
insert into student_tests values(103, 58);
insert into student_tests values(104, 40);
insert into student_tests values(105, 50);

select * from student_tests;

select test_id, marks from 
(select test_id, marks, marks-lag(marks) over(order by (select null)) diff from student_tests)er where diff>=0;

select test_id, marks from 
(select test_id, marks, marks-case when lag(marks) over(order by (select null)) is not null then lag(marks) over(order by (select null)) else 0 end diff from student_tests)er where diff>=0;

create table salary_lnk
( emp_id int, emp_name varchar(30), base_salary int);
insert into salary_lnk values(1, 'Rohan', 5000);
insert into salary_lnk values(2, 'Alex', 6000);
insert into salary_lnk values(3, 'Maryam', 7000);


drop table if exists income_lnk;
create table income_lnk
( id int, income varchar(20), percentage int);
insert into income_lnk values(1,'Basic', 100);
insert into income_lnk values(2,'Allowance', 4);
insert into income_lnk values(3,'Others', 6);


drop table if exists deduction_lnk;
create table deduction_lnk
( id int, deduction varchar(20), percentage int);
insert into deduction_lnk values(1,'Insurance', 5);
insert into deduction_lnk values(2,'Health', 6);
insert into deduction_lnk values(3,'House', 4);

select emp_id, emp_name, Basic, Allowance, Others, Insurance, Health, House, Basic+Allowance+Others as gross, Insurance+Health+House as tot from 
(select emp_id, emp_name, trans_type, amount from 
(select a.emp_id, a.emp_name, b.income as trans_type, (a.base_salary * b.percentage)/100 as amount, row_number() over(order by a.emp_id) rn from salary_lnk a cross join income_lnk b 
union all 
select a.emp_id, a.emp_name, c.deduction as trans_type, (a.base_salary * c.percentage)/100 as amount, row_number() over(order by a.emp_id) rn from salary_lnk a cross join deduction_lnk c) as emp_transaction) as src 
pivot (max(amount) for trans_type in(Basic, Allowance, Others, Insurance, Health, House)) as pvt order by emp_id;


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




CREATE TABLE FOOTER ( id INT PRIMARY KEY, car VARCHAR(20),  length INT,  width INT,  height INT);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL), (2, NULL, NULL, NULL, 20), (3, NULL, 12, 8, 15), (4, 'Toyota Rav4', NULL, 15, NULL), (5, 'Kia Sportage', NULL, NULL, 18);

SELECT * FROM FOOTER;

SELECT COALESCE(car, 'Kia Sportage') AS car, COALESCE(length, 12) AS length, COALESCE(width, 15) AS width, COALESCE(height, 18) AS height
FROM FOOTER WHERE car IS NOT NULL OR length IS NOT NULL OR width IS NOT NULL OR height IS NOT NULL;



With cte as ( select *, count(car) over ( order by id ) as car_grp,
count(length) over ( order by id ) as length_grp,
count(width) over ( order by id ) as width_grp,
count(height) over ( order by id ) as height_grp from FOOTER)
Select max( car) over( partition by car_grp) as car,
max( length) over( partition by length_grp) as length,
max( width) over( partition by width_grp) as width,
max( height) over( partition by height_grp) as height from cte order by id desc limit 1;