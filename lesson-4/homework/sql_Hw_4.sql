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

