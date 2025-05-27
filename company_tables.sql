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