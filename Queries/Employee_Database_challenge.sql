-- 
-- Creating retirement title table
--
SELECT e.emp_no,
  e.first_name,
  e.last_name,
  t.title,
  t.from_date,
  t.to_date
INTO retirement_titles
FROM employees AS e
  INNER JOIN titles AS t
    ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no
;
-- 
-- Creating unique title table
--
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title, from_date, to_date
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no ASC
;
select emp_no, first_name, last_name, title 
from unique_titles
order by emp_no ASC, to_date DESC
;
-- 
-- Creating retiring title table
--
select title, count(*) 
INTO retiring_titles
from unique_titles
group by title
order by count(*) DESC
;
-- 
-- Creating mentorship eligibilty table
--
SELECT DISTINCT ON (t.emp_no) t.emp_no,
  e.first_name,
  e.last_name,
  e.birth_date, 
  d.from_date,
  d.to_date,
  t.title
INTO mentorship_eligibilty
FROM employees AS e
  INNER JOIN titles AS t
    ON (e.emp_no = t.emp_no)
	INNER JOIN dept_emp AS d
	ON (d.emp_no = e.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
and t.to_date = ('9999-01-01')
ORDER BY t.emp_no
;
