-- 03_goto_example.sql
-- Small, clear GOTO demonstration. Note: GOTO is supported, but avoid in production.
SET SERVEROUTPUT ON;

DECLARE
  CURSOR c IS SELECT Employee_ID, Salary FROM Employees ORDER BY Employee_ID;
  v_threshold NUMBER := 70000;
  v_count_high PLS_INTEGER := 0;
BEGIN
  FOR r IN c LOOP
    IF r.Salary IS NULL THEN
      -- avoid null salaries
      GOTO skip_emp;
    END IF;

    IF r.Salary > v_threshold THEN
      v_count_high := v_count_high + 1;
      DBMS_OUTPUT.PUT_LINE('High earner: ' || r.Employee_ID || ' salary=' || r.Salary);
      GOTO after_mark;
    END IF;

    -- normal processing
    DBMS_OUTPUT.PUT_LINE('Checked: ' || r.Employee_ID || ' salary=' || NVL(TO_CHAR(r.Salary),'N/A'));

    <<after_mark>>
    NULL; -- placeholder label target

    <<skip_emp>>
    NULL; -- skip label
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Total high earners over '||v_threshold||' = '||v_count_high);
END;
/
-- End GOTO demo

-- Note in docs: prefer structured control (IF/LOOP/EXIT) over GOTO except for tiny cases.
