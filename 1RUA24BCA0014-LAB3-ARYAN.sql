-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 02: Program 02 - Implementation of DML Commands in SQL ( INSERT , SELECT, UPDATE and DELETE )
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: 
-- USN: 
-- SECTION: 
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command
-- 11:32:18	SELECT USER(),         @@hostname AS Host_Name,         VERSION() AS MySQL_Version,         NOW() AS Current_Date_Time LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec


-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Scenario: You are managing a database for a library with two tables: Books and Members.
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Task 01: Create Tables [ Check the below mentioned Instructions:
-- Create the Books and Members tables with the specified structure.
-- Books Table and Member Table : 
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task with the Instructed Column in the session 
create database Library_Management;
use Library_Management;

create table books(
book_ID int primary key,
title varchar(15),
author varchar(10)
);

alter table books modify column title varchar(30);
alter table books modify column author varchar(30);

create table members(
member_ID int primary key,
member_name varchar(15),
phone_number int
);

alter table members modify column member_name varchar(30);
alter table members rename column phone_number to date_joined;
alter table members modify column date_joined varchar(30);

desc books;
desc members;


-- Paste the Output below for the given command ( DESC TableName;) 

/*'book_ID', 'int', 'NO', 'PRI', NULL, ''
'title', 'varchar(15)', 'YES', '', NULL, ''
'author', 'varchar(10)', 'YES', '', NULL, ''
*/
/*'member_ID', 'int', 'NO', 'PRI', NULL, ''
'member_name', 'varchar(15)', 'YES', '', NULL, ''
'phone_number', 'int', 'YES', '', NULL, ''
*/

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 02: Insert a New Book
-- Instructions: Insert a book titled "1984_The Black Swan" by George Orwell (published in 1949) with 04 available copies and 10 Total copies. 
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

insert into books values
(001, '1984_The Black Swan', 'George Orwell'),
(002, '48_Laws of Power', 'Robert Greene'),
(003, 'Harry Potter', 'JK Rowling'),
(004, 'Spider-Man', 'Stanley'),
(005, 'The Alchemist', 'Aryan Yadav');

select * from books;

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
/*
# book_ID	title	author
1	1984_The Black Swan	George Orwell
2	48_Laws of Power	Robert Greene
3	Harry Potter	JK Rowling
4	Spider-Man	Stanley
5	The Alchemist	Aryan Yadav
*/

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 03: Add New Members
-- Instructions: Insert two members: David Lee (Platinum, joined 2024-04-15) and Emma Wilson (Silver, joined 2024-05-22).
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

insert into members values
(001, 'Aryan Yadav', '2020-11-11'),
(002, 'Riyan Shreshtha', '2022-8-9'),
(003, 'Girish Kailash', '2021-9-9'),
(004, 'Sumukh Ravikumar', '2023-10-11'),
(005, 'Swaroop R', '2024-7-8');

select * from members;

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

/*
# member_ID	member_name	date_joined
1	Aryan Yadav	2020-11-11
2	Riyan Shreshtha	2022-8-9
3	Girish Kailash	2021-9-9
4	Sumukh Ravikumar	2023-10-11
5	Swaroop R	2024-7-8
*/

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 04: Update Book Details 
-- Instructions: The library acquired 2 additional copies of "1984_The Black Swan". Update the Books table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

alter table books add publoc varchar(20);
update books set publoc = 'bangalore';

select * from books;

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
/*
# book_ID	title	author	publoc
1	1984_The Black Swan	George Orwell	bangalore
2	48_Laws of Power	Robert Greene	bangalore
3	Harry Potter	JK Rowling	bangalore
4	Spider-Man	Stanley	bangalore
5	The Alchemist	Aryan Yadav	bangalore
*/
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 05: Modify a Member's Information
-- Instructions: Update a member's membership type. Emma Wilson has upgraded her membership from 'Silver' to 'Gold'.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

alter table members add membership_type varchar(25);
update members set membership_type = 'Gold';
select * from members;


-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
/*
# member_ID	member_name	date_joined	membership_type
1	Aryan Yadav	2020-11-11	Gold
2	Riyan Shreshtha	2022-8-9	Gold
3	Girish Kailash	2021-9-9	Gold
4	Sumukh Ravikumar	2023-10-11	Gold
5	Swaroop R	2024-7-8	Gold
*/
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 06: Remove a Member
-- Instructions: Delete David Lee’s record from the Members table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

delete from members
where name = 'Swaroop R';







-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 09: Borrowing Table 
-- Instructions: Create a Borrowing table with foreign keys referencing Books and Members.
-- Subtask 1: Borrow a Book
-- Scenario:Emma Wilson (member_id = 2) borrows the book "The Catcher in the Rye" (book_id = 102) on 2024-06-01. Insert this record into the Borrowing table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.








-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 10: Find the name of Borrower who book = 102 [ Advance and Optional ]
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.








-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Final Task 00: ER Diagram - Instructions:
-- Draw an ER diagram for the library database. Additional Upload the scanned copy of the created ER Daigram in the Google Classroom.



-- END of the Task -- 