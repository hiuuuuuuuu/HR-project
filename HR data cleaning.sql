CREATE DATABASE projects;

USE projects;

select * from hr;

-- sua doi employee_id
ALTER TABLE hr
CHANGE COLUMN ï»¿id employee_id VARCHAR(20) NULL;

DESCRIBE hr;

select birthdate from hr;

-- bo qua cac kiem tra cho phep UPDATE DELETE khong can WHERE
SET sql_safe_updates=0;

-- cap nhat , chinh sua bang  birthdate
UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE'%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL 
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT birthdate FROM hr;  

-- cap nhat , chinh sua hire_date
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- CẬP NHẬT CHỈNH SỬA termdate
UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- TẠO THÊM CỘT AGE
ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR,birthdate, CURDATE());

SELECT 
	 max(age),
     min(age)
FROM hr;


