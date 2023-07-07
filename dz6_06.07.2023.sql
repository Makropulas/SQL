CREATE DATABASE IF NOT EXISTS dz6;
USE dz6;

-- 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS convert_seconds;
DELIMITER $$
CREATE FUNCTION convert_seconds(seconds INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(50);
    DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    IF seconds > 86400 THEN 
		SET days = seconds DIV 86400;
        SET seconds = seconds - (days * 86400);
    END IF;
    SET hours = seconds DIV 3600;
    SET seconds = seconds % 3600;
    SET minutes = seconds DIV 60;
    SET seconds = seconds % 60;
	SET result = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');
    RETURN result;
END $$
DELIMITER ;

SELECT convert_seconds(1234567);


-- 2. Создайте процедуру которая, выводит только четные числа от 1 до 10. Пример: 2,4,6,8,10

DROP PROCEDURE IF EXISTS even_to_ten;
DELIMITER //
CREATE PROCEDURE even_to_ten()
BEGIN
	DECLARE x INT DEFAULT 2;
    DECLARE result VARCHAR(15) DEFAULT '2';
	WHILE x < 10 DO
		SET x = x + 2;
        SET result = CONCAT(result, ',', x);
	END WHILE;
    SELECT result;
END //
DELIMITER ;

CALL even_to_ten();