--Easy
--1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
Select  LEFT(Name, CHARINDEX(',', Name )-1) as NName,
RIGHT(Name, Len(Name)-CHARINDEX(',', Name ))
From TestMultipleColumns

--2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
Select Strs
From TestPercent
Where Strs like '%[%]%'

--3.In this puzzle you will have to split a string based on dot(.).(Splitter)
Select LEFT(Vals, CHARINDEX('.', Vals)-1) as first_1,
    SUBSTRING(Vals, CHARINDEX('.', Vals) + 1, LEN(Vals)) AS Part2
from Splitter
where CHARINDEX('.', Vals)>0

--4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
Declare @input varchar(max) = '1234ABC123456XYZ1234567890ADS' 

SET @input = REPLACE(@input, '0', 'X');
SET @input = REPLACE(@input, '1', 'X');
SET @input = REPLACE(@input, '2', 'X');
SET @input = REPLACE(@input, '3', 'X');
SET @input = REPLACE(@input, '4', 'X');
SET @input = REPLACE(@input, '5', 'X');
SET @input = REPLACE(@input, '6', 'X');
SET @input = REPLACE(@input, '7', 'X');
SET @input = REPLACE(@input, '8', 'X');
SET @input = REPLACE(@input, '9', 'X');

Select @input

--5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
Select Vals
From testDots
Where LEN(Vals)- LEN(REPLACE(Vals, '.', ''))>2

--6.Write a SQL query to count the spaces present in the string.(CountSpaces)
Select LEN(texts)- LEN(REPLACE(texts, ' ', '')) as count_
From CountSpaces

