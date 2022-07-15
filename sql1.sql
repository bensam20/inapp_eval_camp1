--Question 1
-------------
--upon normalizing th etables obtained are:
--EmployeeDetails(emp_id, emp_name, pay, dept_id)
--DepartmentDetails(dept_id, dept_name)

--Creating and using a sql_eval database
CREATE DATABASE sql_eval;
USE sql_eval;


--Creating DepartmenDetails table
CREATE TABLE DepartmentDetails(
	dept_id INT PRIMARY KEY,
	dept_name VARCHAR(25)
	);

--Creating EmployeeDetails table
CREATE TABLE EmployeeDetails(
	emp_id INT PRIMARY KEY,
	emp_name VARCHAR(50) NOT NULL,
	pay INT NOT NULL,
	dept_id INT,
	CONSTRAINT fk_employeedetails
	FOREIGN KEY(dept_id)
	REFERENCES DepartmentDetails(dept_id)
	);


--Inserting values to Departmentdetails table
INSERT INTO DepartmentDetails VALUES
(1,'IT'),
(2,'Sales'),
(3,'Marketing'),
(4,'HR');

--Inserting values to EmployeeDeetails table
INSERT INTO EmployeeDetails VALUES 
(001,'Dilip', 3000, 1),
(002,'Fahad', 4000, 2),
(003,'Lal', 6000, 3),
(004,'Nivin', 2000, 1),
(005,'Vijay', 9000, 2),
(006,'Anu', 5000, 4),
(007,'Nimisha', 5000, 2),
(008,'Praveena', 8000, 3);

--1) The total number of employees.
SELECT COUNT(emp_id) FROM EmployeeDetails;

--2) Total amount required to pay all employees.
SELECT SUM(pay) FROM EmployeeDetails;

--3) Average, minimum and maximum pay in the organization.
SELECT AVG(pay) AS 'AVG Pay', MIN(pay) AS 'MIN Pay', MAX(pay) AS 'MAX Pay' FROM EmployeeDetails;

--4) Each Department wise total pay
SELECT DepartmentDetails.dept_name, SUM(EmployeeDetails.pay) AS 'Department wise total pay'
FROM EmployeeDetails
INNER JOIN DepartmentDetails ON EmployeeDetails.dept_id = DepartmentDetails.dept_id
GROUP BY DepartmentDetails.dept_name;

--5) Average, minimum and maximum pay department-wise.
SELECT dept_id, AVG(pay) AS 'Department wise Average', MAX(pay) AS 'Department wise Maximum',  MIN(pay) AS 'Department wise Minimum' 
FROM EmployeeDetails
GROUP BY dept_id;

--6) Employee details who earns the maximum pay.
SELECT * FROM EmployeeDetails 
WHERE pay = (SELECT MAX(pay) FROM EmployeeDetails);

--7) Employee details who is having a maximum pay in the department.
SELECT DepartmentDetails.dept_name, SUM(EmployeeDetails.pay) AS 'Department wise total pay'
FROM EmployeeDetails
INNER JOIN DepartmentDetails ON EmployeeDetails.dept_id = DepartmentDetails.dept_id
GROUP BY DepartmentDetails.dept_name
WHERE EmployeeDetails.pay = (SELECT MAX(pay) FROM EmployeeDetails GROUP BY dept_id);

--9) Employee who has more pay than the average pay of his department.

--10)Unique departments in the company
SELECT * FROM DepartmentDetails;

--11)Employees In increasing order of pay
SELECT emp_name, pay FROM EmployeeDetails
ORDER BY pay ASC;

--12)Department In increasing order of pay
SELECT DepartmentDetails.dept_name, SUM(EmployeeDetails.pay) AS 'Department wise total pay'
FROM EmployeeDetails
INNER JOIN DepartmentDetails ON EmployeeDetails.dept_id = DepartmentDetails.dept_id
GROUP BY DepartmentDetails.dept_name
ORDER BY SUM(EmployeeDetails.pay);
