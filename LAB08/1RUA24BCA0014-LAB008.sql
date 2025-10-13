-- Lab Experiment 08: Implementation of Procedure ( insert, update and delete)
-- STUDENT NAME: Aryan Yadav
-- USN: 1RUA24BCA0014
-- SECTION: BCA

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
/*  
# USER()	Host_Name	MySQL_Version	Current_Date_Time
root@localhost	RVU-PC-052	8.4.6	2025-10-13 05:53:43
*/

-- Scenario: Employee Management System
-- CREATE AND LOAD THE database DBLab008
-- Write your SQL query below Codespace:
CREATE DATABASE DBLab008;
USE DBLab008;
-- Task 1: Create the Employee Table
-- Create a table to store information about Employee.
-- Include the following columns:
 --   empid INT PRIMARY KEY,
   -- empname VARCHAR(50),
   -- age INT,
   -- salary DECIMAL(10,2),
   -- designation VARCHAR(30),
   -- address VARCHAR(100),
   -- date_of_join DATE
-- Write your SQL query below Codespace:
create table Employee (
empid INT PRIMARY KEY,
empname VARCHAR(50),
age INT,
salary DECIMAL(10,2),
designation VARCHAR(30),
address VARCHAR(100),
date_of_join DATE);
-- DESCRIBE THE SCHEMA -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
desc Employee;
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code
/*  
# Field	Type	Null	Key	Default	Extra
empid	int	NO	PRI		
empname	varchar(50)	YES			
age	int	YES			
salary	decimal(10,2)	YES			
designation	varchar(30)	YES			
address	varchar(100)	YES			
date_of_join	date	YES			
*/

-- insert 10 records to the table 
-- Write your SQL query below Codespace:
INSERT INTO Employee VALUES
(1, 'Riyan', 20, 90000, 'CEO', 'RVU', '2024-02-12'),
(2, 'Girish', 18, 120000, 'Accountant', 'RVU', '2024-02-15'),
(3, 'Aryan', 19, 200000, 'BOSS', 'RVU', '2024-02-19'),
(4, 'Swaroop', 22, 12000, 'PA1', 'RVU', '2024-02-20'),
(5, 'Sumukh', 19, 10000, 'PA2', 'RVU', '2024-02-29'),
(6, 'Deep', 20, 20000, 'Employee', 'RVU', '2024-02-14'),
(7, 'Aakash', 20, 120000, 'Manager', 'RVU', '2024-02-02'),
(8, 'Neel', 20, 20000, 'Staff', 'RVU', '2024-02-15'),
(9, 'Indranil', 20, 120000, 'Manager', 'RVU', '2024-02-16'),
(10, 'Pranav', 20, 20000, 'Staff', 'RVU', '2024-02-18');
-- COPYPASTE OF THE OUTPUT in CSV Format and terminate with ;
select * from Employee;
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	200000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
5	Sumukh	19	10000.00	PA2	RVU	2024-02-29
6	Deep	20	20000.00	Employee	RVU	2024-02-14
7	Aakash	20	120000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	RVU	2024-02-15
9	Indranil	20	120000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
*/
-- perform the following procedures on the employee database and copy paste the output in the space provided
-- A. Insert Procedure
-- 1. Write a stored procedure named InsertEmployee to insert a new employee record into the Employee table with all fields as input parameters.
DELIMITER $$

CREATE PROCEDURE InsertEmployee(
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_address VARCHAR(100),
    IN p_date_of_join DATE
)
BEGIN
    INSERT INTO Employee 
    VALUES (p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join);
END$$

DELIMITER ;
CALL InsertEmployee(11, 'Pragun', 18, 19000, 'Staff', 'RVU', '2024-02-18');
SELECT * FROM Employee;
-- Output: 
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	200000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
5	Sumukh	19	10000.00	PA2	RVU	2024-02-29
6	Deep	20	20000.00	Employee	RVU	2024-02-14
7	Aakash	20	120000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	RVU	2024-02-15
9	Indranil	20	120000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
*/
-- 2. Modify the insert procedure to ensure the employee’s age must be between 18 and 60.
      -- If not, display a message: "Invalid age, employee not added."
