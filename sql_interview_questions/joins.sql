select * from tab;
create table a(id number(10));
insert all
into a values ('1')
into a values ('')
into a values ('2')
into a values ('3')
into a values ('')
select * from dual;
drop table a;
select * from a;
truncate table a;

create table b(id number(10));
insert all
into b values ('1')
into b values ('1')
into b values ('2')
into b values ('3')
into b values ('2')
select * from dual;
select * from b;
truncate table b;
select * from a e inner join b f on e.id=f.id;
select * from a e inner join b f on e.id<>f.id;
select * from a e left outer join b f on e.id=f.id;
select * from a e right outer join b f on e.id=f.id;
select * from a e full outer join b f on e.id=f.id;
select * from a e cross join b f;
delete from b where id is null;

select * from a
not in
select * from b;

create table student (id number(2),name varchar2(10),sub1 number(3), sub2 number(3), sub3 number(3),
state varchar2(10));
desc student;
insert all
into student values ('1', 'Ajay', '50', '100', '60','Karnataka')
into student values ('2', 'Ravi', '100', '', '','Andra') 
into student values ('3', 'Raju', '70', '80', '','Tamil nadu')
into student values ('4', 'shankar', '90', '', '', 'Mumbai')
into student values ('5', 'selvi', '100', '40', '','UP')
select * from dual;

select id, name, (sub1+nvl(sub2,0)+nvl(sub3,0)) total from student;
select * from student;
truncate table student;
drop table student;

select state, count(id) count from student group by state;
select state, count(id) over(partition by state) count from student;

commit;

