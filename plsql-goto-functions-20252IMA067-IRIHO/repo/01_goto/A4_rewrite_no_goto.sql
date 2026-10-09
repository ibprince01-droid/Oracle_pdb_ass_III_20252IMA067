SET SERVEROUTPUT ON

-- A1 rewritten
DECLARE
  v_num NUMBER := 15;
BEGIN
  IF v_num > 0 THEN
    DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE');
  ELSIF v_num < 0 THEN
    DBMS_OUTPUT.PUT_LINE(v_num || ' is NEGATIVE');
  ELSE
    DBMS_OUTPUT.PUT_LINE('The number is ZERO (neither positive nor negative)');
  END IF;

  IF v_num <> 0 THEN
    IF MOD(v_num, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE(v_num || ' is EVEN');
    ELSE
      DBMS_OUTPUT.PUT_LINE(v_num || ' is ODD');
    END IF;
  END IF;
  DBMS_OUTPUT.PUT_LINE('Classification finished.');
END;
/

-- A2 rewritten
DECLARE
  v_emp_id     employees.employee_id%TYPE := 103;
  v_name       VARCHAR2(101);
  v_salary     employees.salary%TYPE;
  v_band       VARCHAR2(10);
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
    DBMS_OUTPUT.PUT_LINE('Review not possible: salary is missing or not positive.');
  ELSE
    v_band := CASE
                WHEN v_salary >= 800000 THEN 'SENIOR'
                WHEN v_salary >= 200000 THEN 'MIDDLE'
                ELSE 'JUNIOR'
              END;
    v_pct  := CASE v_band
                WHEN 'SENIOR' THEN 3
                WHEN 'MIDDLE' THEN 5
                ELSE 8
              END;
    v_new_salary := v_salary * (1 + v_pct / 100);
    DBMS_OUTPUT.PUT_LINE('Band     : ' || v_band);
    DBMS_OUTPUT.PUT_LINE('Increase  : ' || v_pct || '%');
    DBMS_OUTPUT.PUT_LINE('Proposed  : ' || TO_CHAR(v_new_salary, 'FM999,999,990') || ' RWF');
  END IF;
  DBMS_OUTPUT.PUT_LINE('Salary review complete.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee found with ID ' || v_emp_id);
END;
/