DELIMITER $$

CREATE PROCEDURE InsertEmployee_Age(
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_address VARCHAR(100),
    IN p_date_of_join DATE
)
BEGIN 
    IF p_age BETWEEN 18 AND 60 THEN
        INSERT INTO Employee
        VALUES (p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join);
        SELECT 'Employee added successfully.' AS Message;
    ELSE
        SELECT 'Invalid age, employee not added.' AS Message;
    END IF;
END$$

DELIMITER ;
call InsertEmployee_Age(12, 'Kaushal', 18, 6000, 'Staff', 'RVU', '2024-02-18');
call InsertEmployee_Age(13, 'Sharath', 67, 120000, 'Staff', 'RVU', '2024-02-18');
SELECT * FROM Employee;
-- Output:
/*  
# Message
Employee added successfully.
Invalid age, employee not added.
*/
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	200000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
5	Sumukh	19	10000.00	PA2	RVU	2024-02-29
6	Deep	20	20000.00	Employee	RVU	2024-02-14
7	Aakash	20	120000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	RVU	2024-02-15
9	Indranil	20	120000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
12	Kaushal	18	6000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
*/
-- 3. Create a procedure that inserts a new employee record.
          -- If the salary is not provided, assign a default salary of 20000.
DELIMITER $$

CREATE PROCEDURE InsertEmployee_Salary(
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_address VARCHAR(100),
    IN p_date_of_join DATE
)
BEGIN  
   IF p_salary is null THEN set p_salary = 20000;
   END IF;
   INSERT INTO Employee
   VALUES (p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join);
END$$

DELIMITER ;
CALL InsertEmployee_Salary(14, 'Manish', 35, null, 'Head', 'RVU', '2024-02-18');
SELECT * FROM Employee;
-- Output:
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	200000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
5	Sumukh	19	10000.00	PA2	RVU	2024-02-29
6	Deep	20	20000.00	Employee	RVU	2024-02-14
7	Aakash	20	120000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	RVU	2024-02-15
9	Indranil	20	120000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
12	Kaushal	18	6000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
*/

-- 4. Write a procedure that inserts three new employee records in a single procedure using multiple INSERT statements.
DELIMITER $$

CREATE PROCEDURE InsertThreeEmployees()
BEGIN
    INSERT INTO Employee(empid, empname, age, salary, designation, address, date_of_join)
    VALUES (15, 'Sujay', 25, 25000, 'Assistant', 'RVU', '2024-03-05');

    INSERT INTO Employee(empid, empname, age, salary, designation, address, date_of_join)
    VALUES (16, 'Meena', 27, 30000, 'Supervisor', 'RVU', '2024-03-06');

    INSERT INTO Employee(empid, empname, age, salary, designation, address, date_of_join)
    VALUES (17, 'Nisha', 24, 28000, 'Receptionist', 'RVU', '2024-03-07');
END$$

DELIMITER ;
CALL InsertThreeEmployees();
SELECT * FROM Employee;
-- Output:
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	200000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
5	Sumukh	19	10000.00	PA2	RVU	2024-02-29
6	Deep	20	20000.00	Employee	RVU	2024-02-14
7	Aakash	20	120000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	RVU	2024-02-15
9	Indranil	20	120000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
12	Kaushal	18	6000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
15	Sujay	25	25000.00	Assistant	RVU	2024-03-05
16	Meena	27	30000.00	Supervisor	RVU	2024-03-06
17	Nisha	24	28000.00	Receptionist	RVU	2024-03-07
*/
-- B.  Update Procedure
/*
Update Salary:
Write a stored procedure named UpdateSalary to update an employee’s salary based on their empid.*/
DELIMITER $$
CREATE PROCEDURE UpdateSalary(
IN p_empid int,
IN p_new_salary decimal(10,2)
)
Begin
update Employee
set salary = P_new_salary
where empid = p_empid;
end$$
DELIMITER ;
CALL UpdateSalary(3, 90000);
SELECT * FROM Employee;
-- Output:
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	90000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
5	Sumukh	19	10000.00	PA2	RVU	2024-02-29
6	Deep	20	20000.00	Employee	RVU	2024-02-14
7	Aakash	20	120000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	RVU	2024-02-15
9	Indranil	20	120000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
12	Kaushal	18	6000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
15	Sujay	25	25000.00	Assistant	RVU	2024-03-05
16	Meena	27	30000.00	Supervisor	RVU	2024-03-06
17	Nisha	24	28000.00	Receptionist	RVU	2024-03-07
*/
/* 
Increment Salary by Percentage:
Create a procedure to increase the salary by 10% for all employees whose designation = 'Manager'.*/
DELIMITER $$
CREATE PROCEDURE SalaryUP()
BEGIN
    UPDATE Employee
    SET salary = salary * 1.10
    WHERE designation = 'Manager';
