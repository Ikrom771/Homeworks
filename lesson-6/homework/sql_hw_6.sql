--Puzzle 1: Finding Distinct Values

Select distinct
  IIF(col1 < col2, col1, col2) AS col1,
  IIF(col1 < col2, col2, col1) AS col2
from InputTbl

Select distinct
  CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
  CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
from InputTbl

--Puzzle 2: Removing Rows with All Zeroes
CREATE TABLE TestMultipleZero ( A INT NULL, B INT NULL, C INT NULL, D INT NULL );
INSERT INTO TestMultipleZero(A,B,C,D) VALUES (0,0,0,1), (0,0,1,0), (0,1,0,0), (1,0,0,0), (0,0,0,0), (1,1,1,0);

Select A, B, C, D
From TestMultipleZero
 Where A<>0 Or
		B<>0 Or
		C<>0 Or
		D<>0

--Puzzle 3: Find those with odd ids
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'), (2, 'Roma'), (3, 'Steven'), (4, 'Paulo'), (5, 'Genryh'), (6, 'Bruno'), (7, 'Fred'), (8, 'Andro')

Select id, name
from section1
Where id%2=1

--Puzzle 4: Person with the smallest id (use the table in puzzle 3)

Select top 1*
from	section1
order by id asc

--Puzzle 5: Person with the Highest ID
Select top 1*
from	section1
order by id desc

--Puzzle 6: People Whose Name Starts with 'b'
Select *
from section1
where name like 'b%'

--Puzzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
CREATE TABLE ProductCodes ( Code VARCHAR(20) );

INSERT INTO ProductCodes (Code) VALUES ('X-123'), ('X_456'), ('X#789'), ('X-001'), ('X%202'), ('X_ABC'), ('X#DEF'), ('X-999');

Select *
from ProductCodes
Where Code Like '%[_]%'
