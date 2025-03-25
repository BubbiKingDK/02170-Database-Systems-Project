DROP TABLE IF EXISTS Attends;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS Borrows;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Bookshelf;
DROP TABLE IF EXISTS LibraryUser;
DROP TABLE IF EXISTS Section;

CREATE TABLE Section (
    genre VARCHAR(255) PRIMARY KEY
);

CREATE TABLE Bookshelf (
    bookshelf_id INT,
    genre VARCHAR(255) NOT NULL,
	PRIMARY KEY (bookshelf_id, genre),
    FOREIGN KEY (genre) REFERENCES Section(genre)
);

CREATE TABLE Book (
    book_serial_number CHAR(36) DEFAULT (uuid()) NOT NULL PRIMARY KEY,
    genre VARCHAR(255),
    bookshelf_id INT,
    title VARCHAR(255),
    author VARCHAR(255),
    FOREIGN KEY (genre) REFERENCES Section(genre),
    FOREIGN KEY (bookshelf_id) REFERENCES Bookshelf(bookshelf_id)
);

CREATE TABLE LibraryUser (
    user_id char(36) DEFAULT (uuid()) NOT NULL PRIMARY KEY,
    user_name VARCHAR(255),
    date_of_birth DATE
);

CREATE TABLE Borrows (
    user_id char(36),
    book_serial_number CHAR(36),
    PRIMARY KEY (book_serial_number),
    borrow_status ENUM('overdue','borrowed'),
    FOREIGN KEY (user_id) REFERENCES LibraryUser(user_id),
    FOREIGN KEY (book_serial_number) REFERENCES Book(book_serial_number)
);

CREATE TABLE Activity (
    activity_id CHAR(36) DEFAULT (uuid()) NOT NULL PRIMARY KEY,
    genre VARCHAR(255) NOT NULL,
    event_name VARCHAR(255),
    event_date DATE,
    start_time DATE,
    FOREIGN KEY (genre) REFERENCES Section(genre)
);

CREATE TABLE Attends (
    activity_id CHAR(36),
    user_id CHAR(36),
    PRIMARY KEY (activity_id, user_id),
    FOREIGN KEY (activity_id) REFERENCES Activity(activity_id),
    FOREIGN KEY (user_id) REFERENCES LibraryUser(user_id)
);