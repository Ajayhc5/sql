--finding new and repeat customers .using SQL. In this video we will learn following concepts:
--how to approach complex query step by step
--how to use CASE WHEN with SUM
--how to use common table expression (CTE)

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)




select  order_date,  sum(case when order_date=fst_vt_dt then 1 else 0 end) visitor, sum(case when order_date!=fst_vt_dt then 1 else 0 end) rep_visitor from (
select order_id, customer_id, order_date, order_amount, min(order_date) over(partition by customer_id) fst_vt_dt  from customer_orders ) er group by order_date order by order_id



