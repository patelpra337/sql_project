create database books;
USE books;

create table book(bookid varchar(200) primary key,title varchar(200),publishername varchar(200));

BULK 
INSERT book
FROM 'C:\Users\patelpra337\Documents\sql\book\book.csv' --location with filename
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

create table book_authors(bookid varchar(100),authorname varchar(100), primary key(bookid));

BULK 
INSERT book_authors
FROM 'C:\Users\patelpra337\Documents\sql\book\book_authors.csv' --location with filename
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

create table publisher (name varchar(150),address varchar(100),phone varchar(100));

BULK 
INSERT publisher
FROM 'C:\Users\patelpra337\Documents\sql\book\publisher.csv' --location with filename
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

create table library_branch (branch_id varchar(100),branch_name varchar(100),address varchar(150));

BULK 
INSERT library_branch
FROM 'C:\Users\patelpra337\Documents\sql\book\library_branch.csv' --location with filename
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

create table book_copies (bookid varchar(100),branch_id varchar(100),no_of_copies varchar(100));

BULK 
INSERT book_copies
FROM 'C:\Users\patelpra337\Documents\sql\book\book_copies.csv' --location with filename
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

create table borrower (cardno varchar(100),name varchar (100),address varchar(100),address2 varchar(500),address3 varchar(100),phone varchar(50));

BULK 
INSERT borrower
FROM 'C:\Users\patelpra337\Documents\sql\book\borrower_2.csv' --location with filename
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

create table book_loans (bookid varchar(100),branchid varchar (100),cardno varchar(100),dateout varchar (100),duedate varchar (100));

BULK 
INSERT book_loans
FROM 'C:\Users\patelpra337\Documents\sql\book\book_loans.csv' --location with filename
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)



SELECT bc.no_of_copies
FROM book b,book_copies bc, library_branch bl
WHERE b.bookid=bc.bookid and
	  bc.branch_id = bl.branch_id and 
	  title='The Lost Tribe' and branch_name='Sharpstown';


SELECT bc.no_of_copies
FROM book b,book_copies bc, library_branch bl
WHERE b.bookid=bc.bookid and
	  bc.branch_id = bl.branch_id and 
	  title='The Lost Tribe' 

SELECT *
FROM book_loans AS BL 
FULL OUTER JOIN borrower AS BW ON BL.cardno = BW.cardno
WHERE dateout IS NULL

SELECT B.title, R.name, R.address
FROM book B, borrower R, book_loans BL, library_branch LB
WHERE LB.branch_name='Sharpstown' AND LB.branch_id=BL.branchid AND
BL.duedate='6/5/20017' AND BL.cardno=R.cardno AND BL.bookid=B.bookid;

SELECT library_branch.branch_name, COUNT(*)
FROM library_branch,book_loans BL
WHERE BL.branchid = BL.branchid
GROUP BY library_branch.branch_name;

SELECT B.name, B.address, COUNT(*)
FROM borrower B, book_loans L
WHERE B.cardno = L.cardno
GROUP BY B.cardno, B.name, B.address
HAVING COUNT(*)>5;

SELECT B.title, R.name, R.Address, LB.branch_name, BL.duedate
FROM book_loans AS BL INNER JOIN borrower AS R
ON R.cardno=BL.cardno
INNER JOIN Book AS B
ON BL.bookid=B.bookid
INNER JOIN library_branch AS LB
ON BL.branchid=LB.branch_id   
WHERE LB.branch_name='Sharpstown' AND BL.DueDate= '6/5/20017'