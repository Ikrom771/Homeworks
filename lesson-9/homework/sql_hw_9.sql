--1.Using Products, Suppliers table List all combinations of product names and supplier names.
SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s

--2.Using Departments, Employees table Get all combinations of departments and employees.
Select d.DepartmentName, e.[Name]
From Departments d
Cross join Employees e

--3.Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
Select s.SupplierName, p.ProductName
From Products p
Inner join Suppliers s on  p.SupplierID = s.SupplierID

--4.Using Orders, Customers table List customer names and their orders ID.
Select c.FirstName+' '+ c.LastName as FullName, o.OrderID 
From Customers c
Inner join Orders o on o.CustomerID=c.CustomerID

--5.Using Courses, Students table Get all combinations of students and courses.
Select c.CourseName, s.[Name] as StudentName
From Courses c 
Cross Join Students s

--6.Using Products, Orders table Get product names and orders where product IDs match.
Select p.ProductName, o.OrderID
From Products p
Inner join Orders o ON p.ProductID=o.ProductID

--7.Using Departments, Employees table List employees whose DepartmentID matches the department.
Select e.Name, d.DepartmentName
From Employees e
Inner Join Departments d On e.DepartmentID=d.DepartmentID

--8.Using Students, Enrollments table List student names and their enrolled course IDs.
Select s.[Name], e.CourseID
From Students s
Inner join Enrollments e on s.StudentID=e.StudentID

--9.Using Payments, Orders table List all orders that have matching payments.
Select o.OrderID, p.PaymentID
From Orders o 
Inner join Payments p on p.OrderID=o.OrderID

--10.Using Orders, Products table Show orders where product price is more than 100.
Select o.OrderID, p.Price
From Orders o
inner join Products p on o.ProductID= p.ProductID
 where p.Price>100

--11.Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
Select e.[Name], d.DepartmentName 
From Employees e
inner join Departments d on e.DepartmentID=d.DepartmentID
where e.DepartmentID <> d.DepartmentID

--12.Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
Select o.OrderID, o.Quantity, p.StockQuantity
From Orders o
Inner join  Products p on o.ProductID= p.ProductID
where o.Quantity>p.StockQuantity

--13.Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
Select c.[FirstName]+' '+c.LastName,  s.ProductID, s.SaleAmount
From Customers c
Inner join Sales s on c.CustomerID=s.CustomerID
where s.SaleAmount>=500
Order by s.SaleAmount desc

--14.Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
Select s.[Name] , c.CourseName
From Students s
Inner join Enrollments e on s.StudentID=e.StudentID
Inner join Courses c on c.CourseID=e.CourseID

--15.Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
Select p.ProductName, s.SupplierName
From Products p
Inner join Suppliers s on p.SupplierID=s.SupplierID
Where s.SupplierName like '%Tech%'

--16.Using Orders, Payments table Show orders where payment amount is less than total amount.
Select o.OrderID , p.Amount, o.TotalAmount
From Orders o 
Inner join Payments p on p.OrderID=o.OrderID
where p.Amount>o.TotalAmount


--17.Using Employees table List employee names with salaries greater than their manager’s salary.
Select e.[Name] as Emp_Name, m.[Name] as manag_Name, e.Salary as Emp_salary, m.Salary as Manag_salary
From Employees e
Inner Join Employees m on e.ManagerID= m.EmployeeID
Where e.Salary>m.Salary

--18.Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
Select p.ProductName, c.CategoryName
From Products p 
Inner Join Categories c on p.Category=c.CategoryID
Where c.CategoryName IN ('Electronics' ,'Furniture')

--19.Using Sales, Customers table Show all sales from customers who are from 'USA'.
Select s.SaleID , c.[FirstName]+' '+c.LastName as FullName, c.Country
From Sales s
Inner join Customers c on s.CustomerID= c.CustomerID
Where c.Country='USA'


--20.Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
Select o.OrderID, c.[FirstName]+' '+c.LastName as FullName, c.Country, o.TotalAmount
From Orders o 
Inner join Customers c on o.CustomerID=c.CustomerID
Where c.Country= 'Germany' and o.TotalAmount>100


--21.Using Employees table List all pairs of employees from different departments.
SELECT e1.[Name] AS Employee1, e2.[Name] AS Employee2
FROM Employees e1
INNER JOIN Employees e2 ON e1.EmployeeID <> e2.EmployeeID
WHERE e1.DepartmentID <> e2.DepartmentID

--22.Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
Select p.PaymentID , o.OrderID, pr.ProductID, p.PaymentDate, p.Amount, p.PaymentMethod
From Payments p
Inner join Orders o on p.OrderID=o.OrderID
Inner join Products pr on o.ProductID=pr.ProductID
Where p.Amount<> (o.Quantity*pr.Price)

--23.Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
Select s.[Name] as StudentName 
From Students s
Left Join Enrollments e  on e.StudentID=s.StudentID
Where e.EnrollmentID is Null


--24.Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
Select  m.[Name] as manager_Name, e.[Name] as Managed_employee, e.Salary as Employee_salary, m.Salary as Manager_salary
From Employees e
Inner Join Employees m on e.ManagerID= m.EmployeeID
Where m.Salary<=e.Salary

--25.Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
Select c.[FirstName]+' '+c.LastName as FullName, o.OrderID, p.PaymentID
From Customers c 
Inner join Orders o on c.CustomerID= o.CustomerID
Left join Payments p on p.OrderID=o.OrderID	
Where p.PaymentID is Null
