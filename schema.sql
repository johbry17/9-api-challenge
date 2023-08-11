/*
Schematic for creating RDBMS. Links various tables. Follows pattern established in root repo's ERD_schema.txt

TO IMPORT DATA use pdAdmin GUI's 'Import/Export Data' (right-click on each table and import the matched .csv from the root repo's 'Resources' folder)

Alternate versions of this file, 'Resources/schema_explicit_foreign_keys.sql' and 'Resources/schema_efficient.sql', automatically import this data from a local hard drive
But those won't work for anybody but me. I only mention them for nerd cred.
*/

-- drop tables (in reverse order, to avoid errors) if they already exist
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS title;

-- create title table, primary key, import data with pgAdmin GUI
CREATE TABLE title (
    title_id varchar PRIMARY KEY,
    title varchar NOT NULL
);

-- create employees table, primary key, foreign key referencing title table, import data with pgAdmin GUI
CREATE TABLE employees (
    emp_no integer PRIMARY KEY,
    emp_title_id varchar NOT NULL,
    birth_date timestamp NOT NULL,
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    sex varchar NOT NULL,
    hire_date timestamp NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES title (title_id)
);

-- create departments table, primary key, import data with pgAdmin GUI
CREATE TABLE departments (
    dept_no varchar PRIMARY KEY,
    dept_name varchar NOT NULL
);

-- create dept_emp table, composite primary key, foreign keys referencing employees and departments tables
-- import data with pgAdmin GUI
CREATE TABLE dept_emp (
    emp_no integer NOT NULL,
    dept_no varchar NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

-- create dept_manager table, primary key, foreign keys referencing departments and employees tables, import data with pgAdmin GUI
CREATE TABLE dept_manager (
    dept_no varchar NOT NULL,
    emp_no integer PRIMARY KEY,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- create salaries table, primary key, foreign key referencing employees table, import data with pgAdmin GUI
CREATE TABLE salaries (
    emp_no integer PRIMARY KEY,
    salary numeric NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

