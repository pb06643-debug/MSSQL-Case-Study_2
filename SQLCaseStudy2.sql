DROP TABLE LOCATION
CREATE TABLE Location (
    Location_ID INT PRIMARY KEY,
    City VARCHAR(50)
);

INSERT INTO Location(Location_ID, City) VALUES
(122, 'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston');

CREATE TABLE Department (
    Department_Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Location_Id INT,
    FOREIGN KEY (Location_Id) REFERENCES Location(Location_ID)
);

INSERT INTO Department (Department_Id, Name, Location_Id) VALUES
(10, 'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations', 167);

CREATE TABLE Job (
    Job_ID INT PRIMARY KEY,
    Designation VARCHAR(50)
);

INSERT INTO Job (Job_ID, Designation) VALUES
(667, 'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670, 'Sales Person'),
(671, 'Manager'),
(672, 'President');

CREATE TABLE Employee (
    Employee_Id INT PRIMARY KEY,
    Last_Name VARCHAR(50),
    First_Name VARCHAR(50),
    Middle_Name VARCHAR(50),
    Job_Id INT,
    Hire_Date DATE,
    Salary DECIMAL(10, 2),
    Comm DECIMAL(10, 2),
    Department_Id INT,
    FOREIGN KEY (Job_Id) REFERENCES Job(Job_ID),
    FOREIGN KEY (Department_Id) REFERENCES Department(Department_Id)
);

INSERT INTO Employee (Employee_Id, Last_Name, First_Name, Middle_Name, Job_Id, Hire_Date, Salary, Comm, Department_Id) VALUES
(7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800, NULL, 20),
(7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600, 300, 30),
(755, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850, NULL, 30),
(756, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750, NULL, 30),
(757, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200, NULL, 40),
(7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250, 50, 30);


SELECT*FROM Location
SELECT*FROM Employee
SELECT*FROM Job
SELECT*FROM Department




--Simple Queries:

--1. List all the employee details.

SELECT*FROM Employee

--2. List all the department details.

SELECT Employee_Id,Hire_Date,Department_Id From Employee

--3. List all job details.

SELECT*FROM Job

--4. List all the locations.

SELECT*FROM Location

--5. List out the First Name, Last Name, Salary, Commission for all Employees.

select First_Name,Last_Name,Salary,Comm FROM Employee

--6. List out the Employee ID, Last Name, Department ID for all employees and
--alias
--Employee ID as "ID of the Employee", Last Name as "Name of the
--Employee", Department ID as "Dep_id".

SELECT Employee_Id as ID_of_the_employee,Last_Name as name_of_the_employee,
Department_Id as Dep_Id FROM Employee

--7. List out the annual salary of the employees with their names only.

SELECT Salary*12 AS Annual_sal,First_Name FROM Employee



--WHERE Condition:

--1. List the details about "Smith".

SELECT*FROM Employee WHERE Last_Name='Smith'

--2. List out the employees who are working in department 20.

SELECT * FROM Employee where department_id=20

--3. List out the employees who are earning salary between 2000 and 3000.

SELECT*FROM Employee WHERE Salary between 2000 and 3000

--4. List out the employees who are working in department 10 or 20.

SELECT*FROM Employee where department_id=10 or department_id=20

--5. Find out the employees who are not working in department 10 or 30.

SELECT*FROM Employee where department_id!=10 and department_id!=30

--6. List out the employees whose name starts with 'L'.

SELECT*FROM Employee where First_Name like 'L%'

--7. List out the employees whose name starts with 'L' and ends with 'E'.

SELECT*FROM Employee where First_Name like 'L%' and Last_Name like '%E'

--8. List out the employees whose name length is 4 and start with 'J'.

SELECT*FROM Employee where len(First_Name)=4 and First_Name like 'J%'

--9. List out the employees who are working in department 30 and draw the
--salaries more than 2500.

select*from employee where department_Id=30 and salary>3000

--10. List out the employees who are not receiving commission.

SELECT*FROM Employee where Comm is NULL



--ORDER BY Clause:

--1. List out the Employee ID and Last Name in ascending order based on the
--Employee ID.

SELECT Employee_Id,Last_Name FROM Employee ORDER BY Employee_Id ASC

--2. List out the Employee ID and Name in descending order based on salary.

SELECT Employee_Id,First_Name,Last_Name FROM Employee ORDER BY Salary desc

--3. List out the employee details according to their Last Name in ascending-order.

SELECT*FROM Employee ORDER BY Last_Name ASC

--4. List out the employee details according to their Last Name in ascending
--order and then Department ID in descending order.

SELECT*FROM Employee ORDER BY Last_Name,Department_Id DESC



--GROUP BY and HAVING Clause:

--1. List out the department wise maximum salary, minimum salary and
--average salary of the employees.

SELECT Department_Id,MAX(Salary),MIN(Salary),AVG(Salary) FROM Employee GROUP BY Department_Id

--2. List out the job wise maximum salary, minimum salary and average
--salary of the employees.

SELECT Job_Id,MAX(Salary),MIN(Salary),AVG(Salary) FROM Employee GROUP BY Job_Id

--3. List out the number of employees who joined each month in ascending order.

SELECT DATEPART(MONTH,Hire_Date) AS join_month,COUNT(Employee_Id) AS total_emp FROM Employee
GROUP BY DATEPART(MONTH,Hire_Date) ORDER BY join_month

--4. List out the number of employees for each month and year in
--ascending order based on the year and month.

SELECT DATEPART(YEAR,Hire_Date) AS join_yr,DATEPART(MONTH,Hire_Date) as join_month,COUNT(Employee_Id)
total_emp from Employee group by DATEPART(YEAR,Hire_Date),DATEPART(MONTH,Hire_Date) order by
DATEPART(YEAR,Hire_Date),DATEPART(MONTH,Hire_Date)

--5. List out the Department ID having at least four employees.

SELECT Department_Id,COUNT(Employee_Id) TOTAL_EMP FROM Employee 
GROUP BY Department_Id HAVING COUNT(Employee_Id)>=4 

--6. How many employees joined in February month.

SELECT DATEPART(MONTH,Hire_Date)AS HIRE_MON,COUNT(Employee_Id) AS TOTAL_HIRED FROM Employee
GROUP BY DATEPART(MONTH,Hire_Date) HAVING DATEPART(MONTH,Hire_Date)=2

--7. How many employees joined in May or June month.

SELECT DATEPART(MONTH,Hire_Date)AS HIRE_MON,COUNT(Employee_Id) AS TOTAL_HIRED FROM Employee
GROUP BY DATEPART(MONTH,Hire_Date) HAVING DATEPART(MONTH,Hire_Date)=5 OR DATEPART(MONTH,Hire_Date)=6


--8. How many employees joined in 1985?

SELECT DATEPART(YEAR,Hire_Date) AS hr_yr,COUNT(Employee_Id) AS TOTAL_EMP FROM Employee
GROUP BY DATEPART(YEAR,Hire_Date) HAVING DATEPART(YEAR,Hire_Date)=1985

--9. How many employees joined each month in 1985?

SELECT DATEPART(YEAR,Hire_Date) AS hr_yr,DATEPART(MONTH,Hire_Date),COUNT(Employee_Id) AS TOTAL_EMP FROM Employee
GROUP BY DATEPART(YEAR,Hire_Date), DATEPART(MONTH,Hire_Date) HAVING DATEPART(YEAR,Hire_Date)=1985
ORDER BY DATEPART(MONTH,Hire_Date)

--10. How many employees were joined in April 1985?


SELECT DATEPART(YEAR,Hire_Date) AS hr_yr,DATEPART(MONTH,Hire_Date),COUNT(Employee_Id) AS TOTAL_EMP FROM Employee
GROUP BY DATEPART(YEAR,Hire_Date), DATEPART(MONTH,Hire_Date) HAVING DATEPART(YEAR,Hire_Date)=1985 
AND DATEPART(MONTH,Hire_Date)=4


--11. Which is the Department ID having greater than or equal to 3 employees
--joining in April 1985?

SELECT DATEPART(YEAR,Hire_Date) AS hr_yr,DATEPART(MONTH,Hire_Date) AS HIR_MON,COUNT(Department_Id),
COUNT(Employee_Id) AS TOTAL_EMP FROM Employee
GROUP BY DATEPART(YEAR,Hire_Date), DATEPART(MONTH,Hire_Date) HAVING DATEPART(YEAR,Hire_Date)=1985 
AND DATEPART(MONTH,Hire_Date)=4 and COUNT(Employee_Id)>=3



--Joins:

--1. List out employees with their department names.

SELECT *,D.Name FROM Employee e JOIN Department d on e.Department_Id=d.Department_Id

--2. Display employees with their designations.

select *,j.Designation from job j join Employee e on j.Job_ID=e.Job_Id

--3. Display the employees with their department names and city.

select *,d.Name,l.City from Department d join Employee e on d.Department_Id=e.Department_Id
join Location l on d.Location_Id=l.Location_ID

--4. How many employees are working in different departments? Display with
--department names.

select e.Department_Id,d.Name,COUNT(e.Employee_Id) as emp_count from Employee e join
Department d on e.Department_Id=d.Department_Id group by e.Department_Id,d.Name

--5. How many employees are working in the sales department?

select d.Name,d.Department_Id,COUNT(Employee_Id) as emp_count from Employee e join Department d
on d.Department_Id=e.Department_Id group by d.Name,d.Department_Id having d.Name='Sales'

--6. Which is the department having greater than or equal to 3
--employees and display the department names in
--ascending order.

select e.Department_Id,d.Name,COUNT(e.Employee_Id) from Employee e join
Department d on d.Department_Id=e.Department_Id group by e.Department_Id,
d.Name order by d.Name asc

--7. How many employees are working in 'Dallas'?

select l.Location_Id,l.City,d.Department_Id,COUNT(e.Employee_Id) as emp_count
from Location l join Department d on d.Location_Id=l.Location_ID join Employee e 
on e.Department_Id=d.Department_Id group by l.Location_ID,l.City,d.Department_Id
having l.City='Dallas'

--8. Display all employees in sales or operation departments.

select*, d.Name from Department d join Employee e on d.Department_Id=e.Department_Id
where d.Name='Sales' or d.Name='Operations'



--CONDITIONAL STATEMENT

--1. Display the employee details with salary grades. Use conditional statement to
--create a grade column.

SELECT *, CASE WHEN Salary>=2000 THEN 'Grade A' WHEN Salary>=1500 THEN 'Grade B'
ELSE 'Grade C' END AS PAY_GRADE FROM Employee

--2. List out the number of employees grade wise. Use conditional statement to
--create a grade column.

SELECT CASE WHEN Salary>=2000 THEN 'Grade A' WHEN Salary>=1500 THEN 'Grade B'
ELSE 'Grade C' END AS PAY_GRADE,COUNT(Employee_Id) AS EMP_COUNT FROM Employee
GROUP BY CASE WHEN Salary>=2000 THEN 'Grade A' WHEN Salary>=1500 THEN 'Grade B'
ELSE 'Grade C' END 

--3. Display the employee salary grades and the number of employees between
--2000 to 5000 range of salary.

select Employee_Id,Department_Id,Salary,case when Salary>=2000 then 'Grade A' when
salary>=1500 then 'Grade B' else 'Grade C' end,count(Employee_Id) from Employee
group by Employee_Id,Department_Id,Salary,case when Salary>=2000 then 'Grade A' when
salary>=1500 then 'Grade B' else 'Grade C' end having Salary between 2000 and 5000




--Subqueries:

--1. Display the employees list who got the maximum salary.

select*from Employee where Salary=(select max(Salary) from Employee)

--2. Display the employees who are working in the sales department.

select* from Employee e join Department d on e.Department_Id=d.Department_Id 
where d.Department_Id=(select d.Department_Id from Department d where d.Name='Sales')

--3. Display the employees who are working as 'Clerk'.

select* from Employee e join Job j on e.Job_Id=j.Job_ID 
where j.Job_ID=(select j.Job_ID from Job j where j.Designation='Clerk')

--4. Display the list of employees who are living in 'Boston'.

select* from Employee e join Department d on e.Department_Id=d.Department_Id
join Location l on d.Location_Id=l.Location_ID
where l.Location_ID=(select l.Location_ID from Location l where l.City='Boston')


--5. Find out the number of employees working in the sales department.

select d.Department_Id,count(e.Employee_Id) as total_emp from Employee e
join Department d on e.Department_Id=d.Department_Id group by d.Department_Id having
d.Department_Id=(select d.Department_Id from Department d where d.Name='Sales')

--6. Update the salaries of employees who are working as clerks on the basis of
--10%.

select e.Salary*1.10 as new_salary,e.Department_Id,j.Designation from Employee e
join Job j on e.Job_Id=j.Job_ID where j.Job_ID=(select j.Job_ID from Job j where 
j.Designation='Clerk')

--7. Display the second highest salary drawing employee details.

select * from(select*, dense_rank() over(order by Salary desc) as sal_rank from Employee) R
where r.sal_rank=2

--8. List out the employees who earn more than every employee in department 30.

select*from Employee where Salary> all (select Salary from Employee where Department_Id=30) 

--9. Find out which department has no employees.

select * from (select e.Employee_Id,d.* from Employee e full join Department d on e.Department_Id=d.Department_Id) k
where k.Employee_Id is NULL

--10. Find out the employees who earn greater than the average salary for
--their department.

select a.Employee_Id,a.First_Name,a.Salary,a.Department_Id from Employee a
where a.Salary>(select avg(b.Salary) from Employee b where b.Department_Id=a.Department_Id)