END$$
DELIMITER ;
call SalaryUP();
SELECT * FROM Employee;
-- Output:
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	90000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
5	Sumukh	19	10000.00	PA2	RVU	2024-02-29
6	Deep	20	20000.00	Employee	RVU	2024-02-14
7	Aakash	20	132000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	RVU	2024-02-15
9	Indranil	20	132000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
12	Kaushal	18	6000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
15	Sujay	25	25000.00	Assistant	RVU	2024-03-05
16	Meena	27	30000.00	Supervisor	RVU	2024-03-06
17	Nisha	24	28000.00	Receptionist	RVU	2024-03-07
*/
/*
Update Designation:
Write a procedure to update the designation of an employee by empid.
Example: Promote an employee from 'Clerk' to 'Senior Clerk'.*/
DELIMITER $$

CREATE PROCEDURE UpdateDesignation(
    IN p_empid INT,
    IN p_new_designation VARCHAR(30)
)
BEGIN
    UPDATE Employee
    SET designation = p_new_designation
    WHERE empid = p_empid;
END$$

DELIMITER ;
CALL UpdateDesignation(6, 'Senior Employee');
SELECT * FROM Employee;
-- Output:
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	90000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
5	Sumukh	19	10000.00	PA2	RVU	2024-02-29
6	Deep	20	20000.00	Senior Employee	RVU	2024-02-14
7	Aakash	20	132000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	New RVU Campus	2024-02-15
9	Indranil	20	132000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
12	Kaushal	18	6000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
15	Sujay	25	25000.00	Assistant	RVU	2024-03-05
16	Meena	27	30000.00	Supervisor	RVU	2024-03-06
17	Nisha	24	28000.00	Receptionist	RVU	2024-03-07
*/
/* 
Update Address:
Write a procedure to update the address of an employee when empid is given as input.*/
DELIMITER $$

CREATE PROCEDURE UpdateAddress(
    IN p_empid INT,
    IN p_new_address VARCHAR(100)
)
BEGIN
    UPDATE Employee
    SET address = p_new_address
    WHERE empid = p_empid;
END$$

DELIMITER ;
CALL UpdateAddress(8, 'New RVU Campus');
SELECT * FROM Employee;

-- Output:
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	90000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
5	Sumukh	19	10000.00	PA2	RVU	2024-02-29
6	Deep	20	20000.00	Senior Employee	RVU	2024-02-14
7	Aakash	20	132000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	New RVU Campus	2024-02-15
9	Indranil	20	132000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
12	Kaushal	18	6000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
15	Sujay	25	25000.00	Assistant	RVU	2024-03-05
16	Meena	27	30000.00	Supervisor	RVU	2024-03-06
17	Nisha	24	28000.00	Receptionist	RVU	2024-03-07
*/
/*
Conditional Update (Age Check):
Create a procedure that updates salary only if the employee’s age > 40; otherwise, print "Not eligible for salary update."*/
-- Output:
/*  */
-- C. Delete Procedure
/*
Delete by empid:
Write a stored procedure named DeleteEmployee to delete an employee record using their empid.*/
DELIMITER $$

