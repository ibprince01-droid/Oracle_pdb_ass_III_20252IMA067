SET SERVEROUTPUT ON

DECLARE
  v_num NUMBER := 15;
BEGIN
  IF v_num > 0 THEN
    GOTO is_positive;
  ELSIF v_num < 0 THEN
    GOTO is_negative;
  ELSE
    GOTO is_zero;
  END IF;

  <<is_positive>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE');
  GOTO check_parity;

  <<is_negative>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is NEGATIVE');
  GOTO check_parity;

  <<is_zero>>
  DBMS_OUTPUT.PUT_LINE('The number is ZERO (neither positive nor negative)');
  GOTO end_program;

  <<check_parity>>
  IF MOD(v_num, 2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE(v_num || ' is EVEN');
  ELSE
    DBMS_OUTPUT.PUT_LINE(v_num || ' is ODD');
  END IF;

  <<end_program>>
  DBMS_OUTPUT.PUT_LINE('Classification finished.');
END;
/
