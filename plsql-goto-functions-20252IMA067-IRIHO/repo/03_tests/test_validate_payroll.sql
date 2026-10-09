-- Tests for C1 fn_validate_payroll
SET SERVEROUTPUT ON

BEGIN
  FOR r IN (SELECT employee_id FROM employees ORDER BY employee_id) LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD('Employee ' || r.employee_id, 14) || ' -> ' || fn_validate_payroll(r.employee_id));
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(RPAD('Employee 9999', 14) || ' -> ' || fn_validate_payroll(9999));
  DBMS_OUTPUT.PUT_LINE(RPAD('Employee NULL', 14) || ' -> ' || fn_validate_payroll(NULL));
END;
/
-- Expected: 101-107 VALID; 108 salary zero; 109 future hire date; 110 no valid department;
--           9999 does not exist; NULL id rejected.
