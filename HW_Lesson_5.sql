DROP DATABASE IF EXISTS shop;

CREATE DATABASE shop;

USE shop;


CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255), 
  birthday_at DATE,
  created_at DATETIME,
  updated_at DATETIME
);

INSERT INTO users (name, birthday_at) VALUES
  ('Anna', '1990-10-05'),
  ('Ivan', '1984-11-12'),
  ('Stepan', '1985-05-20'),
  ('Irina', '1988-02-14'),
  ('Julia', '1998-01-12'),
  ('Vladimir', '1992-08-29');

 
SHOW CREATE TABLE users;

-- Task 3.1

UPDATE users 
SET created_at = NOW(), updated_at = NOW()
WHERE id>=1 and id<7; 

SHOW CREATE TABLE users;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255), 
  birthday_at DATE, 
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
);

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Anna', '1990-10-05', '20.10.2017 8:10', '21.11.2017 9:10'),
  ('Ivan', '1984-11-12', '20.10.2016 10:10', '12.01.2017 9:15'),
  ('Stepan', '1985-05-20', '20.10.2019 10:10', '12.01.2020 10:15'),
  ('Irina', '1988-02-14', '20.10.2019 10:10', '12.01.2020 9:15'),
  ('Julia', '1998-01-12', '20.10.2009 10:10', '12.01.2010 9:15'),
  ('Vladimir', '1992-08-29', '20.10.2016 19:10', '12.01.2017 19:15');
 SHOW CREATE TABLE users; 

-- Task 3.2

ALTER TABLE users ADD created_at_dt DATETIME; 
ALTER TABLE users ADD updated_at_dt DATETIME;

UPDATE users
SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
    updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users DROP created_at;
ALTER TABLE users DROP updated_at;
ALTER TABLE users RENAME COLUMN created_at_dt TO created_at;
ALTER TABLE users RENAME COLUMN updated_at_dt TO updated_at;


DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT unsigned,
  product_id INT unsigned,
  value INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Task 3.3

insert into storehouses_products (value) values
(0), (1), (5), (0), (7), (1), (3), (2);

 
select *from storehouses_products 
ORDER BY value desc;

SELECT 
	*
FROM 
	storehouses_products sp 
ORDER BY 
	IF(value > 0, 0, 1), value;

-- Task 4.1

select
  AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS avg_age
FROM
  users;

--  Task 4.2
 
 SELECT
  dayname(birthday_at) AS birthday_week,
  COUNT(*) as amt
FROM
  users
GROUP BY
  birthday_week
ORDER BY
  birthday_week;

--  Task 4.3
 
 CREATE TABLE value_op (
  value_new INT unsigned
  );
  
 insert into value_op (value_new) values
(1), (2), (3), (4), (5);


SELECT
  value_new,
  COUNT(*) as op
FROM
  value_op; 
 
SELECT 
	exp(SUM(log(value_new))) as product
from value_op;
 
