
--1.Using Products table, find the total number of products available in each category.
Select Category, SUM(StockQuantity) as Total_numb_avl
From Products
Group by Category

--2.Using Products table, get the average price of products in the 'Electronics' category.
SELECT Category, AVG(Price) AS Avg_Price
FROM Products
WHERE Category = 'Electronics'
GROUP BY Category;

--3.Using Customers table, list all customers from cities that start with 'L'.
Select  FirstName + LastName as FullName, City
from Customers
Where City Like 'L%'

--4.Using Products table, get all product names that end with 'er'.
Select *
From Products
Where ProductName Like '%er'

--5.Using Customers table, list all customers from countries ending in 'A'.
Select *
From Customers
Where Country Like '%A'

--6.Using Products table, show the highest price among all products.
Select top 1*
From Products
Order By  Price desc

--7.Using Products table, use IIF to label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
Select *,
iif(StockQuantity<30 , 'Low Stock', 'Sufficient')
from Products


--8.Using Customers table, find the total number of customers in each country.
Select Country, Sum(CustomerID) as Total_number
From Customers
Group by Country 
Order by SUM(CustomerID) desc

--9.Using Orders table, find the minimum and maximum quantity ordered.
Select OrderID, MIN(Quantity) as Min_order, MAX(Quantity) as Max_order
From Orders
Group by OrderID

--10.Using Orders and Invoices tables, list customer IDs who placed orders in 2023 (using EXCEPT) to find those who did not have invoices.
SELECT DISTINCT CustomerID
FROM Orders
WHERE YEAR(OrderDate) = 2023

EXCEPT

SELECT DISTINCT CustomerID
FROM Invoices;

--11.Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
Select ProductName
From Products

union all
Select ProductName
From Products_Discounted

--12.Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
Select ProductName
From Products

union 
Select ProductName
From Products_Discounted

--13.Using Orders table, find the average order amount by year.
Select YEAR(OrderDate) as Order_Year, AVG(TotalAmount) as Avg_order_amount
From Orders
Group by YEAR(OrderDate)
--14.Using Products table, use CASE to group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
Select ProductName, 
Case
when Price<100 then 'Low'
When Price>=100 and Price<500 then 'Mid'
Else 'High' end as Price_Group
From Products

--15.Using Customers table, list all unique cities where customers live, sorted alphabetically.
Select Distinct City
From Customers
Order by City asc

--16.Using Sales table, find total sales per product Id.
Select  ProductID, SUM(SaleAmount) as Total_sales
from Sales
Group by ProductID


--17.Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
Select ProductName
From Products
Where ProductName LIKE '%oo%'

--18.Using Products and Products_Discounted tables, compare product IDs using INTERSECT.
Select ProductID
From Products

Intersect
Select ProductID
From Products_Discounted

--19.Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
Select Top 3 CustomerID, SUM(TotalAmount) AS TotalSpent
From Invoices
Group by CustomerID
Order by TotalSpent desc


--20.Find product ID and productname that are present in Products but not in Products_Discounted.
Select ProductID, ProductName
From Products

Except

Select ProductID, ProductName
From Products_Discounted 

--21.Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
SELECT 
    p.ProductName,
    COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s
    ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY TimesSold DESC;

--22.Using Orders table, find top 5 products (by ProductID) with the highest order quantities.
SELECT TOP 5 
    ProductID, 
    SUM(Quantity) AS TotalQuantity
FROM Orders
GROUP BY ProductID
ORDER BY TotalQuantity DESC
