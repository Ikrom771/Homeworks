--1.You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
Select CONCAT(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) AS FullName
From Employees
where EMPLOYEE_ID=100

--2.Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
Update Employees
set	PHONE_NUMBER= STUFF(PHONE_NUMBER, CHARINDEX('124',PHONE_NUMBER), 3, '999')
where PHONE_NUMBER like '%124%'

--3.That displays the first name and the length of the first name for all employees whose name starts with the 
--letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
Select FIRST_NAME, LEN(FIRST_NAME) AS	length_of_name
from Employees
Where LEFT(FIRST_NAME, 1) in ('A', 'J', 'M')
Order by FIRST_NAME asc

--4.Write an SQL query to find the total salary for each manager ID.(Employees table)
Select MANAGER_ID, SUM(SALARY) as Total_Salary
From Employees
Group by MANAGER_ID

--5. Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 
--for each row in the TestMax table
Select Year1, MAX(Max1) as High_Max1, MAX(Max2) as High_Max2, MAX(Max3) as High_Max3
From TestMax
Group by Year1

SELECT 
    Year1,
   GREATEST(Max1, Max2, Max3)  AS [Highest Value]
FROM TestMax;

--6.Find me odd numbered movies and description is not boring.(cinema)
Select id, movie, description 
From cinema
Where id%2=1 and description!= 'boring'

--7.You have to sort data based on the Id but Id with 0 should always be the last row. 
--Now the question is can you do that with a single order by column.(SingleOrder)


SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;


--8.Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. 
--If all columns are null, return null.(person)
Select*, coalesce (ssn, passportid,itin) as first_null
From person


--Medium Tasks

--9.Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
 Select SUBSTRING(FullName, 1, CHARINDEX(' ', FullName)-1) as FirstName,
 Substring(FullName, CHARINDEX(' ', FullName)+1, CHARINDEX(' ',FullName, CHARINDEX(' ', FullName)+1)-CHARINDEX(' ', FullName)-1
 
 
 ) As MiddleName,
 Substring(
 FullName, Len(FullName)-Charindex(' ', reverse(FullName))+2, Len(FullName)
 ) as LastName
 From Students

--10.For every customer that had a delivery to California, 
--provide a result set of the customer orders that were delivered to Texas. (Orders Table)

SELECT *
FROM Orders
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
    WHERE DeliveryState = 'CA'
)
AND DeliveryState = 'TX';

--11.Write an SQL statement that can group concatenate the following values.(DMLTable)

SELECT STRING_AGG(String, ' ') 
       WITHIN GROUP (ORDER BY SequenceNumber) AS FullQuery
FROM DMLTable;

--12.Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.

Select CONCAT(FIRST_NAME, LAST_NAME) AS	FullName
From Employees
Where LEN(CONCAT(FIRST_NAME, LAST_NAME))- LEN(REPLACE(COncat(FIRST_NAME,LAST_NAME), 'a', ''))>=3


--13.The total number of employees in each department and the percentage of those employees 
--who have been with the company for more than 3 years(Employees)
Select DEPARTMENT_ID, COUNT(EMPLOYEE_ID) AS TOTAL_nuMBER,
COUNT(CASE 
              WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 
         END) * 100.0 / COUNT(EMPLOYEE_ID) AS PERCENT_OVER_3_YEARS
From Employees
gROUP BY DEPARTMENT_ID

--14.Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
sELECT SpacemanID,
Case 
When JobDescription= 'Technician' Then 'Least experienced' 
when JobDescription= 'Astrogator' then  'Most Experienced'
else 'Middle experience' End as Experience
From Personal


--Difficult tasks
--15.Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from 
--the given string 'tf56sd#%OqH' into separate columns.
DECLARE @input VARCHAR(100) = 'tf56sd#%OqH';

-- Split the input string into individual characters
WITH Numbers AS (
    SELECT TOP (LEN(@input))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
),
Chars AS (
    SELECT 
        SUBSTRING(@input, n, 1) AS char
    FROM Numbers
)
SELECT
    STRING_AGG(CASE 
        WHEN char COLLATE Latin1_General_CS_AS BETWEEN 'a' AND 'z' THEN char 
        END, '') AS Lowercase,

    STRING_AGG(CASE 
        WHEN char COLLATE Latin1_General_CS_AS BETWEEN 'A' AND 'Z' THEN char 
        END, '') AS Uppercase,

    STRING_AGG(CASE 
        WHEN char BETWEEN '0' AND '9' THEN char 
        END, '') AS Numbers,

    STRING_AGG(CASE 
        WHEN char COLLATE Latin1_General_CS_AS NOT BETWEEN 'a' AND 'z' AND
             char COLLATE Latin1_General_CS_AS NOT BETWEEN 'A' AND 'Z' AND
             char NOT BETWEEN '0' AND '9' THEN char 
        END, '') AS Others
FROM Chars;


--16.Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)
SELECT 
    StudentID,
    FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID) AS RunningTotal
FROM 
    Students;

--17. You are given the following table, which contains a VARCHAR column that contains mathematical equations. 
--Sum the equations and provide the answers in the output.(Equations)


DECLARE @expr NVARCHAR(200), @result FLOAT, @sql NVARCHAR(MAX);


DECLARE cur CURSOR FOR
SELECT Equation FROM Equations;

OPEN cur;
FETCH NEXT FROM cur INTO @expr;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Build dynamic SQL to evaluate expression
    SET @sql = N'SELECT @res = ' + @expr;

    BEGIN TRY
        EXEC sp_executesql 
            @sql, 
            N'@res FLOAT OUTPUT', 
            @res = @result OUTPUT;

        -- Update the corresponding row
        UPDATE Equations 
        SET TotalSum = @result
        WHERE Equation = @expr;

    END TRY
    BEGIN CATCH
        PRINT 'Invalid expression: ' + @expr;
    END CATCH;

    FETCH NEXT FROM cur INTO @expr;
END

CLOSE cur;
DEALLOCATE cur;

SELECT *
FROM Equations;


--17.Given the following dataset, find the students that share the same birthday.(Student Table)
Select *
From Student
Where Birthday in (Select Birthday From Student Group by Birthday Having COUNT(*)>1  )
Order by Birthday desc


--18.You have a table with two players (Player A and Player B) and their scores. 
--If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. 
--Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
SELECT 
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerA 
        ELSE PlayerB 
    END AS Player1,
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerB 
        ELSE PlayerA 
    END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerA 
        ELSE PlayerB 
    END,
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerB 
        ELSE PlayerA 
    END
ORDER BY Player1, Player2;
