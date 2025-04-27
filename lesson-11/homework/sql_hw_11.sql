/* 1. Return: OrderID, CustomerName, OrderDate
Task: Show all orders placed after 2022 along with the names of the customers who placed them.
Tables Used: Orders, Customers */
Select 
	Orders.OrderID, 
	Customers.FirstName +' '+Customers.LastName as FullName,
	Orders.OrderDate
From
	Orders
Join Customers on Customers.CustomerID=Orders.CustomerID
Where YEAR(OrderDate) > 2022

/*2.Return: EmployeeName, DepartmentName
Task: Display the names of employees who work in either the Sales or Marketing department.
Tables Used: Employees, Departments */
Select 
	Employees.Name, Departments.DepartmentName
From 
	Employees
Join Departments on  Departments.DepartmentID=Employees.DepartmentID
Where
	    Departments.DepartmentName IN ('Sales', 'Marketing')

/* 3.Return: DepartmentName, TopEmployeeName, MaxSalary
Task: For each department, show the name of the employee who earns the highest salary.
Tables Used: Departments, Employees (as a derived table)*/
Select 
	Departments.DepartmentName, Employees.Name as TopEmployeeName, Employees.Salary as MaxSalary
From
	Departments
Cross Apply (
	Select Top 1
		Name , Salary
	From Employees
	Where Employees.DepartmentID= Departments.DepartmentID
	Order by Salary desc
	) Employees

	

/* 4.Return: CustomerName, OrderID, OrderDate
Task: List all customers from the USA who placed orders in the year 2023.
Tables Used: Customers, Orders */
Select 
	Customers.FirstName +' '+Customers.LastName as FullName,
	Orders.OrderID,
	Orders.OrderDate
From
	Customers
Join Orders on Orders.CustomerID=Customers.CustomerID
Where YEAR(OrderDate) = 2023


/* 5.Return: CustomerName, TotalOrders
Task: Show how many orders each customer has placed.
Tables Used: Orders (as a derived table), Customers*/
Select
	Customers.FirstName +' '+Customers.LastName as FullName,
	Orders.TotalOrders
From
	Customers
Cross apply(
	Select Sum(Orders.TotalAmount) as TotalOrders
	From Orders
	Where Orders.CustomerID=Customers.CustomerID
	) Orders
	Order by Orders.TotalOrders Desc


/*6.Return: ProductName, SupplierName
Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
Tables Used: Products, Suppliers*/
Select 
	Products.ProductName, Suppliers.SupplierName
From
	Products
Join Suppliers On Suppliers.SupplierID=Products.SupplierID
Where Suppliers.SupplierName In ('Gadget Supplies' , 'Clothing Mart')

/* 7.Return: CustomerName, MostRecentOrderDate, OrderID
Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
Tables Used: Customers, Orders (as a derived table) */
Select
	Customers.FirstName +' '+Customers.LastName as FullName,
	Orders.OrderID,
	Orders.MostRecentOrderDate
From
	Customers
Outer apply(
	Select Top 1
		Orders.OrderID,
		Orders.OrderDate as MostRecentOrderDate
	From Orders
	Where Orders.CustomerID=Customers.CustomerID
	Order by Orders.OrderDate desc
		
)Orders
Where Orders.OrderID is Null


-- Medium-Level Tasks (6)
/* 8.Return: CustomerName, OrderID, OrderTotal
Task: Show the customers who have placed an order where the total amount is greater than 500.
Tables Used: Orders, Customers */
Select 
	Customers.FirstName +' '+Customers.LastName as FullName,
	Orders.OrderID,
	Orders.TotalAmount as OrderTotal
From 
	Customers
Join Orders on Orders.CustomerID=Customers.CustomerID
WHere Orders.TotalAmount > 500


/* 9.Return: ProductName, SaleDate, SaleAmount
Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
Tables Used: Products, Sales */
Select 
	Products.ProductName,
	Sales.SaleDate,
	Sales.SaleAmount
From Products
Join Sales on Products.ProductID=Sales.ProductID
Where  YEAR(Sales.SaleDate)=2022 or Sales.SaleAmount>400

/* 10.Return: ProductName, TotalSalesAmount
Task: Display each product along with the total amount it has been sold for.
Tables Used: Sales (as a derived table), Products*/
Select 
	Products.ProductName,
	Sales.TotalSalesAmount
From Products
outer apply(
Select 
	Sum(Sales.SaleAmount) as TotalSalesAmount
	from Sales
	Where Sales.ProductID=Products.ProductID
) Sales

/* 11.Return: EmployeeName, DepartmentName, Salary
Task: Show the employees who work in the HR department and earn a salary greater than 50000.
Tables Used: Employees, Departments */
Select 
	Employees.Name, Departments.DepartmentName, Employees.Salary
From
	Employees
Join Departments on Departments.DepartmentID=Employees.DepartmentID
Where  Departments.DepartmentName= 'Human Resources' 
and Employees.Salary>50000


/* 12.Return: ProductName, SaleDate, StockQuantity
Task: List the products that were sold in 2023 and had more than 50 units in stock at the time.
Tables Used: Products, Sales */
Select	
	Products.ProductName, 
	Sales.SaleDate,
	Products.StockQuantity
From 
	Products
Join Sales on Sales.ProductID=Products.ProductID
Where
	Year(Sales.SaleDate)=2023 
	and Products.StockQuantity>50 


/* 13.Return: EmployeeName, DepartmentName, HireDate
Task: Show employees who either work in the Sales department or were hired after 2020.
Tables Used: Employees, Departments */
Select
	Employees.Name, 
	Departments.DepartmentName, 
	Employees.HireDate 
From
	Employees
Join Departments on Departments.DepartmentID= Employees.DepartmentID
Where Departments.DepartmentName= 'Sales' 
Or Year(Employees.HireDate)> 2020
