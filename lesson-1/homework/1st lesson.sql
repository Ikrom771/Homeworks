--Homework for lesson1
--1.Data refers to raw facts or figures without context. 
--2. In-memory OLTP (Online Transaction Processing) for faster transactions
--   Authentication & authorization (Windows or SQL logins)
--   Integration with Power BI and Azure ML
--	 Backup & restore options for recovery
--	 Integration Services (SSIS) for ETL, Analysis Services (SSAS), and Reporting Services (SSRS)

--3.  Windows Authentication
--	  SQL Server Authentication

--4.
Create database SchoolDB


--5. 
Create table Students (StudentID int primary key, Name Varchar(50), Age Int)

--6.
--	 SQL Server - Relational database management system, used to store, manage and handles data
--   SSMS- SQL Server Management Studio- Graphical interface for managing SQL Server.
--   SQL - language used to interact with relational databases.

--7.
--   DQL - Data query language - used to query data form DB. Ex: "SELECT"
--	 DML - Data manipulation language - used to modify data in tables. Ex: "INSERT", "UPDATE" and etc
--	 DDL - Data definition lang. - used to change or define database objects (tables). Ex: "CREATE", "DROP",  "TRUNCATE"
--	 DCL - Data Control language- controls access and permissions to DB. Ex: "Grant", "REVOKE"
--	 TCL - Transaction Control language- manages transactions and ensure data integrity. Ex: "COMMIT", "ROLLBACK"

--8.
insert into   Students values ( 1 , 'Ikrom', 32)

--9.
--  Backup. Right click over SchoolDB in GUI and select 'Tasks" --> 'Back up'--> select destination where file(.bak) will be stored
-- Restore. Right click over SchoolDB in GUI and select 'Tasks" --> 'Restore--> Select back-up file destination
