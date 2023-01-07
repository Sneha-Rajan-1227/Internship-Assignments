create database training;
use training;
CREATE TABLE demography (
    CustID INT AUTO_INCREMENT,
    cust_name VARCHAR(50),
    Age INT,
    Gender VARCHAR(1),
    primary key(CustID)
);
insert into demography(cust_name,Age,gender)
values('John',25,'M');
insert into demography(cust_name,Age,gender)
values('Pawan', 26,'M');
insert into demography(cust_name,Age,gender)
values('Hema',31,'F');
insert into demography(cust_name,gender)
values('Rekha','F');
select * from demography;
update demography set age=NULL where cust_name='John';
Tablesselect * from demography;
##Retrieve all  rows and columns from table ‘demography’ where age is null
select * from demography where age is NULL;
#Delete all the rows from the table ‘demography’.
delete from demography;
#Drop the table ‘demography’
drop table demography;

/*Module 2 – Where Clause:
Run the queries present in MySQL_Assignment_data file before proceeding to the assignments for this module*/
#Retrieve the account ID, customer ID, and available balance for all accounts whose status equals 'ACTIVE' and whose available balance is greater than $2,500.
use sql_assignment;
select account_id,cust_id,avail_balance from account where status='ACTIVE' and avail_balance>2500;
#Construct a query that retrieves all accounts opened in 2002.
select * from account where year(open_date)=2002;
#Retrieve the account ID, available balance and pending balance for all accounts where available balance is not equal to pending balance.
use sql_assignment;
select account_id,avail_balance,pending_balance from account where avail_balance!=pending_balance;
#Retrieve account ID, Product code for the account ID’s 1,10,23,27
select account_id,product_cd from account where account_id in('1','10','23','27');
#Retrieve account ID, available balance from all those accounts whose available balance is in between 100 and 200.
select account_id,avail_balance from account where avail_balance between 100 and 200;
/*Module 3 - Operators and Functions:
Construct a query that counts the number of rows in the account table.
*/
select count(*) from account;
#Retrieve the first two rows from account table
select * from account
limit 2;
#Retrieve the third and fourth row from account table.
select * from account
where account_id in ('3','4')
order by account_id;
#retrieve year of birth, month of birth, day of birth, weekday of birth for all the individuals from the table individual
select year(birth_date),month(birth_date) as month_of_date,day(birth_date) as date_of_birth,weekday(birth_date) as day_born,dayname(birth_date) as weekday_name from individual
order by year(birth_date);
#Write a query that returns the 17th through 25th characters of the string 'Please find the substring in this string'.
select substring("Please find the substring in this string",17,25-17+1) as position;
#Write a query that returns the absolute value and sign (-1, 0, or 1) of the number -25.76823.Also return the number rounded to the nearest hundredth.
select abs(-25.76823) as absolute_value,sign(-25.76823) as sign_of_num,round(-25.76823,-5) as round_to_hundred;
#Write a query that adds 30 days to the current date.
select date_add(current_date(),interval 30 day) as day_after_30_days;
#Retrieve the first three letters of first name and last three letters of last name from the table individual.
select left(fname,3) as first_name,right (lname,3) as right_name from individual;
#Retrieve the first names in Upper case from individual whose first name consists of five characters
select upper(fname) from individual where length(fname)=5;
#Retrieve the maximum balance and average balance from the account table for customer ID = 1.
select max(avail_balance),avg(avail_balance) from account where cust_id='1';
/*Module 4 – Group by:
Construct a query to count the number of accounts held by each customer. Show the customer ID and the number of accounts for each customer.*/
select cust_id,count(cust_id) as individual_count from account
group by cust_id;
#Modify the previous query to fetch only those customers who has more than two accounts.
select cust_id,count(cust_id) as individual_count from account
group by cust_id
having individual_count>2;
#Retrieve first name and date of birth from individual and sort them from youngest to oldest.
select fname,birth_date from individual
order by birth_date desc;
#From the account table, retrieve the year of account opening (year part of open_date) and average available balance (avail_balance) present in the accounts that are opened in each calendar year. Retrieve the year only if the average balance is greater than 200. Also sort the results based on calendar year.
select year(open_date) as open_year,avg(avail_balance) as average 
from account
group by open_year
having average>200
order by open_year;
#Retrieve the product code and maximum pending balance for the product codes (CHK, SAV, CD)  present in account table. 
select product_cd,max(pending_balance) 
from account
group by product_cd
having product_cd in ('CHK','SAV','CD');
/*Module 5 – Joins and sub-query:
Retrieve first name, title and department name by joining tables employee and department using department id.*/
select e.fname,e.title,d.name from employee e join department d using(dept_id)
order by fname;
#Left join table product with table product_type (product_type left join product) to retrieve product_type.name and product.name from the tables.
select py.name as product_type_name,p.name as product_name
from product p left join product_type py
using(product_type_cd);
#Using inner join, Retrieve the full employee name (fname followed by a space and then lname), Superior name (using superior_emp_id) from the employee table.Ex, for Susan Barker, Michael is superior
select concat(e1.fname,' ',e1.lname),e2.superior_emp_id  from employee e1 join employee e2  on e1.superior_emp_id=e2.superior_emp_id 
order by superior_emp_id; 
#Using subquery, retrieve the fname and lname of the employees whose superior is ‘Susan Hawthorne’ from employee
select emp_id,fname,lname,superior_emp_id from employee where superior_emp_id=(select emp_id 
from employee where fname='Susan' and lname='Hawthorne');
#In employee table, retrieve the superior names (fname and lname) present in department 1. A person is superior if he/she is superior to atleast one person in the given department. Use sub-query concept.
select e.fname,e.lname,e.superior_emp_id from employee e inner join department d using(dept_id) where(d.dept_id='1')
group by e.superior_emp_id
having e.superior_emp_id=(select emp_id from employee where count(emp_id)>1)
order by e.superior_emp_id;
select e.emp_id,e.fname,e.lname,d.dept_id from employee e join department d using(dept_id)
where e.emp_id in (select superior_emp_id from employee);
