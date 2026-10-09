-- B1: fn_annual_salary
-- Returns monthly salary * 12 for an employee. NULL if employee not found.
CREATE OR REPLACE FUNCTION fn_annual_salary (
  p_emp_id IN employees.employee_id%TYPE
) RETURN NUMBER
IS
  v_salary employees.salary%TYPE;
BEGIN
  SELECT salary INTO v_salary
    FROM employees
   WHERE employee_id = p_emp_id;

  RETURN v_salary * 12;          -- NULL salary gives NULL
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END fn_annual_salary;
/
SHOW ERRORS FUNCTION fn_annual_salary
