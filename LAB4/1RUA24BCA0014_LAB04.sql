-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 03: Implementation of different types of SQL functions.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Aryan Yadav
-- USN: 1RUA24BCA0014
-- SECTION: BCA
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command
-- root@localhost	RVU-PC-053	8.4.6	2025-09-08 11:28:12

create database DBLAB03;
use DBLAB03;

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- PreCoded Relational Schema and Instance.
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- 1. create a table named Employee with EmpID ,FirstName,LastName Salary BirthDate HireDate 

create table Employee
( EmpID varchar(12) Primary Key,
FirstName varchar(15),
LastName varchar(15),
Salary int,
BirthDate date,
HireDate date);

-- 2. Insert 10 records to employee;

insert into Employee values
('E101', 'Girish', 'Kailash', 75000, '2006-09-06', '2022-03-15'),
('E102', 'Aryan', 'Yadav', 58000, '2007-12-08', '2024-09-02'),
('E103', 'Swaroop', 'Gowda', 55000, '2006-11-12', '2023-02-12'),
('E104', 'Sumuk', 'Ravikumar', 55000, '2006-05-21', '2022-09-19'),
('E105', 'Riyan', 'Shrestha', 65000, '2005-11-09', '2023-09-01'),
('E106', 'Deep', 'Paul', 72000, '2004-12-07', '2022-10-03'),
('E107', 'Ambrish', 'Dhanvee', 54000, '2005-03-05', '2022-09-09'),
('E108', 'Indranil', 'Saha', 70000, '2004-01-09', '2022-01-10'),
('E109', 'Koushal', 'Mandal', 45000, '2006-07-21', '2024-10-22'),
('E110', 'Akash', 'Bhat', 60000, '2005-04-09', '2022-12-30');

-- 3. create a table named Orders with OrderID , OrderDate, totalAmount, EmpID(foreign key)  

create table Orders 
(OrderID int Primary Key,
OrderDate date,
TotalAmt numeric,
EmpID varchar(12),
Foreign Key(EmpID) references Employee(EmpID));
alter table Orders modify TotalAmt decimal(7,2);

-- 4. Insert 10 records to Orders

insert into Orders values
(1101, '2025-09-01', 2500.00, 'E101'),
(1102, '2025-09-02', 1800.50, 'E102'),
(1103, '2025-09-03', 3200.75, 'E103'),
(1104, '2025-09-04', 1500.00, 'E101'),
(1105, '2025-09-05', 2750.25, 'E104'),
(1106, '2025-09-06', 1999.99, 'E102'),
(1107, '2025-09-07', 3050.00, 'E105'),
(1108, '2025-09-08', 4000.00, 'E107'),
(1109, '2025-09-09', 2200.00, 'E110'),
(1110, '2025-09-10', 3300.00, 'E105');

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Print the Information of the Employee and Order Table. [ Hint: SELECT * FROM TABLENAME ]

-- Write the SQL Query below this line.
select * from Employee;
select * from Orders;


-- Output: 
/*
# EmpID	FirstName	LastName	Salary	BirthDate	HireDate
E101	Girish	Kailash	75000	2006-09-06	2022-03-15
E102	Aryan	Yadav	58000	2007-12-08	2024-09-02
E103	Swaroop	Gowda	55000	2006-11-12	2023-02-12
E104	Sumuk	Ravikumar	55000	2006-05-21	2022-09-19
E105	Riyan	Shrestha	65000	2005-11-09	2023-09-01
E106	Deep	Paul	72000	2004-12-07	2022-10-03
E107	Ambrish	Dhanvee	54000	2005-03-05	2022-09-09
E108	Indranil	Saha	70000	2004-01-09	2022-01-10
E109	Koushal	Mandal	45000	2006-07-21	2024-10-22
E110	Akash	Bhat	60000	2005-04-09	2022-12-30
*/

/*
OrderID  OrderDate TotalAmt EmpID
1101	2025-09-01	2500.00	E101
1102	2025-09-02	1800.50	E102
1103	2025-09-03	3200.75	E103
1104	2025-09-04	1500.00	E101
1105	2025-09-05	2750.25	E104
1106	2025-09-06	1999.99	E102
1107	2025-09-07	3050.00	E105
1108	2025-09-08	4000.00	E107
1109	2025-09-09	2200.00	E110
1110	2025-09-10	3300.00	E105
*/


-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Number Functions Section
-- ------------------------------------------------------------
/* a. Round Salaries: Round employee salaries to nearest integer */
select round(Salary) As "Round-Off Salaries"
from Employee;

