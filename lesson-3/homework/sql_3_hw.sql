--1.Define and explain the purpose of BULK INSERT in SQL Server.
--bulk insert is used to quickly load large volumes of data from a file (e.g., .txt, .csv) into a SQL Server table. It's faster than row-by-row inserts.

--2.List four file formats that can be imported into SQL Server.
--.csv, .txt, .xml, xls( or xlsx)
--3. Create Products table
create table Products (ProductID int primary key, ProductName varchar(50), Price decimal (10,2))

--4. Insert three records into the Products table using INSERT INTO.
insert into Products values (1, 'Bread', 10), (2, 'Shampoo', 25), (3, 'Phone', 500)

--5. Explain the difference between NULL and NOT NULL with examples.
-- Example of allowing NULL
CREATE TABLE Example1 ( ID INT, Description VARCHAR(100) NULL);

-- Example of NOT NULL
CREATE TABLE Example2 (ID INT, Description VARCHAR(100) NOT NULL);

--6.Add a UNIQUE constraint to the ProductName column in the Products table.
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

--7.Write a comment in a SQL query explaining its purpose.
--The purpose is to ensure that no two products can have the same name.

--8.Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
create table Categories (CategoryID int primary key,CategoryName varchar(50) unique)

--9.Explain the purpose of the IDENTITY column in SQL Server.
-- indentity column autogenerates new numbers when adding rows. Usually used as primary key

--10.Use BULK INSERT to import data from a text file into the Products table.
BULK INSERT Products
FROM 'C:\Users\User\Desktop\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2


--11.Create a FOREIGN KEY in the Products table that references the Categories table.
ALTER TABLE Products
ADD CategoryID INT;

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

--12. Explain the differences between PRIMARY KEY and UNIQUE KEY with examples.
-- PRIMARY KEY = unique + not null (only one per table)
-- UNIQUE = allows one null, can have multiple per table

-- 13. CHECK constraint: Price > 0
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);

--14.Modify the Products table to add a column Stock (INT, NOT NULL).
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

--15. Use the ISNULL function to replace NULL values in a column with a default value.
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

--16. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
-- Ensures referential integrity between related tables (e.g., Products linked to Categories)

--17. Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
CREATE TABLE Customers (CustomerID INT PRIMARY KEY, CustomerName VARCHAR(100), Age INT CHECK (Age >= 18));

--18. Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE InvoiceNumbers (InvoiceID INT IDENTITY(100, 10) PRIMARY KEY, InvoiceDate DATE);

--19. Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
create table OrderDetails (OrderID INT, ProductID INT, Quantity INT, PRIMARY KEY (OrderID, ProductID));

--20. Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.
--ISNULL returns the first non-null value, same as COALESCE in simple cases
SELECT 
    ProductName,
    ISNULL(Price, 0) AS Price_ISNULL,
    COALESCE(Price, 0) AS Price_COALESCE
FROM Products;

--21.Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.

Create table Employees     EmpID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100) UNIQUE.

--22. Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
CREATE TABLE Orders (OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);









