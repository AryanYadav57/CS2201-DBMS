/*Create a database to manage books, members, and book issue records.
 Implement relationships using keys, insert records, and write SQL queries using aggregate functions (like total issued books per member), joins, date functions (issue/return dates), and a stored procedure to update book availability.
*/
create database librarys;
use librarys;

create table books
(book_id varchar(30)primary key,
book_name varchar(20),
author_name varchar(30));

create table members
(member_id varchar(20)primary key,
member_name varchar(20),
email varchar(30));

create table book_issued
(issued_id varchar(20)primary key,
book_id varchar(30),
member_id varchar(20),
issued_date date,
foreign key (book_id) references books(book_id),
foreign key (member_id) references members(member_id));

insert into books(book_id, book_name, author_name) values
('B001', 'Harry Potter', 'J.K. Rowling'),
('B002', 'The Alchemist', 'Paulo Coelho'),
('B003', '1984', 'George Orwell');

insert into members(member_id, member_name, email) values
('M001', 'Alice', 'alice@example.com'),
('M002', 'Bob', 'bob@example.com'),
('M003', 'Charlie', 'charlie@example.com');

insert into book_issued(issued_id, book_id, member_id, issued_date) values
('I001', 'B001', 'M001', '2025-10-26'),
('I002', 'B002', 'M001', '2025-10-26'),
('I003', 'B003', 'M002', '2025-10-25');

select m.member_name,count(issued_id)
from book_issued b
inner join members m on b.member_id = m.member_id
group by member_name;

select b.book_name,
       m.member_name,
       i.issued_id
from book_issued i
inner join books b on i.book_id = b.book_id
inner join members m on i.member_id = m.member_id ;

select b.book_name, m.member_name, i.issued_date , year(issued_date),
month(issued_date)
from book_issued i
inner join books b on i.book_id = b.book_id
inner join members m on i.member_id = m.member_id ;

alter table books add availibility boolean default TRUE;

delimiter $$
create procedure update_availibility
(in bk_id varchar(30),
in avil boolean)
begin 
update books
set availibility = avil
where book_id =bk_id;
end $$
delimiter ;

call update_availibility('B001',false);
select* from books;