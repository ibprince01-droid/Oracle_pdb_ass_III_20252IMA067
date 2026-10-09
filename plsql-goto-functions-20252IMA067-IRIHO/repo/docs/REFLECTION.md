# C2 — Reflection

> Draft written to help structure your answers. **Edit it in your own words and
> experience** — you are expected to explain it in the quiz.

## 1. What I learned about GOTO
GOTO transfers control to a label (`<<label>>`) in the same block or an enclosing
block. It cannot jump *into* an IF, LOOP or nested block, and a label must be followed
by an executable statement (use `NULL;`). In A3 the compiler rejected a jump into an IF
with `PLS-00375`; the fix was moving the label to the enclosing level.

## 2. GOTO vs structured code
A1/A2 work with GOTO, but A4 shows the same logic is shorter and easier to read with
`IF/ELSIF` and `CASE`. GOTO makes execution order harder to follow ("spaghetti code"),
so I would avoid it. One reasonable use is a single error-exit label, as in
`fn_validate_payroll`.

## 3. Functions
A function must `RETURN` a value and can be called from SQL (B5) as well as PL/SQL.
Compared with procedures, they are for computing a value. Functions called from SQL
should not change data. I handled edge cases: `NO_DATA_FOUND` returns NULL
(B1, B2, B4) and invalid salary raises `ORA-20001` (B3).

## 4. Challenges
- *(Write your own: e.g. getting labels in the right scope, SHOW ERRORS, compile order of C1.)*

## 5. What I would improve
- Store tax bands in a table instead of hard-coding them.
- Return error codes plus messages from the validator.
