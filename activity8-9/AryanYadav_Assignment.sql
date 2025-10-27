-- -----------------------------------------------------------------
-- scenario 1: hospital management system
-- -----------------------------------------------------------------

-- create and load the database
create database if not exists hospital_db;
use hospital_db;

-- task 1: create the tables
create table doctors (
    doctor_id int primary key,
    doctor_name varchar(100),
    specialization varchar(50)
);

create table patients (
    patient_id int primary key,
    patient_name varchar(100),
    age int,
    gender char(1)
);

create table appointments (
    appointment_id int primary key,
    patient_id int,
    doctor_id int,
    appointment_date datetime,
    foreign key (patient_id) references patients(patient_id),
    foreign key (doctor_id) references doctors(doctor_id)
);

-- describe the schema
desc doctors;
/*# field            type          null    key     default    extra
doctor_id        int           no      pri     null
doctor_name      varchar(100)  yes             null
specialization   varchar(50)   yes             null
*/

desc patients;
/*# field          type          null    key     default    extra
patient_id     int           no      pri     null
patient_name   varchar(100)  yes             null
age            int           yes             null
gender         char(1)       yes             null
*/

desc appointments;
/*# field            type          null    key     default    extra
appointment_id   int           no      pri     null
patient_id       int           yes     mul     null
doctor_id        int           yes     mul     null
appointment_date datetime      yes             null
*/

-- task 2: insert sample records
insert into doctors values
(1, 'dr. anil sharma', 'cardiologist'),
(2, 'dr. sunita verma', 'dermatologist');

insert into patients values
(101, 'rajesh kumar', 45, 'm'),
(102, 'priya singh', 28, 'f'),
(103, 'amit patel', 52, 'm');

insert into appointments values
(1001, 101, 1, '2025-11-10 09:00:00'),
(1002, 102, 2, '2025-11-10 10:00:00'),
(1003, 103, 1, '2025-11-11 09:30:00'),
(1004, 101, 1, '2025-11-17 09:00:00');

-- display the records
select * from appointments;
/*
appointment_id,patient_id,doctor_id,appointment_date
1001,101,1,'2025-11-10 09:00:00'
1002,102,2,'2025-11-10 10:00:00'
1003,103,1,'2025-11-11 09:30:00'
1004,101,1,'2025-11-17 09:00:00'
*/

-- task 3: joins and aggregate functions

-- join query: get patient name, doctor name, and appointment date
select p.patient_name, d.doctor_name, d.specialization, a.appointment_date
from appointments as a
join patients as p on a.patient_id = p.patient_id
join doctors as d on a.doctor_id = d.doctor_id;
/*
patient_name,doctor_name,specialization,appointment_date
'rajesh kumar','dr. anil sharma','cardiologist','2025-11-10 09:00:00'
'priya singh','dr. sunita verma','dermatologist','2025-11-10 10:00:00'
'amit patel','dr. anil sharma','cardiologist','2025-11-11 09:30:00'
'rajesh kumar','dr. anil sharma','cardiologist','2025-11-17 09:00:00'
*/

-- aggregate query: calculate total patients (appointments) per doctor
select d.doctor_name, count(a.patient_id) as total_appointments
from appointments as a
join doctors as d on a.doctor_id = d.doctor_id
group by d.doctor_name;
/*
doctor_name,total_appointments
'dr. anil sharma',3
'dr. sunita verma',1
*/

-- task 4: stored procedures

-- procedure to insert a new appointment
delimiter $$
create procedure insert_appointment(
    in p_appointment_id int,
    in p_patient_id int,
    in p_doctor_id int,
    in p_appointment_date datetime
)
begin
    insert into appointments values (p_appointment_id, p_patient_id, p_doctor_id, p_appointment_date);
end$$
delimiter ;

call insert_appointment(1005, 102, 2, '2025-11-15 11:00:00');

-- procedure to update an appointment date
delimiter $$
create procedure update_appointment(
    in p_appointment_id int,
    in p_new_date datetime
)
begin
    update appointments set appointment_date = p_new_date where appointment_id = p_appointment_id;
end$$
delimiter ;

call update_appointment(1002, '2025-11-12 10:30:00');


-- -----------------------------------------------------------------
-- scenario 2: library management system
-- -----------------------------------------------------------------

-- create and load the database
create database if not exists library_db;
use library_db;

