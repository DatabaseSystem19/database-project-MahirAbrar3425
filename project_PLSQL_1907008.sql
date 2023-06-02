--Retrieving information about an employee using a row type variable:
set serveroutput on 
DECLARE
  emp_info employee%ROWTYPE;
BEGIN
  SELECT * INTO emp_info FROM employee WHERE em_id = 1;
  DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_info.em_id);
  DBMS_OUTPUT.PUT_LINE('Name: ' || emp_info.name);
  DBMS_OUTPUT.PUT_LINE('Salary: ' || emp_info.salary);
  -- Retrieve other columns as needed
END;
/
--Updating employee information using a row type variable:
set serveroutput on 
DECLARE
  emp_info employee%ROWTYPE;
BEGIN
  SELECT * INTO emp_info FROM employee WHERE em_id = 2;
  emp_info.name := 'New Name';
  emp_info.salary := 65000;
  -- Update other columns as needed
  UPDATE employee SET ROW = emp_info WHERE em_id = 2;
  COMMIT;
END;
/
--Using a cursor to retrieve employee names and counting the number of records:
set serveroutput on 
DECLARE
  CURSOR c_employee IS SELECT name FROM employee;
  emp_name employee.name%TYPE;
  total_count NUMBER := 0;
BEGIN
  OPEN c_employee;
  LOOP
    FETCH c_employee INTO emp_name;
    EXIT WHEN c_employee%NOTFOUND;
    total_count := total_count + 1;
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name);
  END LOOP;
  CLOSE c_employee;
  DBMS_OUTPUT.PUT_LINE('Total Employees: ' || total_count);
END;
/
--Using a cursor to update salary for employees based on a condition and counting the number of updated records:
set serveroutput on 
DECLARE
  CURSOR c_employee IS SELECT * FROM employee WHERE qualification = 'BSC' FOR UPDATE;
  emp_record employee%ROWTYPE;
  update_count NUMBER := 0;
BEGIN
  OPEN c_employee;
  LOOP
    FETCH c_employee INTO emp_record;
    EXIT WHEN c_employee%NOTFOUND;
    emp_record.salary := emp_record.salary + 1000;
    -- Update other columns as needed
    UPDATE employee SET ROW = emp_record WHERE CURRENT OF c_employee;
    update_count := update_count + 1;
  END LOOP;
  CLOSE c_employee;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Updated Employees: ' || update_count);
END;
/
--Using a FOR LOOP to retrieve and display employee names:
set serveroutput on 
BEGIN
  FOR emp_record IN (SELECT name FROM employee) LOOP
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_record.name);
  END LOOP;
END;
/
--Using a WHILE LOOP and an array to calculate the total profit from performance table:
SET SERVEROUTPUT ON

DECLARE
  TYPE profit_array IS VARRAY(5) OF performance.profit%TYPE;
  
  profits profit_array := profit_array();
  total_profit NUMBER := 0;
  i NUMBER := 1;
  entry_count NUMBER := 0;
BEGIN
  SELECT COUNT(DISTINCT em_id) INTO entry_count FROM performance;
  WHILE i <= entry_count LOOP
    profits.EXTEND();

    SELECT em_id , SUM(profit) INTO profits(i)
    FROM performance
    GROUP BY em_id;

    total_profit := total_profit + profits(i);
    i := i + 1;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('Total Profit: ' || total_profit);
END;

/
--Initializing an array and assigning values manually:
set serveroutput on 
DECLARE
  TYPE qualification_array IS VARRAY(5) OF VARCHAR2(30);
  qualifications qualification_array := qualification_array('BSC', 'MSC', 'BBA', 'MBA', 'BTECH');
BEGIN
  FOR i IN 1..qualifications.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Qualification: ' || qualifications(i));
  END LOOP;
END;
/
--Retrieving qualification names from employees and storing them in an array:
set serveroutput on 
DECLARE
  TYPE qualification_array IS TABLE OF employee.qualification%TYPE;
  qualifications qualification_array := qualification_array();
BEGIN
  SELECT qualification BULK COLLECT INTO qualifications FROM employee;
  FOR i IN 1..qualifications.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Qualification: ' || qualifications(i));
  END LOOP;
END;
/
--Using the EXTEND function to dynamically add elements to an array:
set serveroutput on 
DECLARE
  TYPE employee_id_array IS TABLE OF employee.em_id%TYPE;
  employee_ids employee_id_array := employee_id_array();
BEGIN
  employee_ids.EXTEND(3);
  employee_ids(1) := 1;
  employee_ids(2) := 3;
  employee_ids(3) := 5;
  FOR i IN 1..employee_ids.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employee_ids(i));
  END LOOP;
END;
/
--Initializing an array without using the EXTEND function:
set serveroutput on 
DECLARE
  TYPE salary_array IS VARRAY(3) OF NUMBER;
  salaries salary_array := salary_array(50000, 60000, 45000);
BEGIN
  FOR i IN 1..salaries.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Salary: ' || salaries(i));
  END LOOP;
END;
/
--Checking if an employee's age is greater than 30 and displaying a message accordingly:
set serveroutput on 

DECLARE
  emp_age employee.age%TYPE;
BEGIN
  SELECT age INTO emp_age FROM employee WHERE em_id = 1;
  IF emp_age > 30 THEN
    DBMS_OUTPUT.PUT_LINE('Employee is above 30 years old.');
  ELSIF emp_age < 30 THEN
    DBMS_OUTPUT.PUT_LINE('Employee is below 30 years old.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Employee is exactly 30 years old.');
  END IF;
END;
/
--Checking if a project is completed or not and updating the status accordingly:
set serveroutput on 

DECLARE
  proj_status work.is_completed%TYPE;
BEGIN
  SELECT is_completed INTO proj_status FROM work WHERE project_id = 1;
  IF proj_status = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Project is completed.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Project is not completed.');
    UPDATE work SET is_completed = 1 WHERE project_id = 1;
    COMMIT;
  END IF;
END;
/
--Creating a procedure to update an employee's qualification based on their age:
set serveroutput on 

CREATE OR REPLACE PROCEDURE update_qualification(p_em_id IN employee.em_id%type)
IS
  v_age employee.age%TYPE;
BEGIN
  SELECT age INTO v_age FROM employee WHERE em_id = p_em_id;
  
  IF v_age < 25 THEN
    UPDATE employee SET qualification = 'BSC' WHERE em_id = p_em_id;
  ELSIF v_age >= 25 AND v_age < 30 THEN
    UPDATE employee SET qualification = 'MSC' WHERE em_id = p_em_id;
  ELSE
    UPDATE employee SET qualification = 'MBA' WHERE em_id = p_em_id;
  END IF;
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Qualification updated successfully.');
END;


--Calling the procedure to update an employee's qualification:


--Creating a function to calculate the average salary of employees in a team:
set serveroutput on 

CREATE OR REPLACE FUNCTION calculate_avg_salary(p_team_id IN team.team_id%type)
  RETURN NUMBER
IS
  v_avg_salary NUMBER;
BEGIN
  SELECT AVG(salary) INTO v_avg_salary
  FROM employee
  WHERE team_id = p_team_id;
  
  RETURN v_avg_salary;
END;
show errors;
--Calling the function to calculate the average salary of a team:
set serveroutput on 

DECLARE
  team_id team.team_id%TYPE := 1;
  avg_salary NUMBER;
BEGIN
  update_qualification(1);
  avg_salary := calculate_avg_salary(team_id);
  DBMS_OUTPUT.PUT_LINE('Average Salary: ' || avg_salary);
END;
/