CREATE DATABASE hw5_3;
USE hw5_3;


CREATE TABLE cars(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
name varchar(50),
cost int);

INSERT INTO cars (name, cost) VALUES(
"AUDI", 52642),
("MERCEDES", 57127),
("SKODA", 9000),
("VOLVO", 2900),
("BENTLEY", 350000),
("CITROEN", 21000),
("HAMMER", 41400),
("VOLKSWAGEN", 21600);

CREATE VIEW economy_cars AS
(SELECT * FROM cars WHERE cost <25000);

SELECT* FROM economy_cars;

-- 2
ALTER VIEW economy_cars AS 
(SELECT * FROM cars WHERE cost <49000);

-- 3

ALTER VIEW economy_cars AS 
(SELECT * FROM cars WHERE cost <49000 AND name = "SKODA" OR name = "AUDI");

-- 4



CREATE TABLE a_groups(
gr_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
gr_name VARCHAR (150),
gr_temp DECIMAL (8, 4));
CREATE TABLE Analysis (
an_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
an_name VARCHAR (150),
an_cost DECIMAL (16, 2),
an_price DECIMAL (16,2),
an_group INT,
FOREIGN KEY (an_group) REFERENCES a_groups (gr_id));
CREATE TABLE Orders(
ord_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
ord_datetime DATETIME,
ord_an INT,
FOREIGN KEY (ord_an) REFERENCES Analysis(an_id));
INSERT INTO Analysis (an_name, an_cost, an_price, an_group) 
VALUES ("ОАК", 560, 650, 1),
("gemoglobin", 300, 450, 1),
("kalcitonin", 900, 1200, 1),
("TTG", 300, 700, 1),
("PH", 200, 400, 2),
("leikocyt", 300, 500, 2),
("eozonofil", 400, 500, 1);
SELECT * FROM Analysis;

INSERT INTO a_groups (gr_id, gr_name, gr_temp) VALUES  
(1, "BLOOD", 36.3), (2, "URINE", 35.4), (3, "salvia", 28.6);

INSERT INTO Orders (ord_datetime, ord_an) VALUES
 ('2017-02-01 18:00:00', 8), 
 ('2017-02-01 19:15:00', 9), 
 ('2018-01-12 17:00:00', 10), 
 ('2018-01-12 14:00:00', 11),
 ('2018-01-12 12:00:00', 12), 
 ('2019-02-01 11:15:00', 13), 
 ('2019-02-01 12:15:00', 11), 
 ('2019-02-01 10:15:00', 12),
 ('2020-01-10 17:00:00', 12), 
 ('2020-02-01 21:00:12', 13), 
 ('2020-01-12 13:25:00', 14), 
 ('2020-05-03 14:45:00', 14),
 ('2020-05-04 18:21:00', 11), 
 ('2020-05-04 14:45:00', 9), 
 ('2020-05-05 12:14:00', 8), 
 ('2020-05-06 15:41:00', 14);
 INSERT INTO Orders (ord_datetime, ord_an) 
 VALUES  ('2020-05-03 14:45:00', 14),
 ('2020-05-04 18:21:00', 11), 
 ('2020-05-04 14:45:00', 9), 
 ('2020-05-05 12:14:00', 8), 
 ('2020-05-06 15:41:00', 14);
 SELECT *FROM Analysis;
 SELECT * FROM ORDERS;


-- Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю


SELECT an_name, an_price FROM Analysis
JOIN Orders
ON Orders.ord_an = Analysis.an_id
WHERE DATE(ord_datetime) BETWEEN '2020-05-02' AND '2020-05-09';


/*
обавьте новый столбец под названием «время до следующей станции». 
 */
-- 5

CREATE TABLE trains (
tr_id INT,
station VARCHAR(20),
station_time TIME);

INSERT INTO trains(tr_id, station, station_time) 
VALUES (110, "SAN FRANCISCO", '10:00:00'),
(110, 'REDWOOD CITY', '10:54:00'),
(110, 'PLATO ALTO', '11:02:00'),
(110, 'SAN JOSE', '12:35:00'),
(120, 'SAN FRANCISCO', '11:00:00'),
(120, 'PALO ALTO', '12:49:00'),
(120, 'SAN JOSE', '13:30:00');

SELECT * FROM trains;

SELECT *, TIME(
LEAD (station_time) OVER (ORDER BY station_time) - station_time) AS time_to_the_next_station
FROM trains;

 