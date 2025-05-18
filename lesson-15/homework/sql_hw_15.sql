--1.Find Employees with Minimum Salary
WITH MinSalaryPerName AS (
    SELECT name, MIN(salary) AS min_salary
    FROM employees
    GROUP BY name
)
Select employees.id, employees.name, employees.salary
From employees
join MinSalaryPerName on employees.name=MinSalaryPerName.name and employees.salary=MinSalaryPerName.min_salary


--2.Find Products Above Average Price
with average_price as(
Select  AVG(price) as avg_price
from products
)

Select id, product_name ,price
from products, average_price
Where products.price> average_price.avg_price

--3.Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

Select	id, name, department_id
from employees
where department_id= (
Select id  from departments where department_name= 'Sales') 

--4. Retrieve customers who have not placed any orders. 
--Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
Select customer_id, name
from customers
where not exists ( select 1 from orders where orders.customer_id=customers.customer_id
)

--5.Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
Select product_name, price, category_id
from products p  
Where price = ( Select MAX(price) from products where category_id=p.category_id
)

--6.Retrieve employees working in the department with the highest average salary. 
--Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)

with dept_avg_salary as (
Select  department_id,  AVG(salary) as avg_salary
from employees
group by department_id
),

max_avg_salary as (
	Select MAX(avg_salary) as max_avg_sal
	from dept_avg_salary
	)
Select employees.name, employees.salary
From employees
Join dept_avg_salary on dept_avg_salary.department_id=employees.department_id
Join max_avg_salary on max_avg_salary.max_avg_sal=dept_avg_salary.avg_salary

--7. Find Employees Earning Above Department Average
Select employees.name, employees.salary
from	employees
Where employees.salary> (Select AVG(salary) as avg_salary from employees e2 where employees.department_id=e2.department_id  )

--8.Find Students with Highest Grade per Course
--Retrieve students who received the highest grade in each course. 
--Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
with max_grade as (
Select course_id, MAX(grade) as maxi_grade
from grades 
group by course_id
)

Select students.name, grades.course_id, grades.grade
from students
Join grades on grades.student_id=students.student_id
Join max_grade on max_grade.maxi_grade=grades.grade and max_grade.course_id=grades.course_id


--9.Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
--Tables: products (columns: id, product_name, price, category_id)
Select  product_name, price, category_id
From(
	SELECT product_name, price, category_id,
           DENSE_RANK () over(partition by category_id order by price desc) as rank
    FROM products
) as ranked

where rank =3

--10. Find Employees whose Salary Between Company Average and Department Max Salary
--Task: Retrieve employees with salaries above the company average but below the maximum in their department. 
--Tables: employees (columns: id, name, salary, department_id)

with comp_avg as (
	Select AVG(salary) as avg_salary
	From employees
),

dep_Max_salary as(
	Select department_id, MAX(salary) as max_salary
	from employees
	group by department_id
)

Select  employees.name, employees.salary
From employees
Join comp_avg on 1=1
Join dep_Max_salary on dep_Max_salary.department_id=employees.department_id
Where employees.salary > comp_avg.avg_salary and  employees.salary< dep_Max_salary.max_salary
