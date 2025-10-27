/*Design a payroll database with tables for employee,institute, departments, and salary details.
 Include primary/foreign key constraints, insert sample data, and write queries using aggregate functions (sum, avg), group by department, join employee and department details, and procedures to insert and update salary.
*/
create database institution;
use institution;

create table institute
(institute_id varchar(20)primary key,
institute_name varchar(30));

create table departments
(department_id varchar(30)primary key,
department_name varchar(40),
email varchar(30),
institute_id varchar(30),
foreign key (institute_id) references institute(institute_id));

create table Employee(
Employee_id varchar(30)primary key,
employee_name varchar(30),
contact int,
department_id varchar(30),
foreign key (department_id) references departments(department_id));

create table salary
(salary_id varchar(20) primary key,
Employee_id varchar(30),
total_salary decimal(10,2),
foreign key (Employee_id) references Employee(Employee_id));

INSERT INTO institute VALUES
('I1', 'Tech Institute'),
('I2', 'Global Academy'),
('I3', 'Future Skills College');

INSERT INTO departments VALUES
('D1', 'Computer Science', 'cs@tech.edu', 'I1'),
('D2', 'Mathematics', 'math@global.edu', 'I2'),
('D3', 'Business Management', 'bm@future.edu', 'I3');

INSERT INTO employee VALUES
('E1', 'Alice', 3457, 'D1'),
('E2', 'Bob', 4512, 'D2'),
('E3', 'Charlie', 328, 'D3');

INSERT INTO salary VALUES
('S1', 'E1', 55000.00),
('S2', 'E2', 60000.00),
('S3', 'E3', 65000.00);

select d.department_name ,sum(s.total_salary),avg(s.total_salary)
from employee e
inner join departments d on e.department_id = d.department_id
inner join salary s on  e.employee_id = s.employee_id
group by department_name;

select e.employee_name , d.department_name
from employee e
inner join departments d on e.department_id = d.department_id;


delimiter $$
create procedure insertsalary
(sal_id varchar(20),
Emp_id varchar(30),
tot_sal decimal(10,2)
)
begin
     insert into salary(salary_id,Employee_id,total_salary) 
     values(sal_id,Emp_id,tot_sal);
end $$
delimiter ;

call insertsalary('S4','E3','55555.00');
select *from salary;

delimiter $$
create procedure updatesalary
(sal_id varchar(20),
tot_sal decimal(10,2))
begin 
    update salary
    set total_salary = tot_sal
    where salary_id = sal_id;
end $$
delimiter ;
call updatesalary('S1','56789.00');
select *from salary;

INSERT INTO employee (employee_id, employee_name, contact, department_id)
VALUES ('E4', 'David', 10, 'D3');
select *from employee ;