/*
Schematic for creating RDBMS. Links various tables. Follows pattern established in root repo's ERD_schema.txt

Note the use of COPY FROM DELIMITER CSV HEADER to populate tables
To get this part of code to work in Windows, permissions must be enabled
My workaround was to manually change permissions for *each* csv file -> Properties-> Security -> Edit permissions -> Add -> 'Everyone'
On my system, it automatically only enabled 'Read' and 'Read & execute'
!!NOTE!! This is a hack workaround. It's a security risk. It's doubtful anybody would mess with local .csv files used for education
In a professional work environment, presumably some safeguards would be in place, even if only for read & execute permissions
But it sure is more efficient than right-clicking on tables in the pgadmin GUI and using 'Import/Export'
Life is full of trade-offs

Resources/schema_efficient.sql has another version of this code, that combines the merges the foreign keys into the column line. That is:
    emp_title_id varchar NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES title (title_id)
                becomes:
    emp_title_id varchar NOT NULL REFERENCES title (title_id)
I like it better, and it certainly works perfectly, but QuickDBD does not import it and show the relationships
So I submitted the version more explicitly naming foreign keys here
Interestingly, this version runs in a minute, and the _efficient version runs in 30 seconds.
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
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\titles.csv'
DELIMITER ','
CSV HEADER;

-- create employees table, primary key, foreign key referencing title table, import data
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
    emp_no integer NOT NULL,
    dept_no varchar NOT NULL,
	CONSTRAINT pk_dept_emp PRIMARY KEY (emp_no,dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
COPY dept_emp (emp_no, dept_no)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\dept_emp.csv'
DELIMITER ','
CSV HEADER;

-- create dept_manager table, primary key, foreign keys referencing departments and employees tables, import data
CREATE TABLE dept_manager (
    dept_no varchar NOT NULL,
    emp_no integer PRIMARY KEY,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
COPY dept_manager (dept_no, emp_no)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\dept_manager.csv'
DELIMITER ','
CSV HEADER;

-- create salaries table, primary key, foreign key referencing employees table, import data
CREATE TABLE salaries (
    emp_no integer PRIMARY KEY,
    salary numeric NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
COPY salaries (emp_no, salary)
FROM 'C:\Users\johbr\Data-Analyst\Projects\9-sql-challenge\Resources\salaries.csv'
DELIMITER ','
CSV HEADER;

