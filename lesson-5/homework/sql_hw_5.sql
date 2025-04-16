--1.Write a query that uses an alias to rename the ProductName column as Name in the Products table.
Select ProductName as Name
from  Products

--2.Write a query that uses an alias to rename the Customers table as Client for easier reference.
Select *	
from Customers as Client

--3.Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
Select ProductName
from Products
union
Select ProductName from Products_Discounted

--4.Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
Select* from Products
intersect
Select*  from Products_Discounted

--5.Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.
Select distinct FirstName, LastName, Country
from Customers

--6.Write a query that uses CASE to create a conditional column that 
--displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
Select Price , ProductName,
Case
	when Price>1000 then  'High'
	else 'Low'

	end as Price_category
	From Products


--7.Use IIF to create a column that shows 'Yes' if Stock > 100, and 
--'No' otherwise (Products_Discounted table, StockQuantity column).
Select ProductName, 

IIF( StockQuantity > 100, 'Yes', 'No') as product_available

From Products_Discounted

--8.Use UNION to combine results from two queries that select ProductName 
--from Products and ProductName from OutOfStock tables.
Select ProductName
From Products
Union
Select ProductName
From OutofStock

--9.Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
Select *  
From Products
Except
Select*
From Products

--10.Create a conditional column using IIF that shows 
--'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
Select  Price, ProductName,

IIF( Price < 1000, 'affordable', 'Expensive') as Price_Category

From Products

--11.Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
Select*, 
from Employees

where age<25 or Salary>60000


--12.Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5
update Employees
set Salary = Salary * 1.10
where DepartmentName = 'HR' OR EmployeeID = 5;

--13.Use INTERSECT to show products that are common between Products and Products_Discounted tables.
Select ProductName
From Products
intersect
Select ProductName
from Products

--14.Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
SELECT *,
  CASE 
    WHEN SaleAmount > 500 THEN 'Top Tier'
    WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
    ELSE 'Low Tier'
  END AS Tier
FROM Sales

--15.Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Invoices table.
SELECT CustomerID
FROM Orders
EXCEPT
SELECT CustomerID
FROM Invoices;

--16.Write a query that uses a CASE statement to determine the discount percentage based on 
--the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. 
--The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%

Select CustomerID, Quantity, 
case 
when Quantity=1 then '3%'
when Quantity>1 and Quantity<=3 then '5%'
else '7%'
end as Discount_percentage
from Orders