-- task 1: create the tables
create table members (
    member_id int primary key,
    member_name varchar(100),
    join_date date
);

create table books (
    book_id int primary key,
    title varchar(100),
    author varchar(100),
    is_available boolean
);

create table book_issue (
    issue_id int primary key,
    book_id int,
    member_id int,
    issue_date date,
    return_date date,
    foreign key (book_id) references books(book_id),
    foreign key (member_id) references members(member_id)
);

-- describe the schema
desc books;
/*# field          type          null    key     default    extra
book_id        int           no      pri     null
title          varchar(100)  yes             null
author         varchar(100)  yes             null
is_available   tinyint(1)    yes             null
*/

desc book_issue;
/*# field          type          null    key     default    extra
issue_id       int           no      pri     null
book_id        int           yes     mul     null
member_id      int           yes     mul     null
issue_date     date          yes             null
return_date    date          yes             null
*/

-- task 2: insert sample records
insert into members values
(1, 'alok verma', '2022-01-15'),
(2, 'meena gupte', '2022-03-22');

insert into books values
(101, 'the great gatsby', 'f. scott fitzgerald', 1),
(102, '1984', 'george orwell', 1),
(103, 'moby dick', 'herman melville', 0);

insert into book_issue values
(1001, 103, 1, '2025-10-01', null),
(1002, 101, 2, '2025-10-05', '2025-10-20'),
(1003, 101, 1, '2025-10-22', null);

-- display the records
select * from book_issue;
/*
issue_id,book_id,member_id,issue_date,return_date
1001,103,1,'2025-10-01',NULL
1002,101,2,'2025-10-05','2025-10-20'
1003,101,1,'2025-10-22',NULL
*/

-- task 3: joins and aggregate functions

-- join query: get member name, book title, and issue date
select m.member_name, b.title, i.issue_date
from book_issue as i
join books as b on i.book_id = b.book_id
join members as m on i.member_id = m.member_id;
/*
member_name,title,issue_date
'alok verma','moby dick','2025-10-01'
'meena gupte','the great gatsby','2025-10-05'
'alok verma','the great gatsby','2025-10-22'
*/

-- aggregate query: total issued books per member (all time)
select m.member_name, count(i.book_id) as total_books_issued
from book_issue as i
join members as m on i.member_id = m.member_id
group by m.member_name;
/*
member_name,total_books_issued
'alok verma',2
'meena gupte',1
*/

-- task 4: stored procedures

-- procedure to issue a book (inserts and updates availability)
delimiter $$
create procedure issue_book(
    in p_issue_id int,
    in p_book_id int,
    in p_member_id int,
    in p_issue_date date
)
begin
    insert into book_issue(issue_id, book_id, member_id, issue_date)
    values (p_issue_id, p_book_id, p_member_id, p_issue_date);
    
    update books set is_available = 0 where book_id = p_book_id;
end$$
delimiter ;

call issue_book(1004, 102, 2, '2025-10-25');

-- procedure to update book availability (on return)
delimiter $$
create procedure update_book_availability(
    in p_book_id int,
    in p_issue_id int,
    in p_return_date date,
    in p_new_status boolean
)
begin
    update books set is_available = p_new_status where book_id = p_book_id;
    update book_issue set return_date = p_return_date where issue_id = p_issue_id;
end$$
delimiter ;

call update_book_availability(103, 1001, '2025-10-26', 1);


-- -----------------------------------------------------------------
-- scenario 3: employee payroll system
-- -----------------------------------------------------------------

-- create and load the database
create database if not exists payroll_db;
use payroll_db;

-- task 1: create the tables
create table departments (
    dept_id int primary key,
    dept_name varchar(50)
);

create table employees (
    emp_id int primary key,
    emp_name varchar(100),
    dept_id int,
    foreign key (dept_id) references departments(dept_id)
);

create table salary (
    salary_id int primary key,
    emp_id int,
    amount decimal(10, 2),
    pay_date date,
    foreign key (emp_id) references employees(emp_id)
);

-- describe the schema
desc employees;
/*# field       type          null    key     default    extra
emp_id      int           no      pri     null
emp_name    varchar(100)  yes             null
dept_id     int           yes     mul     null
*/

desc salary;
/*# field       type          null    key     default    extra
salary_id   int           no      pri     null
emp_id      int           yes     mul     null
amount      decimal(10,2) yes             null
pay_date    date          yes             null
*/

