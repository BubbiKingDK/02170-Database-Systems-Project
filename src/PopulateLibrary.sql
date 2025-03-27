

INSERT Section VALUES
("Romance"),
('Science Fiction'),
('Mystery'),
('Fantasy'),
('History'),
('Biography'),
('Science'),
('Philosophy'),
('Poetry'),
('Thriller');

INSERT Bookshelf VALUES
(0,"Romance"),
(1, 'Science Fiction'),
(2, 'Mystery'),
(3, 'Fantasy'),
(4, 'History'),
(5, 'Biography'),
(6, 'Science'),
(7, 'Philosophy'),
(8, 'Poetry'),
(9, 'Thriller');

INSERT Book VALUES
(DEFAULT, "Romance", 0, 'Romeo and Juliet', 'William Shakespeare'),
(DEFAULT,'Science Fiction', 1, 'Dune', 'Frank Herbert'),
(DEFAULT,'Mystery', 2, 'Murder on the Orient Express', 'Agatha Christie'),
(DEFAULT,'Fantasy', 3, 'The Lord of the Rings', 'J.R.R. Tolkien'),
(DEFAULT,'History', 4, 'Guns, Germs, and Steel', 'Jared Diamond'),
(DEFAULT,'Biography', 5, 'Steve Jobs', 'Walter Isaacson'),
(DEFAULT,'Science', 6, 'A Brief History of Time', 'Stephen Hawking'),
(DEFAULT,'Philosophy', 7, 'Meditations', 'Marcus Aurelius'),
(DEFAULT,'Poetry', 8, 'Leaves of Grass', 'Walt Whitman'),
(DEFAULT,'Romance', 9, 'Twisted Love', 'Ana Huang');

INSERT LibraryUser VALUES
('00001','Bacon','1992-04-18'),
('00002', 'BubbyKing','2000-01-01'),
('00003', 'Bjorki','2000-02-02'),
('00004','Squirrel Modeller','2000-03-03'),
('00005','Karl','2000-03-03'),
('00006','Jessica Taylor', '1987-09-18'),
('00007','Robert Anderson', '1993-06-25'),
('00008','Amanda Martinez', '1991-01-14'),
('00009','Christopher Lee', '1986-08-07'),
('00010','Elizabeth Clark', '1994-04-20');

INSERT INTO Borrows VALUES
((SELECT user_id FROM LibraryUser WHERE user_name = 'Bacon'), (SELECT book_serial_number FROM Book WHERE title = 'Dune'), 'overdue'),
((SELECT user_id FROM LibraryUser WHERE user_name = 'BubbiKing'), (SELECT book_serial_number FROM Book WHERE title = 'Murder on the Orient Express'), 'borrowed'),
((SELECT user_id FROM LibraryUser WHERE user_name = 'Bjorki'), (SELECT book_serial_number FROM Book WHERE title = 'The Lord of the Rings'), 'available'),
((SELECT user_id FROM LibraryUser WHERE user_name = 'Squirrel Modeller'), (SELECT book_serial_number FROM Book WHERE title = 'Guns, Germs, and Steel'), 'available'),
((SELECT user_id FROM LibraryUser WHERE user_name = 'Karl'), (SELECT book_serial_number FROM Book WHERE title = 'Steve Jobs'), 'borrowed'),
((SELECT user_id FROM LibraryUser WHERE user_name = 'Jessica Taylor'), (SELECT book_serial_number FROM Book WHERE title = 'A Brief History of Time'), 'borrowed'),
((SELECT user_id FROM LibraryUser WHERE user_name = 'Robert Anderson'), (SELECT book_serial_number FROM Book WHERE title = 'Meditations'), 'available'),
((SELECT user_id FROM LibraryUser WHERE user_name = 'Amanda Martinez'), (SELECT book_serial_number FROM Book WHERE title = 'Leaves of Grass'), 'overdue'),
((SELECT user_id FROM LibraryUser WHERE user_name = 'Christopher Lee'), (SELECT book_serial_number FROM Book WHERE title = 'Twisted Love'), 'available'),
((SELECT user_id FROM LibraryUser WHERE user_name = 'Elizabeth Clark'), (SELECT book_serial_number FROM Book WHERE title = 'Romeo and Juliet'), 'overdue');

INSERT Activity VALUES
(DEFAULT,'Romance','Summer reads','2025-03-25','8:00'),
(DEFAULT,'Science Fiction', 'Sci-Fi World Building Workshop', '2025-04-16', '19:00'),
(DEFAULT,'Mystery', 'Crime Novel Discussion', '2025-04-17', '17:30'),
(DEFAULT,'Fantasy', 'Epic Fantasy Reading Group', '2025-04-18', '18:30'),
(DEFAULT,'History', 'Historical Perspectives Lecture', '2025-04-19', '19:00'),
(DEFAULT,'Biography', 'Life Stories Book Club', '2025-04-20', '17:00:00'),
(DEFAULT,'Science', 'Scientific Discoveries Symposium', '2025-04-21', '18:00'),
(DEFAULT,'Philosophy', 'Philosophical Thinking Roundtable', '2025-04-22', '19:30'),
(DEFAULT,'Poetry', 'Poetry Reading Night', '2025-04-23', '20:00'),
(DEFAULT,'Thriller', 'Suspense and Mystery Panel', '2025-04-24', '18:30');


INSERT Attends VALUES
((SELECT activity_id FROM Activity WHERE event_name = 'Sci-Fi World Building Workshop'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Bacon')),
((SELECT activity_id FROM Activity WHERE event_name = 'Crime Novel Discussion'), (SELECT user_id FROM LibraryUser WHERE user_name = 'BubbyKing')),
((SELECT activity_id FROM Activity WHERE event_name = 'Epic Fantasy Reading Group'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Bjorki')),
((SELECT activity_id FROM Activity WHERE event_name = 'Historical Perspectives Lecture'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Squirrel Modeller')),
((SELECT activity_id FROM Activity WHERE event_name = 'Life Stories Book Club'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Karl')),
((SELECT activity_id FROM Activity WHERE event_name = 'Scientific Discoveries Symposium'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Jessica Taylor')),
((SELECT activity_id FROM Activity WHERE event_name = 'Philosophical Thinking Roundtable'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Robert Anderson')),
((SELECT activity_id FROM Activity WHERE event_name = 'Poetry Reading Night'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Amanda Martinez')),
((SELECT activity_id FROM Activity WHERE event_name = 'Suspense and Mystery Panel'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Christopher Lee')),
((SELECT activity_id FROM Activity WHERE event_name = 'Summer reads'), (SELECT user_id FROM LibraryUser WHERE user_name = 'Elizabeth Clark'));


SELECT * FROM Section;
SELECT * FROM Bookshelf;
SELECT * FROM Book;
DESCRIBE BOOK;
SELECT * FROM LibraryUser;
SELECT * FROM Borrows;
SELECT * FROM Activity;
SELECT * FROM Attends;

