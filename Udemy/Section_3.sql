create table tblSecond (myNumbers int)
go

select * from [dbo].[tblFirst];

insert into tblSecond (myNumbers) values (234), (867), (456), (156), (478)
delete from [dbo].[tblSecond];
truncate table [dbo].[tblSecond]; 
drop table [dbo].[tblSecond]; 

select * from [dbo].[tblSecond];

