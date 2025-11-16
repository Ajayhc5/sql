select * from emp
insert into emp values ('7369', 'SMITH', 'CLERK', '7902', '800', NULL, '20', '1980-12-17');
select JOB from EMP group by JOB having count(*)>4

update emp set COMM=null where
ENAME ='KING'


create table SplitNameID (
IdEname varchar(50)
);

insert into SplitNameID values (1);
insert into SplitNameID values ('Ajay');
insert into SplitNameID values (2);
insert into SplitNameID values ('DEEPU');
insert into SplitNameID values (3);
insert into SplitNameID values ('SANJU');
insert into SplitNameID values (4);
insert into SplitNameID values ('MURTHY');

drop table EMP_dupl

create table ers (id int);

insert into ers values (1)
insert into ers values (null)
insert into ers values (2)
insert into ers values (3)
insert into ers values (null)
insert into ers values (5)
insert into ers values (6)

drop table ers;
select * from a;
truncate table b;

create table grs(ids int);

insert into grs values (1)
insert into grs values (1)
insert into grs values (null)
insert into grs values (3)
insert into grs values (2)
insert into grs values (null)
insert into grs values (5)
insert into grs values (null)
insert into grs values (4)

select * from b;
truncate table b;


select * from ers e inner join grs g on e.id=g.ids;
select * from ers e left join grs f on e.id=f.ids;
select * from ers e right join grs f on e.id=f.ids;
select * from ers e full outer join grs f on e.id=f.ids;


CREATE TABLE EMPDATA
(
EMPNAME VARCHAR(25),
GENDER VARCHAR(6),
DEPT VARCHAR(20),
CONTACTNO BIGINT NOT NULL,
CITY VARCHAR(15)
);

INSERT INTO EMPDATA
VALUES ('VISHAL','MALE','SALES',9193458625,'GHAZIABAD'),
('DIVYA','FEMALE','MANAGER',7352158944,'BAREILLY'),
('REKHA','FEMALE','IT',7830246946,'KOLKATA'),
('RAHUL','MALE','MARKETING',9635688441,'MEERUT'),
('SANJAY','MALE','SALES',9149335694,'MORADABAD'),
('ROHAN','MALE','MANAGER',7352158944,'BENGALURU'),
('RAJSHREE','FEMALE','SALES',9193458625,'VODODARA'),
('AMAN','MALE','IT',78359941265,'RAMPUR'),
('RAKESH','MALE','MARKETING',9645956441,'BOKARO'),
('MOHINI','FEMALE','SALES',9147844694,'Delhi') 
 SELECT * FROM EMPDATA;


CREATE TABLE OriginalData (
    ID INT NULL, -- ID column is nullable due to missing values
    City VARCHAR(50),
    Gender CHAR(1)
);

INSERT INTO OriginalData (ID, City, Gender)
VALUES
    (1, 'Delhi', 'F'),
    (2, 'Delhi', 'F'),
    (3, 'Chennai', 'M'),
    (4, 'Chennai', 'F'),
    (5, 'Chennai', 'F'),
    (6, 'Bangalore', 'M'),
    (7, 'Bangalore', 'M'),
    (8, 'Pune', 'M');

truncate table OriginalData;


CREATE TABLE IdTable (
    ID INT
);

INSERT INTO IdTable (ID)
VALUES
    (100),
    (2020),
    (3010);


-- Create the table
CREATE TABLE ColorsTable (
    Name1 VARCHAR(50),
    Name2 VARCHAR(50),
    Name3 VARCHAR(50)
);

-- Insert the data into the table
INSERT INTO ColorsTable (Name1, Name2, Name3)
VALUES 
    ('yellow', 'pink', 'red'),
    ('black', 'yellow', 'white'),
    ('purple', 'orange', 'blue');


CREATE TABLE JobSkills (
    ROW_ID INT PRIMARY KEY,
    JOB_ROLE VARCHAR(50),
    SKILLS VARCHAR(50)
);