-- Output: 
/*
# Round-Off Salaries
75000
58000
55000
55000
65000
72000
54000
70000
45000
60000
*/

/* b. Absolute Values: Show absolute values of salaries */

select abs(Salary) As "Absolute Value"
from Employee;
-- Output:
/*
# Absolute Value
75000
58000
55000
55000
65000
72000
54000
70000
45000
60000
*/ 

/* c. Ceiling Values: Get ceiling values of order amounts */

select ceil(TotalAmt) As "Upper-Values of orders"
from Orders;

-- Output: 
/*
# Upper-Values of orders
2500
1801
3201
1500
2751
2000
3050
4000
2200
3300
*/

-- ------------------------------------------------------------
-- Aggregate Functions Section
-- ------------------------------------------------------------
/* a. Count of Employees: Find total number of employees */

select count(*) As "Total number of employees"
from Employee;

-- Output: 
/*
# Total number of employees
10
*/

/* b. Sum of Salaries: Calculate total salary expense */

select sum(Salary) As "Total Salary Expense"
from Employee;

-- Output: 
/*
# Total Salary Expense
609000
*/

/* c. Average Order Amount: Find average order value */

select avg(TotalAmt) As "Average Order Value"
from Orders;

-- Output: 
/*
# Average Order Value
2630.174500
*/

/* d. Max/Min Salary: Find highest and lowest salaries */

select max(Salary), min(Salary)
from Employee;

-- Output: 
/*
# max(Salary)	min(Salary)
75000	45000
*/

-- ------------------------------------------------------------
-- Character Functions Section
-- ------------------------------------------------------------
/* a. Case Conversion: Show names in uppercase and lowercase */

select upper(FirstName), lower(FirstName)
from Employee;

-- Output: 
/*
# upper(FirstName)	lower(FirstName)
GIRISH	girish
ARYAN	aryan
SWAROOP	swaroop
SUMUK	sumuk
RIYAN	riyan
DEEP	deep
AMBRISH	ambrish
INDRANIL  indranil
KOUSHAL	koushal
AKASH	akash
*/

/* b. Concatenate Names: Create full names */

select concat(FirstName,LastName) As "FullName" 
from Employee;

-- Output: 
/*
# FullName
GirishKailash
AryanYadav
SwaroopGowda
SumukRavikumar
RiyanShrestha
DeepPaul
AmbrishDhanvee
IndranilSaha
KoushalMandal
AkashBhat
*/

/* c. Extract Substring: Get first 3 characters of first names */
select substr(FirstName,1,3)
from Employee;

-- Output: 
/*
# substr(FirstName,1,3)
Gir
Ary
Swa
Sum
Riy
Dee
Amb
Ind
Kou
Aka
*/
-- ------------------------------------------------------------
-- Conversion Functions Section
-- ------------------------------------------------------------
/* Convert Date to String: Convert DATE to TEXT type */

select cast(OrderDate AS CHAR) As ConvertedDate 
From Orders;

-- Output: 
/*
# ConvertedDate
2025-09-01
2025-09-02
2025-09-03
2025-09-04
2025-09-05
2025-09-06
2025-09-07
2025-09-08
2025-09-09
2025-09-10
*/

-- ------------------------------------------------------------
-- Date Functions Section
-- ------------------------------------------------------------
/* a. Current Date/Time: Get current timestamp */

select now() As "Current Timestamp";

-- Output: 
/*
# Current Timestamp
2025-09-08 12:25:10
*/

/* b. Extract Year: Get year from order dates */
select extract(Year from OrderDate) As OrderYear 
from Orders;

-- Output: 
/* 
# OrderYear
2025
2025
2025
2025
2025
2025
2025
2025
2025
2025
*/

/* c. Add Months: Add 3 months to order dates */
select date_add(OrderDate, INTERVAL 3 MONTH) As FinalDate
from Orders;

-- Output: 
/*
# FinalDate
2025-12-01
2025-12-02
2025-12-03
2025-12-04
2025-12-05
2025-12-06
2025-12-07
2025-12-08
2025-12-09
2025-12-10
*/

/* d. Days Since Order: Calculate days between order date and now */
select OrderID, datediff(Now(),OrderDate) As DAYSSINCEORDER
from Orders;

-- Output: 
/*
 # OrderID	DAYSSINCEORDER
1101	7
1102	6
1103	5
1104	4
1105	3
1106	2
1107	1
1108	0
1109	-1
1110	-2
*/
-- END of the Task -- 
