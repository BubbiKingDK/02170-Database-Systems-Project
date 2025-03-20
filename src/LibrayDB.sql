DROP TABLE IF EXISTS Attends;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS Borrow;
DROP TABLE IF EXISTS BookshelfSectionRelationship;
DROP TABLE IF EXISTS BookLocation;
DROP TABLE IF EXISTS Bookshelf;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS LibraryUser;
DROP TABLE IF EXISTS Section;

CREATE TABLE Section (
    genre VARCHAR(255) PRIMARY KEY
);

CREATE TABLE Bookshelf (
    bookshelf_id INT PRIMARY KEY
);

CREATE TABLE BookshelfSectionRelationship (
    genre VARCHAR(255),
    bookshelf_id INT,
    PRIMARY KEY (genre, bookshelf_id),
    FOREIGN KEY (genre) REFERENCES Section(genre),
    FOREIGN KEY (bookshelf_id) REFERENCES Bookshelf(bookshelf_id)
);

CREATE TABLE Book (
    book_serial_number BINARY(16) DEFAULT (uuid()) NOT NULL PRIMARY KEY,  
    genre VARCHAR(255),
    title VARCHAR(255),
    author_id VARCHAR(255),
    FOREIGN KEY (genre) REFERENCES Section(genre)
);

CREATE TABLE BookLocation (
    book_serial_number binary(16),
    bookshelf_id INT,
    PRIMARY KEY (book_serial_number, bookshelf_id),
    FOREIGN KEY (book_serial_number) REFERENCES Book(book_serial_number),
    FOREIGN KEY (bookshelf_id) REFERENCES Bookshelf(bookshelf_id)
);

CREATE TABLE LibraryUser (
    user_id BINARY(16) DEFAULT (uuid()) NOT NULL PRIMARY KEY,
    user_name VARCHAR(255),
    date_of_birth DATE
);

CREATE TABLE Borrow (
    user_id binary(16),
    book_serial_number binary(16),
    PRIMARY KEY (book_serial_number),
    status VARCHAR(8) CHECK (status IN ('Overdue', 'Borrowed')),
    FOREIGN KEY (user_id) REFERENCES LibraryUser(user_id),
    FOREIGN KEY (book_serial_number) REFERENCES Book(book_serial_number)
);

CREATE TABLE Activity (
    event_id BINARY(16) DEFAULT (uuid()) NOT NULL PRIMARY KEY,
    genre VARCHAR(255),
    event_name VARCHAR(255),
    event_date DATE,
    start_time DATE,
    FOREIGN KEY (genre) REFERENCES Section(genre)
);

CREATE TABLE Attends (
    event_id binary(16),
    user_id binary(16),
    FOREIGN KEY (event_id) REFERENCES Activity(event_id),
    FOREIGN KEY (user_id) REFERENCES LibraryUser(user_id)
);