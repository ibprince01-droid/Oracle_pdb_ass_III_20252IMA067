SET SERVEROUTPUT ON

DECLARE
  v_emp_id     employees.employee_id%TYPE := 103;
  v_name       VARCHAR2(101);
  v_salary     employees.salary%TYPE;
  v_pct        NUMBER;
  v_new_salary NUMBER;
BEGIN
  SELECT first_name || ' ' || last_name, salary
    INTO v_name, v_salary
    FROM employees
   WHERE employee_id = v_emp_id;

  DBMS_OUTPUT.PUT_LINE('Employee : ' || v_name || ' (ID ' || v_emp_id || ')');
  DBMS_OUTPUT.PUT_LINE('Current  : ' || TO_CHAR(v_salary, 'FM999,999,990') || ' RWF');

  IF v_salary IS NULL OR v_salary <= 0 THEN
    GOTO invalid_salary;
  ELSIF v_salary >= 800000 THEN
    GOTO senior_band;
  ELSIF v_salary >= 200000 THEN
    GOTO middle_band;
  ELSE
    GOTO junior_band;
  END IF;

  <<senior_band>>
  v_pct := 3;
  DBMS_OUTPUT.PUT_LINE('Band     : SENIOR');
  GOTO show_result;

  <<middle_band>>
  v_pct := 5;
  DBMS_OUTPUT.PUT_LINE('Band     : MIDDLE');
  GOTO show_result;

  <<junior_band>>
  v_pct := 8;
  DBMS_OUTPUT.PUT_LINE('Band     : JUNIOR');
  GOTO show_result;

  <<invalid_salary>>
  DBMS_OUTPUT.PUT_LINE('Review not possible: salary is missing or not positive.');
  GOTO end_review;

  <<show_result>>
  v_new_salary := v_salary * (1 + v_pct / 100);
  DBMS_OUTPUT.PUT_LINE('Increase  : ' || v_pct || '%');
  DBMS_OUTPUT.PUT_LINE('Proposed  : ' || TO_CHAR(v_new_salary, 'FM999,999,990') || ' RWF');

  <<end_review>>
  DBMS_OUTPUT.PUT_LINE('Salary review complete.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee found with ID ' || v_emp_id);
END;
/
