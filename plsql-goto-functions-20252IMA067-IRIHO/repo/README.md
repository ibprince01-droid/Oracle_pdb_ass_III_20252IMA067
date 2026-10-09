# PL/SQL GOTO Statements and Functions — Individual Assignment III

- **Course:** Database Development with PL/SQL (INSY 8311)
- **Student:** `<Your Name>` — ID `<studentID>`
- **Group:** `<I / B / C / D>`
- **Instructor:** Eric Maniraguha

## Contents
| Task | File | Description |
|---|---|---|
| Setup | `00_setup/create_tables.sql` | `departments`, `employees` and sample data |
| A1 | `01_goto/A1_number_classifier.sql` | Positive/negative/zero + even/odd with GOTO |
| A2 | `01_goto/A2_salary_review.sql` | Salary band review with GOTO |
| A3 | `01_goto/A3_illegal_goto.sql` | Illegal GOTO (PLS-00375) and its fix |
| A4 | `01_goto/A4_rewrite_no_goto.sql` | A1 and A2 rewritten with IF/CASE |
| B1 | `02_functions/B1_fn_annual_salary.sql` | Monthly × 12 |
| B2 | `02_functions/B2_fn_years_of_service.sql` | Whole years since hire |
| B3 | `02_functions/B3_fn_calculate_tax.sql` | Progressive tax bands |
| B4 | `02_functions/B4_fn_dept_name.sql` | Department name lookup |
| B5 | `03_tests/B5_functions_in_select.sql` | Functions used in SQL |
| C1 | `02_functions/C1_fn_validate_payroll.sql` | Payroll validator (GOTO + functions) |
| C2 | `docs/REFLECTION.md` | Reflection |

## How to run (Oracle SQL*Plus / SQL Developer)
1. `00_setup/create_tables.sql`
2. `02_functions/` in order: **B1, B2, B3, B4, then C1** (C1 depends on B3 and B4)
3. Programs in `01_goto/`
4. Tests in `03_tests/`: `test_functions.sql`, `test_validate_payroll.sql`, `B5_functions_in_select.sql`
5. Check results against the screenshots in `screenshots/`.

Run each script with `SET SERVEROUTPUT ON` enabled.

## Assumptions
- `salary` is **monthly**, in RWF.
- Tax bands follow Rwanda PAYE-style brackets (0% to 60,000; 20% to 100,000; 30% above) and are illustrative.
- Employees 108–110 are deliberately invalid to demonstrate the validator.

## Notes
- AI usage: *(edit this)* I used an AI assistant (Claude) to generate a first draft of the
  SQL scripts and documentation. I reviewed, ran and tested the code myself and can explain it.
