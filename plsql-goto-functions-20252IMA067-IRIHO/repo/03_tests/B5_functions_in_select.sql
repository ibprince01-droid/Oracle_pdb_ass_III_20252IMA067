-- B5: Using the functions inside SQL
SET LINESIZE 200
SET PAGESIZE 50
COLUMN employee FORMAT A22
COLUMN department FORMAT A16
COLUMN payroll_check FORMAT A45

-- 1) Functions in the SELECT list
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name AS employee,
       e.salary                           AS monthly_salary,
       fn_annual_salary(e.employee_id)    AS annual_salary,
       fn_years_of_service(e.employee_id) AS years_service,
       fn_calculate_tax(e.salary)         AS monthly_tax,
       fn_dept_name(e.department_id)      AS department
  FROM employees e
 WHERE e.salary > 0                       -- tax function rejects negatives; zero is fine too
 ORDER BY e.employee_id;

-- 2) Function in WHERE and ORDER BY
SELECT employee_id, first_name, fn_years_of_service(employee_id) AS years_service
  FROM employees
 WHERE fn_years_of_service(employee_id) >= 5
 ORDER BY fn_years_of_service(employee_id) DESC;

-- 3) Payroll validation across all employees
SELECT employee_id, fn_validate_payroll(employee_id) AS payroll_check
  FROM employees
 ORDER BY employee_id;
