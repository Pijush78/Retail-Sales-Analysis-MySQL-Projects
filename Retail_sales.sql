create database retail_sales;
use retail_sales;

CREATE TABLE retail (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender CHAR(50),
    age INT,
    category CHAR(50),
    quantiy INT,
    price_per_unit DOUBLE,
    cogs DOUBLE,
    total_sale DOUBLE
);

select * from retail limit 10;
desc retail;

select count(*) from retail;

select count(distinct(customer_id)) from retail;

select count(distinct(transactions_id)) from retail;

select distinct(category) from retail;

SELECT count(*) FROM retail
WHERE
    sale_date IS NULL 
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
        
SET SQL_SAFE_UPDATES = 0;

DELETE FROM retail
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
alter table retail
rename column quantiy to quantity;

alter table retail
rename column cogs to cost_per_unit;

alter table retail
add column total_cost double after cost_per_unit;

update retail
set total_cost = quantity * cost_per_unit;

SELECT * FROM retail;

desc retail;

# 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail where sale_date = '2022-11-05';

# 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail
WHERE
    category = 'Clothing' AND quantity >= 4
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
    
# 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT 
    category, SUM(total_sale) AS total_sale_category
FROM
    retail
GROUP BY category
ORDER BY total_sale_category DESC;

# 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT 
    category, round(AVG(age)) AS average_age
FROM
    retail
WHERE
    category = 'Beauty';
    
# 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT 
    *
FROM
    retail
WHERE
    total_sale >= 1000;

# 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT 
    category,
    gender,
    COUNT(transactions_id) AS total_number_tran
FROM
    retail
GROUP BY gender , category;

# 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select
	date_format(sale_date, '%Y') as year_name,
    date_format(sale_date, '%M') as month_name,
    avg(total_sale) as avg_sale,
    dense_rank() over (partition by date_format(sale_date, '%Y') order by avg(total_sale)) as rank_
    from retail 
    group by year_name, month_name;
    
# 8. Write a SQL query to find the top 5 customers based on the highest total sales:
SELECT 
    customer_id, SUM(total_sale) AS total_Sales
FROM
    retail
GROUP BY customer_id
ORDER BY total_sales DESC limit 5;

# 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
    category, COUNT(DISTINCT (customer_id)) AS unique_customers
FROM
    retail
GROUP BY category;

# 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select
	case
		when hour(sale_time) <12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
	end as shifts,
    count(*) as order_number
	from
		retail
			group by shifts;


;
select * from retail;

    










