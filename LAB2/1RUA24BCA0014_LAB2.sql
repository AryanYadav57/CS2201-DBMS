-- Lab Experiment 01: Implementation of DDL Commands in SQL for the given scenarios
-- STUDENT NAME: Aryan Yadav
-- USN: 1RUA24BCA0014 
-- SECTION: A

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- root@localhost, RVU-PC-069, 9.4.0, 2025-08-25 05:58:39


-- Scenario: College Student Management System

-- CREATE AND LOAD THE database
-- Write your SQL query below Codespace:
create database DBLab0002;
use DBLab0002;

-- Task 1: Create the Tables under this system (min 5 tables)
  -- Table 01: Departments ( DepartmentID, DepartmentName, HOD,ContactEmail,PhoneNumber,Location )
  -- Table 02: Course (CourseID, CourseName,Credits,DepartmentID,Duration,Fee )
  -- Table 03: Students (StudentID,FirstName,LastName,Email,DateOfBirth,CourseID)
  -- Table 04: Faculty FacultyID,FacultyName,DepartmentID,Qualification,Email,PhoneNumber)
  -- Table 05: Enrollments (  EnrollmentID,StudentID,CourseID,Semester,Year,Grade)
-- Specify the Key (Primary and Foreign) for each table while creating


-- Write your SQL query below Codespace:
create table departments(
departmentID int primary key,
departmentName varchar(15),
HOD varchar(10),
phoneNumber int,
location varchar(15)
);

create table course (
courseID varchar(10) primary key,
CourseName varchar(15),
credits int,
departmentID int,
foreign key(departmentID) references departments(departmentID),
duration varchar(15),
fee int);

create table students (
studentID varchar(15) primary key,
FirstName varchar(15),
LastName varchar(15),
email varchar(25),
DOB date,
courseID varchar(5),
foreign key(courseID) references course(courseID));

create table faculty (
facultyID varchar(15) primary key,
facultyName varchar(20),
departmentID int,
foreign key(departmentID) references departments(departmentID),
qualifications varchar(15),
email varchar(20),
phoneNumber int);

create table enrollments (
enrollmentID varchar(10),
studentID varchar(15),
departmentID int,
foreign key(departmentID) references departments(departmentID),
foreign key(studentID) references students(studentID),
semester int,
Year int,
grade numeric);


-- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code
desc departments;
/* departmentID	int	NO	PRI		
departmentName	varchar(15)	YES			
HOD	varchar(10)	YES			
phoneNumber	int	YES			
location	varchar(15)	YES			
*/

desc course;
/* courseID	varchar(10)	NO	PRI		
CourseName	varchar(15)	YES			
credits	int	YES			
departmentID	int	YES	MUL		
duration	varchar(15)	YES			
fee	int	YES			
*/

desc students;
/* studentID	varchar(15)	NO	PRI		
FirstName	varchar(15)	YES			
LastName	varchar(15)	YES			
email	varchar(25)	YES			
DOB	date	YES			
courseID	varchar(5)	YES	MUL		
*/

desc faculty;
/* facultyID	varchar(15)	NO	PRI		
facultyName	varchar(20)	YES			
departmentID	int	YES	MUL		
qualifications	varchar(15)	YES			
email	varchar(20)	YES			
phoneNumber	int	YES			
*/

desc enrollments;
/* enrollmentID	varchar(10)	YES			
studentID	varchar(15)	YES	MUL		
departmentID	int	YES	MUL		
semester	int	YES			
Year	int	YES			
grade	decimal(10,0)	YES			
*/

--  describe the structure of each table and copy paste the Output 

-- Perform the following operations on the each of the tables

-- 01: add 2 new columns for each table
alter table departments add( manager varchar(15), establishedYear int);
alter table course add( syllabus varchar(25), instructor varchar(20));
alter table students add( gender varchar(15), address varchar(20));
alter table faculty add( departmentName varchar(20), joiningDate date);
alter table enrollments add( erollmentDate date, status varchar(15));

-- 02: Modify the existing column from each table
alter table departments modify HOD varchar(20);
alter table course modify duration varchar(20);
alter table students modify FirstName varchar(15);
alter table faculty modify facultyName varchar(15);
alter table enrollment modify grade decimal (2,2);

-- 03 change the datatypes
alter table course modify fee decimal(10,2);
alter table faculty modify phoneNumber varchar(15);

-- 04: Rename a column
alter table students rename column DOB to DateOfBirth;

-- 05: Drop a column
alter table departments drop column phoneNumber;

-- 06: Rename the table
alter table students rename to StudentDetails;

-- 07: describe the structure of the new table
desc StudentDetails;


/*  Additional set of questions 
--1 Add a new column Address (VARCHAR(100)) to the Students table.
    -- already done

--2 Add a column Gender (CHAR(1)) to the Students table.
    --already done

--3 Add a column JoiningDate (DATE) to the Faculty table.
    -- already done
  */  
-- 4 Modify the column CourseName in the Courses table to increase its size from VARCHAR(50) to VARCHAR(100).
alter table course modify courseName varchar(100);


 -- 5 Modify the column Location in the Departments table to VARCHAR(80).
alter table departments modify location varchar(80);


-- 6 Rename the column Qualification in the Faculty table to Degree.
	alter table faculty rename column qualifications to degree; 
    
 -- 7 Rename the table Faculty to Teachers.
alter table faculty rename to teachers;

-- 8 Drop the column PhoneNumber from the Departments table.
-- done

-- 9 Drop the column Email from the Students table.
alter table studentDetails drop column email;

-- 10 Drop the column Duration from the Courses table.
alter table course drop column duration;

SHOW TABLES; -- Before dropping the table
/* 
course
departments
enrollments
faculty
students
*/
-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:
drop table enrollments;
-- courses cannot be droppped beacause of the foreign key

SHOW TABLES; -- After dropping the table Enrollement and Course
/* 
course
departments
faculty
students
*/

-- Note: Perform the specified operations on all the 5 tables in the system
-- End of Lab Experiment 01
-- Upload the Completed worksheet in the google classroom with file name USN _ LabScenario01
