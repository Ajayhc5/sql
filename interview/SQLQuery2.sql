create table dbo.customer (
CustomerID int NOT null primary key,
CustomerFirstName varchar(50) NOT null,
CustomerLastName varchar(50) NOT null,
CustomerAddress varchar(50) NOT null,
CustomerSuburb varchar(50) null,
CustomerCity varchar(50) NOT null,
CustomerPostCode char(4) null,
CustomerPhoneNumber char(12) null,
);
create table dbo.inventory (
InventoryID tinyint NOT null primary key,
InventoryName varchar(50) NOT null,
InventoryDescription varchar(255) null,
);
create table dbo.employee (
EmployeeID tinyint NOT null primary key,
EmployeeFirstName varchar(50) NOT null,
EmployeeLastName varchar(50) NOT null,
EmployeeExtension char(4) null,
);
create table dbo.sale (
SaleID tinyint not null primary key,
CustomerID int not null references customer(CustomerID),
InventoryID tinyint not null references Inventory(InventoryID),
EmployeeID tinyint not null references Employee(EmployeeID),
SaleDate date not null,
SaleQuantity int not null,
SaleUnitPrice smallmoney not null
);



SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics ED
JOIN EmployeeSalary ES
 ON ED.EmployeeID = ES.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1
SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics ED
JOIN EmployeeSalary ES
 ON ED.EmployeeID = ES.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)




create table customer 
(
customerid int identity(1,1) primary key,
customernumber int not null unique check (customernumber>0),
lastname varchar(30) not null,
firstname varchar(30) not null,
areacode int default 71000,
address varchar(50),
country varchar(50) default 'Malaysia'
)

insert into customer values
(100,'Fang Ying','Sham','418999','sdadasfdfd',default),
(200,'Mei Mei','Tan',default,'adssdsadsd','Thailand'),
(300,'Albert','John',default,'dfdsfsdf',default)


select * from customer


alter table customer
add phonenumber varchar(20)
update customer set phonenumber='1234545346' where
customerid=1
update customer set phonenumber='45554654' where
customerid=2




