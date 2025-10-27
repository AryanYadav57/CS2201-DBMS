-- 1.Hospital Database
create database HospitalDB;
use HospitalDB;
create table Doctors (
doctor_id int Primary Key,
doctor_name varchar(20),
specialization varchar(15),
experience varchar(15));
create table Patients (
patient_id int Primary key,
patient_name varchar(20),
gender varchar(8),
phone_no int);
create table Appointment (
apt_id int primary key,
doctor_id int,
patient_id int,
disease varchar(20),
fees decimal(10,2));
insert into Doctors values
(501, 'Dr.ABC', 'Lung', 18),
(502, 'Dr. XYZ', 'Cancer', 5),
(503, 'Dr.lemon', 'Heart', 12);
select * from Doctors;
/*
# doctor_id, doctor_name, specialization, experience
'501', 'Dr.ABC', 'Lung', '18'
'502', 'Dr. XYZ', 'Cancer', '5'
'503', 'Dr.lemon', 'Heart', '12'
*/
insert into Patients value
(301, 'Sumukh', 'M', 2653846),
(302, 'Girish', 'M', 5698421),
(303, 'Swaroop', 'M', 451932);
select * from Patients;
/*  
# patient_id	patient_name	gender	phone_no
301	Sumukh	M	2653846
302	Girish	M	5698421
303	Swaroop	M	451932
*/
insert into Appointment (apt_id, patient_id, doctor_id, disease, fees) values
(201, 301, 501, 'Heart cancer', 12300.00),
(202, 302, 503, 'alzhimer', 26000.00),
(203, 303, 501, 'lung cancer', 1500.00),
(204, 301, 502, 'Cancer', 5600.00);
select * from Appointment;
/* 
# apt_id	doctor_id	patient_id	disease	fees
201	501	301	Heart cancer	12300.00
202	503	302	alzhimer	26000.00
203	501	303	lung cancer	1500.00
204	502	301	Cancer	5600.00

*/
-- Aggregate function
select count(*) as Total_Patient from Patients; 
select avg(fees) as AVG_fees from Appointment;

-- Inner join
select p.patient_name, d.doctor_name, a.disease, a.fees
from Patients p
inner join Appointment a on p.patient_id = a.patient_id
inner join Doctors d on a.doctor_id = d.doctor_id;
/*  
# patient_name	doctor_name	disease	fees
Sumukh	Dr.ABC	Heart cancer	12300.00
Girish	Dr.lemon	alzhimer	26000.00
Swaroop	Dr.ABC	lung cancer	1500.00
Sumukh	Dr. XYZ	Cancer	5600.00
*/
-- Left join 
select p.patient_name, d.doctor_name, a.disease
from Patients p
left join Appointment a on p.patient_id = a.patient_id
left join Doctors d on a.doctor_id = d.doctor_id;
/*  
# patient_name	doctor_name	disease
Sumukh	Dr. XYZ	Cancer
Sumukh	Dr.ABC	Heart cancer
Girish	Dr.lemon	alzhimer
Swaroop	Dr.ABC	lung cancer
*/
-- Right join
select d.doctor_name, p.patient_name, p.phone_no, a.disease, a.fees
from Doctors d
right join Appointment a on d.doctor_id = a.doctor_id
right join Patients p on a.patient_id = p.patient_id;
/* 
# doctor_name	patient_name	phone_no	disease	fees
Dr.ABC	Sumukh	2653846	Heart cancer	12300.00
Dr. XYZ	Sumukh	2653846	Cancer	5600.00
Dr.lemon	Girish	5698421	alzhimer	26000.00
Dr.ABC	Swaroop	451932	lung cancer	1500.00
*/
select * from Appointment;
-- Procedure 
delimiter //
create procedure Insert_appt (
in apt_id int,
in doctor_id int, 
in patient_id int,
in disease varchar(30),
in fees decimal(10,2)
)
begin 
 insert into Appointment values (apt_id, doctor_id, patient_id, disease, fees);
end //
delimiter ;

