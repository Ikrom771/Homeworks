--1.Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
-- Expected Output: EmployeeName, Salary, DepartmentName
Select E.Name, E.Salary, D.DepartmentName
From Employees E	
Join Departments D on D.DepartmentID=E.DepartmentID
Where Salary>50000

--2.Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
-- Expected Output: FirstName, LastName, OrderDate
Select Cus.FirstName, Cus.LastName, Ord.OrderDate
From Customers Cus
join Orders Ord on Ord.CustomerID= cus.CustomerID
Where YEAR(Ord.OrderDate) = 2023

--3.Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
--Expected Output: EmployeeName, DepartmentName
--(Hint: Use a LEFT OUTER JOIN)
Select Emp.Name, Dep.DepartmentName
From Employees Emp
Left join Departments dep on Dep.DepartmentID=Emp.DepartmentID

--4.Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
--Expected Output: SupplierName, ProductName
Select Sup.SupplierName, Pr.ProductName 
From Suppliers Sup
Left join Products pr on Sup.SupplierID=pr.SupplierID


--5.Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
-- Expected Output: OrderID, OrderDate, PaymentDate, Amount
Select Ord.OrderID, Ord.OrderDate, P.PaymentDate, P.Amount
From Orders Ord
full  join Payments P on p.OrderID=Ord.OrderID


--6.Using the Employees table, write a query to show each employee's name along with the name of their manager.
-- Expected Output: EmployeeName, ManagerName
Select Emp.Name as EmployeeName, Man.Name ManagerName
From Employees emp
Join Employees Man on emp.ManagerID= Man.EmployeeID

--7.Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
-- Expected Output: StudentName, CourseName

Select St.Name, C.CourseName
From Students St
Join Enrollments on St.StudentID=Enrollments.StudentID
Join Courses C On C.CourseID=Enrollments.CourseID
Where C.CourseName= 'Math 101'

--8.Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
-- Expected Output: FirstName, LastName, Quantity
Select Cus.FirstName, Cus.LastName, Ord.Quantity
From Customers Cus
Join Orders ord On ord.CustomerID=Cus.CustomerID
Where ord.Quantity>3

--9.Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
--Expected Output: EmployeeName, DepartmentName
Select Emp.Name, Dep.DepartmentName
From Employees Emp
Join Departments Dep on Dep.DepartmentID=Emp.DepartmentID
Where Dep.DepartmentName='Human Resources'


-- Medium-Level Tasks (9)
--10.Using the Employees and Departments tables, write a query to return department names that have more than 10 employees.
-- Expected Output: DepartmentName, EmployeeCount
Select Dep.DepartmentName, COUNT(Emp.EmployeeID) as  EmployeeCount
From Departments Dep
Join Employees Emp on Emp.DepartmentID=Dep.DepartmentID
Group by Dep.DepartmentName 
Having COUNT(Emp.EmployeeID)>10

--11.Using the Products and Sales tables, write a query to find products that have never been sold.
--Expected Output: ProductID, ProductName
Select Products.ProductID, Products.ProductName
From Products
 Left Join Sales on Products.ProductID=Sales.ProductID
Where Sales.SaleID is Null

--12.Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
--Expected Output: FirstName, LastName, TotalOrders
Select Cus.FirstName, Cus.LastName, Count(Orders.OrderID) as TotalOrders
From Customers cus	
Join Orders on Orders.CustomerID=cus.CustomerID
Group by Cus.FirstName, Cus.LastName
Having Count(Orders.OrderID)>=1


--13.Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
--Expected Output: EmployeeName, DepartmentName
Select Employees.Name , Departments.DepartmentName
From Employees 
Join Departments on Departments.DepartmentID= Employees.DepartmentID


--14.Using the Employees table, write a query to find pairs of employees who report to the same manager.
--Expected Output: Employee1, Employee2, ManagerID
Select Emp.Name as Employee1, Emp2.Name as Employee2 , Emp.ManagerID
From Employees Emp
Join Employees Emp2 on Emp.ManagerID=Emp2.ManagerID
Where
 Emp.EmployeeID < Emp2.EmployeeID
    AND Emp.ManagerID IS NOT NULL;

