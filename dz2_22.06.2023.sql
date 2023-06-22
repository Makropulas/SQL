-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными

CREATE DATABASE dz2;

USE dz2;

CREATE TABLE sales
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	order_date DATE NOT NULL,
	count_product INT DEFAULT 0
);
INSERT INTO sales(order_date, count_product)
VALUES
	('2022-01-01', 156),
    ('2022-01-02', 180),
    ('2022-01-03', 21),
    ('2022-01-04', 124),
    ('2022-01-05', 341);
    
SELECT * FROM sales;


-- 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300, используя функцию IF

SELECT IF(count_product < 100,"Маленький заказ",
	IF(count_product >= 100 AND count_product <= 300,"Средний заказ","Большой заказ"))
    AS "Тип заказа"
FROM sales;


-- 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE

DROP TABLE orders;
CREATE TABLE orders
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id VARCHAR(10) NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	order_status VARCHAR(15) NOT NULL
);
INSERT INTO orders(employee_id, amount, order_status)
VALUES
	('e03', 15.00, 'OPEN'),
    ('e01', 25.50, 'OPEN'),
    ('e05', 100.70, 'CLOSED'),
    ('e02', 22.18, 'OPEN'),
    ('e04', 9.50, 'CANCELLED');
    
SELECT * FROM orders;

SELECT employee_id, amount,
	CASE
		WHEN order_status = "OPEN" THEN "Order is in open state"
        WHEN order_status = "CLOSED" THEN "Order is closed"
        WHEN order_status = "CANCELLED" THEN "Order is cancelled"
	END AS full_order_status
FROM orders;