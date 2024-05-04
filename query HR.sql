-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
-- 1. What is the gender breakdown of employees in the company?
SELECT 
	gender,
    COUNT(*) AS count_gender
FROM 
	hr
WHERE
	termdate ='0000-00-00'
GROUP BY 
	gender;
    
select * from hr;

-- 2. What is the race/ethnicity breakdown of employees in the company?
-- 2. Sự phân chia chủng tộc/dân tộc của nhân viên trong công ty như thế nào?

SELECT 
	race,
    COUNT(*) AS count_race
FROM
	hr
WHERE
	termdate = '0000-00-00'
GROUP BY
	race
ORDER BY 
	count_race DESC;


select * from hr;
-- 3. What is the age distribution of employees in the company?
-- 3. Sự phân bổ độ tuổi của nhân viên trong công ty như thế nào?
SELECT
	MAX(age) AS youngest,
    MIN(age) AS oldest
FROM
	hr
WHERE
	termdate = '0000-00-00';
    
SELECT 
	CASE
		WHEN age >= 20 AND age <30 THEN '20-30'
        WHEN age >= 30 AND age <40 THEN '30-40'
        WHEN age >= 40 AND age < 50 THEN '40-50'
        WHEN age >= 50 AND age < 60 THEN '50-60'
		ELSE '60+'
	END AS age_group,
    COUNT(*) AS count
FROM
	hr
WHERE 
	termdate = '0000-00-00'
GROUP BY
	age_group
ORDER BY
	age_group;


SELECT 
	CASE
		WHEN age >= 20 AND age <30 THEN '20-30'
        WHEN age >= 30 AND age <40 THEN '30-40'
        WHEN age >= 40 AND age < 50 THEN '40-50'
        WHEN age >= 50 AND age < 60 THEN '50-60'
		ELSE '60+'
	END AS age_group,
    gender,
    COUNT(*) AS count
FROM
	hr
WHERE 
	termdate = '0000-00-00'
GROUP BY
	age_group,gender
ORDER BY
	age_group,gender;
    
-- 4. How many employees work at headquarters versus remote locations?
-- 4. Có bao nhiêu nhân viên làm việc tại trụ sở chính so với các địa điểm ở xa?
SELECT
	location,
    COUNT(*) AS count_location
FROM 
	hr
WHERE
	termdate = '0000-00-00'
GROUP BY
	location;



select * from hr;
-- 5. What is the average length of employment for employees who have been terminated?
-- 5. Thời gian làm việc trung bình của những nhân viên đã bị chấm dứt hợp đồng là bao lâu?
SELECT
	ROUND(AVG(datediff(termdate,hire_date))/365,1) as avg_length_employee
FROM 
	hr
WHERE
	termdate <= curdate() AND termdate <> '0000-00-00';

-- 6. How does the gender distribution vary across departments?
-- 6. Sự phân bổ giới tính giữa các phòng ban khác nhau như thế nào?
SELECT
	department,
    gender,
    COUNT(*)
FROM
	hr
WHERE
	termdate = '0000-00-00'
GROUP BY
	department, gender
ORDER BY
	department;

-- 7. What is the distribution of job titles across the company?


-- 8. Which department has the highest turnover rate?


-- 9. What is the distribution of employees across locations by city and state?


-- 10. How has the company's employee count changed over time based on hire and term dates?

-- 11. What is the tenure distribution for each department?