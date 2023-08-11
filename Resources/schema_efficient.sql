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
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\titles.csv'
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
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\employees.csv'
DELIMITER ','
CSV HEADER;

-- create departments table, primary key, import data
CREATE TABLE departments (
    dept_no varchar PRIMARY KEY,
    dept_name varchar NOT NULL
);
COPY departments (dept_no, dept_name)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\departments.csv'
DELIMITER ','
CSV HEADER;

-- create dept_emp table, composite primary key, foreign keys referencing employees and departments tables
-- import data
CREATE TABLE dept_emp (
    emp_no integer NOT NULL REFERENCES employees (emp_no),
    dept_no varchar NOT NULL REFERENCES departments (dept_no),
	CONSTRAINT pk_dept_emp PRIMARY KEY (emp_no,dept_no)
);
COPY dept_emp (emp_no, dept_no)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\dept_emp.csv'
DELIMITER ','
CSV HEADER;

-- create dept_manager table, primary key, foreign keys referencing departments and employees tables, import data
CREATE TABLE dept_manager (
    dept_no varchar NOT NULL REFERENCES departments (dept_no),
    emp_no integer PRIMARY KEY REFERENCES employees (emp_no)
);
COPY dept_manager (dept_no, emp_no)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\dept_manager.csv'
DELIMITER ','
CSV HEADER;

-- create salaries table, primary key, foreign key referencing employees table, import data
CREATE TABLE salaries (
    emp_no integer PRIMARY KEY REFERENCES employees (emp_no),
    salary numeric NOT NULL
);
COPY salaries (emp_no, salary)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\salaries.csv'
DELIMITER ','
CSV HEADER;

