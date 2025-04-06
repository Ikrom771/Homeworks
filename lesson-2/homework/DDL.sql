-- 1.
create table Employees (EmpID int, Name varchar(50), Salary decimal(10,2))


--2.
Insert into	Employees values  ( 1, 'John', 5000.35)

Insert into Employees ( EmpID, Name, Salary) values (2, 'Alex', 4556.55), (3, 'Mike', 7345.99)
Select * from Employees

--3.
Update Employees
set Salary = 6500.50
where EmpID = 1

Select * from Employees
where EmpID= 1

--4.
Delete from Employees
Where EmpID = 2
Select * from Employees

--5. For test table will use above one
 Delete from Employees
Where EmpID = 3
Select * from Employees
go
truncate table Employees
select * from Employees

insert into Employees values (1, 'Drake' ,8656.46)
select * from Employees
 drop table Employees

 --6.
 alter table Employees
 alter column Name varchar(100)

 --7.
 alter table Employees
 add  Department varchar(50)
 SELECT * from Employees

 --8.
 alter table Employees
 alter column Salary float

 --9.
 create table Departments (DepartmentID int primary key, DepartmentName varchar(50))
 select * from Departments
 --10.
 truncate  table Employees
 select * from  Employees

--11.
create table Departments_Test (DepartmentID int primary key, DepartmentName varchar(50))
go
Insert into Departments_Test values (1, 'Sales'), (2, 'Service'), (3, 'Finance'), (4,'IT_Dep'), (5, 'Security')
Select * from	Departments_Test

insert into Departments (DepartmentID, DepartmentName)
select DepartmentID, DepartmentName
from Departments_Test;

select * from Departments

--12.
Update Employees
set Department = 'Management'
where Salary > 5000

--13.
truncate table Employees

--14.
alter table Employees
drop column Department

--15.
exec sp_rename 'Employees', 'StaffMembers'

--16.
drop table Departments

--17 and 18.
create table Products (
ProductID int Primary Key, 
ProductName VARCHAR(100), Category VARCHAR(50),
Price DECIMAL(10,2), Supplier varchar(50),
constraint chk_Price CHECK (Price > 0)
)
--19.
alter table Products
add  StockQuantity int Default 50

Select * from Products

--20.
exec sp_rename 'Products.Category', 'ProductCategory', 'column'

--21.
insert into Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
values (1, 'Laptop', 'Electronics', 1200.00, 50),  (2, 'Smartphone', 'Electronics', 800.00, 50),
(3, 'Table', 'Furniture', 150.00, 50),
(4, 'Headphones', 'Electronics', 100.00, 50),
(5, 'Chair', 'Furniture', 75.00, 50);

select * from Products

--22.
SELECT *
INTO Products_Backup
FROM Products;

--23.
exec sp_rename 'Products', 'Inventory'

--24.
	alter table Inventory
	alter column Price float
--25.
	alter table Inventory
	add ProductCode int Identity(1000, 5)

	Select * from Inventory
