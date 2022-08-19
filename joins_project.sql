
SELECT * FROM joins_project..employees;
SELECT * FROM joins_project..dept_manager;
SELECT * FROM joins_project..departments;
SELECT * FROM joins_project..salaries;

-- Inner Join--------------------------------------------

-- Extract all managers' employees number, department number, 
-- department name, from_date, to_date. Order by the manager's department number

SELECT m.emp_no, m.dept_no, d.dept_name, m.from_date, m.to_date
FROM joins_project..dept_manager m
INNER JOIN joins_project..departments d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Extract a list containing information about all managers'
-- employee number, first and last name, dept_number and hire_date

SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM joins_project..dept_manager m
JOIN joins_project..employees e
ON m.emp_no = e.emp_no
ORDER BY m.dept_no;

-- Ignore Duplicate Records Using Inner Joins and Group By

INSERT INTO joins_project..dept_manager 
VALUES 	('10228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO joins_project..departments 
VALUES	('d004', 'Customer Service');

SELECT m.emp_no, m.dept_no, d.dept_name  ---- add COUNT(*) to check the duplicates.
FROM joins_project..dept_manager m
INNER JOIN joins_project..departments d
ON m.dept_no = d.dept_no
GROUP BY m.emp_no, m.dept_no, d.dept_name
ORDER BY m.dept_no;

-- LEFT OUTER JOIN ---------------------------------------------------
-- All the data from the left table and common data or null from the right table

INSERT INTO joins_project..dept_manager 
VALUES 	('11001', 'd010', '1992-03-21', '9999-01-01'),
		('11002', 'd011', '1992-03-21', '9999-01-01');

SELECT m.emp_no, m.dept_no, d.dept_name 
FROM joins_project..dept_manager m
LEFT JOIN joins_project..departments d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- RIGHT INNER JOIN --------------------------------------------------
-- All the data from the right table and only common data otherwise null from the left table.

SELECT m.emp_no, m.dept_no, d.dept_name  
FROM joins_project..dept_manager m
RIGHT JOIN joins_project..departments d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- FULL OUTER JOIN -----------------------------------------------------
-- It shows all the data from the both tables combined and null in the place of missing data from the tables.

SELECT m.emp_no, m.dept_no, d.dept_name  
FROM joins_project..dept_manager m
FULL OUTER JOIN joins_project..departments d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- JOIN and WHERE used together -----------------------------

-- 6.4: Join the 'employees' and the 'dept_manager' tables to return a subset
-- of all the employees whose last name is 'Markovitch'. 
-- See if the output contains a manager with that name

SELECT e.emp_no, m.dept_no, e.first_name , e.last_name
FROM joins_project..employees e
JOIN joins_project..dept_manager m
ON e.emp_no = m.emp_no
WHERE e.last_name = 'Bonifati';

-- Joins with Aggregate Functions ----------------------------------

SELECT e.gender, AVG(s.salary) AS average_salary
FROM joins_project..employees e
JOIN joins_project..salaries s 
	ON e.emp_no = s.emp_no
GROUP BY gender;

-- How many males and how many females managers do we have in
-- employees database?

SELECT e.gender, COUNT(m.emp_no) AS manager_count
FROM joins_project..employees e
JOIN joins_project..dept_manager m
	ON e.emp_no = m.emp_no
GROUP BY e.gender;


-- Joining Multiple Tables ----------------------------

-- Retrieve the average salary for the different departments where the
-- average_salary is more than 60000

SELECT d.dept_name, AVG(s.salary) AS average_salary
FROM joins_project..departments d
JOIN joins_project..dept_emp e
	ON d.dept_no = e.dept_no
JOIN joins_project..salaries s
	ON e.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING AVG(s.salary)>60000
ORDER BY average_salary ASC;