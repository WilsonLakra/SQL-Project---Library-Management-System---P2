-- SQL Project - Library Management System - P2

SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;


-- Project Task (CRUD Operations)
/*
-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes',
'Harper Lee', 'J.B. Lippincott & Co.')"
*/

SELECT * FROM books;

INSERT INTO books (isbn, book_title, category, rental_price, status, author, publisher) 
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');


-- Task 2: Update an Existing Member's Address

SELECT * FROM members;

UPDATE members 
SET member_address = '123 Main St'
WHERE member_id = 'C101';


/*
-- Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with 
issued_id = 'IS121' from the issued_status table.
*/

SELECT * FROM issued_status;

SELECT * FROM issued_status
WHERE issued_id = 'IS121';

DELETE FROM issued_status
WHERE issued_id = 'IS121';


/*
-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee 
with emp_id = 'E101'.
*/

SELECT * FROM books;
SELECT * FROM employees;
SELECT * FROM issued_status;;

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';


/*
-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have 
issued more than one book.
*/

SELECT * FROM issued_status;;

SELECT issued_emp_id, 
	COUNT(issued_id)  AS total_book_issued 
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) > 1;

SELECT issued_emp_id
	-- COUNT(*)  AS total_book_issued 
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(*) > 1;




-- CTAS (Create Table As Select)
/*
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book 
and total book_issued_cnt**
*/

SELECT * FROM books;
SELECT * FROM issued_status;

CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(issued_id) AS issue_count
FROM issued_status AS ist
JOIN books AS b
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

SELECT * FROM book_issued_cnt;




-- Data Analysis & Findings
-- The following SQL queries were used to address specific questions:

-- Task 7. Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = 'Classic';


-- Task 8: Find Total Rental Income by Category:

SELECT * FROM books;
SELECT * FROM issued_status;

SELECT b.category,
	SUM(rental_price),
	COUNT(*)
FROM books AS b
JOIN issued_status AS ist
ON b.isbn = issued_book_isbn
GROUP BY 1;


-- Task 9. List Members Who Registered in the Last 180 Days:

SELECT * FROM members;

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';


-- Task 10. List Employees with Their Branch Manager's Name and their branch details:

SELECT * FROM branch;
SELECT * FROM employees;

SELECT 
	e1.* ,
	b1.manager_id,
	e2.emp_name AS manager
FROM employees AS e1
JOIN branch AS b1
ON b1.branch_id = e1.branch_id
JOIN employees AS e2
ON b1.manager_id = e2.emp_id;


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:

SELECT * FROM books;

CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;

SELECT * FROM expensive_books;


-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT * FROM issued_status;
SELECT * FROM return_status;

SELECT * 
FROM issued_status AS ist
LEFT JOIN return_status AS rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS null;

-- List of Books Name Not Yet Returned

SELECT DISTINCT(ist.issued_book_name) 
FROM issued_status AS ist
LEFT JOIN return_status AS rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS null;


