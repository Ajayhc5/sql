-------------------------------------------------------------
select * from emp_pivot;

select emp_id, [salary], [bonus], [hike_percent] from
(select emp_id, salary_component_type, val from emp_pivot) as src 
pivot 
(max(val) 
For 
salary_component_type in([salary], [bonus], [hike_percent]) ) as ptv_tbl;

select emp_id, 
sum(case when salary_component_type='salary' then val end) as salary, 
sum(case when salary_component_type='bonus' then val end) as bonus, 
sum(case when salary_component_type='hike_percent' then val end) as hike_percent into emp_unpivot
from emp_pivot group by emp_id

select * from emp_unpivot;

select emp_id, 'salary' as  salary_component_type, salary as val from emp_unpivot 
union 
select emp_id, 'bonus' as  salary_component_type, bonus as val from emp_unpivot 
union 
select emp_id, 'hike_percent' as  salary_component_type, hike_percent as val from emp_unpivot
---------------------------------------------------------------
select * from yt_pivot;

select store, [1], [2], [3] from 
(select store, week, xCount from yt_pivot) as src 
pivot 
(max(xCount) 
for 
week in([1], [2], [3])) as pvt_yt_tbl

select store, 
sum(case when week = 1 then xCount end) as "1",
sum(case when week = 2 then xCount end) as "2", 
sum(case when week = 3 then xCount end) as "3" 
from yt_pivot group by store;

--------------------------------------------------------------
select * from pivot_demo;

select year, North, South from
(select year, region, sales from pivot_demo) as src 
pivot 
(max(sales) 
for 
region in (North, South)) as pvt_src

