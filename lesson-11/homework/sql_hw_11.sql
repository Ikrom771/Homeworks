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


--Hard-Level Tasks (7)
/* 14.Return: CustomerName, OrderID, Address, OrderDate
Task: List all orders made by customers in the USA whose address starts with 4 digits.
Tables Used: Customers, Orders*/
Select
	Customers.FirstName +' '+Customers.LastName as FullName,
	Orders.OrderID,
	Customers.Address,
	Orders.OrderDate
From
	Customers
Join Orders on Orders.CustomerID= Customers.CustomerID
Where Customers.Country ='USA' 
and Customers.Address like '[0-9]%' 
and LEN(Address)>=4


/* 15.Return: ProductName, Category, SaleAmount
Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
Tables Used: Products, Sales */
Select
	Products.ProductName,
	Categories.CategoryName,
	Sales.SaleAmount
From
	Products
Join Categories on Categories.CategoryID=Products.Category
Join Sales on Sales.ProductID = Products.ProductID
Where Categories.CategoryName= 'Electronics'
and Sales.SaleAmount>350


/* 16.Return: CategoryName, ProductCount
Task: Show the number of products available in each category.
Tables Used: Products (as a derived table), Categories */
Select 
	Categories.CategoryName,
	Products.ProductCount
From
	Categories
Cross apply(
	Select 
		Count(Products.ProductID) as ProductCount
	From Products
	Where  Products.Category= Categories.CategoryID
) Products


/* 17.Return: CustomerName, City, OrderID, Amount
Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
Tables Used: Customers, Orders  */
Select
	Customers.FirstName +' '+Customers.LastName as FullName,
	Customers.City,
	Orders.OrderID,
	Orders.TotalAmount
From Customers
Join Orders on Orders.CustomerID=Customers.CustomerID
And Customers.City= 'Los Angeles'
And Orders.TotalAmount>300

/* 18.Return: EmployeeName, DepartmentName
Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
Tables Used: Employees, Departments*/
SELECT 
    Employees.Name AS EmployeeName, 
    Departments.DepartmentName
FROM 
    Employees
JOIN 
    Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE 
    Departments.DepartmentName IN ('HR', 'Finance') 
    OR LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Employees.Name, 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', '')) <= LEN(Employees.Name) - 4;

/*19.Return: ProductName, QuantitySold, Price
Task: List products that had a sales quantity above 100 and a price above 500.
Tables Used: Sales, Products */
Select 
	Products.ProductName,
	Products.Price,
	Sum(Sales.SaleAmount) as QuantitySold
From 
	Products
Join Sales on Sales.ProductID=Products.ProductID

group by Products.ProductName , Products.Price
Having Sum(Sales.SaleAmount)>100 and Products.Price>500
Order by QuantitySold desc

/* 20.Return: EmployeeName, DepartmentName, Salary
Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
Tables Used: Employees, Departments*/
Select
	Employees.Name, 
	Departments.DepartmentName,
	Employees.Salary
From 
	Employees 
Join Departments on Departments.DepartmentID=Employees.DepartmentID
Where Departments.DepartmentName in ('Sales', 'Marketing')
And Employees.Salary>60000

