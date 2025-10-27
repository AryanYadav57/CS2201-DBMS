/* E-Commerce System
Develop a database for an online shopping platform with tables for customers, products, and orders.
 Use primary and foreign keys, insert records, and perform queries to find total sales per product, 
 most purchased product, joins between customer and order tables, and a procedure to update product stock.
*/
create database E_Commerce_Systeml;
use E_Commerce_Systeml;

create table customers
(customer_id varchar(20)primary key,
customer_name varchar(20),
phone_No bigint);

create table products 
(product_id varchar(20)primary key,
product_name varchar(20),
price decimal(10,2));

create table orders
(order_id varchar(20)primary key,
order_date date,
quantity varchar(20),
customer_id varchar(20),
product_id varchar(20),
foreign key (customer_id) references customers(customer_id),
foreign key (product_id) references products(product_id));

INSERT INTO customers VALUES
('C1', 'Alice', 9876543210),
('C2', 'Bob', 9123456780),
('C3', 'Charlie', 9988776655);

INSERT INTO products VALUES
('P1', 'Laptop', 55000.00),
('P2', 'Smartphone', 30000.00),
('P3', 'Headphones', 2000.00);

INSERT INTO orders VALUES
('O1', '2025-10-26', 1, 'C1', 'P1'),
('O2', '2025-10-26', 2, 'C2', 'P3'),
('O3', '2025-10-26', 1, 'C3', 'P2');

select p.product_name ,sum(q.quantity*p.price) as total_sales
from products p
inner join orders q on p.product_id = q.product_id
group by p.product_name
order by total_sales desc
limit 1;

select c.customer_name , o.order_id
from orders o
inner join customers c on o.customer_id = c.customer_id;

delimiter $$
create procedure updateproducts
( prod_id varchar(20),
pric decimal(10,2))
begin
     update products
      set price = pric
      where product_id =prod_id;
end $$
delimiter ;

call updateproducts('P1','40000.00');
select *from products;