INSERT INTO JobSkills (ROW_ID, JOB_ROLE, SKILLS)
VALUES
(1, 'Data Engineer', 'SQL'),
(2, NULL, 'Python'),
(3, NULL, 'AWS'),
(4, NULL, 'Snowflake'),
(5, NULL, 'Apache Spark'),
(6, 'Web Developer', 'Java'),
(7, NULL, 'HTML'),
(8, NULL, 'CSS'),
(9, 'Data Scientist', 'Python'),
(10, NULL, 'Machine Learning'),
(11, NULL, 'Deep Learning'),
(12, NULL, 'Tableau');



create table erss (id int);

insert into erss values (1)
insert into erss values (1)
insert into erss values (1)
insert into erss values (1)
insert into erss values (2)
insert into erss values (2)
insert into erss values (3)
insert into erss values (4)

drop table grss;
--select * from a;
--truncate table b;

create table grss(ids int);

insert into grss values (1)
insert into grss values (1)
insert into grss values (1)
insert into grss values (1)
insert into grss values (2)
insert into grss values (2)
insert into grss values (3)
insert into grss values (4)
insert into grss values (6)


select * from erss e inner join grss g on e.id=g.ids;
select * from erss e left join grss f on e.id=f.ids;
select * from erss e right join grss f on e.id=f.ids;
select * from erss e full outer join grss f on e.id=f.ids;

create table emp_pivot (
emp_id int,
salary_component_type varchar(20),
val int
);
insert into emp_pivot
values (1,'salary',10000),(1,'bonus',5000),(1,'hike_percent',10)
, (2,'salary',15000),(2,'bonus',7000),(2,'hike_percent',8)
, (3,'salary',12000),(3,'bonus',6000),(3,'hike_percent',7);



CREATE TABLE yt_pivot 
(
  [Store] int, 
  [Week] int, 
  [xCount] int
);
--drop table yt;    
INSERT INTO yt_pivot
(
  [Store], 
  [Week], [xCount]
)
VALUES
    (102, 1, 96),
    (101, 1, 138),
    (105, 1, 37),
    (109, 1, 59),
    (101, 2, 282),
    (102, 2, 212),
    (105, 2, 78),
    (109, 2, 97),
    (105, 3, 60),
    (102, 3, 123),
    (101, 3, 220),
    (109, 3, 87);


CREATE TABLE pivot_demo    
(    
   Region varchar(45),    
   Year int,    
   Sales int    
)    

INSERT INTO pivot_demo  
VALUES ('North', 2010, 72500),  
('South', 2010, 60500),  
('South', 2010, 52000),  
('North', 2011, 45000),  
('South', 2011, 82500),    
('North', 2011, 35600),  
('South', 2012, 32500),   
('North', 2010, 20500);   


CREATE TABLE cards_hidenumbersby_star    
(        
   card_number int   
)   


INSERT INTO cards_hidenumbersby_star  
VALUES (12345678),  
(90876543),  
(10234567)

drop table cards_hidenumbersby_star;


CREATE TABLE Email_substr (
    ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    EMAIL VARCHAR(100),
    MOB BIGINT,
    SAL INT,
    GENDER CHAR(1)
);


INSERT INTO Email_substr (ID, NAME, EMAIL, MOB, SAL, GENDER)
VALUES 
(1, 'SONALIKA', 'SONALIKA.BM.5@GMAIL.COM', 102030405, 5000, 'F'),
(2, 'CHIRAG', 'CHIRAG.BM.52@GMAIL.COM', 102030401, 5000, 'M'),
(3, 'SHREYA', 'SHREYA.BM.52@GMAIL.COM', 102030402, 5000, 'F'),
(4, 'CHETHAN', 'CHETHAN.NS.5@GMAIL.COM', 102030403, 5000, 'M'),
(5, 'NISCHITHA', 'NISCHITHA.TR.4@GMAIL.COM', 102030404, 5000, 'F'),
(6, 'SHARU', 'SHARU.TJ.4@GMAIL.COM', 102030406, 5000, 'F');



create table delete_duplicate (ids int);

insert into delete_duplicate values (1), (2), (2), (3), (4)

