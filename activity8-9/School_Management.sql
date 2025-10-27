/* School Management System
Create a database for students, classes, and marks.
 Insert records and perform joins to display class-wise student marks, use aggregate functions to find average marks per class, 
 and procedures to insert a new student and update marks.
*/
create database school_management;
use school_management;

create table students
(student_id varchar(20)primary key,
student_name varchar(20),
age int);

create table classes
(classes_id varchar(20)primary key,
class_name varchar(20),
subjects varchar(20));

create table marks
(marks_id varchar(20)primary key,
total_marks int,
student_id varchar(20),
classes_id varchar(20),
foreign key(student_id) references students(student_id),
foreign key(classes_id) references classes(classes_id));

insert into students (student_id, student_name, age) values
('S001', 'Alice', 15),
('S002', 'Bob', 16),
('S003', 'Charlie', 15);

insert into classes (classes_id, class_name, subjects) values
('C001', '10th Grade', 'Math'),
('C002', '10th Grade', 'Science'),
('C003', '9th Grade', 'English');

insert into marks (marks_id, total_marks, student_id, classes_id) values
('M001', 85, 'S001', 'C001'),
('M002', 90, 'S002', 'C001'),
('M003', 78, 'S003', 'C002');

select c.class_name,t.total_marks
from marks t
inner join classes c on t.classes_id= c.classes_id;

select c.class_name ,m.total_marks,avg(m.total_marks)
from marks m
inner join classes c on m.classes_id= c.classes_id
group by c.class_name,m.total_marks;

delimiter $$
create procedure  insertstudent
(stu_id varchar(20),
stu_name varchar(20),
age int)
begin 
     insert into students(student_id,student_name, age)
     values(stu_id,stu_name,age);
	end $$
    delimiter ;
call insertstudent('S4','suzain',19);
select *from students;

delimiter $$
create procedure  updatestudent
(stu_id varchar(20),
ag int)
begin
	update students
    set age =ag
    where student_id= stu_id;
    end $$
    delimiter ;
call updatestudent('S4',20);
select *from students;