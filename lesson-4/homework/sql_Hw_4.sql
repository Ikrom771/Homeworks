--1.Write a query to select the top 5 employees from the Employees table.
Select top 5 *
from Employees

--2. Use SELECT DISTINCT to select unique ProductName values from the Products table
Select distinct ProductName 
from Products

--3.Write a query that filters the Products table to show products with Price > 100.

Select *
from Products
where Price>100

--4.Select all CustomerName values that start with 'A' using the LIKE operator
Select FirstName
from Customers
Where FirstName Like 'A%'

--5.Order the results of a Products query by Price in ascending order.
Select*
from Products
order by Price asc

--6. Filter for employees with Salary >= 60000 and Department = 'HR'
Select *
from Employees
where Salary >= 60000 and DepartmentName = 'HR'

--7.Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table
Select ISNULL(Email, 'noemail@example.com') as Email
from Employees

--8.Show all products with Price BETWEEN 50 AND 100
Select Price
from Products
where Price between 50 and 100

--9.Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table
Select Distinct Category, ProductName
from Products

--10. After SELECT DISTINCT on two columns (Category and ProductName), order the results by ProductName in descending order
Select Distinct Category, ProductName
from Products
order by ProductName desc

--11. Select the top 10 products from the Products table, ordered by Price DESC
Select top 10 *
From Products
Order by Price desc

--12. Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table
Select coalesce( FirstName, LastName) as Name
From Employees

--13.Select distinct Category and Price from the Products table
Select Category, Price
from Products



--14.Filter the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'
Select *
from Employees
where (Age between 30 and 40) or DepartmentName = 'Marketing'

--15.Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC
Select *
From Employees 
order by Salary desc 
offset 10 rows  fetch next 20 rows only

--16.Display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order
Select *
From Products 
where Price<=1000 and StockQuantity>50
Order by StockQuantity asc

--17.Filter the Products table for ProductName values containing the letter 'e' using LIKE
Select *
from Products
Where ProductName like '%e%'

--18. Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'
Select *
from Employees;
Where DepartmentName In( 'Hr', 'IT', "Finance")

--19.Order the customers by City in ascending and PostalCode in descending order
Select * 
from Customers
order by City asc , PostalCode desc

--20.Write a query that selects the top 10 products with the highest sales, using TOP(10) and ordered by SalesAmount DESC.
Select top 10 *
from Sales
order by SaleAmount desc

--21.Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)
Select isnull(FirstName, '') + ' ' + isnull(LastName, '') as FullName
FROM Employees

--22.Write a query to select the distinct Category, ProductName, 
--and Price for products that are priced above $50, using DISTINCT on three columns.
Select  distinct Category, ProductName, Price
from Products 
where Price>50

--23.Write a query that selects products whose Price is less than 10% of the average price in the Products table. 
--(Do some research on how to find average price of all products)
Select *
from Products
Where Price <  0.1*(Select avg(Price) from Products)

--24.Use WHERE clause to filter for employees 
--whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
Select *
from Employees
where Age<30 and DepartmentName in ('HR', 'IT')

--25.Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
Select *
from Customers
where Email like '%@gmail.com'

--26.Write a query that uses the ALL operator to find employees whose 
--salary is greater than all employees in the 'Sales' department.
Select *
from Employees
where Salary > all (
Select Salary from Employees
where DepartmentName= 'Sales'
  )

--27.Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and CURRENT_DATE. (Search how to get the current date)
SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATEADD(day, -180, GETDATE()) AND GETDATE();

