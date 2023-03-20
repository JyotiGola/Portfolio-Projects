---Find customers who have never ordered
select name from users 
where user_id not in(select distinct user_id 
                           from orders where user_id is not null)

--- Average Price/dish

select f_name as Dish, avg(price) as [Average Price] 
from food f  join  menu m on f.f_id = m.f_id
group by f.f_name;

---Find the top restaurant in terms of the number of orders for a given month
select Top 1  o.r_id, r.r_name,count(o.r_id) as [Order Frequency] from orders o join restaurants r on o.r_id = r.r_id
where month(date) = 5
group by o.r_id, r.r_name 
order by o.r_id desc 


---restaurants with monthly sales greater than x;
select r_name, sum(amount) as [Monthly sales ]
from restaurants  r join orders o on o.r_id = r.r_id
where month(date)=6
group by r_name
having sum(amount) > 500
order by sum(amount) desc

---Show all orders with order details for a particular customer in a particular date range
select o.order_id,r.r_name, f.f_name from orders o  
join order_details  od on o.order_id = od.order_id 
join restaurants r on o.r_id = r.r_id
join users u on u.user_id = o.user_id
join food f on od.f_id = f.f_id
where date>'2022-06-10' and date<'2022-07-10'  and name = 'Ankit'

---- Find restraurants with max repeated customers
select Top 1   t.r_id,r.r_name, count(t.r_id) as  [Loyal Customers] from 
(select r_id, user_id, count( r_id)  as 'Visits' from orders
group by r_id, user_id
Having count(r_id) > 1) t
join restaurants r on r.r_id = t.r_id
group by t.r_id, r.r_name
Order by [Loyal Customers] desc 

----- Month over month revenue growth of swiggy

	--with sales as
	--(
	--select month(date) as  _month_, sum(amount) as  revenue
	--from orders
	--where month(date) is not null
	--group by month(date)
	--)

	--select _month_, ((revenue-prev)/prev)*100 from(
	--select _month_, revenue,
	--lag(revenue,1) over(order by revenue) as prev from sales)			

			
	SELECT 
    month(date) AS _month_, 
    sum(amount) AS revenue, 
    (sum(amount) - lag(sum(amount), 1) 
	OVER (ORDER BY month(date))) / lag(sum(amount), 1) OVER (ORDER BY month(date)) * 100 AS revenue_growth
	FROM orders
	GROUP BY month(date)


	----favorite food of each customer
	

	with temp AS (
	select  o.user_id, od.f_id, count(*) as freq from orders o
	join order_details od on o.order_id=od.order_id
	group by o.user_id, od.f_id
	) 
	select u.name,f.f_name,t1.freq from temp t1 
	join users u on u.user_id = t1.user_id
	join food f on f.f_id=t1.f_id
	where t1.freq = (
	select max(freq) from temp t2 where t2.user_id = t1.user_id);



	


