-- Data entries for employee table
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (1, 25, 'BSC', 50000, 'John Doe');
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (2, 30, 'MSC', 60000, 'Jane Smith');
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (3, 28, 'BBA', 45000, 'Mike Johnson');
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (4, 32, 'MBA', 70000, 'Emily Brown');
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (5, 27, 'BTECH', 55000, 'David Wilson');
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (6, 29, 'BSC', 52000, 'Sophia Davis');
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (7, 31, 'MSC', 65000, 'Oliver Miller');
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (8, 26, 'BBA', 48000, 'Emma Taylor');
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (9, 33, 'MBA', 72000, 'Noah Anderson');
INSERT INTO employee (em_id, age, qualification, salary, name) VALUES (10, 28, 'BTECH', 53000, 'Ava Martinez');

-- Data entries for team table
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (1, 1, 1, 'Developer');
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (1, 2, 1, 'Developer');
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (2, 3, 3, 'Tester');
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (2, 4, 3, 'Tester');
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (3, 5, 6, 'Analyst');
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (3, 6, 6, 'Analyst');
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (4, 7, 7, 'Designer');
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (4, 8, 7, 'Designer');
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (5, 9, 9, 'Management');
INSERT INTO team (team_id, em_id, t_lead, team_role) VALUES (5, 10, 9, 'Management');


-- Data entries for work table
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (1, 1,DATE '2022-01-01',DATE '2022-03-31', 1);
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (2, 2,DATE '2022-02-01',DATE '2022-04-30', 0);
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (3, 3,DATE '2022-03-01',DATE '2022-05-31', 1);
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (4, 4,DATE '2022-04-01',DATE '2022-06-30', 1);
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (5, 5,DATE '2022-05-01',DATE '2022-07-31', 0);
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (6, 1,DATE '2022-06-01',DATE '2022-08-31', 0);
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (7, 2,DATE '2022-07-01',DATE '2022-09-30', 1);
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (8, 3,DATE '2022-08-01',DATE '2022-10-31', 1);
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (9, 4,DATE '2022-09-01',DATE '2022-11-30', 0);
INSERT INTO work (project_id, team_id, from_date, to_date, is_completed) VALUES (10, 5,DATE '2022-10-01',DATE '2022-12-31', 1);


-- Data entries for performance table
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (1, 1, 90, 10000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (2, 1, 80, 8000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (3, 2, 95, 12000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (4, 2, 85, 9000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (5, 3, 92, 11000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (6, 3, 78, 7500);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (7, 4, 87, 9500);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (8, 4, 93, 10500);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (9, 5, 81, 8200);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (10, 5, 88, 9800);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (1, 6, 90, 10000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (2, 6, 80, 8000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (3, 7, 95, 12000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (4, 7, 85, 9000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (5, 8, 92, 11000);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (6, 8, 78, 7500);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (7, 9, 87, 9500);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (8, 9, 93, 10500);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (9, 10, 81, 8200);
INSERT INTO performance (em_id, project_id, presence, profit) VALUES (10, 10, 88, 9800);

--sql queries

--Query using JOIN to retrieve teams, their team leads, and project details:
SELECT t.team_id, e.name AS team_lead, w.project_id, w.from_date, w.to_date
FROM team t
JOIN employee e ON t.t_lead = e.em_id
JOIN work w ON t.team_id = w.team_id;

--Query using JOIN to retrieve employees, their salaries, and project profits:
SELECT e.name, e.salary, p.profit
FROM employee e
JOIN performance p ON e.em_id = p.em_id
JOIN work w ON p.project_id = w.project_id;

--Query using JOIN to retrieve employees, their projects, and corresponding presence:
SELECT e.name, w.project_id, p.presence
FROM employee e
JOIN performance p ON e.em_id = p.em_id
JOIN work w ON p.project_id = w.project_id;

--Query using the WITH clause to find employees and their corresponding teams:
WITH employee_teams AS (
  SELECT e.em_id, e.name, t.team_id, t.team_role
  FROM employee e
  JOIN team t ON e.em_id = t.em_id
)
SELECT * FROM employee_teams;

--Create a view to retrieve completed projects:
CREATE VIEW completed_projects AS
SELECT * FROM work WHERE is_completed = 1;

--Query using GROUP BY and AVG to calculate the average salary for each team role:
SELECT team_role, AVG(salary) AS average_salary
FROM employee
JOIN team ON employee.em_id = team.em_id
GROUP BY team_role;

--Query using GROUP BY and COUNT to count the number of employees in each qualification category:
SELECT qualification, COUNT(*) AS employee_count
FROM employee
GROUP BY qualification;

--Query using IN operator to retrieve employees who have a qualification of 'BSC' or 'MSC':
SELECT *
FROM employee
WHERE qualification IN ('BSC', 'MSC');

--Query using ALL operator to retrieve employees whose salary is greater than all employees with the qualification 'BSC':
SELECT *
FROM employee
WHERE salary > ALL (
  SELECT salary
  FROM employee
  WHERE qualification = 'BSC'
);

--Query using SOME operator to retrieve employees whose salary is greater than at least one employee with the qualification 'BTECH':
SELECT *
FROM employee
WHERE salary > SOME (
  SELECT salary
  FROM employee
  WHERE qualification = 'BTECH'
);
