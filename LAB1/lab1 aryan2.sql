create database school1;
use school1;
create table student
( USN varchar(15),
name varchar(15),
age int,
m1 int,
m2 int);
create table staff
 ( name varchar(15),
 age int,
 salary int);
 create table course 
 ( coursecode varchar(15),
 coursename varchar(20),
 credits int);
 create table classrooms
 ( classrooms int,
 buildingname varchar(15),
 capacity int);
 alter table classrooms
 modify buildingname varchar(20);
 desc classrooms;
 alter table student
 add ( total int,
 average numeric(5,2));
 desc student;