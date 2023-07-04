CREATE DATABASE IF NOT EXISTS dz5;
USE dz5;

CREATE TABLE IF NOT EXISTS cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

CREATE OR REPLACE VIEW `buckets` AS
SELECT * FROM cars
WHERE cost <= 25000;

SELECT * FROM buckets;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

ALTER VIEW `buckets` AS
SELECT * FROM cars
WHERE cost <= 30000;

SELECT * FROM buckets;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)

CREATE VIEW skoudi AS
SELECT * FROM cars
WHERE `name` IN ('Skoda', 'Audi');

SELECT * FROM skoudi;



-- Доп задания:

-- 1* Получить ранжированный список автомобилей по цене в порядке возрастания

SELECT DENSE_RANK() OVER(ORDER BY cost) AS `rank`,
name, cost
FROM cars;

-- 2* Получить топ-3 самых дорогих автомобилей, а также их общую стоимость

SELECT *, 
SUM(cost) OVER(ORDER BY cost DESC) AS total_cost
FROM cars
LIMIT 3;

SELECT *, 
SUM(cost) OVER() AS total_cost
FROM 
(SELECT * FROM cars 
ORDER BY cost DESC
LIMIT 3) AS three_expensive;

-- 3* Получить список автомобилей, у которых цена больше предыдущей цены

SELECT * FROM
	(SELECT *,
	LAG(name) OVER() previous_car,
	LAG(cost) OVER() cost_previous_car
	FROM cars) AS previous
WHERE cost > cost_previous_car;

-- 4* Получить список автомобилей, у которых цена меньше следующей цены

SELECT * FROM
	(SELECT *,
	LEAD(name) OVER() next_car,
	LEAD(cost) OVER() cost_next_car
	FROM cars) AS `next`
WHERE cost < cost_next_car;

-- 5* Получить список автомобилей, отсортированный по возрастанию цены, и добавить столбец со значением разницы между текущей ценой и ценой следующего автомобиля

SELECT id, name, cost, (cost_next_car - cost) AS `diff_next`
FROM
(SELECT *, LEAD(cost) OVER() cost_next_car
FROM cars ORDER BY cost) AS sorted;