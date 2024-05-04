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
-- 7. Sự phân bổ chức danh công việc trong công ty như thế nào?

SELECT 
	jobtitle,
    COUNT(*) AS count
FROM
	hr
WHERE
	termdate = '0000-00-00'
GROUP BY
	jobtitle
ORDER BY
	jobtitle;

-- 8. Which department has the highest turnover rate?
-- 8. Bộ phận nào có tỷ lệ luân chuyển cao nhất?
WITH department_terminated AS (
SELECT
	department,
	COUNT(*) AS total_count,
    SUM(CASE WHEN termdate = '0000-000-00' THEN 1 ELSE 0 END) AS active_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
FROM
	hr
GROUP BY 
	department
)
SELECT
	department,
    total_count,
    active_count,
    terminated_count,
    terminated_count / total_count AS termination_rate
FROM
	department_terminated
ORDER BY
	termination_rate DESC;


-- 9. What is the distribution of employees across locations by city and state?
-- 9. Sự phân bố nhân viên giữa các địa điểm theo tiểu bang như thế nào?

SELECT
	location_state,
    COUNT(*) AS count_location_state
FROM
	hr
WHERE 
	termdate ='0000-00-00'
GROUP BY
	location_state
ORDER BY
	count_location_state DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
-- 10. Số lượng nhân viên của công ty thay đổi như thế nào theo thời gian dựa trên ngày thuê và thời hạn?
WITH terminations_hires AS(
SELECT
	YEAR(hire_date) AS year,
    COUNT(*) AS hires,
    SUM(CASE WHEN termdate <> 0 AND termdate < CURDATE() THEN 1 ELSE 0 END) AS terminations
FROM 
	hr
GROUP BY
	year
ORDER BY
	year ASC
)
SELECT 
	year,
    hires,
    terminations,
    hires - terminations AS  net_change,
    ROUND((hires - terminations)/hires * 100 ,2) AS net_change_percent
FROM
	terminations_hires;



-- 11. What is the tenure distribution for each department?
-- 11. Phân bổ nhiệm kỳ cho từng bộ phận như thế nào?
-- trung bình nhân viên làm việc ở mỗi bộ phận trong bao lâu trước khi họ rời đi hoặc bị buộc phải rời đi?


SELECT
	department,
    ROUND(AVG(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM 
	hr
WHERE
	termdate <> '0000-00-00' AND termdate <= curdate()
GROUP BY
	department;


