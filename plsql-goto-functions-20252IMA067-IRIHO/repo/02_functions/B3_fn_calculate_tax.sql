-- B3: fn_calculate_tax
-- Monthly progressive tax (modelled on Rwanda PAYE bands, illustrative only):
--      0 -  60,000 : 0%
--  60,001 - 100,000 : 20% of the part above 60,000
--  above 100,000    : 8,000 + 30% of the part above 100,000
-- Raises ORA-20001 for NULL or negative salary.
CREATE OR REPLACE FUNCTION fn_calculate_tax (
  p_salary IN NUMBER
) RETURN NUMBER
IS
  c_band1 CONSTANT NUMBER := 60000;
  c_band2 CONSTANT NUMBER := 100000;
BEGIN
  IF p_salary IS NULL OR p_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Salary must be a non-negative number');
  END IF;

  IF p_salary <= c_band1 THEN
    RETURN 0;
  ELSIF p_salary <= c_band2 THEN
    RETURN (p_salary - c_band1) * 0.20;
  ELSE
    RETURN (c_band2 - c_band1) * 0.20 + (p_salary - c_band2) * 0.30;
  END IF;
END fn_calculate_tax;
/
SHOW ERRORS FUNCTION fn_calculate_tax
