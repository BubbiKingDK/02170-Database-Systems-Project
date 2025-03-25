INSERT Section VALUES
("Romance");

INSERT Bookshelf VALUES
(0,"Romance");

INSERT Book VALUES
(DEFAULT, "Romance", 0, "Test", "Test");

SELECT book_serial_number from Book WHERE title = "Test";