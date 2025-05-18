--Easy
--1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
Select  LEFT(Name, CHARINDEX(',', Name )-1) as NName,
RIGHT(Name, Len(Name)-CHARINDEX(',', Name ))
From TestMultipleColumns

--2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
Select Strs
From TestPercent
Where Strs like '%[%]%'

--3.In this puzzle you will have to split a string based on dot(.).(Splitter)
Select LEFT(Vals, CHARINDEX('.', Vals)-1) as first_1,
    SUBSTRING(Vals, CHARINDEX('.', Vals) + 1, LEN(Vals)) AS Part2
from Splitter
where CHARINDEX('.', Vals)>0

--4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
Declare @input varchar(max) = '1234ABC123456XYZ1234567890ADS' 

SET @input = REPLACE(@input, '0', 'X');
SET @input = REPLACE(@input, '1', 'X');
SET @input = REPLACE(@input, '2', 'X');
SET @input = REPLACE(@input, '3', 'X');
SET @input = REPLACE(@input, '4', 'X');
SET @input = REPLACE(@input, '5', 'X');
SET @input = REPLACE(@input, '6', 'X');
SET @input = REPLACE(@input, '7', 'X');
SET @input = REPLACE(@input, '8', 'X');
SET @input = REPLACE(@input, '9', 'X');

Select @input

--5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
Select Vals
From testDots
Where LEN(Vals)- LEN(REPLACE(Vals, '.', ''))>2

--6.Write a SQL query to count the spaces present in the string.(CountSpaces)
Select LEN(texts)- LEN(REPLACE(texts, ' ', '')) as count_
From CountSpaces

--7.write a SQL query that finds out employees who earn more than their managers.(Employee)
Select Employee.Name, Employee.Salary as Emp_salary
From Employee
Join Employee m on Employee.ManagerId=M.id	
Where Employee.Salary>m.Salary


--8.Find the employees who have been with the company for more than 10 years, but less than 15 years. 
--Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service 
--(calculated as the number of years between the current date and the hire date).(Employees)
Select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE
From Employees
Where Datediff(YEAR,  HIRE_DATE, GETDATE()) between 10 and 15

--Medium Tasks

--9.Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
DECLARE @input VARCHAR(100) = 'rtcfvty34redt';

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n + 1 <= LEN(@input)
),
Chars AS (
    SELECT 
        SUBSTRING(@input, n, 1) AS ch
    FROM Numbers
)
SELECT
    STRING_AGG(CASE WHEN ch COLLATE Latin1_General_CS_AS BETWEEN 'A' AND 'Z' 
                      OR ch COLLATE Latin1_General_CS_AS BETWEEN 'a' AND 'z' 
                    THEN ch END, '') AS CharactersOnly,
    STRING_AGG(CASE WHEN ch BETWEEN '0' AND '9' THEN ch END, '') AS DigitsOnly
FROM Chars
OPTION (MAXRECURSION 100);


--10.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
Select w1.Id, w1.Temperature, w1.RecordDate
From weather w1
Join weather w2 on  w1.RecordDate=Dateadd(Day, 1, w2.RecordDate)
Where w1.Temperature>w2.Temperature

--11.Write an SQL query that reports the first login date for each player.(Activity)
Select player_id, MIN(event_date)
From Activity
Group by player_id

--12.Your task is to return the third item from that list.(fruits)
Select SUBSTRING(fruit_list, CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1, 
				CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1)
				- CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) - 1 )
From fruits

--13.Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
DECLARE @str NVARCHAR(MAX) = 'sdgfhsdgfhs@121313131';

-- Generate numbers from 1 to LEN(@str)
WITH Numbers AS (
    SELECT TOP (LEN(@str))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects  
)
SELECT 
    n AS Position,
    SUBSTRING(@str, n, 1) AS Character
FROM Numbers;


