-- 01_collections_examples.sql
-- Demonstrates associative arrays, nested tables, and varrays.

SET SERVEROUTPUT ON SIZE 100000;

-- 1) Associative array (index-by) example:
--    load employee salaries into an associative array, give a 10% raise to
--    employees in department 3 (IT), then print old/new.

DECLARE
  TYPE t_salary_map IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  v_salaries t_salary_map;
  v_emp_id   PLS_INTEGER;
  CURSOR c_emp IS
    SELECT Employee_ID, Salary, Department_ID FROM Employees; -- uses your Employees table. :contentReference[oaicite:3]{index=3}
BEGIN
  FOR r IN c_emp LOOP
    v_salaries(r.Employee_ID) := r.Salary;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Applied 10% raise to department 3 (IT):');
  FOR idx IN v_salaries.FIRST .. v_salaries.LAST LOOP
    EXIT WHEN idx IS NULL; -- safe-guard for sparse indexes
    BEGIN
      SELECT Department_ID INTO v_emp_id FROM Employees WHERE Employee_ID = idx;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      CONTINUE;
    END;
    -- only apply when department = 3
    IF v_emp_id = 3 THEN
      DBMS_OUTPUT.PUT_LINE('Emp ' || idx || ' old=' || v_salaries(idx)
                            || ' new=' || ROUND(v_salaries(idx)*1.10,2));
      -- (You could UPDATE Employees SET Salary = Salary * 1.10 WHERE Employee_ID = idx;)
    END IF;
  END LOOP;
END;
/
-- End assoc array demo


-- 2) Nested table example: collect emails of a department
DECLARE
  TYPE t_email_nt IS TABLE OF VARCHAR2(200);
  v_emails t_email_nt := t_email_nt();
BEGIN
  SELECT Email
  BULK COLLECT INTO v_emails
  FROM Employees
  WHERE Department_ID = 3; -- IT department

  DBMS_OUTPUT.PUT_LINE('Emails for Department 3, count=' || v_emails.COUNT);
  FOR i IN 1..v_emails.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('  - ' || v_emails(i));
  END LOOP;
END;
/
-- End nested table demo


-- 3) VARRAY example: top 5 salaries snapshot
DECLARE
  TYPE t_top_vr IS VARRAY(5) OF NUMBER;
  v_top t_top_vr := t_top_vr();
BEGIN
  FOR rec IN (SELECT Salary FROM Employees ORDER BY Salary DESC FETCH FIRST 5 ROWS ONLY) LOOP
    v_top.EXTEND;
    v_top(v_top.COUNT) := rec.Salary;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Top 5 salaries snapshot:');
  FOR i IN 1..v_top.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(i || ': ' || v_top(i));
  END LOOP;
END;
/
-- End varray demo
