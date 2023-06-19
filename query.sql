--Import each CSV file into its corresponding SQL table.
SELECT * from "DEPARTMENTS"
SELECT * from "DEPT_EMP"
SELECT * from "DEPT_MANAGER"
SELECT * from "EMPLOYEE"
SELECT * from "SALARIES"
SELECT * from "TITLES"

--List the employee number, last name, first name, sex and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, ss.salary  
FROM "EMPLOYEE" AS e
JOIN "SALARIES" AS ss
ON e.emp_no = ss.emp_no;

--List the first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM "EMPLOYEE"
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;

--List the manager of each dept and their dept no, dept name, emp no, last name and first name.
SELECT dm.dept_no, d."Dept_Name", dm.emp_no, e.last_name, e.first_name
FROM "DEPT_MANAGER" AS dm
JOIN "EMPLOYEE" AS e
ON dm.emp_no = e.emp_no
JOIN "DEPARTMENTS" AS d
ON dm.dept_no = d."Dept_No";


--List the dept no for each employee along with that employee’s EE no, last name, first name and dept name.
SELECT e.emp_no, e.last_name, e.first_name, d."Dept_Name"
FROM "EMPLOYEE" AS e
JOIN "DEPT_EMP" AS de
ON e.emp_no = de.emp_no
JOIN "DEPARTMENTS" AS d
ON d."Dept_No" = de.dept_no
ORDER BY d."Dept_Name" ASC;

--List first name, last name, and sex of each employee with first name Hercules and last name beginning with B.
SELECT first_name, last_name, sex
FROM "EMPLOYEE"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name ASC;

--List each employee in the Sales department. Include EE NO, last name and first name.
SELECT e.emp_no, e.last_name, e.first_name, d."Dept_Name"
FROM "EMPLOYEE" AS e
JOIN "DEPT_EMP" AS de
ON e.emp_no = de.emp_no
JOIN "DEPARTMENTS" AS d
ON d."Dept_No" = de.dept_no
WHERE d."Dept_Name" = 'Sales';

--List each employee in the Sales and Development depts & include their employee number, last name, first name and dept name.
SELECT e.emp_no, e.last_name, e.first_name, d."Dept_Name"
FROM "EMPLOYEE" AS e
JOIN "DEPT_EMP" AS de
ON e.emp_no = de.emp_no
JOIN "DEPARTMENTS" AS d
ON d."Dept_No" = de.dept_no
WHERE d."Dept_Name" = 'Sales' OR d."Dept_Name" = 'Development';

--List the frequency counts, in descending order, of all the employee last names (how many employees share each last name).
SELECT last_name, COUNT(emp_no) as num_employees_with_same_last_name
FROM "EMPLOYEE"
GROUP BY last_name
ORDER BY num_employees_with_same_last_name DESC; 





