-- =====================================================================
-- MySQL Assignment 1 - DDL Commands & Constraints (Solution)
-- Requires MySQL 8.0.16 or later (for CHECK constraints and
-- expression defaults like DEFAULT (CURDATE())).
-- Run the sections in order, top to bottom.
-- =====================================================================


-- =====================================================================
-- PART A: DDL COMMANDS
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. TABLE CREATION (CREATE)
-- ---------------------------------------------------------------------

CREATE DATABASE employee;
USE employee;

CREATE TABLE Departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE Location (
    location_id INT PRIMARY KEY,
    location    VARCHAR(30)
);

CREATE TABLE Employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(50),
    gender        ENUM('M','F'),
    age           INT,
    hire_date     DATE,
    designation   VARCHAR(100),
    department_id INT,
    location_id   INT,
    salary        DECIMAL(10,2)
);

-- ---------------------------------------------------------------------
-- 2. TABLE ALTERATION (ALTER)
-- ---------------------------------------------------------------------

-- Add a new column "email" to the Employees table
ALTER TABLE Employees
ADD COLUMN email VARCHAR(100);

-- Modify the data type of "designation" to support a wider range of values
ALTER TABLE Employees
MODIFY COLUMN designation VARCHAR(255);

-- Drop the "age" column
ALTER TABLE Employees
DROP COLUMN age;

-- Rename "hire_date" to "date_of_joining"
ALTER TABLE Employees
RENAME COLUMN hire_date TO date_of_joining;

-- ---------------------------------------------------------------------
-- 3. TABLE RENAMING (RENAME)
-- ---------------------------------------------------------------------

RENAME TABLE Departments TO Departments_Info;

RENAME TABLE Location TO Locations;

-- ---------------------------------------------------------------------
-- 4. TABLE TRUNCATION (TRUNCATE)
-- ---------------------------------------------------------------------

TRUNCATE TABLE Employees;

-- ---------------------------------------------------------------------
-- 5. DATABASE & TABLE DROPPING (DROP)
-- ---------------------------------------------------------------------

-- Drop the Employees table first, then the database
DROP TABLE Employees;

DROP DATABASE employee;


-- =====================================================================
-- PART B: CONSTRAINTS
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. DATABASE RECREATION
-- ---------------------------------------------------------------------

DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

-- ---------------------------------------------------------------------
-- 2. DEPARTMENTS TABLE
--    - department_id uniquely identifies each department (PRIMARY KEY)
--    - department_name cannot be NULL or duplicated (NOT NULL + UNIQUE)
-- ---------------------------------------------------------------------

CREATE TABLE Departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- ---------------------------------------------------------------------
-- 3. LOCATION TABLE
--    - location_id is generated automatically, incrementing by 1
--    - location cannot be NULL or duplicated
-- ---------------------------------------------------------------------

CREATE TABLE Location (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location    VARCHAR(30) NOT NULL UNIQUE
);

-- ---------------------------------------------------------------------
-- 4. EMPLOYEES TABLE
--    - employee_id is distinct for every employee (PRIMARY KEY)
--    - employee_name must always be provided (NOT NULL)
--    - gender can only be 'M' or 'F' (ENUM)
--    - age must be 18 or above (CHECK)
--    - hire_date defaults to the current date (DEFAULT)
--    - department_id and location_id link to their tables (FOREIGN KEY)
-- ---------------------------------------------------------------------

CREATE TABLE Employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender        ENUM('M','F'),
    age           INT,
    hire_date     DATE DEFAULT (CURDATE()),
    designation   VARCHAR(100),
    department_id INT,
    location_id   INT,
    salary        DECIMAL(10,2),
    CONSTRAINT chk_age CHECK (age >= 18),
    CONSTRAINT fk_department FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),
    CONSTRAINT fk_location FOREIGN KEY (location_id)
        REFERENCES Location(location_id)
);

-- ---------------------------------------------------------------------
-- OPTIONAL: quick check that everything was created correctly
-- ---------------------------------------------------------------------
-- SHOW TABLES;
-- DESCRIBE Departments;
-- DESCRIBE Location;
-- DESCRIBE Employees;

-- =====================================================================
-- END OF ASSIGNMENT
-- =====================================================================
