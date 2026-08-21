-- UTC Online Retail Sales Analysis
create database Online_Retail_db;
select count(*) from online_retail;

-- Total Number of Cancelled Records
select count(*) as cancelled_records
from online_retail
where InvoiceNo like 'C%'; -- 8872

-- Viewing cancelled transactions
select* from online_retail
where InvoiceNo like 'C%'
limit 10;

-- Comparing cancelled vs valid transactions
select case
			when InvoiceNO like 'C%' then 'Cancelled'
            else 'Completed'
		end as Transaction_status,
        count(*) as Total_records
	from online_retail
    group by Transaction_Status;
    
-- Creating Transaction Status
create view online_transactions as select *, case
	when InvoiceNo like 'C%' then 'Cancelled'
    else 'Completed'
    end as Transaction_Status
from online_retail;

-- Cancellation Analysis
-- A. Total no. of cancelled invoices
select * from online_transactions
where transaction_status = 'Cancelled';

-- B. Cancellation Rate
select round(
			count(distinct case 
				when transaction_status = 'Cancelled' then InvoiceNo end) * 100.0
                / count(distinct invoiceno),
                2)
                as cancellation_Rate_Percentage
	From online_transactions;
    
-- C. Most Cancelled Products
select stockcode, `description`, abs(sum(Quantity)) as Cancelled_quantity
from online_transactions
where transaction_status = 'Cancelled'
group by stockcode, `description`
order by Cancelled_Quantity desc
limit 10;

-- D. Countrines with most cancellation
select  country, count(distinct invoiceno) as cancelled_orders
from online_transactions
where Transaction_status = 'Cancelled'
group by country
order by cancelled_orders desc;

-- E. Monthly Cancellation Trend
select date_format(invoicedate, '%Y-%m') as month,
count(distinct invoiceno) as cancelled_orders
from online_transactions
where transaction_status = 'Cancelled'
group by date_format(Invoicedate, '%Y-%m')
order by month;

-- Sales Analysis
-- A. Total orders
SELECT
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_transactions
WHERE Transaction_Status = 'Completed';

-- B. Total Products Sold
SELECT
    SUM(Quantity) AS Total_Products_Sold
FROM online_transactions
WHERE Transaction_Status = 'Completed';

-- C. Unique Customers
SELECT
    COUNT(DISTINCT CustomerID) AS Unique_Customers
FROM online_transactions
WHERE Transaction_Status = 'Completed';

-- Time Based Sales Analysis
--  Monthly Revenue Trend
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month_,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM online_transactions
WHERE Transaction_Status = 'Completed'
GROUP BY Month_
ORDER BY Month_;

-- Monthly Orders
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Monthly_,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_transactions
WHERE Transaction_Status = 'Completed'
GROUP BY Month_
ORDER BY Monthly_;

-- Sales by Day of the week
SELECT
    DAYNAME(InvoiceDate) AS Day_Name,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM online_transactions
WHERE Transaction_Status = 'Completed'
GROUP BY DAYOFWEEK(InvoiceDate), DAYNAME(InvoiceDate)
ORDER BY DAYOFWEEK(InvoiceDate);

-- Product Analysis
-- Top 10 Products by revenue
SELECT
    StockCode,
    Description,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM online_transactions
WHERE Transaction_Status = 'Completed'
GROUP BY StockCode, Description
ORDER BY Revenue DESC
LIMIT 10;

-- Top 10 products by quantity sold
SELECT
    StockCode,
    Description,
    SUM(Quantity) AS Quantity_Sold
FROM online_transactions
WHERE Transaction_Status = 'Completed'
GROUP BY StockCode, Description
ORDER BY Quantity_Sold DESC
LIMIT 10;

-- Products Generating the least Revenue
SELECT
    StockCode,
    Description,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM online_transactions
WHERE Transaction_Status = 'Completed'
GROUP BY StockCode, Description
HAVING Revenue > 0
ORDER BY Revenue ASC
LIMIT 10;

-- Most Frequent Customers
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_transactions
WHERE Transaction_Status = 'Completed'
    AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Total_Orders DESC
LIMIT 10;

-- Average customer spending
SELECT
    ROUND(AVG(Customer_Revenue), 2) AS Average_Customer_Spending
FROM (
    SELECT
        CustomerID,
        SUM(Quantity * UnitPrice) AS Customer_Revenue
    FROM online_transactions
    WHERE Transaction_Status = 'Completed'
        AND CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS customer_sales;

-- Country Analysis
-- Revenue by country
SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM online_transactions
WHERE Transaction_Status = 'Completed'
GROUP BY Country
ORDER BY Revenue DESC;

-- Top countries by orders
SELECT
    Country,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_transactions
WHERE Transaction_Status = 'Completed'
GROUP BY Country
ORDER BY Total_Orders DESC;

-- Average order value by country
SELECT
    Country,
    ROUND(
        SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo),
        2
    ) AS Average_Order_Value
FROM online_transactions
WHERE Transaction_Status = 'Completed'
GROUP BY Country
ORDER BY Average_Order_Value DESC;