--15.Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
--Expected Output: OrderID, OrderDate, FirstName, LastName
Select Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
From Orders
Left join Customers on Orders.CustomerID=Customers.CustomerID
Where YEAR(Orders.OrderDate)= 2022


--16.Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
--Expected Output: EmployeeName, Salary, DepartmentName
Select Employees.Name, Employees.Salary, Departments.DepartmentName
From Employees
Join Departments on Departments.DepartmentID=Employees.DepartmentID
Where Departments.DepartmentName= 'Sales' And Employees.Salary>60000

--17.Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
-- Expected Output: OrderID, OrderDate, PaymentDate, Amount
Select Orders.OrderID, Orders.OrderDate, Payments.PaymentDate, Payments.Amount
From Orders
 Join Payments on Orders.OrderID=Payments.OrderID


--18.Using the Products and Orders tables, write a query to find products that were never ordered.
--Expected Output: ProductID, ProductName
Select 
	Products.ProductID, Products.ProductName
From
	Products
Left join
	Orders on Orders.ProductID=Products.ProductID
Where 
	Orders.OrderID is Null


 --Hard-Level Tasks (9)
--19.Using the Employees table, write a query to find employees whose salary is greater than the average salary of all employees.
-- Expected Output: EmployeeName, Salary
Select Employees.Name, Employees.Salary
From Employees
Where Employees.Salary> (Select AVG(Salary) From Employees)


--20.Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
-- Expected Output: OrderID, OrderDate
Select Orders.OrderID, Orders.OrderDate
From Orders
 Left Join Payments on Payments.OrderID=Orders.OrderID
 Where YEAR(Orders.OrderDate)<2020 And Payments.PaymentID Is null


--21.Using the Products and Categories tables, write a query to return products that do not have a matching category.
--Expected Output: ProductID, ProductName
Select Products.ProductID, Products.ProductName
From Products
Left join Categories on Categories.CategoryID=Products.Category
Where Categories.CategoryID is Null

--22.Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
--Expected Output: Employee1, Employee2, ManagerID, Salary
Select E1.Name as Employee1 ,
		E2.Name as Employee2,
		 E1.ManagerID,
    E1.Salary
From Employees E1
Join Employees E2 on E1.ManagerID=E2.ManagerID
And E1.EmployeeID<E2.EmployeeID
And E1.Salary>60000	
And E2.Salary>60000	
--23.Using the Employees and Departments tables, write a query to return employees who work in departments whose name starts with the letter 'M'.
--Expected Output: EmployeeName, DepartmentName
Select
	Employees.Name, Departments.DepartmentName
From	Employees
Join Departments on Departments.DepartmentID=Employees.DepartmentID
Where Departments.DepartmentName Like 'M%'


--24Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
--Expected Output: SaleID, ProductName, SaleAmount
Select
	Sales.SaleID, Products.ProductName, Sales.SaleAmount
	From Sales
Join Products on Products.ProductID=Sales.ProductID
Where Sales.SaleAmount>500


--25.Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
--Expected Output: StudentID, StudentName
Select
Students.StudentID, Students.Name
From Students
 left Join  Enrollments  on Enrollments.StudentID=Students.StudentID
 left Join Courses on Courses.CourseID= Enrollments.CourseID
 and Courses.CourseName= 'Math101'
 Where Courses.CourseID is null


--26.Using the Orders and Payments tables, write a query to return orders that are missing payment details.
--Expected Output: OrderID, OrderDate, PaymentID
Select
	Orders.OrderID, Orders.OrderDate, Payments.PaymentID
From Orders
Left Join	Payments on Payments.OrderID=Orders.OrderID
Where Payments.PaymentID is null


--27.Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
-- Expected Output: ProductID, ProductName, CategoryName
Select 
Products.ProductID, Products.ProductName, Categories.CategoryName
From Products
Join	Categories on Categories.CategoryID=Products.Category
Where Categories.CategoryName= 'Electronics' Or Categories.CategoryName= 'Furniture'

