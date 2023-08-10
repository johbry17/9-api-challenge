-- drop tables (in reverse order, to avoid errors) if they already exist
drop table if exists salaries;
drop table if exists dept_manager;
drop table if exists dept_emp;
drop table if exists departments;
drop table if exists employees;
drop table if exists title;

-- Adapted from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/YmTQEe

-- create title table, import data
CREATE TABLE title (
    title_id varchar   NOT NULL,
    title varchar   NOT NULL,
    CONSTRAINT pk_title PRIMARY KEY (
        title_id
     )
);
COPY title (title_id, title)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\titles.csv'
DELIMITER ','
CSV HEADER;

-- create employees table, import data
CREATE TABLE employees (
    emp_no integer   NOT NULL,
    emp_title_id varchar   NOT NULL,
    birth_date timestamp   NOT NULL,
    first_name varchar   NOT NULL,
    last_name varchar   NOT NULL,
    sex varchar   NOT NULL,
    hire_date timestamp   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);
COPY employees (emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\employees.csv'
DELIMITER ','
CSV HEADER;

-- create departments table, import data
CREATE TABLE departments (
    dept_no varchar   NOT NULL,
    dept_name varchar   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);
COPY departments (dept_no, dept_name)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\departments.csv'
DELIMITER ','
CSV HEADER;

-- create dept_emp table, import data
CREATE TABLE dept_emp (
    emp_no integer  NOT NULL,
    dept_no varchar   NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (
        emp_no,dept_no
     )
);
COPY dept_emp (emp_no, dept_no)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\dept_emp.csv'
DELIMITER ','
CSV HEADER;

-- create dept_manager table, import data
CREATE TABLE dept_manager (
    dept_no varchar   NOT NULL,
    emp_no integer   NOT NULL,
    CONSTRAINT pk_dept_manager PRIMARY KEY (
        emp_no
     )
);
COPY dept_manager (dept_no, emp_no)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\dept_manager.csv'
DELIMITER ','
CSV HEADER;

-- create salaries table, import data
CREATE TABLE salaries (
    emp_no integer   NOT NULL,
    salary numeric   NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (
        emp_no
     )
);
COPY salaries (emp_no, salary)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\salaries.csv'
DELIMITER ','
CSV HEADER;

-- add foreign keys to prior tables
ALTER TABLE employees ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES title (title_id);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

