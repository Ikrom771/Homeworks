

--1. Create a temporary table named MonthlySales to store the total quantity sold 
--and total revenue for each product in the current month.

Select s.ProductID, sum(s.Quantity) as total_qty, Sum(s.Quantity*p.Price) as total_rev
From Sales s
join Products p on p.ProductID=s.ProductID
  where MONTH(s.SaleDate) = MONTH(GETDATE()) AND
    YEAR(s.SaleDate) = YEAR(GETDATE())
Group by s.ProductID

--2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
create view vw_ProductSalesSummary as
Select p.ProductID, p.Category, p.ProductName, SUM(s.Quantity) as total_qty
From Products p 
Join Sales s on s.ProductID=p.ProductID
group by p.ProductID, p.Category,  p.ProductName

go
Select*
from vw_ProductSalesSummary

--3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
--Return: total revenue for the given product ID


Create function fn_GetTotalRevenueForProduct(@ProductID INT)
returns decimal

as
begin
 declare @TotalRevenue Decimal

 Select @TotalRevenue = SUM(Sales.Quantity* Products.Price)
 From Sales
 Join Products on Products.ProductID=Sales.ProductID

 Where Sales.ProductID=@ProductID

 Return isnull(@TotalRevenue, 0);
 End

 Select dbo.fn_GetTotalRevenueForProduct(1) as Total_rev

 --4.Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
--Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.


create function dbo.fn_GetSalesByCategory(@Category VARCHAR(50))
returns 
 @Result table (
 ProductName varchar(max),
 TotalQuantity  int,
 TotalRevenue decimal(10,2)
 )

 as begin
 insert into @Result
 Select 
 p.ProductName,
 SUM(s.Quantity) as TotalQuantity, 
 SUM(p.Price*s.Quantity) as TotalRevenue
 from Products p
 Join Sales s on s.ProductID=p.ProductID
 Where p.Category=@Category
 Group by p.ProductName

 return;
 end

 Select * from dbo.fn_GetSalesByCategory('Clothing') 
 

 --5. You have to create a function that get one argument 
 --as input from user and the function should return 'Yes' if the input number is a prime number and 
 --'No' otherwise. You can start it like this:

 Create function dbo.fn_IsPrime (@Number INT)
Returns varchar(max)
as
 begin
 DECLARE @i INT = 2;
    DECLARE @IsPrime BIT = 1;
	 IF @Number < 2
        SET @IsPrime = 0;

    WHILE @i <= SQRT(@Number) AND @IsPrime = 1
    BEGIN
        IF @Number % @i = 0
            SET @IsPrime = 0;
        SET @i = @i + 1;
    END

    RETURN CASE WHEN @IsPrime = 1 THEN 'Yes' ELSE 'No' END;
END;

select dbo.fn_IsPrime (7)

--6 Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
--The function should return a table with a single column:

CREATE FUNCTION fn_GetNumbersBetween
(
    @Start INT,
    @End INT
)
RETURNS TABLE
AS
RETURN
(
    WITH Nums AS
    (
        SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Number
        FROM sys.all_columns a
        CROSS JOIN sys.all_columns b
    )
    SELECT
        Number
    FROM
        Nums
    WHERE
        Number >= @Start AND Number <= @End
);
GO

Select Number
From dbo.fn_GetNumbersBetween (1,10)

--7. Write a SQL query to return the Nth highest distinct salary from the Employee table. 
--If there are fewer than N distinct salaries, return NULL.

Create table Employee(id int , salary decimal(10,2))
Insert into Employee values(1, 150), (2, 280), (3, 234), (4, 540)

IF OBJECT_ID('fn_get_nth_salary') IS NOT NULL
    DROP FUNCTION fn_get_nth_salary;
GO

CREATE FUNCTION fn_get_nth_salary (@number INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        salary AS NthHighestSalary
    FROM 
    (
        SELECT 
            salary,
            DENSE_RANK() OVER (ORDER BY salary DESC) AS RankNum
        FROM 
            Employee
    ) AS RankedSalaries
    WHERE 
        RankedSalaries.RankNum = @number
);
GO
Select *
from fn_get_nth_salary (7)

--8. Write a SQL query to find the person who has the most friends.
--Return: Their id, The total number of friends they have

CREATE TABLE RequestAccepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date) VALUES
(1, 2, '2016/06/03'),
(1, 3, '2016/06/08'),
(3, 4, '2016/06/09'),
(4, 5, '2016/06/10');

-- The actual solution query
SELECT TOP 1 id, COUNT(*) AS num_friends
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY num_friends DESC;


--9. Create a View for Customer Order Summary.
Create view vw_CustomerOrderSummary
as
Select 
c.customer_id, 
c.name, 
count(o.order_id) as total_orders, 
isnull(SUM(o.amount), 0) as Total_amount,
MAX(o.order_date)  as last_order_date

from Customers c

 left join Orders o on o.customer_id=c.customer_id

Group by c.name, c.customer_id

Select *
from vw_CustomerOrderSummary

--10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.


WITH FillGaps AS (
  SELECT 
    RowNumber,
    TestCase,
    MAX(TestCase) OVER (ORDER BY RowNumber 
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS FilledTestCase
  FROM Gaps
)
SELECT 
  RowNumber, 
  FilledTestCase AS Workflow
FROM FillGaps
ORDER BY RowNumber;
