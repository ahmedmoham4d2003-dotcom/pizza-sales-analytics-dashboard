select *
from ps

-- 1.	ما إجمالي الإيرادات الكلية من جميع المبيعات؟

select round(sum(total_price),2)  'Total Revenue'
from ps

-- 2.	ما أكثر أنواع البيتزا مبيعًا من حيث عدد الطلبات؟=

create view top_10_Pizza_sales as

select Top 10 pizza_name, count(order_id) 'Total Orders'
from ps 
group by pizza_name
order by count(order_id) DESC

-- 3.	ما أقل أنواع البيتزا مبيعًا؟=

create view Lowest_5_Pizza_saless as

select Top 5 pizza_name, count(order_id) 'Total Orders'
from ps 
group by pizza_name
order by count(order_id) ASC

-- 4.	ما الفئة (Category) التي حققت أعلى إيرادات؟

create view Category_With_Highest_Revenues as

select pizza_category, round(sum(total_price),2) 'Total Revenue'
from ps 
group by pizza_category
order by sum(total_price) DESC

-- 5.	ما الحجم (Size) الأكثر طلبًا؟

create view Sizes_With_Highest_Quantity as

select pizza_size, sum(quantity) 'Number of Pizza'
from ps 
group by pizza_size
order by sum(quantity) DESC

-- 6.	ما الحجم الذي حقق أعلى Revenue؟

create view Sizes_With_Highest_Revenue as

select  pizza_size , round(sum(total_price),2) 'Total Revenue'
from ps
group by pizza_size
order by sum(total_price) DESC

--7.	ما متوسط قيمة الطلب الواحد؟

create view Average_Per_Order as

select round(AVG(Total_Sales),2) 'Average Per Order'
from(
select order_id , sum(total_price) 'Total_Sales'
from ps
group by order_id) r

-- 8.	ما أكثر الأيام تحقيقًا للمبيعات؟

create view high_days_in_Sales as
select order_date , round(sum(total_price),2) 'Total Revenue'
from ps
group by order_date
order by sum(total_price) DESC

-- 9.	ما أقل الأيام تحقيقًا للمبيعات؟؟ 

select order_date , round(sum(total_price),2) 'Total Revenue'
from ps
group by order_date
order by sum(total_price) 

-- 10.	ما أكثر ساعات اليوم نشاطًا في الطلبات؟

create view The_Most_Crowded_Hours as

select DATEPART(HOUR,order_time) 'Hours' , count(order_id) 'Number of Orders'
from ps
group by DATEPART(HOUR,order_time)
order by count(order_id) DESC

-- 11.	ما أنواع البيتزا التي سعرها أعلى من متوسط الأسعار؟
create view pizza_name_price_higher_than_average as
select distinct pizza_name, unit_price
from ps
where unit_price > (select AVG(unit_price) from ps)

-- 12.	ما الطلبات التي تجاوزت متوسط قيمة الطلبات؟

create view orders_higher_than_avg as
select order_id , total_price
from ps
where total_price > (select avg(total_price) from ps)


-- 13.	ما الفئات التي تجاوزت مبيعاتها 5000؟

create view Categories_sales_over_5000 as

select pizza_category , round(sum(total_price),2) 'Total Sales'
from ps
group by pizza_category 
having sum(total_price) > 5000

-- 14.	ما إجمالي المبيعات شهريًا؟

create view Total_Sales_over_Months as

select month(order_date) 'month' ,round(sum(total_price),2) 'Total Sales'
from ps
group by month(order_date)
order by month(order_date)

-- 15.	ما نسبة مساهمة كل Category في إجمالي الإيرادات؟

create view Sales_Percentage_Each_category as

select pizza_category ,round(sum(total_price) * 100 / (select sum(total_price) from ps ),2) 'percentage'
from ps 
group by pizza_category
order by percentage

-- 16.	ما أكثر أنواع البيتزا التي تحتوي على Chicken طلبًا؟
create view pizza_chicken as
select pizza_name , count(order_id) 'Number of Orders'
from ps
where pizza_ingredients like '%Chicken%'
group by pizza_name
order by count(order_id) DESC


-- 17.	ما متوسط عدد القطع المباعة لكل Order؟

create view Average_Quantity_Per_Order as

select avg(Total_Quantity) 'average quantity per order'
from (
  select sum(quantity) 'Total_Quantity', order_id
  from ps
  group by order_id) q


-- 18.	ما عدد الطلبات لكل يوم من أيام الأسبوع؟

create view Total_Orders_Per_Day as

select DATENAME(WEEKDAY, order_date) AS day_name ,count(distinct order_id) 'Number of Orders'
from ps
group by DATENAME(WEEKDAY, order_date) , DATEPART(WEEKDAY, order_date)
order by DATEPART(WEEKDAY, order_date)


-- 19.	ما أعلى 5 أنواع بيتزا من حيث الإيرادات؟

create view Top_5_Pizza_In_Sales as

select top 5 pizza_name , sum(total_price) 'Revenue'
from ps
group by pizza_name
order by sum(total_price) DESC

-- 20.	ما أقل 5 أنواع بيتزا من حيث الإيرادات؟

create view Lowest_5_Pizza_In_Sales as

select top 5 pizza_name , round(sum(total_price),2) 'Revenue'
from ps
group by pizza_name
order by sum(total_price) ASC


----------------------------------------------------------------------------------------------------------
create view Total_Revenue as 
select round(sum(total_price),2) 'Total Revenue'
from ps

create view Total_Orders as 
select count(distinct order_id) 'Total Orders'
from ps

create view Total_Quantity as 
select sum(quantity) 'Total Quantity'
from ps

create view Average_Price_Per_Order as 
select round(sum(total_price) / count(distinct order_id),2) 'Avg Price per Order'
from ps







---------------------------------------------------------------------------------------------------------------
create view Category_Per_Revenue as
select  pizza_category, round(sum(total_price),2) 'Total Revenue'
from ps 
group by pizza_category
order by sum(total_price) DESC

create view Size_Per_Revenues as
select pizza_size, round(sum(total_price),2) 'Total Revenue'
from ps 
group by pizza_size
order by sum(total_price) DESC



create view Quantity_Per_Category as
select  pizza_category, count(order_id) 'Total Orders'
from ps 
group by pizza_category
order by count(order_id) DESC



create view Pizza_name_Sales as
select pizza_name ,round(sum(total_price),2) 'Total Revenue', sum(quantity) 'Number of Pizza'
from ps
group by pizza_name


create view Pizza_Name as
select distinct pizza_name 
from ps


create view Pizza_Category as
select distinct pizza_category 
from ps

create view Date_Month as
select distinct month(order_date) as month
from ps

create view hour_time as
select DATEPART(HOUR,order_time) 'Hours' , count(distinct order_id) 'Number of Orders'
from ps
group by DATEPART(HOUR,order_time)
order by count(distinct order_id) DESC