--14.You are given two tables: p1 and p2. Join these tables on the id column. 
--The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
Select p1.id,p1.code  as P1_code,  p2.code as P2_code, 
case
  WHEN p1.code = 0 THEN p2.code
    ELSE p1.code
  END AS replacement_of_Zero
  From p1
Join p2 on p2.id=p1.id



--15.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)
Select EMPLOYEE_ID, HIRE_DATE,

case 
when DATEDIFF(year,HIRE_DATE, GEtdate())<1  then 'New Hire'
when DATEDIFF(year,HIRE_DATE, GEtdate()) between 1 and 5 then 'Junior'
when DATEDIFF(year,HIRE_DATE, GEtdate()) between 5 and 10 then 'Mid-level'
when DATEDIFF(year,HIRE_DATE, GEtdate()) between 10 and 20 then 'Senior'
else 'Veteran'
end as Experience_level
from Employees

--16.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)

SELECT 
  ID,
  Vals,
  CASE
    WHEN TRY_CAST(LEFT(LTRIM(Vals), PATINDEX('%[^0-9]%', LTRIM(Vals) + 'X') - 1) AS INT) IS NOT NULL
      THEN LEFT(LTRIM(Vals), PATINDEX('%[^0-9]%', LTRIM(Vals) + 'X') - 1)
    ELSE 
      'Not Starting With Digit'
  END AS StartingInteger
FROM GetIntegers;


--Difficult ones

SELECT 
  Vals,
  -- Extract second + first + rest
  CONCAT(
    PARSENAME(REPLACE(Vals, ',', '.'), 2), ',',  -- second
    PARSENAME(REPLACE(Vals, ',', '.'), 3),       -- first
    CASE 
      WHEN LEN(Vals) - LEN(REPLACE(Vals, ',', '')) >= 2 
      THEN ',' + RIGHT(Vals, LEN(Vals) - CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1))
      ELSE ''
    END
  ) AS SwappedVals
FROM MultipleVals
WHERE Vals LIKE '%,%';  -- make sure there are at least 2 values


--18.Write a SQL query that reports the device that is first logged in for each player.(Activity)
SELECT DISTINCT
  player_id,
  FIRST_VALUE(device_id) OVER (
    PARTITION BY player_id
    ORDER BY event_date ASC
  ) AS first_device,
  MIN(event_date) OVER (PARTITION BY player_id) AS first_login_date
FROM Activity
ORDER BY player_id;


--19.You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week.
--For each week, the total sales will be considered 100%, and the percentage sales for each day of the week 
--should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
WITH WeeklyAreaSales AS (
    SELECT
        Area,
        FinancialYear,
        FinancialWeek,
        SUM(ISNULL(SalesLocal,0) + ISNULL(SalesRemote,0)) AS TotalSalesWeek
    FROM WeekPercentagePuzzle
    GROUP BY Area, FinancialYear, FinancialWeek
)

SELECT
    w.Area,
    w.FinancialYear,
    w.FinancialWeek,
    w.[Date],
    w.DayName,
    w.DayOfWeek,
    w.SalesLocal,
    w.SalesRemote,
    -- Calculate total sales per day
    ISNULL(w.SalesLocal,0) + ISNULL(w.SalesRemote,0) AS SalesDay,
    -- Calculate percentage sales per day relative to total week sales for area
    CASE 
        WHEN ws.TotalSalesWeek = 0 THEN 0
        ELSE ROUND(100.0 * (ISNULL(w.SalesLocal,0) + ISNULL(w.SalesRemote,0)) / ws.TotalSalesWeek, 2)
    END AS PercentSalesPerDay
FROM WeekPercentagePuzzle w
JOIN WeeklyAreaSales ws
    ON w.Area = ws.Area
    AND w.FinancialYear = ws.FinancialYear
    AND w.FinancialWeek = ws.FinancialWeek
ORDER BY w.Area, w.FinancialYear, w.FinancialWeek, w.DayOfWeek;



