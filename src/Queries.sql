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
