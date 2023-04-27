use homework5;

CREATE TABLE Cars
(
    id    INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NULL,
    cost  INT NULL
);

INSERT INTO Cars (name, cost) VALUES ('Audi', 52642);
INSERT INTO Cars (name, cost) VALUES ('Mercedes', 57127);
INSERT INTO Cars (name, cost) VALUES ('Skoda', 9000);
INSERT INTO Cars (name, cost) VALUES ('Volvo', 29000);
INSERT INTO Cars (name, cost) VALUES ('Bentley', 350000);
INSERT INTO Cars (name, cost) VALUES ('Citroen', 21000);
INSERT INTO Cars (name, cost) VALUES ('Hummer', 41400);
INSERT INTO Cars (name, cost) VALUES ('Volkswagen', 21600);

-- 1 Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE VIEW Cars_temp AS
SELECT * from cars
Where cost >25000;

-- 2 Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW cars_temp AS 
SELECT * from cars
Where cost <30000;


-- 3 Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE VIEW cars_temp2 AS
Select * from cars
where name = "skoda" or name = "Audi";

CREATE TABLE ANALYSIS
(
	an_id INT AUTO_INCREMENT PRIMARY KEY,
	an_name VARCHAR(40) not null,
	an_cost INT not null,
	an_price INT not null,
	an_group VARCHAR(40) not null
);

INSERT INTO ANALYSIS (an_name, an_cost, an_price, an_group)
VALUES 
("ДНК", 1000, 2000, "медицинские"),
("Кровь", 500, 1000, "медицинские"),
("Краска", 5000, 10000, "Промышленные"),
("масло", 3000, 7000, "Автомобиль"),
("хладогент", 3000, 8000, "Промышленные");

CREATE TABLE groups_of_analysis
(
	gr_id INT AUTO_INCREMENT PRIMARY KEY,
	gr_name VARCHAR(40) not null,
	gr_temp INT not null
);

INSERT INTO groups_of_analysis (gr_name, gr_temp)
VALUES
("медицинские", 10),
("Промышленные", 20),
("Автомобиль", 15);

CREATE TABLE orders
(
	ord_id INT AUTO_INCREMENT PRIMARY KEY,
	ord_datetime DATE not null,
	ord_an INT not null,
    FOREIGN KEY (ord_an) REFERENCES ANALYSIS (an_id)
);

INSERT INTO orders (ord_datetime, ord_an)
VALUES
("2020-02-07",1),
('2020-02-20',2),
('2020-02-03',3),
('2020-02-04',4),
('2020-02-11',5);

-- 4. Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
SELECT an_name,an_price, ord_datetime  from Analysis
LEFT JOIN orders
ON an_id = ord_an
where ord_datetime > '2020-02-05' and ord_datetime < '2020-02-12';


CREATE TABLE timetable
(
	train_id INT,
	station varchar (20) not null,
	station_time time not null 
);

INSERT INTO timetable (train_id, station, station_time)
VALUES
(110, "San Francisco", "10:00:00"),
(110, "Redwood City", "10:54:00"),
(110, "Palp Alto", "11:02:00"),
(110, "San Jose", "12:35:00"),
(120, "San Francisco", "11:00:00"),
(120, "Palp Alto", "12:49:00"),
(120, "San Jose", "13:30:00");

/* -- 5. Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно.
 Проще это сделать с помощью оконной функции LEAD . Эта функция сравнивает значения из одной 
 строки со следующей строкой, чтобы получить результат. В этом случае функция сравнивает 
 значения в столбце «время» для станции со станцией сразу после нее.
*/

SELECT *, 
SUBTIME(LEAD(station_time) OVER(partition by train_id),station_time)
AS time_to_next_station
from timetable;