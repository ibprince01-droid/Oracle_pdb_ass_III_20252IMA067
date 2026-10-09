-- C1: fn_validate_payroll  (combined task: GOTO + functions + exceptions)
-- Returns 'VALID' or 'INVALID: <reason>'.
-- Uses GOTO for a single error exit; calls fn_calculate_tax and fn_dept_name,
-- so run B3 and B4 BEFORE this file.
-- Checks: id given, employee exists, salary > 0 and <= 10,000,000,
--         hire date present and not in the future, valid department, tax < salary.
CREATE OR REPLACE FUNCTION fn_validate_payroll (
  p_emp_id IN employees.employee_id%TYPE
) RETURN VARCHAR2
IS
  c_max_salary CONSTANT NUMBER := 10000000;
  v_count   NUMBER;
  v_salary  employees.salary%TYPE;
  v_hire    employees.hire_date%TYPE;
  v_dept_id employees.department_id%TYPE;
  v_tax     NUMBER;
  v_msg     VARCHAR2(200);
BEGIN
  IF p_emp_id IS NULL THEN
    v_msg := 'Employee ID is NULL';
    GOTO payroll_invalid;
  END IF;

  SELECT COUNT(*) INTO v_count FROM employees WHERE employee_id = p_emp_id;
  IF v_count = 0 THEN
    v_msg := 'Employee ' || p_emp_id || ' does not exist';
    GOTO payroll_invalid;
  END IF;

  SELECT salary, hire_date, department_id
    INTO v_salary, v_hire, v_dept_id
    FROM employees
   WHERE employee_id = p_emp_id;

  IF v_salary IS NULL OR v_salary <= 0 THEN
    v_msg := 'Salary must be greater than zero';
    GOTO payroll_invalid;
  END IF;

  IF v_salary > c_max_salary THEN
    v_msg := 'Salary exceeds maximum allowed (' || c_max_salary || ')';
    GOTO payroll_invalid;
  END IF;

  IF v_hire IS NULL THEN
    v_msg := 'Hire date is missing';
    GOTO payroll_invalid;
  ELSIF v_hire > SYSDATE THEN
    v_msg := 'Hire date is in the future';
    GOTO payroll_invalid;
  END IF;

  IF v_dept_id IS NULL OR fn_dept_name(v_dept_id) IN ('No Department', 'Unknown Department') THEN
    v_msg := 'Employee has no valid department';
    GOTO payroll_invalid;
  END IF;

  v_tax := fn_calculate_tax(v_salary);
  IF v_tax >= v_salary THEN
    v_msg := 'Tax is not lower than salary';
    GOTO payroll_invalid;
  END IF;

  RETURN 'VALID';

  <<payroll_invalid>>
  RETURN 'INVALID: ' || v_msg;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 'INVALID: unexpected error - ' || SQLERRM;
END fn_validate_payroll;
/
SHOW ERRORS FUNCTION fn_validate_payroll
