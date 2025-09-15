-- Lab Experiment 04: Implement arithmetic, logical, comparison, special, and set operators in SQL using the Employees and Departments tables.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Aryan Yadav
-- USN: 1RUA24BCA0014
-- SECTION: A
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- 06:10:02	SELECT USER(),         @@hostname AS Host_Name,         VERSION() AS MySQL_Version,         NOW() AS Current_Date_Time LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec

-- Write your code below this line along with the output 
CREATE DATABASE DBLAB004;
USE DBLAB004;

CREATE TABLE Employees (  
    EmployeeID INT PRIMARY KEY,  
    Name VARCHAR(100),  
    Age INT,  
    Salary DECIMAL(10,2),  
    DepartmentID INT,  
    HireDate DATE,  
    Address VARCHAR(255)  
);  

INSERT INTO Employees VALUES  
(1, 'Alice Johnson', 30, 60000, 1, '2020-03-15', '123 Main St, City A'),  
(2, 'Bob Smith', 28, 55000, 2, '2021-06-20', '456 Oak St, City B'),  
(3, 'Charlie Brown', 35, 75000, 3, '2019-01-10', '789 Pine St, City C'),  
(4, 'David Wilson', 40, 90000, 3, '2018-07-25', '101 Maple St, City D'),  
(5, 'Emma Davis', 27, 50000, 4, '2022-09-30', '202 Birch St, City E'),  
(6, 'Frank Miller', 32, 70000, 5, '2020-11-18', '303 Cedar St, City F'),  
(7, 'Grace Lee', 29, 58000, 1, '2021-04-05', '404 Walnut St, City G'),  
(8, 'Hank Adams', 45, 98000, 2, '2017-12-12', '505 Spruce St, City H'),  
(9, 'Ivy Green', 31, 64000, 4, '2023-02-14', '606 Redwood St, City I'),  
(10, 'Jack White', 38, 85000, 5, '2019-08-08', '707 Elm St, City J');  

-- TABLE:02 Department Table

CREATE TABLE Departments (  
    DepartmentID INT PRIMARY KEY,  
    DepartmentName VARCHAR(50)  
);  

INSERT INTO Departments VALUES  
(1, 'HR'),  
(2, 'Finance'),  
(3, 'Engineering'),  
(4, 'Marketing'),  
(5, 'Sales');  

-- TASK FOR STUDENTS 

/* 
Exercise 1: Arithmetic Operators
Addition, Subtraction, Multiplication, Division
*/
/*
Q1 - Add a bonus (10% of Salary) to each employee’s salary.
*/
SELECT 
    EmployeeID, 
    Name, 
    Salary, 
    Salary * 0.10 AS Bonus, 
    Salary + (Salary * 0.10) AS Total_Salary_With_Bonus
FROM Employees;
-- OUTPUT
# EmployeeID	Name	Salary	Bonus	Total_Salary_With_Bonus
/*
1	Alice Johnson	60000.00	6000.0000	66000.0000
2	Bob Smith	55000.00	5500.0000	60500.0000
3	Charlie Brown	75000.00	7500.0000	82500.0000
4	David Wilson	90000.00	9000.0000	99000.0000
5	Emma Davis	50000.00	5000.0000	55000.0000
6	Frank Miller	70000.00	7000.0000	77000.0000
7	Grace Lee	58000.00	5800.0000	63800.0000
8	Hank Adams	98000.00	9800.0000	107800.0000
9	Ivy Green	64000.00	6400.0000	70400.0000
10	Jack White	85000.00	8500.0000	93500.0000
*/

/*
Q2 - Subtract tax (15% of Salary) from each employee’s salary.
*/
SELECT 
    EmployeeID, 
    Name, 
    Salary, 
    Salary * 0.15 AS Tax, 
    Salary - (Salary * 0.15) AS Salary_After_Tax
FROM Employees;

-- output
/*
# EmployeeID	Name	Salary	Tax	Salary_After_Tax
1	Alice Johnson	60000.00	9000.0000	51000.0000
2	Bob Smith	55000.00	8250.0000	46750.0000
3	Charlie Brown	75000.00	11250.0000	63750.0000
4	David Wilson	90000.00	13500.0000	76500.0000
5	Emma Davis	50000.00	7500.0000	42500.0000
6	Frank Miller	70000.00	10500.0000	59500.0000
7	Grace Lee	58000.00	8700.0000	49300.0000
8	Hank Adams	98000.00	14700.0000	83300.0000
9	Ivy Green	64000.00	9600.0000	54400.0000
10	Jack White	85000.00	12750.0000	72250.0000
*/

/*
Q3 - Calculate the yearly salary from the monthly salary.
*/
SELECT 
    EmployeeID, 
    Name, 
    Salary, 
    Salary * 12 AS Yearly_Salary
FROM Employees;

-- output
/*
# EmployeeID	Name	Salary	Yearly_Salary
1	Alice Johnson	60000.00	720000.00
2	Bob Smith	55000.00	660000.00
3	Charlie Brown	75000.00	900000.00
4	David Wilson	90000.00	1080000.00
5	Emma Davis	50000.00	600000.00
6	Frank Miller	70000.00	840000.00
7	Grace Lee	58000.00	696000.00
8	Hank Adams	98000.00	1176000.00
9	Ivy Green	64000.00	768000.00
10	Jack White	85000.00	1020000.00
*/

