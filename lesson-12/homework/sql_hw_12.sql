--1. Combine two tables
Select 
	Person.firstName,
	Person.lastName,
	Address.city,
	Address.state
From 
	Person
 left Join Address on  Address.personId=Person.personId

 --2.Employees Earning More Than Their Managers
Select 
	Employee.name as Employee
From 
	Employee 
Join Employee manager on Employee.managerId=manager.id
Where Employee.salary>manager.salary


--3.Duplicate Emails
Select  email
From Person
group by email
Having COUNT(email)>1


--4.Delete Duplicate Emails
Delete From Person
Where id not in(Select MIN(id)
From Person 
Group by email)

--5.
Select girls.ParentName as girl_parent
From girls
left join boys on boys.ParentName=girls.ParentName
Where boys.ParentName is Null

--6.
use TSQL2012
SELECT 
    o.custid,
    SUM(o.freight) AS TotalSalesAmount,
    MIN(w.total_weight) AS LeastWeight
FROM Sales.Orders o
CROSS APPLY (
    SELECT SUM(od.qty) AS total_weight
    FROM Sales.OrderDetails od
    WHERE od.orderid = o.orderid
) AS w
WHERE w.total_weight > 50
GROUP BY o.custid;

--7.
SELECT 
    ISNULL(c1.Item, '') AS [Item Cart 1],
    ISNULL(c2.Item, '') AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
    ON c1.Item = c2.Item
	Order by [Item Cart 1] desc

--8.
SELECT 
    MatchID,
    Match,
    Score,
    CASE 
        WHEN TRY_CAST(LEFT(Score, CHARINDEX(':', Score) - 1) AS INT) 
             > TRY_CAST(RIGHT(Score, LEN(Score) - CHARINDEX(':', Score)) AS INT) 
            THEN LEFT(Match, CHARINDEX('-', Match) - 1)
        WHEN TRY_CAST(LEFT(Score, CHARINDEX(':', Score) - 1) AS INT) 
             < TRY_CAST(RIGHT(Score, LEN(Score) - CHARINDEX(':', Score)) AS INT) 
            THEN RIGHT(Match, LEN(Match) - CHARINDEX('-', Match))
        ELSE 'Draw'
    END AS Result
FROM match1;


--9.
Select Customers.name
From Customers
Left join Orders on Customers.id=Orders.customerId
Where Orders.id Is null

--10.
Select Students.student_id, Students.student_name, Subjects.subject_name, COUNT(Examinations.student_id) as attended_exams
from Students
Join Examinations on Students.student_id= Examinations.student_id
Join Subjects on Subjects.subject_name= Examinations.subject_name

Group by Students.student_id, Students.student_name, Subjects.subject_name