CREATE PROCEDURE DeleteEmployee(
    IN p_empid INT
)
BEGIN
    DELETE FROM Employee
    WHERE empid = p_empid;
END$$

DELIMITER ;
CALL DeleteEmployee(5);
SELECT * FROM Employee;
-- Output:
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	90000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
6	Deep	20	20000.00	Senior Employee	RVU	2024-02-14
7	Aakash	20	132000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	New RVU Campus	2024-02-15
9	Indranil	20	132000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
12	Kaushal	18	6000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
15	Sujay	25	25000.00	Assistant	RVU	2024-03-05
16	Meena	27	30000.00	Supervisor	RVU	2024-03-06
17	Nisha	24	28000.00	Receptionist	RVU	2024-03-07
*/
/*
Delete by Designation:
Create a procedure that deletes all employees belonging to a specific designation (e.g., 'Intern').*/
DELIMITER $$

CREATE PROCEDURE DeleteByDesignation(
    IN p_designation VARCHAR(30)
)
BEGIN
    DELETE FROM Employee
    WHERE designation = p_designation;
END$$

DELIMITER ;
CALL DeleteByDesignation('Assistant');
SELECT * FROM Employee;
-- Output:
/*  # empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	90000.00	BOSS	RVU	2024-02-19
4	Swaroop	22	12000.00	PA1	RVU	2024-02-20
6	Deep	20	20000.00	Senior Employee	RVU	2024-02-14
7	Aakash	20	132000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	New RVU Campus	2024-02-15
9	Indranil	20	132000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
12	Kaushal	18	6000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
16	Meena	27	30000.00	Supervisor	RVU	2024-03-06
17	Nisha	24	28000.00	Receptionist	RVU	2024-03-07
*/
/*
Delete Based on Salary Range:
Write a procedure to delete employees whose salary is less than ₹15000.*/
DELIMITER $$

CREATE PROCEDURE DeleteByLowSalary()
BEGIN
    DELETE FROM Employee
    WHERE salary < 15000;
END$$

DELIMITER ;
CALL DeleteByLowSalary();
SELECT * FROM Employee;
-- Output:
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	90000.00	BOSS	RVU	2024-02-19
6	Deep	20	20000.00	Senior Employee	RVU	2024-02-14
7	Aakash	20	132000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	New RVU Campus	2024-02-15
9	Indranil	20	132000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
16	Meena	27	30000.00	Supervisor	RVU	2024-03-06
17	Nisha	24	28000.00	Receptionist	RVU	2024-03-07
*/
/*
Delete by Joining Year:
Write a procedure to delete employees who joined before the year 2015.
*/
DELIMITER $$

CREATE PROCEDURE DeleteByJoiningYear()
BEGIN
    DELETE FROM Employee
    WHERE YEAR(date_of_join) < 2015;
END$$

DELIMITER ;
CALL DeleteByJoiningYear();
SELECT * FROM Employee;
-- Output:
/*  
# empid	empname	age	salary	designation	address	date_of_join
1	Riyan	20	90000.00	CEO	RVU	2024-02-12
2	Girish	18	120000.00	Accountant	RVU	2024-02-15
3	Aryan	19	90000.00	BOSS	RVU	2024-02-19
6	Deep	20	20000.00	Senior Employee	RVU	2024-02-14
7	Aakash	20	132000.00	Manager	RVU	2024-02-02
8	Neel	20	20000.00	Staff	New RVU Campus	2024-02-15
9	Indranil	20	132000.00	Manager	RVU	2024-02-16
10	Pranav	20	20000.00	Staff	RVU	2024-02-18
11	Pragun	18	19000.00	Staff	RVU	2024-02-18
13	Sharath	60	120000.00	Staff	RVU	2024-02-18
14	Manish	35	20000.00	Head	RVU	2024-02-18
16	Meena	27	30000.00	Supervisor	RVU	2024-03-06
17	Nisha	24	28000.00	Receptionist	RVU	2024-03-07
*/
-- End of Lab Experiment 
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01