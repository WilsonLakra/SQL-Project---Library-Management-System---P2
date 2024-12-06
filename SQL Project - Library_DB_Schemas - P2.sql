-- SQL Project - Library Management System - P2
-- Library_DB_Schemas below :

-- Creates a database named library_db.
CREATE DATABASE library_db;


-- Creating branch table
DROP TABLE IF EXISTS branch;
CREATE TABLE branch (
	branch_id	VARCHAR(10) PRIMARY KEY,
	manager_id	VARCHAR(10),
	branch_address	VARCHAR(55),
	contact_no	VARCHAR(15)
);
/*
ALTER TABLE branch
ALTER COLUMN contact_no TYPE VARCHAR(20);
*/


-- Creating employees table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	emp_id	VARCHAR(10) PRIMARY KEY,
	emp_name	VARCHAR(30),
	position	VARCHAR(30),
	salary	NUMERIC(10,2),
	branch_id	VARCHAR(10)		-- FK
);


-- Creating books table
DROP TABLE IF EXISTS books;
CREATE TABLE books (
	isbn	VARCHAR(25) PRIMARY KEY,
	book_title	VARCHAR(75),
	category	VARCHAR(30),
	rental_price	NUMERIC(10,2),
	status	VARCHAR(10),
	author	VARCHAR(35),
	publisher	VARCHAR(55)
);
/*
ALTER TABLE books
ALTER COLUMN category TYPE VARCHAR(20);
*/


-- Creating members table
DROP TABLE IF EXISTS members;
CREATE TABLE members (
	member_id	VARCHAR(10) PRIMARY KEY,
	member_name	VARCHAR(30),
	member_address	VARCHAR(75),
	reg_date	DATE
);


-- Creating issued_status
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status (
	issued_id	VARCHAR(10) PRIMARY KEY,
	issued_member_id	VARCHAR(10),	-- FK
	issued_book_name	VARCHAR(75),
	issued_date		DATE,
	issued_book_isbn	VARCHAR(25),	-- FK
	issued_emp_id	VARCHAR(10)		-- FK
);


-- Creating return_status
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status (
	return_id	VARCHAR(10) PRIMARY KEY,
	issued_id	VARCHAR(10),
	return_book_name	VARCHAR(75),
	return_date	 DATE,
	return_book_isbn	VARCHAR(25)
);




-- FOREIGN KEY Constraint
ALTER TABLE issued_status
ADD CONSTRAINT fk_members 
FOREIGN KEY (issued_member_id)
REFERENCES members (member_id);		-- 1


ALTER TABLE issued_status
ADD CONSTRAINT fk_books 
FOREIGN KEY (issued_book_isbn)
REFERENCES books (isbn);				-- 2


ALTER TABLE issued_status
ADD CONSTRAINT fk_employees 
FOREIGN KEY (issued_emp_id)
REFERENCES employees (emp_id);			-- 3


ALTER TABLE employees
ADD CONSTRAINT fk_branch 
FOREIGN KEY (branch_id)
REFERENCES branch (branch_id);			-- 4


ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status 
FOREIGN KEY (issued_id)
REFERENCES issued_status (issued_id);	-- 5



