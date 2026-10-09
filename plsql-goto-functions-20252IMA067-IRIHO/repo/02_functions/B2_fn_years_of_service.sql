-- B2: fn_years_of_service
-- Returns completed years of service (whole years) from hire_date to today.
-- NULL if the employee is not found or hire_date is missing.
CREATE OR REPLACE FUNCTION fn_years_of_service (
  p_emp_id IN employees.employee_id%TYPE
) RETURN NUMBER
IS
  v_hire_date employees.hire_date%TYPE;
BEGIN
  SELECT hire_date INTO v_hire_date
    FROM employees
   WHERE employee_id = p_emp_id;

  IF v_hire_date IS NULL THEN
    RETURN NULL;
  END IF;

  RETURN GREATEST(FLOOR(MONTHS_BETWEEN(SYSDATE, v_hire_date) / 12), 0);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END fn_years_of_service;
/
SHOW ERRORS FUNCTION fn_years_of_service
