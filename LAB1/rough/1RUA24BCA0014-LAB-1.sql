-- Lab Experiment 01: Implementation of DDL Commands in SQL
-- STUDENT NAME: Aryan Yadav
-- USN: 1RUA24BCA0014
-- SECTION: BCA

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- 11:42:11	SELECT USER(),         @@hostname AS Host_Name,         VERSION() AS MySQL_Version,         NOW() AS Current_Date_Time LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec


-- Scenario: University Course Management System
-- CREATE AND LOAD THE database DBLab001
-- Write your SQL query below Codespace:

create database BCALab1;
use BCALab1;

-- Task 1: Create the Students Table
-- Create a table to store information about students.
-- Include the following columns:
-- 1. StudentID (Primary Key)
-- 2. FirstName
-- 3. LastName
-- 4. Email (Unique Constraint)
-- 5. DateOfBirth

-- Write your SQL query below Codespace:

create table Students (
student_id varchar(10) Primary Key,
First_Name varchar(15),
Last_Name varchar(15),
Email varchar(50) UNIQUE,
Date_Of_Birth date
);

DESC STUDENTS; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code

-- # Field	Type	Null	Key	Default	Extra
-- student_id	varchar(10)	NO	PRI		
-- First_Name	varchar(15)	YES			
-- Last_Name	varchar(15)	YES			
-- Email	varchar(50)	YES	UNI		
-- Date_Of_Birth	date	YES			

-- Alter the table and 2 new columns
-- Modify a column data type
-- Rename a column
-- Drop a column
-- Rename the table




-- Task 2: Create the Courses Table
-- Create a table to store information about courses.
-- Include the following columns:
-- - CourseID (Primary Key)
-- - CourseName
-- - Credits

-- Write your SQL query below Codespace:
create Table courses (
course_id varchar(10) Primary key,
course_name varchar(20),
Credits int
);

DESC Courses; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- OUTPUT :
/*
'course_id', 'varchar(10)', 'NO', 'PRI', NULL, ''
'course_name', 'varchar(20)', 'YES', '', NULL, ''
'Credits', 'int', 'YES', '', NULL, ''
*/





-- Alter the table and 2 new columns
alter table courses add (course_teacher varchar(20), Department varchar(10));
DESC COURSES;
-- Modify a column data type
alter table courses modify column Department varchar(20);
DESC COURSES;
-- Rename a column
alter table courses rename column credits to Credit;
DESC COURSES;
-- Drop a column
alter table courses drop Department;
-- Rename the table
Rename table courses to COURSE;
DESC COURSE;


-- Task 3: Create the Enrollments Table
-- Create a table to store course enrollment information.
-- Include the following columns:
-- - EnrollmentID (Primary Key)
-- - StudentID (Foreign Key referencing Students table)
-- - CourseID (Foreign Key referencing Courses table)
-- - EnrollmentDate

-- Write your SQL query below Codespace:

create table Enrollments (
enrollment_id varchar(15) primary key,
student_id varchar(15),
course_id varchar(15),
foreign key (student_id) references STUDENTS(student_id),
foreign key (course_id) references COURSE(course_id)
);


DESC ENROLLMENTS; -- [ [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ] ]
-- OUTPUT :

/*
  'enrollment_id', 'varchar(15)', 'NO', 'PRI', NULL, ''
'student_id', 'varchar(15)', 'YES', 'MUL', NULL, ''
'course_id', 'varchar(15)', 'YES', 'MUL', NULL, ''
*/

-- Alter the table and 2 new columns
alter table Students add age int, add Gender varchar(5);
DESC STUDENTS;
-- Modify a column data type
alter table Students Modify Student_id varchar(15);
DESC STUDENTS;
-- Rename a column
alter table students rename column Date_Of_Birth to DOB;
DESC STUDENTS;
-- Drop a column
Alter table Students drop column Age;
DESC STUDENTS;
-- Rename the table
Rename table Students to STUDENTS;
DESC STUDENTS;

-- Task 4: Alter the Students Table
alter table students add(address varchar(10), age varchar(10));
DESC STUDENTS;
-- Add a column 'PhoneNumber' to store student contact numbers.
alter table STUDENTS add column PhoneNumber(15);
DESC STUDENTS;
-- Write your SQL query below Codespace:

DESC STUDENTS; -- [[ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]]

-- Task 5: Modify the Courses Table
-- Change the data type of the 'Credits' column to DECIMAL.
-- Write your SQL query below Codespace:
alter table course modify Credit decimal;
DESC COURSE;

-- Task 6: Drop Tables


SHOW TABLES; -- Before dropping the table

-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:
drop table enrollments;
drop table course;

SHOW TABLES; -- After dropping the table Enrollement and Course

-- End of Lab Experiment 01
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01
