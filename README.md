# sql-challenge
Module 9: SQL Challenge

# Background
As a new data engineer, conduct a research project about the employees whom the company employed during the 1980s and 1990s. This is based on six CSV files from that time period.

# Objective
For this project, design the tables to hold the data from the CSV files, import the CSV files into a SQL database, and then answer questions about the data. This entails data modeling, data engineering and data analysis, respectively.

# Data Modeling
After inspecting the CSVs, create an ERD using Quick Database Diagrams.
![QuickDBD-Free Diagram](https://github.com/RP8844/sql-challenge/assets/118138351/530bb332-f03d-4350-a36b-dede4851775f)

# Data Engineering
Create a table schema for each of the six CSV files with specific data types, primary keys, foreign keys, and constraints.


-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/HwZKUc
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "DEPARTMENTS" (
    "Dept_No" varchar   NOT NULL,
    "Dept_Name" varchar   NOT NULL,
    CONSTRAINT "pk_DEPARTMENTS" PRIMARY KEY (
        "Dept_No"
     )
);

CREATE TABLE "TITLES" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_TITLES" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "EMPLOYEE" (
    "emp_no" varchar   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_EMPLOYEE" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "DEPT_EMP" (
    "emp_no" varchar   NOT NULL,
    "dept_no" varchar   NOT NULL,
    CONSTRAINT "pk_DEPT_EMP" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "DEPT_MANAGER" (
    "dept_no" varchar   NOT NULL,
    "emp_no" varchar   NOT NULL,
    CONSTRAINT "pk_DEPT_MANAGER" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "SALARIES" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_SALARIES" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE "EMPLOYEE" ADD CONSTRAINT "fk_EMPLOYEE_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "TITLES" ("title_id");

ALTER TABLE "DEPT_EMP" ADD CONSTRAINT "fk_DEPT_EMP_emp_no" FOREIGN KEY("emp_no")
REFERENCES "EMPLOYEE" ("emp_no");

ALTER TABLE "DEPT_EMP" ADD CONSTRAINT "fk_DEPT_EMP_dept_no" FOREIGN KEY("dept_no")
REFERENCES "DEPARTMENTS" ("Dept_No");

ALTER TABLE "DEPT_MANAGER" ADD CONSTRAINT "fk_DEPT_MANAGER_dept_no" FOREIGN KEY("dept_no")
REFERENCES "DEPARTMENTS" ("Dept_No");

ALTER TABLE "DEPT_MANAGER" ADD CONSTRAINT "fk_DEPT_MANAGER_emp_no" FOREIGN KEY("emp_no")
REFERENCES "EMPLOYEE" ("emp_no");

ALTER TABLE "SALARIES" ADD CONSTRAINT "fk_SALARIES_emp_no" FOREIGN KEY("emp_no")
REFERENCES "EMPLOYEE" ("emp_no");

# Data Analysis 
## 1. List the employee number, last name, first name, sex and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, ss.salary  
FROM "EMPLOYEE" AS e
JOIN "SALARIES" AS ss
ON e.emp_no = ss.emp_no;

## 2. List the first name, last name and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM "EMPLOYEE"
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;

## 3. List the manager of each dept and their dept no, dept name, emp no, last name and first name.
SELECT dm.dept_no, d."Dept_Name", dm.emp_no, e.last_name, e.first_name
FROM "DEPT_MANAGER" AS dm
JOIN "EMPLOYEE" AS e
ON dm.emp_no = e.emp_no
JOIN "DEPARTMENTS" AS d
ON dm.dept_no = d."Dept_No";

## 4. List the dept no for each employee along with that employee’s EE no, last name, first name and dept name.
SELECT e.emp_no, e.last_name, e.first_name, d."Dept_Name"
FROM "EMPLOYEE" AS e
JOIN "DEPT_EMP" AS de
ON e.emp_no = de.emp_no
JOIN "DEPARTMENTS" AS d
ON d."Dept_No" = de.dept_no
ORDER BY d."Dept_Name" ASC;

## 5. List first name, last name, and sex of each employee with first name Hercules and last name beginning with B.
SELECT first_name, last_name, sex
FROM "EMPLOYEE"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name ASC;

## 6. List each employee in the Sales department. Include EE NO, last name and first name.
SELECT e.emp_no, e.last_name, e.first_name, d."Dept_Name"
FROM "EMPLOYEE" AS e
JOIN "DEPT_EMP" AS de
ON e.emp_no = de.emp_no
JOIN "DEPARTMENTS" AS d
ON d."Dept_No" = de.dept_no
WHERE d."Dept_Name" = 'Sales';

## 7. List each employee in the Sales and Development depts & include their employee number, last name, first name and dept name.
SELECT e.emp_no, e.last_name, e.first_name, d."Dept_Name"
FROM "EMPLOYEE" AS e
JOIN "DEPT_EMP" AS de
ON e.emp_no = de.emp_no
JOIN "DEPARTMENTS" AS d
ON d."Dept_No" = de.dept_no
WHERE d."Dept_Name" = 'Sales' OR d."Dept_Name" = 'Development';

## 8. List the frequency counts, in descending order, of all the employee last names (how many employees share each last name).
SELECT last_name, COUNT(emp_no) as num_employees_with_same_last_name
FROM "EMPLOYEE"
GROUP BY last_name
ORDER BY num_employees_with_same_last_name DESC;
