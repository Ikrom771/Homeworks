
--Easy Tasks
--1.Create a numbers table using a recursive query from 1 to 1000.
with numbers as (
select 1 as n
union all

select n+1
from numbers
Where n<1000
)

select *
from numbers
option(MAxrecursion 1000)

--2.Write a query to find the total sales per employee using a derived table.(Sales, Employees)
Select Employees.EmployeeID, Employees.FirstName, s.Total_sales 
from Employees
Join (
Select EmployeeID, SUM(SalesAmount) as Total_sales
From Sales
Group by EmployeeID) s on s.EmployeeID=Employees.EmployeeID

--3.Create a CTE to find the average salary of employees.(Employees)
with avg_salary as(
select AVG(Salary) as average_salary
from Employees
)
Select average_salary
from avg_salary

--4.Write a query using a derived table to find the highest sales for each product.(Sales, Products)
Select Products.ProductID, Products.ProductName, s.Highest_sale
from Products
Join (
Select  ProductID, MAX(SalesAmount)  as Highest_sale
from Sales
Group by ProductID
) s on Products.ProductID=s.ProductID


--5.Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
with numbers as (
select 1 as n
union all

select n*2
from numbers
Where n*2<1000000
)

select *
from numbers
option(MAxrecursion 0)

--6.Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
with great_sales as (
Select EmployeeID, COUNT(SalesID) as Num_sales
from Sales
Group by EmployeeID
having COUNT(SalesID)>5
)
Select Employees.FirstName, Employees.LastName, great_sales.Num_sales
From Employees
Join great_sales on great_sales.EmployeeID=Employees.EmployeeID

--7.Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
with good_sales as (
Select ProductID,SalesAmount
from Sales
Where SalesAmount>500
)

Select Products.ProductName, good_sales.SalesAmount
From Products
Join good_sales on good_sales.ProductID=Products.ProductID
Order by good_sales.SalesAmount desc


--8.Create a CTE to find employees with salaries above the average salary.(Employees)
with salary_above_avg as (
Select  AVG(Salary) as avg_salary
From Employees
)

Select e.EmployeeID, e.FirstName, e.LastName, salary_above_avg.avg_salary , e.Salary
from Employees e
Join salary_above_avg on 1=1
Where e.Salary>salary_above_avg.avg_salary


--Medium Tasks
--1.Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
Select Top 5 Employees.EmployeeID, Employees.FirstName, Employees.LastName, S.numb_orders
From Employees
Join (
Select EmployeeID, COUNT(SalesID) as numb_orders
From Sales
Group by EmployeeID
)  S on S.EmployeeID=Employees.EmployeeID
Order by S.numb_orders desc


--2.Write a query using a derived table to find the sales per product category.(Sales, Products)
Select  P.CategoryID ,COUNT(SalesID) as num_sales
From Sales
Join (Select CategoryID, ProductID
From Products) P on P.ProductID=Sales.ProductID
Group by P.CategoryID

--3.Write a script to return the factorial of each value next to it.(Numbers1)
-- Recursive CTE to calculate factorials for each number in Numbers1
WITH FactorialCTE AS (
    -- Anchor: start with 1! = 1
    SELECT 
        Number, 
        1 AS Counter,
        1 AS Factorial
    FROM Numbers1

    UNION ALL

    -- Recursive step
    SELECT 
        f.Number,
        f.Counter + 1,
        f.Factorial * (f.Counter + 1)
    FROM FactorialCTE f
    WHERE f.Counter + 1 <= f.Number
)

-- Final output: max factorial per number
SELECT 
    Number,
    MAX(Factorial) AS Factorial
FROM FactorialCTE
GROUP BY Number
ORDER BY Number
OPTION (MAXRECURSION 100);


select *
from Numbers1
option(MAxrecursion 9)

--4.This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
with split_string as (

Select 
1 as Position,
SUBSTRING(String, 1, 1) as character,
String 
from Example

Union all

Select 
	Position+1,
	SUBSTRING(String, Position+1, 1),
	String
From split_string
where Position+1<=LEN(string)

)
Select Position, Character
From split_string
Order by character
Option (Maxrecursion 100)