-- task 2: insert sample records
insert into departments values
(1, 'engineering'),
(2, 'sales');

insert into employees values
(101, 'karan joshi', 1),
(102, 'riya desai', 2),
(103, 'steve rogers', 1);

insert into salary values
(1001, 101, 80000, '2025-10-01'),
(1002, 102, 65000, '2025-10-01'),
(1003, 103, 82000, '2025-10-01');

-- display the records
select * from salary;
/*
salary_id,emp_id,amount,pay_date
1001,101,80000.00,'2025-10-01'
1002,102,65000.00,'2025-10-01'
1003,103,82000.00,'2025-10-01'
*/

-- task 3: joins and aggregate functions

-- join query: get employee name, department name, and salary
select e.emp_name, d.dept_name, s.amount
from employees as e
join departments as d on e.dept_id = d.dept_id
join salary as s on e.emp_id = s.emp_id;
/*
emp_name,dept_name,amount
'karan joshi','engineering',80000.00
'riya desai','sales',65000.00
'steve rogers','engineering',82000.00
*/

-- aggregate query: average salary per department
select d.dept_name, avg(s.amount) as average_salary
from employees as e
join departments as d on e.dept_id = d.dept_id
join salary as s on e.emp_id = s.emp_id
group by d.dept_name;
/*
dept_name,average_salary
'engineering',81000.000000
'sales',65000.000000
*/

-- task 4: stored procedures

-- procedure to insert a new salary record
delimiter $$
create procedure insert_salary(
    in p_salary_id int,
    in p_emp_id int,
    in p_amount decimal(10, 2),
    in p_pay_date date
)
begin
    insert into salary values (p_salary_id, p_emp_id, p_amount, p_pay_date);
end$$
delimiter ;

call insert_salary(1004, 102, 65000, '2025-11-01');

-- procedure to update an employee's salary
delimiter $$
create procedure update_salary(
    in p_emp_id int,
    in p_new_amount decimal(10, 2)
)
begin
    update salary set amount = p_new_amount where emp_id = p_emp_id;
end$$
delimiter ;

call update_salary(102, 68000.00);


-- -----------------------------------------------------------------
-- scenario 4: e-commerce system
-- -----------------------------------------------------------------

-- create and load the database
create database if not exists ecommerce_db;
use ecommerce_db;

-- task 1: create the tables
create table customers (
    customer_id int primary key,
    customer_name varchar(100),
    email varchar(100)
);

create table products (
    product_id int primary key,
    product_name varchar(100),
    price decimal(10, 2),
    stock int
);

create table orders (
    order_id int primary key,
    customer_id int,
    product_id int,
    quantity int,
    order_date date,
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id)
);

-- describe the schema
desc products;
/*# field          type          null    key     default    extra
product_id     int           no      pri     null
product_name   varchar(100)  yes             null
price          decimal(10,2) yes             null
stock          int           yes             null
*/

desc orders;
/*# field          type          null    key     default    extra
order_id       int           no      pri     null
customer_id    int           yes     mul     null
product_id     int           yes     mul     null
quantity       int           yes             null
order_date     date          yes             null
*/

-- task 2: insert sample records
insert into customers values
(1, 'aakash mehta', 'aakash@example.com'),
(2, 'bina roy', 'bina@example.com');

insert into products values
(101, 'laptop', 75000.00, 50),
(102, 'mouse', 1200.00, 200),
(103, 'keyboard', 2500.00, 150);

insert into orders values
(1001, 1, 101, 1, '2025-10-20'),
(1002, 1, 102, 2, '2025-10-20'),
(1003, 2, 103, 1, '2025-10-21'),
(1004, 2, 102, 1, '2025-10-22');

-- display the records
select * from orders;
/*
order_id,customer_id,product_id,quantity,order_date
1001,1,101,1,'2025-10-20'
1002,1,102,2,'2025-10-20'
1003,2,103,1,'2025-10-21'
1004,2,102,1,'2025-10-22'
*/

-- task 3: joins and aggregate functions

-- join query: get customer name, product name, and quantity
select c.customer_name, p.product_name, o.quantity
from orders as o
join customers as c on o.customer_id = c.customer_id
join products as p on o.product_id = p.product_id;
/*
customer_name,product_name,quantity
'aakash mehta','laptop',1
'aakash mehta','mouse',2
'bina roy','keyboard',1
'bina roy','mouse',1
*/