drop table delete_duplicate;


select * from delete_duplicate;


SELECT ids, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as row_num
INTO #dulp_del
FROM delete_duplicate;


drop table #dulp_del;

select * from #dulp_del;

CREATE TABLE CONTACT_INFO (
    Identifier INT PRIMARY KEY,
    Surname NVARCHAR(50),
    Given_Name NVARCHAR(50),
    Middle_Initial NVARCHAR(10),
    Suffix NVARCHAR(10),
    Primary_Street_Number NVARCHAR(20),
    Primary_Street_Name NVARCHAR(100),
    City NVARCHAR(50),
    State NVARCHAR(10),
    Zipcode NVARCHAR(10),
    Primary_Street_Number_Prev NVARCHAR(20),
    Primary_Street_Name_Prev NVARCHAR(100),
    City_Prev NVARCHAR(50),
    State_Prev NVARCHAR(10),
    Zipcode_Prev NVARCHAR(10),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    BirthMonth INT
);

INSERT INTO CONTACT_INFO VALUES
(1, 'Kattubadi', 'Sreenivasulu', '', '', '9/566', 'Satya sai nagar', 'Banglore', 'KA', '560045', '23/566', 'Bala nagar', 'Anantapur', 'AP', '515671', 'Kattubadi@gmail.com', '8765656553', 199801),
(2, 'Hari', 'Prasad', '', '', '9/567', 'Shanti nagar', 'Banglore', 'KA', '560045', '23/567', 'Bala nagar', 'Anantapur', 'AP', '515672', 'Kattubadi@gmail.com', '8765656554', 199502),
(3, 'Kattubadi', 'Ram', '', '', '9/568', 'Tirumala nagar', 'Banglore', 'KA', '560045', '23/568', 'Bala nagar', 'Anantapur', 'AP', '515673', 'Kattubadi@gmail.com', '8765656555', 199203),
(4, 'Raheem', 'Ahammed', '', '', '9/569', 'Madhapur', 'Banglore', 'KA', '560045', '23/569', 'Bala nagar', 'Anantapur', 'AP', '515674', 'Kattubadi@gmail.com', '8765656556', 198904),
(5, 'mahesh', 'Kumar', '', '', '9/570', 'Miyapur', 'Banglore', 'KA', '560045', '23/570', 'Bala nagar', 'Anantapur', 'AP', '515675', 'Kattubadi@gmail.com', '8765656557', 198605),
(6, 'Hari', 'test', '', '', '9/571', 'Somasekar nagar', 'Banglore', 'KA', '560045', '23/571', 'Bala nagar', 'Anantapur', 'AP', '515676', 'Kattubadi@gmail.com', '8765656558', 198306),
(7, 'ramana', 'Ramesh', '', '', '9/572', 'Bola nagar', 'Banglore', 'KA', '560045', '23/572', 'Bala nagar', 'Anantapur', 'AP', '515677', 'Kattubadi@gmail.com', '8765656559', 198007),
(8, 'Ranganath', 'V', '', '', '9/573', 'rr nagar', 'Banglore', 'KA', '560045', '23/573', 'Bala nagar', 'Anantapur', 'AP', '515678', 'Kattubadi@gmail.com', '8765656560', 197708),
(9, 'Bhole', 'Hamad', '', '', '9/574', 'SS nagar', 'Banglore', 'KA', '560045', '23/574', 'Bala nagar', 'Anantapur', 'AP', '515679', 'Kattubadi@gmail.com', '8765656561', 197409),
(10, 'Arun', 'LK', '', '', '9/575', 'Maruti nagar', 'Banglore', 'KA', '560045', '23/575', 'Bala nagar', 'Anantapur', 'AP', '515680', 'Kattubadi@gmail.com', '8765656562', 197110),
(11, 'Arun', 'LK', '', '', '9/575', 'Maruti nagar', 'Banglore', 'KA', '560045', '23/575', 'Bala nagar', 'Anantapur', 'AP', '515680', 'Kattubadi@gmail.com', '8765656562', 197110);

select * from CONTACT_INFO;