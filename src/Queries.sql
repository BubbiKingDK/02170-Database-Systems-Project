SELECT
	Section.Genre,
    COUNT(DISTINCT activity_id) AS activity_count,
    COUNT(DISTINCT book_serial_number) AS book_count
FROM Section
NATURAL LEFT JOIN Activity
NATURAL LEFT JOIN Book
GROUP BY Genre;

SELECT book_serial_number, title, author
FROM Book
WHERE Genre = 'Science Fiction'
AND book_serial_number NOT IN (SELECT book_serial_number FROM Borrows);

SELECT user_id, user_name
FROM LibraryUser 
NATURAL JOIN Attends 
NATURAL JOIN Activity
WHERE activity_name = 'Sci-Fi World Building Workshop'
GROUP BY user_id, user_name;

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

SELECT Genre, Availability(Genre) AS AvailableBooks FROM Section;



SET SQL_SAFE_UPDATES = 0;
UPDATE Activity SET start_time =
    CASE
        WHEN start_time <= '10:00:00' THEN '10:00'
        ELSE start_time
    END;

SELECT* FROM Activity; 
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

CALL borrowBook('00001', 'Dune', 'Frank Herbert');
SELECT b.book_serial_number, br.borrow_status
FROM Book b
JOIN Borrows br ON b.book_serial_number = br.book_serial_number
WHERE b.title = 'Dune'
AND br.user_id = '00001';

DELETE FROM Borrows
WHERE book_serial_number IN (
    SELECT b.book_serial_number
    FROM Book b
    WHERE b.title = 'Dune'
      AND b.author = 'Frank Herbert'
)
AND user_id = '00001';

