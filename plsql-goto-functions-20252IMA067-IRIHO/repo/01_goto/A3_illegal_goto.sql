SET SERVEROUTPUT ON

-- PART 1: ILLEGAL GOTO
DECLARE
  v_x NUMBER := 5;
BEGIN
  GOTO inside_if;

  IF v_x > 0 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Reached the label inside the IF');
  END IF;
END;
/

-- PART 2: FIX
DECLARE
  v_x NUMBER := 5;
BEGIN
  IF v_x > 0 THEN
    GOTO positive_branch;
  END IF;
  DBMS_OUTPUT.PUT_LINE('x is not positive');
  GOTO finish;

  <<positive_branch>>
  DBMS_OUTPUT.PUT_LINE('Reached the label correctly: x = ' || v_x);

  <<finish>>
  DBMS_OUTPUT.PUT_LINE('Done.');
END;
/
