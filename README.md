## Module 9 Challenge, 17 August 2023, SQL Challenge

Development on this project has stopped.

## Description

This project simulates creating a relational database management system (RDBMS), using PostgreSQL, from six old .csv files containing data from the 1980's and 1990's on employees of the fictional Pewlett Hackard company. The point of the exercise is to go through the steps of data modeling, data engineering, and data analysis.

Data modeling is accomplished using https://app.quickdatabasediagrams.com/#/ to create an entity relationship diagram (ERD).

Data engineering: 'schema.sql' contains the code to create all of the tables for the RDBMS. 

Data analysis: 'queries.sql' contains code for all of the queries. A Jupyter Notebook, 'analysis.ipynb', displays results for all of the queries. Some are limited to the first ten results to conserve computer memory.

## Usage

Results can be viewed in the Jupyter Notebook 'analysis.ipynb'. 

Individual queries can be run from 'queries.sql'. 

Tables can be recreated using 'schema.sql' and directly importing the data using the pgAdmin GUI.

The ERD can be found at https://app.quickdatabasediagrams.com/#/d/YmTQEe. Code to create the ERD is located in 'ERD_schema.txt'. 'Resources/ERD_schema_docs.pdf' contains more info.

## Gallery:

ERD:

![ERD](Images/QuickDBD-ERD_Pewlett_Hackard_employees.png)

## Acknowledgments

Thanks to Geronimo Perez for feedback and assistance. Also, credit to https://app.quickdatabasediagrams.com/ for supplying the tools to create the ERD.

## Author

Bryan Johns, August, 2023
