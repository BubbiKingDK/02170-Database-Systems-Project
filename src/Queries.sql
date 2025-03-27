SELECT
	SECTION.Genre,
    COUNT(DISTINCT activity_id) AS activity_count,
    COUNT(DISTINCT book_serial_number) AS book_count
FROM SECTION
NATURAL LEFT JOIN Activity
NATURAL LEFT JOIN book
GROUP BY Genre;

SELECT book_serial_number, title, author
FROM BOOK
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
SELECT COUNT(*) INTO vTotalCount FROM BOOK WHERE Genre = vGenre;
SELECT COUNT(*) INTO vBorrowCount FROM BOOK WHERE Genre = vGenre AND book_serial_number NOT IN (SELECT book_serial_number FROM Borrows);
RETURN CONCAT(vBorrowCount,'/',vTotalCount);
END//
DELIMITER ;

SELECT Genre, Availability(Genre) AS AvailableBooks FROM Section;