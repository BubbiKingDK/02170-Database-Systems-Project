INSERT Section VALUES
("Romance"),
('Science Fiction'),
('Mystery'),
('Fantasy'),
('History'),
('Biography'),
('Philosophy'),
('Poetry'),
('Thriller');

INSERT Bookshelf VALUES
(0,"Romance"),
(0, 'Science Fiction'),
(1, 'Science Fiction'),
(2, 'Science Fiction'),
(0, 'Mystery'),
(1, 'Mystery'),
(0, 'Fantasy'),
(0, 'History'),
(1, 'History'),
(0, 'Biography'),
(1, 'Biography'),
(0, 'Philosophy'),
(1, 'Philosophy'),
(0, 'Thriller');

INSERT Book VALUES
(DEFAULT, 'Romance', 0, 'Romeo and Juliet', 'William Shakespeare'),
(DEFAULT,'Science Fiction', 1, 'Dune', 'Frank Herbert'),
(DEFAULT,'Science Fiction', 0, '1984', 'George Orwell'),
(DEFAULT,'Science Fiction', 1, 'Fagre nye verden', 'Aldous Huxley'),
(DEFAULT,'Mystery', 1, 'Murder on the Orient Express', 'Agatha Christie'),
(DEFAULT,'Fantasy', 0, 'The Lord of the Rings', 'J.R.R. Tolkien'),
(DEFAULT,'Fantasy', 0, 'Twilight', 'Stephenie Meyer'),
(DEFAULT,'History', 1, 'Guns, Germs, and Steel', 'Jared Diamond'),
(DEFAULT,'Biography', 1, 'Steve Jobs', 'Walter Isaacson'),
(DEFAULT,'Science Fiction', 2, 'A Brief History of Time', 'Stephen Hawking'),
(DEFAULT,'Romance', 0, 'Twisted Love', 'Ana Huang');

INSERT LibraryUser VALUES
('00001','Weihao','1992-04-18'),
('00002', 'Benjamin','2000-01-01'),
('00003', 'Bjarke','2000-02-02'),
('00004','William','2000-03-03'),
('00005','Karl','2000-03-03'),
('00006','Jessica Taylor', '1987-09-18'),
('00007','Robert Anderson', '1993-06-25'),
('00008','Amanda Martinez', '1991-01-14'),
('00009','Christopher Lee', '1986-08-07'),
('00010','Elizabeth Clark', '1994-04-20');

INSERT INTO Borrows VALUES
('00001', (SELECT book_serial_number FROM Book WHERE title = 'Dune'), 'overdue'),
('00002', (SELECT book_serial_number FROM Book WHERE title = 'Murder on the Orient Express'), 'borrowed'),
('00003', (SELECT book_serial_number FROM Book WHERE title = 'The Lord of the Rings'), 'borrowed'),
('00004', (SELECT book_serial_number FROM Book WHERE title = 'Guns, Germs, and Steel'), 'borrowed'),
('00004', (SELECT book_serial_number FROM Book WHERE title = 'Steve Jobs'), 'borrowed'),
('00004', (SELECT book_serial_number FROM Book WHERE title = 'A Brief History of Time'), 'borrowed'),
('00001', (SELECT book_serial_number FROM Book WHERE title = 'Twisted Love'), 'overdue'),
('00001', (SELECT book_serial_number FROM Book WHERE title = 'Romeo and Juliet'), 'overdue');

INSERT Activity VALUES
(DEFAULT,'Romance','Summer reads','2025-03-25','8:00'),
(DEFAULT,'Science Fiction', 'Sci-Fi World Building Workshop', '2025-04-16', '19:00'),
(DEFAULT,'Mystery', 'Crime Novel Discussion', '2025-04-17', '17:30');

INSERT Attends VALUES
((SELECT activity_id FROM Activity WHERE activity_name = 'Sci-Fi World Building Workshop'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Weihao')),
((SELECT activity_id FROM Activity WHERE activity_name = 'Sci-Fi World Building Workshop'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Karl')),
((SELECT activity_id FROM Activity WHERE activity_name = 'Sci-Fi World Building Workshop'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Bjarke')),
((SELECT activity_id FROM Activity WHERE activity_name = 'Crime Novel Discussion'), (SELECT user_id FROM LibraryUser WHERE user_name = 'William')),
((SELECT activity_id FROM Activity WHERE activity_name = 'Crime Novel Discussion'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Weihao')),
((SELECT activity_id FROM Activity WHERE activity_name = 'Summer reads'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Elizabeth Clark'));


SELECT * FROM Section;
SELECT * FROM Bookshelf;
SELECT * FROM Book;
SELECT * FROM LibraryUser;
SELECT * FROM Borrows;
SELECT * FROM Activity;
SELECT * FROM Attends;

