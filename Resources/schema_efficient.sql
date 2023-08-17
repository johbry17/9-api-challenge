/*
Alternate verson of schema that automatically imports data, bypassing the need for the pgAdmin GUI 'Import/Export'

Saves a lot of time

Unfortunately, it relies on a local path
I tried to use github, 'https://raw.githubusercontent.com/blah/blah'blah.csv', but pgAdmin does not like remote data sources
If you can figure it out, let me know
So, to get it to work, I had to create a local path to each .csv
AND I had to edit permissions on each .csv to allow Everyone access to read each individual file
Bit of a security risk, but I believe it's acceptable when dealing with 6 .csv's from a fictional company for a school assignment on my personal laptop
Something to consider in professional settings, though

To use this, one would have to save all six .csv's locally, 
edit each of the six below 'Local\Path\Resources\blah.csv' in COPY FROM, 
and grant permissions to each csv
*/

-- drop tables (in reverse order, to avoid errors) if they already exist
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS title;

-- create title table, primary key, import data
CREATE TABLE title (
    title_id varchar PRIMARY KEY,
    title varchar NOT NULL
);
COPY title (title_id, title)
FROM 'Local\Path\Resources\titles.csv'
DELIMITER ','
CSV HEADER;

-- create employees table, primary key, foreign key referencing title table, import data
CREATE TABLE employees (
    emp_no integer PRIMARY KEY,
    emp_title_id varchar NOT NULL REFERENCES title (title_id),
    birth_date timestamp NOT NULL,
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    sex varchar NOT NULL,
    hire_date timestamp NOT NULL
);
COPY employees (emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM 'Local\Path\Resources\employees.csv'
DELIMITER ','
CSV HEADER;

-- create departments table, primary key, import data
CREATE TABLE departments (
    dept_no varchar PRIMARY KEY,
    dept_name varchar NOT NULL
);
COPY departments (dept_no, dept_name)
FROM 'Local\Path\Resources\departments.csv'
DELIMITER ','
CSV HEADER;

-- create dept_emp table, composite primary key, foreign keys referencing employees and departments tables
-- import data
CREATE TABLE dept_emp (
    emp_no integer NOT NULL REFERENCES employees (emp_no),
    dept_no varchar NOT NULL REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no,dept_no)
);
COPY dept_emp (emp_no, dept_no)
FROM 'Local\Path\Resources\dept_emp.csv'
DELIMITER ','
CSV HEADER;

-- create dept_manager table, primary key, foreign keys referencing departments and employees tables, import data
CREATE TABLE dept_manager (
    dept_no varchar NOT NULL REFERENCES departments (dept_no),
    emp_no integer PRIMARY KEY REFERENCES employees (emp_no)
);
COPY dept_manager (dept_no, emp_no)
FROM 'Local\Path\Resources\dept_manager.csv'
DELIMITER ','
CSV HEADER;

-- create salaries table, primary key, foreign key referencing employees table, import data
CREATE TABLE salaries (
    emp_no integer PRIMARY KEY REFERENCES employees (emp_no),
    salary numeric NOT NULL
);
COPY salaries (emp_no, salary)
FROM 'Local\Path\Resources\salaries.csv'
DELIMITER ','
CSV HEADER;

