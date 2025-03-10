-- ---------------------------------------
-- Group By
-- Name:	Josef Meßner
-- Datum: 	29.01.24
-- ---------------------------------------

SOURCE C:\TMP\backUp\Group_By.sql

Select Count(Distinct job_id) from employees;

Select Sum(Salary) from employees;

select min(Salary) from employees;

select max(Salary), job_id from employees where job_id = 'IT_PROG';

select AVG(Salary), count(EMPLOYEE_ID) from employees where DEPARTMENT_ID = 90;

select min(Salary), max(Salary), sum(Salary), AVG(Salary) from employees;

select job_id, count(EMPLOYEE_ID) from employees Group By job_id;

select max(Salary)-min(Salary) from employees;

select Manager_id, min(Salary) from employees Group By Manager_id ORDER BY min(Salary) DESC;

select DEPARTMENT_ID, sum(Salary) from employees Group By DEPARTMENT_ID;

Select job_id, AVG(Salary) from employees Group By job_id Having job_id != 'IT_PROG';

Select job_id, min(Salary), max(Salary), sum(Salary), AVG(Salary) from employees where DEPARTMENT_ID = 90 Group By job_id;

select job_id, max(Salary) from employees Group By job_id Having max(Salary) >= 4000.00;

select DEPARTMENT_ID, AVG(Salary) from employees where count(DEPARTMENT_ID) > 10;


