-- 1. Создайте таблицу с мобильными телефонами. Заполните БД данными

CREATE DATABASE dz1;
USE dz1;
CREATE TABLE mobilephones
(
Id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
ProductName VARCHAR(30) NOT NULL,
Manufacturer VARCHAR(30) NOT NULL,
ProductCount INT NOT NULL,
Price INT
);

INSERT INTO mobilephones(ProductName, Manufacturer, ProductCount, Price)
VALUES
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 41000),
('P20 Pro', 'Huawei', 5, 36000);

SELECT * FROM mobilephones;


-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2

SELECT ProductName, Manufacturer, Price FROM mobilephones WHERE ProductCount > 2;


-- 3. Выведите весь ассортимент товаров марки “Samsung”

SELECT * FROM mobilephones WHERE Manufacturer = 'Samsung';