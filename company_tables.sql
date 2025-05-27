CREATE SCHEMA company;
CREATE TABLE company.employees_table (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(40),
    LastName VARCHAR(40),
    Gender VARCHAR(10),
    Department VARCHAR(60),
    HireDate DATE NOT NULL,
    Salary FLOAT CHECK (Salary>0)
);
INSERT INTO company.employees_table (EmployeeID, FirstName, LastName, Gender, Department, HireDate, Salary) VALUES
(1, 'John', 'Doe', 'Male', 'IT', '2018-05-01', 60000.00),
(2, 'Jane', 'Smith', 'Female', 'HR', '2019-06-15', 50000.00),
(3, 'Michael', 'Johnson', 'Male', 'Finance', '2017-03-10', 75000.00),
(4, 'Emily', 'Davis', 'Female', 'IT', '2020-11-20', 70000.00),
(5, 'Sarah', 'Brown', 'Female', 'Marketing', '2016-07-30', 45000.00),
(6, 'David', 'Wilson', 'Male', 'Sales', '2019-01-05', 55000.00),
(7, 'Chris', 'Taylor', 'Male', 'IT', '2022-02-25', 65000.00);
CREATE TABLE company.products_table (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price FLOAT CHECK (Price>0),
    Stock INT CHECK (Stock >= 0)
);
INSERT INTO company.products_table (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 30),
(2, 'Desk', 'Furniture', 300.00, 50),
(3, 'Chair', 'Furniture', 150.00, 200),
(4, 'Smartphone', 'Electronics', 800.00, 75),
(5, 'Monitor', 'Electronics', 250.00, 40),
(6, 'Bookshelf', 'Furniture', 100.00, 20),
(7,'Printer', 'Electronics', 200.00, 25);
CREATE TABLE company.sales_table (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    EmployeeID INT,
    SaleDate DATE,
    Quantity INT,
    Total FLOAT
);
INSERT INTO company.sales_table (SaleID, ProductID, EmployeeID, SaleDate, Quantity, Total) VALUES
(1, 1, 1, '2021-01-15', 2, 2400.00),
(2, 2, 2, '2021-03-22', 1, 300.00),
(3, 3, 1, '2021-05-10', 4, 600.00),
(4, 4, 4, '2021-07-18', 3, 2400.00),
(5, 4, 2, '2021-09-25', 2, 500.00),
(6, 5, 1, '2021-11-30', 1, 100.00),
(7, 1, 1, '2022-02-15', 1, 200.00),
(8, 1, 2, '2022-04-10', 2, 1200.00),
(9, 2, 2, '2022-06-20', 2, 600.00),
(10, 3, 4, '2022-08-05', 3, 450.00),
(11, 4, 1, '2022-10-11', 1, 800.00),
(12, 5, 6, '2022-12-29', 4, 1000.00);

-- All columns from the Employees table.
SELECT * FROM company.employees_table;
-- First name of all employees
SELECT FirstName AS First FROM company.employees_table;

--  Distinct departments from the Employees table.
SELECT DISTINCT Department AS dp FROM company.employees_table;

-- Total number of employees. 
SELECT COUNT(*) AS EmployeeNo FROM company.employees_table;

-- Total salary paid to all employees. 
SELECT SUM(salary) AS Total FROM company.employees_table;

-- Avg salary of all Employees
SELECT AVG(salary) AS avgSal FROM company.employees_table;

-- The highest salary in the employee table
SELECT MAX(salary) AS maxsal FROM company.employees_table;

-- The lowest salary
SELECT MIN(salary) AS minsal FROM company.employees_table;

-- Total of Male employees
SELECT COUNT(*) AS totalmale FROM company.employees_table WHERE Gender = 'Male';

-- Female employees
SELECT COUNT(*) AS totalfemale FROM company.employees_table WHERE Gender = 'Female';

-- Employess hired in 2020
SELECT COUNT(*) AS recenthire FROM  company.employees_table WHERE YEAR(Hiredate) =2020;

-- Avg IT dep salary
SELECT AVG(salary) AS avgITsal FROM company.employees_table WHERE Department = 'IT';

-- No of employees in each dep
SELECT Department,COUNT(*) AS employeeNo FROM company.employees_table GROUP BY Department;

-- Total salary paid to employees in each department
SELECT Department, SUM(Salary) AS TotalDepSal FROM company.employees_table GROUP BY Department;
-- Max salary in each department
SELECT Department, MAX(Salary) AS maxdepSalary FROM company.employees_table GROUP BY Department;

--  Min salary in each department
SELECT Department, MIN(Salary) AS mindepSalary FROM company.employees_table GROUP BY Department;

-- Total number of employees by gender.
SELECT Gender, COUNT(*) AS genderNo FROM company.employees_table GROUP BY Gender;

-- Average salary of employees by gender.
SELECT Gender, AVG(Salary) AS avgsal FROM company.employees_table GROUP BY Gender;

-- Top 5 highest-paid employees.
SELECT * FROM company.employees_table ORDER BY Salary DESC LIMIT 5;

-- No of unique first names in the Employees table.
SELECT COUNT(DISTINCT FirstName) AS uniquefirst FROM company.employees_table ;

--  Employees and corresponding sales
SELECT emp.*, sale.* 
FROM company.employees_table emp 
LEFT JOIN company.sales_table sale ON emp.EmployeeID = sale.EmployeeID;

-- First 10 employees hired by HireDate.
SELECT * FROM company.employees_table ORDER BY HireDate ASC LIMIT 10;

-- Employees without any sales.
SELECT * FROM company.employees_table emp
LEFT JOIN company.sales_table sale ON emp.EmployeeID = sale.EmployeeID
WHERE sale.SaleID IS NULL;

-- Total number of sales by each employee.
SELECT EmployeeID, COUNT(*) AS TotalSales FROM company.sales_table GROUP BY EmployeeID;

-- Employee with highest total sales.
SELECT EmployeeID, COUNT(*) AS highestsale
FROM company.sales_table
GROUP BY EmployeeID 
ORDER BY highestsale DESC 
LIMIT 1;

-- Average quantity of products sold by employees in each department.
SELECT emp.Department, AVG(sale.Quantity) AS AvgQuantity
FROM company.employees_table emp
JOIN company.sales_table sale ON emp.EmployeeID = sale.EmployeeID
GROUP BY emp.Department;

-- Total sales made by each employee in the year 2021.

SELECT emp.EmployeeID, emp.FirstName, emp.LastName, SUM(sale.Total) AS 2021sales
FROM company.employees_table emp
JOIN company.sales sale ON emp.EmployeeID = sale.EmployeeID
WHERE EXTRACT(YEAR FROM sale.SaleDate) = 2021
GROUP BY emp.EmployeeID, emp.FirstName, emp.LastName;

-- The top 3 employees with the most sales in terms of quantity.
SELECT EmployeeID, SUM(Quantity) AS highestquant
FROM company.sales_table
GROUP BY EmployeeID
ORDER BY highestquant DESC
LIMIT 3;

--Total quantity of products sold by each department.
SELECT emp.Department, SUM(sale.Quantity) AS TotalQuantity
FROM company.employees_table emp
JOIN company.sales_table sale ON emp.EmployeeID = sale.EmployeeID
GROUP BY emp.Department;

--  Total revenue generated by sales of products in each category.
SELECT product.Category, SUM(sale.Quantity * product.Price) AS TotalRevenue
FROM company.sales_table sale
JOIN company.products_table product ON sale.ProductID = product.ProductID
GROUP BY product.Category;