call Insert_appt (206, 503, 301, 'pneumonia', 25000.00);
/*  
# apt_id	doctor_id	patient_id	disease	fees
201	501	301	Heart cancer	12300.00
202	503	302	alzhimer	26000.00
203	501	303	lung cancer	1500.00
204	502	301	Cancer	5600.00
206	503	301	pneumonia	25000.00
*/
-- Update
delimiter //
create procedure update_appt (
in p_apt_id int,
in new_fees decimal(10,2)
)
begin 
update Appointment set fees = new_fees where apt_id = p_apt_id;
end //
delimiter ;
call update_appt (202, 599000.00);

-- 2.Library Management
create database LibraryDB;
use LibraryDB;

create table Books (
Book_id int Primary Key,
Book_name varchar(20),
Publisher varchar(20),
Price Decimal(10,2));
create table Members (
M_id int Primary Key,
M_name varchar(20),
Gender varchar(5),
join_date date);
create table Issue_Record (
issue_id int Primary Key,
Book_id int,
M_id int,
issue_date date,
return_date date,
foreign key(Book_id) references Books(Book_id),
foreign key(M_id) references Members(M_id));
insert into Books values 
(101, 'Harry Potter', 'JK.Rowling', 1500.00),
(102, 'Alchimist', 'Someone', 400.00),
(103, 'Peter', 'Almight', 500.00);
select * from Books;
/*  
# Book_id	Book_name	Publisher	Price
101	Harry Potter	JK.Rowling	1500.00
102	Alchimist	Someone	400.00
103	Peter	Almight	500.00
*/
insert into Members values
(201, 'Girish', 'M', '2023-08-10'),
(202, 'Swaroop', 'M', '2023-09-10'),
(203, 'Riyan', 'M', '2023-12-19');
select * from Members;
/*  
# M_id	M_name	Gender	join_date
201	Girish	M	2023-08-10
202	Swaroop	M	2023-09-10
203	Riyan	M	2023-12-19
*/
insert into Issue_Record values
(501, 101, 201, '2025-07-12', '2025-08-10'),
(502, 102, 203, '2025-01-01', '2025-04-12'),
(503, 101, 202, '2025-04-10', '2025-05-11'),
(504, 103, 201, '2025-08-10', '2025-10-12');
select * from Issue_Record;
/*  
# issue_id	Book_id	M_id	issue_date	return_date
501	101	201	2025-07-12	2025-08-10
502	102	203	2025-01-01	2025-04-12
503	101	202	2025-04-10	2025-05-11
504	103	201	2025-08-10	2025-10-12
*/
-- Aggregate functions
select count(*) as Total_Books from Books;
select m.M_name, count(i.issue_id) as Issue_Books
from Members m
left join Issue_Record i on m.M_id = i.M_id 
group by m.M_name;
/*  
# M_name	Issue_Books
Girish	2
Swaroop	1
Riyan	1
*/
-- Inner join
select b.Book_name, m.M_name, i.issue_id
from Books b
inner join Issue_Record i on b.Book_id = i.Book_id
inner join Members m on i.M_id = m.M_id;
/*  
# Book_name	M_name	issue_id
Harry Potter	Girish	501
Harry Potter	Swaroop	503
Alchimist	Riyan	502
Peter	Girish	504
*/
-- Procedure
delimiter //
create procedure Insert_Books (
IN B_id int,
IN B_name varchar(20),
IN B_Publisher varchar(20),
IN B_Price decimal(10,2)
)
Begin 
insert into Books values 
(B_id, B_name, B_Publisher, B_Price);
end //
delimiter ; 
call Insert_Books (104, 'hail hitler', 'Adolf Hitler', 1800.00);
select * from Books;
/* 
# Book_id	Book_name	Publisher	Price
101	Harry Potter	JK.Rowling	1500.00
102	Alchimist	Someone	400.00
103	Peter	Almight	500.00
104	hail hitler	Adolf Hitler	1800.00
*/

-- Update
delimiter //
create procedure Update_Price (
IN B_id int,
IN new_price decimal(10,2)
)
begin 
update Books set price = new_price where Book_id = B_id;
end //
delimiter ;
call Update_Price (102, 250);
/*  
# Book_id	Book_name	Publisher	Price
101	Harry Potter	JK.Rowling	1500.00
102	Alchimist	Someone	250.00
103	Peter	Almight	500.00
104	hail hitler	Adolf Hitler	1800.00
*/