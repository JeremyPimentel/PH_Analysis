-- Use Dictinct with Orderby to remove duplicate row
SELECT 
    employees.emp_no,
    employees.first_name,
    employees.last_name,
    titles.title,
    titles.from_date,
    titles.to_date
INTO retirement_titles
FROM employees
LEFT JOIN titles
ON employees.emp_no = titles.emp_no
WHERE employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY employees.emp_no;



SELECT * FROM retirement_titles;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE retirement_titles.to_date = '9999-01-01'
ORDER BY emp_no ASC, retirement_titles.to_date DESC;

SELECT * FROM unique_titles;


DROP TABLE retiring_titles;

SELECT COUNT (emp_no) AS count, title AS title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;


--Membership eligibility

DROP TABLE membership_eligibility_1;

SELECT DISTINCT ON(emp_no) 
    retirement_titles.emp_no, 
    retirement_titles.first_name, 
    retirement_titles.last_name, 
    retirement_titles.title,
    dept_emp.from_date,
    dept_emp.to_date
INTO membership_eligibility_1
FROM retirement_titles
LEFT JOIN dept_emp
ON retirement_titles.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date = '9999-01-01' 
ORDER BY emp_no ASC;


SELECT * FROM membership_eligibility_1;

DROP TABLE membership_eligibility;
SELECT 
    membership_eligibility_1.emp_no, 
    membership_eligibility_1.first_name, 
    membership_eligibility_1.last_name, 
    membership_eligibility_1.title,
    membership_eligibility_1.from_date,
    membership_eligibility_1.to_date,
    employees.birth_date
INTO membership_eligibility
FROM employees
RIGHT JOIN membership_eligibility_1
ON membership_eligibility_1.emp_no = employees.emp_no
;

SELECT * FROM membership_eligibility;


INTO mentorship_eligibility
SELECT from_date, to_date
FROM dept_emp

DROP TABLE dept_emp;

CREATE TABLE dept_emp(
   emp_no INT,
   dept_no VARCHAR(10),
   from_date date,
   to_date date

);