--5.Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
with Sum_sales_prev as (
Select SUM(SalesAmount) as total_sales_prev , ProductID
from Sales
Where datediff(month, Saledate, Getdate())=1
group by ProductID

),

 Sum_sales_cur as (
Select SUM(SalesAmount) as total_sales_curr , ProductID
from Sales
Where datediff(month, Saledate, Getdate())=0
group by ProductID

)

SELECT 
    COALESCE(curr.ProductID, prev.ProductID) AS ProductID,
    ISNULL(curr.total_sales_curr, 0) AS current_month_sales,
    ISNULL(prev.total_sales_prev, 0) AS previous_month_sales,
    ISNULL(curr.total_sales_curr, 0) - ISNULL(prev.total_sales_prev, 0) AS sales_difference
FROM Sum_sales_cur curr
FULL OUTER JOIN Sum_sales_prev prev ON curr.ProductID = prev.ProductID;

--6.Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
Select Employees.EmployeeID, Employees.FirstName, s.Quarter, 
    s.total_sales
From Employees
Join (
Select  EmployeeID, DATEPART(QUARTER, SaleDate) AS Quarter,
        YEAR(SaleDate) AS SaleYear,
Sum(SalesAmount) as total_Sales
From Sales
Group by EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
) s on s.EmployeeID=Employees.EmployeeID

Where s.total_Sales> 45000 
ORDER BY Employees.EmployeeID, s.SaleYear, s.Quarter;

--Difficult Tasks
--1.This script uses recursion to calculate Fibonacci numbers
WITH Fibonacci AS (
    SELECT 0 AS n, 0 AS fib1, 1 AS fib2  -- starting with 0 and 1
    UNION ALL
    SELECT n + 1, fib2, fib1 + fib2
    FROM Fibonacci
    WHERE n < 20
)
SELECT 
    n, 
    fib1 AS FibonacciNumber
FROM Fibonacci
OPTION (MAXRECURSION 100);

--2.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT *
FROM FindSameCharacters
WHERE 
    Vals IS NOT NULL
    AND len(Vals) > 1
    AND LEN(REPLACE(Vals, LEFT(Vals, 1), '')) = 0;

--3.Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
DECLARE @n INT = 6;

WITH NumbersCTE AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(MAX)) AS sequence
    UNION ALL
    SELECT num + 1, sequence + CAST(num + 1 AS VARCHAR)
    FROM NumbersCTE
    WHERE num + 1 <= @n
)
SELECT sequence
FROM NumbersCTE
OPTION (MAXRECURSION 100);
--4.Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)

Select Employees.EmployeeID, Employees.FirstName, s.total_sales
From Employees

Join(
Select Top 5 EmployeeID, SUM(SalesAmount) as total_sales
From Sales
WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
Group by EmployeeID
Order by total_sales desc
) s on s.EmployeeID=Employees.EmployeeID


--5.Write a T-SQL query to remove the duplicate integer values present in the string column. 
--Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

WITH ExtractDigits AS (
    SELECT 
        r.PawanName,
        r.Pawan_slug_name,
        SUBSTRING(r.Pawan_slug_name, v.number, 1) AS digit
    FROM RemoveDuplicateIntsFromNames r
    JOIN master..spt_values v 
        ON v.number BETWEEN 1 AND LEN(r.Pawan_slug_name)
    WHERE v.type = 'P'
      AND SUBSTRING(r.Pawan_slug_name, v.number, 1) LIKE '[0-9]'
),
CountDigits AS (
    SELECT 
        PawanName,
        digit,
        COUNT(*) AS cnt
    FROM ExtractDigits
    GROUP BY PawanName, digit
    HAVING COUNT(*) > 1  -- keep only digits appearing more than once
),
CleanedDigits AS (
    SELECT 
        PawanName,
        STRING_AGG(digit, '') AS Cleaned
    FROM CountDigits
    GROUP BY PawanName
)
SELECT 
    r.PawanName,
    r.Pawan_slug_name,
    ISNULL(c.Cleaned, '') AS Digits_Cleaned
FROM RemoveDuplicateIntsFromNames r
LEFT JOIN CleanedDigits c ON r.PawanName = c.PawanName;
