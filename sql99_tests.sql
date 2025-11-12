-- 99_tests.sql
SET SERVEROUTPUT ON;

-- 1. Count employees (sanity)
SELECT COUNT(*) FROM Employees;

-- 2. Show sample employees (first 10)
SELECT Employee_ID, First_Name, Last_Name, Department_ID, Salary FROM Employees ORDER BY Employee_ID FETCH FIRST 10 ROWS ONLY;

-- 3. Avg salary dept 3
SELECT ROUND(AVG(Salary),2) FROM Employees WHERE Department_ID = 3;
