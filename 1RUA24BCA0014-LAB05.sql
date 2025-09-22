-- Lab Experiment 05: To implement different types of joins: Inner Join, Outer Join (Left, Right, Full), and Natural Join.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Aryan Yadav
-- USN: 1RUA24BCA0014
-- SECTION: A
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
       
--  06:34:05	SELECT USER(),         @@hostname AS Host_Name,         VERSION() AS MySQL_Version,         NOW() AS Current_Date_Time LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec

-- Write your code below this line along with the output 

create database lab05;
use lab05;

-- table 01: Customers
-- CREATE  a TABLE named Customers (customer_id INT PRIMARY KEY,customer_name VARCHAR(50),city VARCHAR(50)

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

-- insert 5 records

INSERT INTO Customers VALUES
(1, 'Ravi Kumar', 'Bangalore'),
(2, 'Anjali Sharma', 'Mumbai'),
(3, 'Amit Singh', 'Bangalore'),
(4, 'Sneha Reddy', 'Hyderabad'),
(5, 'Karan Patel', 'Delhi');

-- TABLE:02 Orders Table

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- CREATE a TABLE named Orders (order_id INT PRIMARY KEY,customer_id INT foreign key,product_name VARCHAR(50),order_date DATE,
    -- insert 5 records
INSERT INTO Orders VALUES
(101, 1, 'Laptop', '2025-09-01'),
(102, 2, 'Mobile', '2025-09-05'),
(103, 1, 'Keyboard', '2025-09-07'),
(104, 3, 'Tablet', '2025-09-10'),
(105, 4, 'Headphones', '2025-09-15');

-- TASK FOR STUDENTS 
select*from Customers;
 
-- output
/*
'1', 'Ravi Kumar', 'Bangalore'
'2', 'Anjali Sharma', 'Mumbai'
'3', 'Amit Singh', 'Bangalore'
'4', 'Sneha Reddy', 'Hyderabad'
'5', 'Karan Patel', 'Delhi'
*/

-- Write and Execute Queries

/* 1. Inner Join – 
--   Find all orders placed by customers from the city "Bangalore." */

SELECT c.customer_name, o.product_name, o.order_date
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
WHERE c.city = 'Bangalore';

-- output
/* 
# customer_name	product_name	order_date
Ravi Kumar	Laptop	2025-09-01
Ravi Kumar	Keyboard	2025-09-07
Amit Singh	Tablet	2025-09-10
*/

-- List all customers with the products they ordered.
SELECT c.customer_name, o.product_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

-- output
/*
# customer_name	product_name
Ravi Kumar	Laptop
Ravi Kumar	Keyboard
Anjali Sharma	Mobile
Amit Singh	Tablet
Sneha Reddy	Headphones
*/

-- Show customer names and their order dates.
SELECT c.customer_name, o.order_date
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

-- output
/*
# customer_name	order_date
Ravi Kumar	2025-09-01
Ravi Kumar	2025-09-07
Anjali Sharma	2025-09-05
Amit Singh	2025-09-10
Sneha Reddy	2025-09-15
*/
-- Display order IDs with the corresponding customer names.
SELECT o.order_id, c.customer_name
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;
-- output
/*
# order_id	customer_name
101	Ravi Kumar
103	Ravi Kumar
102	Anjali Sharma
104	Amit Singh
105	Sneha Reddy
*/

-- Find the number of orders placed by each customer.
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
-- output
/*
# customer_name	total_orders
Ravi Kumar	2
Anjali Sharma	1
Amit Singh	1
Sneha Reddy	1
*/
-- Show city names along with the products ordered by customers.
SELECT c.city, o.product_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

-- output
/*
# city	product_name
Bangalore	Laptop
Bangalore	Keyboard
Mumbai	Mobile
Bangalore	Tablet
Hyderabad	Headphones

*/

/*
2  Left Outer Join – 
    Find all customers and their orders, even if a customer has no orders.*/
SELECT c.customer_name, o.product_name, o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;
-- output
/*
# customer_name	product_name	order_date
Ravi Kumar	Laptop	2025-09-01
Ravi Kumar	Keyboard	2025-09-07
Anjali Sharma	Mobile	2025-09-05
Amit Singh	Tablet	2025-09-10
Sneha Reddy	Headphones	2025-09-15
Karan Patel		

*/
-- List all customers and the products they ordered.
SELECT c.customer_name, o.product_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;
-- output
/*
# customer_name	product_name
Ravi Kumar	Laptop
Ravi Kumar	Keyboard
Anjali Sharma	Mobile
Amit Singh	Tablet
Sneha Reddy	Headphones
Karan Patel	
*/

-- Show customer IDs, names, and their order IDs.
SELECT c.customer_id, c.customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- output
/*# customer_id	customer_name	order_id
1	Ravi Kumar	101
1	Ravi Kumar	103
2	Anjali Sharma	102
3	Amit Singh	104
4	Sneha Reddy	105
5	Karan Patel	
*/
-- Find the total number of orders (if any) placed by each customer.
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
-- output
/*
# customer_name	total_orders
Ravi Kumar	2
Anjali Sharma	1
Amit Singh	1
Sneha Reddy	1
Karan Patel	0
*/

-- Retrieve customers who have not placed any orders.
SELECT c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
-- output
/*
# customer_name
Karan Patel
*/

-- Display customer names with their order dates.
SELECT c.customer_name, o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;
-- output
/*
# customer_name	order_date
Ravi Kumar	2025-09-01
Ravi Kumar	2025-09-07
Anjali Sharma	2025-09-05
Amit Singh	2025-09-10
Sneha Reddy	2025-09-15
Karan Patel	
*/
-- Write your code below this line along with the output 

/* 3: Right Outer Join – 
      Find all orders and their corresponding customers, even if an order doesn't have a customer associated with it.
      */
SELECT o.order_id, o.product_name, c.customer_name
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;
      -- OUTPUT
/*      
# order_id	product_name	customer_name
101	Laptop	Ravi Kumar
103	Keyboard	Ravi Kumar
102	Mobile	Anjali Sharma
104	Tablet	Amit Singh
105	Headphones	Sneha Reddy
		Karan Patel
*/

-- Show all orders with the customer names.
SELECT o.order_id, c.customer_name, o.product_name
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;
-- OUTPUT
/*
# order_id	customer_name	product_name
101	Ravi Kumar	Laptop
103	Ravi Kumar	Keyboard
102	Anjali Sharma	Mobile
104	Amit Singh	Tablet
105	Sneha Reddy	Headphones
	Karan Patel	
*/

-- Display product names with the customers who ordered them.

SELECT o.product_name, c.customer_name
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;

-- OUTPUT
/*
# product_name	customer_name
Laptop	Ravi Kumar
Keyboard	Ravi Kumar
Mobile	Anjali Sharma
Tablet	Amit Singh
Headphones	Sneha Reddy
	Karan Patel
*/

-- List order IDs with customer cities.
SELECT o.order_id, c.city
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;

-- OUTPUT

/*
# order_id	city
101	Bangalore
103	Bangalore
102	Mumbai
104	Bangalore
105	Hyderabad
	Delhi
*/

-- Find the number of orders per customer (include those without orders).

SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name;

-- OUTPUT
/*
# customer_name	total_orders
Ravi Kumar	2
Anjali Sharma	1
Amit Singh	1
Sneha Reddy	1
Karan Patel	0
*/
-- Retrieve customers who do not have any matching orders.

-- Write your code below this line along with the output 
 
/* 4: Full Outer Join – 
Find all customers and their orders, including those customers with no orders and orders without a customer.*/

SELECT c.customer_name, o.product_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_name, o.product_name
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
        
-- OUTPUT
/*
# customer_name	product_name
Ravi Kumar	Laptop
Ravi Kumar	Keyboard
Anjali Sharma	Mobile
Amit Singh	Tablet
Sneha Reddy	Headphones
Karan Patel	
*/        
-- List all customers and products, whether they placed an order or not.
SELECT c.customer_id, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_id, o.order_id
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
-- OUTPUT
/*
# customer_id	order_id
1	101
1	103
2	102
3	104
4	105
5	
*/

-- Show customer IDs with order IDs (include unmatched ones).

SELECT c.customer_name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
UNION
SELECT c.customer_name, o.order_id
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

-- OUTPUT
/*
# customer_name	order_id
Karan Patel	
*/

-- Display customer names with order dates.


-- Find all unmatched records (customers without orders and orders without customers).
-- Show customer cities with products.
-- Write your code below this line along with the output 

  /* 5: Natural Join – 
Find all orders placed by customers.*/

SELECT * 
FROM Customers
NATURAL JOIN Orders;

-- OUTPUT
/*
# customer_id	customer_name	city	order_id	product_name	order_date
1	Ravi Kumar	Bangalore	101	Laptop	2025-09-01
2	Anjali Sharma	Mumbai	102	Mobile	2025-09-05
1	Ravi Kumar	Bangalore	103	Keyboard	2025-09-07
3	Amit Singh	Bangalore	104	Tablet	2025-09-10
4	Sneha Reddy	Hyderabad	105	Headphones	2025-09-15
*/
-- List all customers with the products they ordered using NATURAL JOIN.
SELECT customer_name, product_name
FROM Customers
NATURAL JOIN Orders;
-- OUTPUT
/*
# customer_name	product_name
Ravi Kumar	Laptop
Anjali Sharma	Mobile
Ravi Kumar	Keyboard
Amit Singh	Tablet
Sneha Reddy	Headphones
*/

-- Show customer names along with their order dates using NATURAL JOIN.
SELECT customer_name, order_date
FROM Customers
NATURAL JOIN Orders;

-- OUTPUT
/*
# customer_name	order_date
Ravi Kumar	2025-09-01
Anjali Sharma	2025-09-05
Ravi Kumar	2025-09-07
Amit Singh	2025-09-10
Sneha Reddy	2025-09-15
*/

-- Find all customer cities and the products ordered by those customers using NATURAL JOIN.
SELECT city, product_name
FROM Customers
NATURAL JOIN Orders;

-- OUTPUT
/*
# city	product_name
Bangalore	Laptop
Mumbai	Mobile
Bangalore	Keyboard
Bangalore	Tablet
Hyderabad	Headphones
*/
-- Write your code below this line along with the output 
  
-- END OF THE EXPERIMENT