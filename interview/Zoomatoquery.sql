CREATE TABLE ZomatoOrderDetails (
    OrderID INT PRIMARY KEY,
    DishName VARCHAR(50),
    RestaurantID VARCHAR(10),
    Quantity INT,
    OrderDate DATE
);

INSERT INTO ZomatoOrderDetails (OrderID, DishName, RestaurantID, Quantity, OrderDate) VALUES
(1, 'Burger', 'R101', 2, '2025-01-01'),
(2, 'Pasta', 'R101', 1, '2025-01-02'),
(3, 'Burger', 'R101', 1, '2025-01-03'),
(4, 'Pizza', 'R102', 3, '2025-01-01'),
(5, 'Burger', 'R101', 4, '2025-01-04'),
(6, 'Pasta', 'R101', 2, '2025-01-05');



--1_ Write an SQL query to find the top 5 most-ordered dishes from a given restaurant.

select * from ZomatoOrderDetails;

with cte as(
select *, sum(qty) over(partition by RestaurantID) tot_qty from (select distinct DishName, RestaurantID, sum(Quantity) over(partition by DishName, RestaurantID order by DishName, RestaurantID)qty  from ZomatoOrderDetails) er)
select DishName, RestaurantID, qty from cte where tot_qty>5


--2. Write a Query to Retrieve All Orders Placed in the Last 30 Days for a Specific User 

select * from Zomato_Orders where CONVERT(DATE, OrderDate, 120)  >= (select format(DATEADD(DAY, -30, max(OrderDate)), 'yyyy-MM-dd') from Zomato_Orders);

select * from Zomato_Orders where OrderDate > format(DATEADD(DAY, -30, '2025-01-14'), 'yyyy-MM-dd')

select (DATEADD(DAY, -30, '2025-01-14')) dt, format((DATEADD(DAY, -30, '2025-01-14')), 'yyyy-MM-dd')ft

SELECT * FROM Zomato_Orders WHERE UserID = 'U123' AND OrderDate >= DATEADD(DAY, -30, '2025-01-16');

select * from Zomato_Orders where cast(OrderDate as varchar) >='2024-12-15'


select * from emp where Hiredate >(select format(DATEADD(DAY, -30, max(Hiredate)), 'yyyy-MM-dd') from emp);
select * from emp  where format(Hiredate, 'yyyy')='1983'

select format(DATEADD(DAY, -30, max(Hiredate)), 'yyyy-MM-dd') from emp

select getdate()