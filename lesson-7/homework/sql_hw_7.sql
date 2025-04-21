--1.Write a query to find the minimum (MIN) price of a product in the Products table.
Select Min(Price)
from Products

--2.Write a query to find the maximum (MAX) Salary from the Employees table.
Select Max(Salary)
from Employees

--3.Write a query to count the number of rows in the Customers table using COUNT(*).
Select COUNT(*)
from Customers

--4.Write a query to count the number of unique product categories (COUNT(DISTINCT Category)) from the Products table.
Select Count(distinct(Category)) as Num_uniq_prod
From Products

--5.Write a query to find the total (SUM) sales amount for the product with id 7 in the Sales table.
Select Sum(SaleAmount) as TotalAmount
From Sales
Where SaleID=7

--6.Write a query to calculate the average (AVG) age of employees in the Employees table.
Select avg(Age) as Average_age
From Employees

--7.Write a query that uses GROUP BY to count the number of employees in each department.
Select DepartmentName, COUNT(*) as Numb_of_emp
From Employees
Group by DepartmentName

--8.Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
Select  Category, Min(price) as Min_price, Max(Price) as Max_price
From Products
Group by Category

--9.Write a query to calculate the total (SUM) sales per Customer in the Sales table.
Select CustomerID, Sum(SaleAmount) as Total_sales
From Sales
Group by CustomerID

--10.Write a query to use HAVING to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).
Select DepartmentName, Count(EmployeeID) as Numb_empl
From Employees
Group by DepartmentName
Having Count(EmployeeID)>5


--11.Write a query to calculate the total sales and average sales for each product category from the Sales table.
SELECT 
    ProductID,
    SUM(SaleAmount) AS TotalSales, 
    AVG(SaleAmount) AS AverageSales
FROM Sales 
GROUP BY ProductID

--12.Write a query that uses COUNT(columnname) to count the number of employees from the Department HR.
Select DepartmentName, Count(EmployeeID) as Numb_empl
From Employees
Group by DepartmentName
Having DepartmentName='HR'

--13.Write a query that finds the highest (MAX) and lowest (MIN) Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
Select DepartmentName, MIN(Salary) as Min_salary, MAX(Salary) as Max_Salary
From Employees
Group by DepartmentName

--14.Write a query that uses GROUP BY to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
Select DepartmentName, AVG(Salary) as Avg_salary
From Employees
Group by DepartmentName

--15.Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
Select DepartmentName, COUNT(*) as numb_empl, AVG(Salary) as avg_salary
From Employees
group by DepartmentName

--16.Write a query that uses HAVING to filter product categories with an average price greater than 400.
Select Category, AVG(Price) as Average_Price
From Products
Group by Category
Having  AVG(Price)>400


--17.Write a query that calculates the total sales for each year in the Sales table, and use GROUP BY to group them.
Select Year(SaleDate) as Sales_year, SUM(SaleAmount) as Total_Sales
From Sales
Group by YEAR(SaleDate)


--18.Write a query that uses COUNT to show the number of customers who placed at least 3 orders.
Select CustomerID, Count (CustomerID) as Numb_customer, COUNT(OrderID) as Numb_orders
From Orders
Group by CustomerID
Having COUNT(OrderID)>=3

--19.Write a query that applies the HAVING clause to filter out Departments with total salary expenses greater than 500,000.(DeptID is enough, if you don't have DeptName).
Select DepartmentName, SUM(Salary) as Total_Salary 
From Employees
Group by DepartmentName
Having SUM(Salary)>500000

--20.Write a query that shows the average (AVG) sales for each product category, and then uses HAVING to filter categories with an average sales amount greater than 200.
SELECT 
    p.Category,
    AVG(s.SaleAmount) AS AvgSale
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category
HAVING AVG(s.SaleAmount) > 200;

--21.Write a query to calculate the total (SUM) sales for each Customer, then filter the results using HAVING to include only Customers with total sales over 1500.
--We can use JOIN function
Select p.FirstName + p.Lastname as Customer_Name , p.CustomerID, SUM(s.SaleAmount) as Total_Sales
From Sales s
Join Customers p On s.CustomerID=p.CustomerID
Group by p.FirstName,  p.Lastname, p.CustomerID
Having SUM(s.SaleAmount)>1500
--Or we can use simple query without customer name
SELECT 
    CustomerID,
    SUM(SaleAmount) AS TotalSales
FROM Sales 
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

--22.Write a query to find the total (SUM) and average (AVG) salary of employees grouped by department, and use HAVING to include only departments with an average salary greater than 65000.
Select DepartmentName ,SUM(Salary) as Total_salary,  AVG(Salary) as Average_sales
From Employees
group by DepartmentName
Having AVG(Salary)>65000

--23.Write a query that finds the maximum (MAX) and minimum (MIN) order value for each customer, and then applies HAVING to exclude customers with an order value less than 50.
Select CustomerID, MAX(TotalAmount) as Max_order, MIN(TotalAmount) as min_order
from Orders
Group by CustomerID
Having min(TotalAmount)>50

--24.Write a query that calculates the total sales (SUM) and counts distinct products sold in each month, and then applies HAVING to filter the months with more than 8 products sold.
Select FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,  Sum(SaleAmount) as Total_Sales,  count( distinct ProductID)
from Sales
Group by FORMAT(SaleDate, 'yyyy-MM')
Having count( distinct  ProductID)>8

--25.Write a query to find the MIN and MAX order quantity per Year. From orders table. (Do some research)
Select YEAR(OrderDate), MIN(Quantity) as min_order_qty, MAX(Quantity) as Max_order_qty
From Orders
group by YEAR(OrderDate)
