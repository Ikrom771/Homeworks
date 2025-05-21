

--1. You must provide a report of all distributors and their sales by region. 
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. 
--Assume there is at least one sale for each region


with unique_dist as(
Select distinct Distributor
from RegionSales
),

unique_reg as (
Select distinct	Region
from RegionSales
),

All_comb as (
Select unique_dist.Distributor,  unique_reg.Region
from unique_dist
cross join unique_reg 
)

Select All_comb.Distributor, All_comb.Region, ISNULL(RegionSales.Sales,0) as Sales
from All_comb
Left Join RegionSales on  RegionSales.Distributor=All_comb.Distributor and RegionSales.Region=All_comb.Region
Order by All_comb.Region, All_comb.Distributor

--2. Find managers with at least five direct reports

Select  m.name as manag_name
from Employee e

join Employee m on m.id=e.managerId
group by m.name
Having COUNT(e.id)>=5

--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

Select p.product_name, Sum(o.unit) as num_units
from Products p

Join Orders o on o.product_id=p.product_id
where MONTH(o.order_date)= 2    --February
group by p.product_name
having Sum(o.unit)>=100

--4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
with most_order as (
Select CustomerID, Vendor, count([COUNT]) as max_orders,
ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY COUNT([Count]) DESC) AS rn

From Orders
Group by CustomerID, Vendor
)

Select CustomerID, Vendor
from most_order
where rn=1

--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 
--'This number is prime' else eturn 'This number is not prime'
CREATE FUNCTION dbo.IsPrime (@Check_Prime INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Result NVARCHAR(50);
    DECLARE @Divisor INT;

    -- Handle edge cases
    IF @Check_Prime <= 1
    BEGIN
        SET @Result = 'This number is not prime';
        RETURN @Result;
    END

    -- Check for prime
    SET @Divisor = 2;

    WHILE @Divisor * @Divisor <= @Check_Prime
    BEGIN
        IF @Check_Prime % @Divisor = 0
        BEGIN
            SET @Result = 'This number is not prime';
            RETURN @Result;
        END
        SET @Divisor = @Divisor + 1;
    END

    SET @Result = 'This number is prime';
    RETURN @Result;
END;

DECLARE @Check_Prime INT = 91;
SELECT dbo.IsPrime(@Check_Prime) AS Result;


--6. Write an SQL query to return the number of locations,in which location most signals sent, 
--and total number of signal for each device from the given table.


WITH SignalCounts AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount
    FROM 
        Device
    GROUP BY 
        Device_id, Locations
),
RankedLocations AS (
    SELECT 
        Device_id,
        Locations,
        SignalCount,
        ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY SignalCount DESC) AS rn
    FROM 
        SignalCounts
),
MostSignals AS (
    SELECT 
        Device_id,
        Locations AS MostSignalsLocation,
        SignalCount AS MostSignalsCount
    FROM 
        RankedLocations
    WHERE 
        rn = 1
),
TotalSignals AS (
    SELECT 
        Device_id,
        COUNT(*) AS TotalSignals,
        COUNT(DISTINCT Locations) AS NumberOfLocations
    FROM 
        Device
    GROUP BY 
        Device_id
)
SELECT 
    ts.Device_id,
    ms.MostSignalsLocation,
    ms.MostSignalsCount,
    ts.TotalSignals,
    ts.NumberOfLocations
FROM 
    TotalSignals ts
JOIN 
    MostSignals ms ON ts.Device_id = ms.Device_id
ORDER BY 
    ts.Device_id;

--7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. 
--Return EmpID, EmpName,Salary in your output.
with avg_salary as (
	Select DeptID, AVG(Salary) as averageSalary
	From Employee
	Group by DeptID
)

Select e.EmpID, e.EmpName, e.Salary
From Employee e
Join avg_salary a on a.DeptID=e.DeptID
Where e.Salary>a.averageSalary

--8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. 
--If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. 
--Calculate the total winnings for today’s drawing.
WITH WinningNumbers AS (
    SELECT 25 AS Number
    UNION ALL SELECT 45
    UNION ALL SELECT 78
),

-- Step 2: Count how many winning numbers each ticket matched
MatchesPerTicket AS (
    SELECT 
        t.[Ticket ID],
        COUNT(*) AS MatchingCount
    FROM Tickets t
    INNER JOIN WinningNumbers w
        ON t.Number = w.Number
    GROUP BY t.[Ticket ID]
)

-- Step 3: Calculate winnings
SELECT 
    SUM(
        CASE 
            WHEN MatchingCount = 3 THEN 100
            WHEN MatchingCount BETWEEN 1 AND 2 THEN 10
            ELSE 0
        END
    ) AS TotalWinnings
FROM MatchesPerTicket;

--9. The Spending table keeps the logs of the spendings history of users that make purchases
--from an online shopping website which has a desktop and a mobile devices.
--Write an SQL query to find the total number of users and the total amount spent using mobile only, 
--desktop only and both mobile and desktop together for each date.

WITH UsageType AS (
  SELECT 
    User_id,
    Spend_date,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS used_mobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS used_desktop,
    SUM(Amount) AS total_amount
  FROM Spending
  GROUP BY User_id, Spend_date
),

LabeledUsage AS (
  SELECT
    Spend_date,
    CASE 
      WHEN used_mobile = 1 AND used_desktop = 0 THEN 'Mobile Only'
      WHEN used_mobile = 0 AND used_desktop = 1 THEN 'Desktop Only'
      WHEN used_mobile = 1 AND used_desktop = 1 THEN 'Both'
    END AS usage_type,
    total_amount
  FROM UsageType
),

AggregatedUsage AS (
  SELECT 
    Spend_date,
    usage_type,
    COUNT(*) AS total_users,
    SUM(total_amount) AS total_amount
  FROM LabeledUsage
  GROUP BY Spend_date, usage_type
),
 DateTypeCombinations AS (
  SELECT DISTINCT Spend_date FROM Spending
),
UsageTypes AS (
  SELECT 'Mobile Only' AS usage_type
  UNION ALL SELECT 'Desktop Only'
  UNION ALL SELECT 'Both'
),
AllCombos AS (
  SELECT d.Spend_date, u.usage_type
  FROM DateTypeCombinations d
  CROSS JOIN UsageTypes u
)

-- Step 5: LEFT JOIN to fill missing rows with 0
SELECT 
  a.Spend_date,
  a.usage_type,
  ISNULL(b.total_users, 0) AS total_users,
  ISNULL(b.total_amount, 0) AS total_amount
FROM AllCombos a
LEFT JOIN AggregatedUsage b
  ON a.Spend_date = b.Spend_date AND a.usage_type = b.usage_type
ORDER BY a.Spend_date, a.usage_type;

--10. Write an SQL Statement to de-group the following data.
-- Step 1: Get max quantity
DECLARE @max_quantity INT;
SELECT @max_quantity = MAX(Quantity) FROM Grouped;

-- Step 2: Recursive CTE to generate numbers 1 to max quantity
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n + 1 <= @max_quantity
)

-- Step 3: Join to explode the data
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 1000);
