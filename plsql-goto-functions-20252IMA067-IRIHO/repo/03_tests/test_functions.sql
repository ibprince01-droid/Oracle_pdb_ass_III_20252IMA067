-- Tests for B1-B4, including edge cases. Run after all functions compile.
SET SERVEROUTPUT ON

BEGIN
  DBMS_OUTPUT.PUT_LINE('--- B1 fn_annual_salary ---');
  DBMS_OUTPUT.PUT_LINE('101 -> ' || fn_annual_salary(101) || '   (expect 14400000)');
  DBMS_OUTPUT.PUT_LINE('9999 -> ' || NVL(TO_CHAR(fn_annual_salary(9999)), 'NULL') || '   (expect NULL)');

  DBMS_OUTPUT.PUT_LINE('--- B2 fn_years_of_service ---');
  DBMS_OUTPUT.PUT_LINE('101 -> ' || fn_years_of_service(101) || ' years');
  DBMS_OUTPUT.PUT_LINE('107 -> ' || fn_years_of_service(107) || ' years');
  DBMS_OUTPUT.PUT_LINE('9999 -> ' || NVL(TO_CHAR(fn_years_of_service(9999)), 'NULL') || '   (expect NULL)');

  DBMS_OUTPUT.PUT_LINE('--- B3 fn_calculate_tax ---');
  DBMS_OUTPUT.PUT_LINE('50,000  -> ' || fn_calculate_tax(50000)  || '   (expect 0)');
  DBMS_OUTPUT.PUT_LINE('80,000  -> ' || fn_calculate_tax(80000)  || '   (expect 4000)');
  DBMS_OUTPUT.PUT_LINE('100,000 -> ' || fn_calculate_tax(100000) || '   (expect 8000)');
  DBMS_OUTPUT.PUT_LINE('450,000 -> ' || fn_calculate_tax(450000) || '   (expect 113000)');
  BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_calculate_tax(-5));
  EXCEPTION
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('-5 -> error caught: ' || SQLERRM);
  END;

  DBMS_OUTPUT.PUT_LINE('--- B4 fn_dept_name ---');
  DBMS_OUTPUT.PUT_LINE('10   -> ' || fn_dept_name(10)   || '   (expect Finance)');
  DBMS_OUTPUT.PUT_LINE('NULL -> ' || fn_dept_name(NULL) || '   (expect No Department)');
  DBMS_OUTPUT.PUT_LINE('99   -> ' || fn_dept_name(99)   || '   (expect Unknown Department)');
END;
/
