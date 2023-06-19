# sql-challenge
Module 9: SQL Challenge

# Background
As a new data engineer, conduct a research project about the employees whom the company employed during the 1980s and 1990s. This is based on six CSV files from that time period.

# Objective
Design tables to hold the data from the CSV files, import the CSV files into a SQL database and answer questions about the data. 

This entails:
-Data modeling
-Data engineering
-Data analysis

# Data Modeling
After inspecting the CSVs, create an ERD using Quick Database Diagrams.
![QuickDBD-Free Diagram](https://github.com/RP8844/sql-challenge/assets/118138351/530bb332-f03d-4350-a36b-dede4851775f)

# Data Engineering
Create a table schema for each of the six CSV files with specific data types, primary keys, foreign keys, and constraints.


-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/

-- Link to schema: https://app.quickdatabasediagrams.com/#/d/HwZKUc

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
1. List the employee number, last name, first name, sex and salary of each employee.

2. List the first name, last name and hire date for employees who were hired in 1986.

3. List the manager of each dept and their dept number, dept name, emp number, last name and first name.

4. List the dept number for each employee along with that employee’s employee number, last name, first name and dept name.

5. List first name, last name, and sex of each employee with first name Hercules and last name beginning with B.

6. List each employee in the Sales department. Include employee number, last name and first name.

7. List each employee in the Sales and Development depts and include their employee number, last name, first name and dept name.

8. List the frequency counts, in descending order, of all the employee last names (how many employees share each last name).

