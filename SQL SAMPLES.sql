/*
1.  here we created an Library databases
2.  Here The Entities Are :
     * authors(AuthorID,Name,Bio Are The Attributes)
     * bookauthors(BookID,AuthorId Are The Attributes)
     * books(BookID Title,Genre,PublishedYear Are The Attributes)
     * borrow(BorrowID,MemberID,BookID,BorrowDate,ReturnDate Are The Attributes)
     * members(MemberID ,Name ,Email,JoinDate Are The Attributes)
3.  The RelationShip Between The Entities Are:
	   * A book can have one or more authors (Many-to-Many)
       * A member can borrow many books (One-to-Many)
       * A book can be borrowed by many members (through Borrow table)
4.  Primary Key:  The Primary Constraint Is An Uniquely Identifies Each Records In The Tables In The Table And Can't Contains The Null Values And Contain Unique Values
5.  Foreign Key:  The Foreign Key Constraint Is Used To Combain The More Then One Table The Foreign Key Must Be An Primary Key Are Unique Column Of An Another Table
*/
SHOW TABLES;
CREATE DATABASE LibraryDB;
USE LibraryDB;
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY, /* AuthorId Is The Primary Key*/
    Name VARCHAR(100),
    Bio TEXT
);
INSERT INTO Authors (Name, Bio)
VALUES 
('J.K. Rowling', 'British author, best known for the Harry Potter series.'),
('George R.R. Martin', 'American novelist and creator of Game of Thrones.'),
('Agatha Christie', 'Famous British writer known for detective novels.'),
('Dan Brown', 'American author known for thriller novels like The Da Vinci Code.'),
('Chetan Bhagat', 'Indian author of popular English-language novels.');
SELECT * FROM Authors;
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY, /* BookID Is The Primary Key*/
    Title VARCHAR(255),
    Genre VARCHAR(100),
    PublishedYear INT
);
INSERT INTO Books (Title, Genre, PublishedYear)
VALUES
('Harry Potter and the Sorcerer\'s Stone', 'Fantasy', 1997),
('A Game of Thrones', 'Fantasy', 1996),
('Murder on the Orient Express', 'Mystery', 1934),
('The Da Vinci Code', 'Thriller', 2003),
('Half Girlfriend', 'Romance', 2014);
SELECT * FROM Books;
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,   /*MemberId Is The Primary Key*/
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);
INSERT INTO Members (Name, Email, JoinDate)
VALUES
('Aarav Mehta', 'aarav.mehta@example.com', '2023-06-15'),
('Priya Sharma', 'priya.sharma@example.com', '2023-07-20'),
('Rahul Verma', 'rahul.verma@example.com', '2023-08-01'),
('Sneha Reddy', 'sneha.reddy@example.com', '2024-01-10'),
('Gopinath MK', 'mailamgopinath@gmail.com', '2024-03-25');
SELECT * FROM Members;
/*
1.  In the Borrow table, the relationships represent how members borrow books.
2.  So, the Borrow table creates two One-to-Many relationships:
        ^ Members → Borrow = One-to-Many
        ^ Books → Borrow = One-to-Many
*/
CREATE TABLE Borrow (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,    /*BorrowId Is The Primary Key*/
    MemberID INT,     /*MemberId Is The Foreign Key*/
    BookID INT,       /*BookId Is The Foreign Key*/
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID), 
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
INSERT INTO Borrow (MemberID, BookID, BorrowDate, ReturnDate) 
VALUES
(1, 1, '2024-04-10', '2024-04-20'),   /*Aarav borrowed "Harry Potter"*/
(2, 2, '2024-05-01', '2024-05-12'),   /*Priya borrowed "A Game of Thrones"*/
(3, 3, '2024-06-05', '2024-06-15'),   /*Rahul borrowed "Murder on the Orient Express"*/
(4, 4, '2024-06-18', NULL),            /*Sneha borrowed "The Da Vinci Code", not returned yet*/
(5, 5, '2024-07-01', '2024-07-10');   /*Gopinath borrowed "Half Girlfriend"*/
SELECT * FROM Borrow;
/*BookAuthors Table (Many-to-Many relationship)*/
CREATE TABLE BookAuthors (
    BookID INT,   /*BookID Is The Foreign Key*/
    AuthorID INT, /*AuthorId Is The Foreign Key*/
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);
INSERT INTO BookAuthors (BookID, AuthorID) VALUES (1, 2);
INSERT INTO BookAuthors (BookID, AuthorID) VALUES (2, 1);
INSERT INTO BookAuthors (BookID, AuthorID) VALUES (3, 5);
INSERT INTO BookAuthors (BookID, AuthorID) VALUES (4, 2);
INSERT INTO BookAuthors (BookID, AuthorID) VALUES (5, 4);
SELECT * FROM BookAuthors;
