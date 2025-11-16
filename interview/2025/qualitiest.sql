-- Create the table
CREATE TABLE StudentMarksRaw (
    StudentName VARCHAR(50),
    Marks VARCHAR(100)  -- Store comma-separated marks as text
);

-- Insert values
INSERT INTO StudentMarksRaw (StudentName, Marks) VALUES
('Amit', '30,130,20,4'),
('Sukruta', '100,20,30'),
('Sonali', '140,10');


select StudentName, len(Marks)-len(replace(marks, ',' ,''))+1 Marks_Count from StudentMarksRaw


CREATE TABLE StudentContacts (
    ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    PHONE_NO VARCHAR(20)
);


INSERT INTO StudentContacts (ID, NAME, PHONE_NO) VALUES
(1, 'Priya Verma', '9845297170'),
(2, 'Praveen Shinde', '785429856'),
(3, 'Sachin Dubhe', '9925378601'),
(4, 'Lavanya Sharma', '9610945');


select substring(name, 1, charindex(',', name)-1) as Frist_name, 
substring(name, charindex(',', name)+1, len(name)-charindex(',', name)) as Last_name, 
right('0000000000'+ cast(phone_no as varchar), 10) PHONE_NO from
(select replace(name, ' ', ',') as name, phone_no from StudentContacts) er


select left(name, charindex(' ', name)-1) as Frist_name, right( name, len(name)-charindex(' ', name)+1) as Last_name from StudentContacts;
select NAME, substring(name, 1, CHARINDEX(' ', name)-1) as fst_nm, substring(name, CHARINDEX(' ', name)+1, len(name)- CHARINDEX(' ', name)) as lst_nm, 
right('0000000000'+ cast(PHONE_NO as varchar), 10) PHONE_NO from StudentContacts;



--- ITC INFOTECH 
CREATE TABLE itc_Customers (
    customer_id CHAR(1) PRIMARY KEY,
    customer_name VARCHAR(50),
    Age INT,
    Gender CHAR(1)
);

INSERT INTO itc_Customers (customer_id, customer_name, Age, Gender) VALUES
('A', 'Steven', 45, 'M'),
('B', 'Valli', 34, 'F'),
('C', 'Neena', 27, 'F'),
('D', 'Lex', 33, 'F');

CREATE TABLE itc_Transactions (
    Tran_id INT PRIMARY KEY,
    customer_id CHAR(1) FOREIGN KEY REFERENCES itc_Customers(customer_id),
    Tran_date DATE,
    tran_type CHAR(1), -- 'C' for credit, 'D' for debit (assumed)
    Amount DECIMAL(10,2)
);

INSERT INTO itc_Transactions (Tran_id, customer_id, Tran_date, tran_type, Amount) VALUES
(101, 'A', '2023-10-12', 'C', 450),
(102, 'B', '2023-10-13', 'D', 5000),
(103, 'A', '2023-10-14', 'D', 4590),
(104, 'A', '2023-10-16', 'C', 4050),
(105, 'C', '2023-10-18', 'C', 100),
(106, 'B', '2023-10-23', 'D', 5);

--write a query to get "Number of male customer and number of female" customer who are all doing transaction
select * from itc_Customers;
select * from itc_Transactions;

select  a.Gender, COUNT(DISTINCT a.customer_id) AS number_of_customers 
from itc_Customers a left join itc_Transactions b on a.customer_id=b.customer_id group by a.Gender;


--select customer_id, sum(case when Gender='M' then 1 else 0 end) male_cnt, sum(case when Gender='F' then 1 else 0 end) female_cnt from (
--select a.customer_id, a.customer_name, a.Age, a.Gender, b.Tran_id, b.Tran_date, b.tran_type, b.Amount 
--from itc_Customers a left join itc_Transactions b on a.customer_id=b.customer_id where b.Tran_date is not null)er group by customer_id;

--select (customer_id) , count(customer_id) over(partition by gender, customer_id) total_amt from
--(select a.customer_id, a.Gender from itc_Customers a inner join itc_Transactions b on a.customer_id=b.customer_id)er


-- merkle

create table ers (id int);

insert into ers values (1), (1), (1), (1), (null), (null)

create table grs(ids int);

insert into grs values (1), (1), (1), (null) 

select * from ers e inner join grs g on e.id=g.ids; --12
select * from ers e left join grs f on e.id=f.ids;  --14
select * from ers e right join grs f on e.id=f.ids; --13
select * from ers e full outer join grs f on e.id=f.ids; --15
select * from ers e cross join grs f ; --24

select * from emp where SAL in(select sal from emp group by sal having count(*)>1);



-- EPAM
CREATE TABLE epam_CustomerPurchase (
    customer_id INT,
    customer_name VARCHAR(100),
    purchase_date DATE
);

-- Retained: Active in April and May
INSERT INTO epam_CustomerPurchase VALUES
(1, 'Alice', '2025-04-10'),
(1, 'Alice', '2025-05-05'),

(2, 'Bob', '2025-04-15'),
(2, 'Bob', '2025-05-07'),

-- New: Only active in May
(3, 'Charlie', '2025-05-20'),
(4, 'David', '2025-05-12'),

-- Old/Lost: Only active in April
(5, 'Eve', '2025-04-09'),
(6, 'Frank', '2025-04-27');

select * from epam_CustomerPurchase;

select customer_id, customer_name, case when prv=1 and crr=1 then 'retained' when prv=0 and crr=1 then 'new' when prv=1 and crr=0 then 'old' else 'other' end status_cr from (
select customer_id, customer_name, max(case when format(purchase_date, 'yyyy-MM')=FORMAT(dateadd(MONTH, -1, getdate()), 'yyyy-MM') then 1 else 0 end) prv, 
max(case when format(purchase_date, 'yyyy-MM')=FORMAT(getdate(), 'yyyy-MM') then 1 else 0 end) crr from epam_CustomerPurchase group by customer_id, customer_name)er;





CREATE TABLE tech_tbl_a (
    ID INT);

CREATE TABLE tech_tbl_b (
    ID INT);

INSERT INTO tech_tbl_a VALUES (1), (2), (3)

INSERT INTO tech_tbl_b VALUES (1), (2), (3)

select a.id, b.id from tech_tbl_a a cross join tech_tbl_b b where a.ID<>b.ID order by  a.ID;