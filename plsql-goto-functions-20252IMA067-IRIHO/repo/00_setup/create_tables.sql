-- 00_setup/create_tables.sql
-- Creates DEPARTMENTS and EMPLOYEES with sample data (salaries are MONTHLY, in RWF).
-- Rows 108-110 are intentionally "bad" so the payroll validator (C1) has something to catch.
SET SERVEROUTPUT ON

BEGIN EXECUTE IMMEDIATE 'DROP TABLE employees PURGE';   EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE departments PURGE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE departments (
  department_id   NUMBER        PRIMARY KEY,
  department_name VARCHAR2(50)  NOT NULL,
  location        VARCHAR2(50)
);

CREATE TABLE employees (
  employee_id   NUMBER         PRIMARY KEY,
  first_name    VARCHAR2(50)   NOT NULL,
  last_name     VARCHAR2(50)   NOT NULL,
  salary        NUMBER(12,2),
  hire_date     DATE,
  department_id NUMBER REFERENCES departments(department_id)
);

INSERT INTO departments VALUES (10, 'Finance',    'Kigali');
INSERT INTO departments VALUES (20, 'IT',         'Kigali');
INSERT INTO departments VALUES (30, 'HR',         'Huye');
INSERT INTO departments VALUES (40, 'Operations', 'Musanze');

INSERT INTO employees VALUES (101, 'Alice',   'Uwase',      1200000, DATE '2015-03-01', 10);
INSERT INTO employees VALUES (102, 'Eric',    'Nshuti',      850000, DATE '2018-07-15', 20);
INSERT INTO employees VALUES (103, 'Grace',   'Mukamana',    450000, DATE '2020-01-10', 20);
INSERT INTO employees VALUES (104, 'Jean',    'Habimana',    320000, DATE '2022-09-01', 30);
INSERT INTO employees VALUES (105, 'Diane',   'Ingabire',    150000, DATE '2024-05-20', 30);
INSERT INTO employees VALUES (106, 'Patrick', 'Niyonzima',    95000, DATE '2025-02-01', 40);
INSERT INTO employees VALUES (107, 'Claire',  'Umutoni',      55000, DATE '2025-08-01', 40);
-- Intentionally invalid rows for C1:
INSERT INTO employees VALUES (108, 'Zero',    'Salary',           0, DATE '2021-01-01', 10);
INSERT INTO employees VALUES (109, 'Future',  'Hire',        300000, ADD_MONTHS(SYSDATE, 6), 20);
INSERT INTO employees VALUES (110, 'No',      'Department',  300000, DATE '2019-06-01', NULL);

COMMIT;

SELECT COUNT(*) AS departments_loaded FROM departments;
SELECT COUNT(*) AS employees_loaded   FROM employees;