-- aggregate query: total sales ($) per product
select p.product_name, sum(p.price * o.quantity) as total_sales
from orders as o
join products as p on o.product_id = p.product_id
group by p.product_name;
/*
product_name,total_sales
'laptop',75000.00
'mouse',3600.00
'keyboard',2500.00
*/

-- task 4: stored procedures

-- procedure to place an order (inserts order and updates stock)
delimiter $$
create procedure place_order(
    in p_order_id int,
    in p_customer_id int,
    in p_product_id int,
    in p_quantity int,
    in p_order_date date
)
begin
    insert into orders values (p_order_id, p_customer_id, p_product_id, p_quantity, p_order_date);
    update products set stock = stock - p_quantity where product_id = p_product_id;
end$$
delimiter ;

call place_order(1005, 1, 103, 1, '2025-10-26');

-- procedure to update product stock
delimiter $$
create procedure update_product_stock(
    in p_product_id int,
    in p_new_stock int
)
begin
    update products set stock = p_new_stock where product_id = p_product_id;
end$$
delimiter ;

call update_product_stock(101, 75);


-- -----------------------------------------------------------------
-- scenario 5: school management system
-- -----------------------------------------------------------------

-- create and load the database
create database if not exists school_db;
use school_db;

-- task 1: create the tables
create table classes (
    class_id int primary key,
    class_name varchar(20)
);

create table students (
    student_id int primary key,
    student_name varchar(100),
    class_id int,
    foreign key (class_id) references classes(class_id)
);

create table marks (
    mark_id int primary key,
    student_id int,
    subject varchar(50),
    mark int,
    foreign key (student_id) references students(student_id)
);

-- describe the schema
desc students;
/*# field          type          null    key     default    extra
student_id     int           no      pri     null
student_name   varchar(100)  yes             null
class_id       int           yes     mul     null
*/

desc marks;
/*# field          type          null    key     default    extra
mark_id        int           no      pri     null
student_id     int           yes     mul     null
subject        varchar(50)   yes             null
mark           int           yes             null
*/

-- task 2: insert sample records
insert into classes values
(10, 'class 10a'),
(9, 'class 9b');

insert into students values
(101, 'rohan sharma', 10),
(102, 'priya das', 9),
(103, 'ali khan', 10);

insert into marks values
(1001, 101, 'maths', 85),
(1002, 101, 'science', 90),
(1003, 102, 'maths', 78),
(1004, 102, 'science', 82),
(1005, 103, 'maths', 95);

-- display the records
select * from marks;
/*
mark_id,student_id,subject,mark
1001,101,'maths',85
1002,101,'science',90
1003,102,'maths',78
1004,102,'science',82
1005,103,'maths',95
*/

-- task 3: joins and aggregate functions

-- join query: display class-wise student marks
select c.class_name, s.student_name, m.subject, m.mark
from marks as m
join students as s on m.student_id = s.student_id
join classes as c on s.class_id = c.class_id;
/*
class_name,student_name,subject,mark
'class 10a','rohan sharma','maths',85
'class 10a','rohan sharma','science',90
'class 9b','priya das','maths',78
'class 9b','priya das','science',82
'class 10a','ali khan','maths',95
*/

-- aggregate query: find average marks per class (for maths)
select c.class_name, avg(m.mark) as average_maths_mark
from marks as m
join students as s on m.student_id = s.student_id
join classes as c on s.class_id = c.class_id
where m.subject = 'maths'
group by c.class_name;
/*
class_name,average_maths_mark
'class 10a',90.0000
'class 9b',78.0000
*/

-- task 4: stored procedures

-- procedure to insert a new student
delimiter $$
create procedure insert_student(
    in p_student_id int,
    in p_student_name varchar(100),
    in p_class_id int
)
begin
    insert into students values (p_student_id, p_student_name, p_class_id);
end$$
delimiter ;

call insert_student(104, 'meera nair', 9);

-- procedure to update marks
delimiter $$
create procedure update_marks(
    in p_mark_id int,
    in p_new_mark int
)
begin
    update marks set mark = p_new_mark where mark_id = p_mark_id;
end$$
delimiter ;

call update_marks(1003, 80);
