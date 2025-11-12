-- 02_records_examples.sql
-- Demonstrates %ROWTYPE retrieval and a custom RECORD to hold summary stats.

SET SERVEROUTPUT ON;

-- 1) %ROWTYPE example: fetch an employee row
DECLARE
  v_emp Employees%ROWTYPE;  -- typed directly off the Employees table. :contentReference[oaicite:4]{index=4}
BEGIN
  SELECT * INTO v_emp FROM Employees WHERE Employee_ID = 1;
  DBMS_OUTPUT.PUT_LINE('Employee 1: ' || v_emp.First_Name || ' ' || v_emp.Last_Name
                       || ' - ' || v_emp.Email || ' - Salary: ' || v_emp.Salary);
END;
/
-- End %ROWTYPE demo


-- 2) Custom RECORD example: summary of department
DECLARE
  TYPE dept_summary IS RECORD (
    department_id   NUMBER,
    emp_count       NUMBER,
    avg_salary      NUMBER
  );

  v_sum dept_summary;
BEGIN
  SELECT Department_ID, COUNT(*), ROUND(AVG(Salary),2)
  INTO v_sum.department_id, v_sum.emp_count, v_sum.avg_salary
  FROM Employees
  WHERE Department_ID = 3
  GROUP BY Department_ID;

  DBMS_OUTPUT.PUT_LINE('Dept '||v_sum.department_id||' count='||v_sum.emp_count
                       ||' avg='||v_sum.avg_salary);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employees found for that department.');
END;
/
-- End RECORD demo