/*
-- Modulus Operator
Q4 - Find the remainder when employees’ ages are divided by 5.*/
SELECT 
    EmployeeID, 
    Name, 
    Age, 
    Age % 5 AS Age_Mod_5
FROM Employees;

-- output
/*
# EmployeeID, Name, Age, Age_Mod_5
1, Alice Johnson, 30, 0
2, Bob Smith, 28, 3
3, Charlie Brown, 35, 0
4, David Wilson, 40, 0
5, Emma Davis, 27, 2
6, Frank Miller, 32, 2
7, Grace Lee, 29, 4
8, Hank Adams, 45, 0
9, Ivy Green, 31, 1
10, Jack White, 38, 3
*/
-- Write your code below this line along with the output 
-- (already done above)

/* Exercise 2: Logical Operators: AND, OR, NOT
*/
/*
Q5 - Retrieve employees older than 30 AND with salary > 50000.
*/
SELECT EmployeeID, Name, Age, Salary
FROM Employees
WHERE Age > 30 AND Salary > 50000;

-- output
/*
# EmployeeID	Name	Age	Salary
3	Charlie Brown	35	75000.00
4	David Wilson	40	90000.00
6	Frank Miller	32	70000.00
8	Hank Adams	45	98000.00
9	Ivy Green	31	64000.00
*/

/*
Q6 - Retrieve employees in the HR department (ID=1) OR earning > 70000.
*/
SELECT EmployeeID, Name, DepartmentID, Salary
FROM Employees
WHERE DepartmentID = 1 OR Salary > 70000;

-- output
/*
# EmployeeID	Name	DepartmentID	Salary
1	Alice Johnson	1	60000.00
3	Charlie Brown	3	75000.00
4	David Wilson	3	90000.00
7	Grace Lee	1	58000.00
8	Hank Adams	2	98000.00
*/

/*
Q7 - Retrieve employees NOT living in City G.*/
SELECT EmployeeID, Name, Address
FROM Employees
WHERE Address NOT LIKE '%City G';

-- output
/*
# EmployeeID	Name	Address
1	Alice Johnson	123 Main St, City A
2	Bob Smith	456 Oak St, City B
3	Charlie Brown	789 Pine St, City C
4	David Wilson	101 Maple St, City D
5	Emma Davis	202 Birch St, City E
*/

-- Write your code below this line along with the output 
-- (already done above)


/* Exercise 3: Comparison Operators
*/
/*
Q8 - Equality, Inequality, Greater Than, Less Than
*/

/*
Q9 - Find employees with salary = 60000.
*/
SELECT EmployeeID, Name, Salary
FROM Employees
WHERE Salary = 60000;

-- output
/*
1	Alice Johnson	60000.00
*/

/*
Q10 - List employees not in the IT department (no IT department exists; returns all).
*/
SELECT EmployeeID, Name, DepartmentID
FROM Employees
WHERE DepartmentID <> 6;

-- output
/*
# EmployeeID	Name	DepartmentID
1	Alice Johnson	1
2	Bob Smith	2
3	Charlie Brown	3
4	David Wilson	3
5	Emma Davis	4
*/

/*
Q11 - Retrieve employees younger than 25 with salary > 50000 
*/
SELECT EmployeeID, Name, Age, Salary
FROM Employees
WHERE Age < 25 AND Salary > 50000;

-- output
/*
# EmployeeID, Name, Age, Salary
*/

/*
Q12 - List employees aged 25–35.
*/
SELECT EmployeeID, Name, Age
FROM Employees
WHERE Age BETWEEN 25 AND 35;

-- output
/*
# EmployeeID	Name	Age
1	Alice Johnson	30
2	Bob Smith	28
3	Charlie Brown	35
5	Emma Davis	27
6	Frank Miller	32
*/

/*
Q13 - Find employees in HR, Finance, or Engineering (IDs 1, 2, 3).
*/
SELECT EmployeeID, Name, DepartmentID
FROM Employees
WHERE DepartmentID IN (1, 2, 3);

-- output
/*
# EmployeeID	Name	DepartmentID
1	Alice Johnson	1
2	Bob Smith	2
3	Charlie Brown	3
4	David Wilson	3
7	Grace Lee	1
*/

/*
Q14 - Find employees with names starting with A.
*/
SELECT EmployeeID, Name
FROM Employees
WHERE Name LIKE 'A%';

-- output
/*
# EmployeeID	Name
1	Alice Johnson
*/

/*
Q15 - List employees with no address.
*/
SELECT EmployeeID, Name
FROM Employees
WHERE Address IS NULL;
-- (output null)

-- Write your code below this line along with the output 
-- (already done above)

/* 
Exercise 5: Set Operators: UNION.
*/
/*
Q16 - Retrieve names from the HR department hired in 2022 OR 2023.
*/

/*
Q17 - Find common employees in the Engineering department (ID=3) hired before and after 2020.
*/

/*
Q18 - Find employees hired in 2023 but not in 2022.
/*