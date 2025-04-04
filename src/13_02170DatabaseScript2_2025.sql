
-- Query 1
SELECT
	Section.Genre,
    COUNT(DISTINCT activity_id) AS activity_count,
    COUNT(DISTINCT book_serial_number) AS book_count
FROM Section
NATURAL LEFT JOIN Activity
NATURAL LEFT JOIN Book
GROUP BY Genre;
SELECT * FROM Book;
-- Query 2
SELECT book_serial_number, title, author
FROM Book
WHERE Genre = 'Science Fiction'
AND book_serial_number NOT IN (SELECT book_serial_number FROM Borrows);

-- Query 3
SELECT user_id, user_name
FROM LibraryUser 
NATURAL JOIN Attends 
NATURAL JOIN Activity
WHERE activity_name = 'Sci-Fi World Building Workshop'
GROUP BY user_id, user_name;

-- Trigger
DROP TRIGGER IF EXISTS validate_user_age;
DELIMITER //
CREATE TRIGGER validate_user_age
BEFORE INSERT ON LibraryUser
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.date_of_birth, CURDATE()) < 10 THEN
        SIGNAL SQLSTATE 'HY000'
        SET MYSQL_ERRNO = 1525,
        MESSAGE_TEXT = 'User must be at least 10 years old';
    END IF;
END //
DELIMITER ;

-- (commented out since it results in an error) INSERT INTO libraryUser (user_id, user_name, date_of_birth) VALUES (00011, 'Peter Hansen', '2019-05-13');

-- Function
DROP FUNCTION IF EXISTS Availability;
DELIMITER //
CREATE FUNCTION Availability (vGenre VARCHAR(255)) RETURNS VARCHAR(255)
BEGIN
DECLARE vTotalCount INT;
DECLARE vBorrowCount INT;
SELECT COUNT(*) INTO vTotalCount FROM Book WHERE Genre = vGenre;
SELECT COUNT(*) INTO vBorrowCount FROM Book WHERE Genre = vGenre AND book_serial_number NOT IN (SELECT book_serial_number FROM Borrows);
RETURN CONCAT(vBorrowCount,'/',vTotalCount);
END//
DELIMITER ;

-- Function Test
SELECT Genre, Availability(Genre) AS AvailableBooks FROM Section;

-- Update
SET SQL_SAFE_UPDATES = 0;
UPDATE Activity SET start_time =
    CASE
        WHEN start_time <= '10:00:00' THEN '10:00'
        ELSE start_time
    END;
SELECT* FROM Activity; 

-- Procedure
DROP PROCEDURE IF EXISTS borrowBook;
DELIMITER //
CREATE PROCEDURE borrowBook(userid CHAR(5), ptitle CHAR(255), pauthor CHAR(255))
    BEGIN
    DECLARE targetBook char(255);

	SELECT book_serial_number INTO targetBook FROM Book WHERE title = ptitle AND author = pauthor;
    
    INSERT INTO Borrows (user_id, book_serial_number, borrow_status)
    SELECT userid, targetBook, 'borrowed'
    WHERE NOT EXISTS (
		SELECT 1 FROM Borrows WHERE book_serial_number = targetBook
    );
    END //
DELIMITER ;

-- Procedure Test
CALL borrowBook('00001', 'Dune', 'Frank Herbert');
SELECT br.user_id, b.book_serial_number, br.borrow_status
FROM Book b
JOIN Borrows br ON b.book_serial_number = br.book_serial_number
WHERE b.title = 'Dune'
AND br.user_id = '00001';



-- Delete
DELETE FROM Borrows
WHERE book_serial_number IN (
    SELECT b.book_serial_number
    FROM Book b
    WHERE b.title = 'Dune'
      AND b.author = 'Frank Herbert'
)
AND user_id = '00001';
