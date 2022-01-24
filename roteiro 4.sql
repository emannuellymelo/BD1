-- Emannuelly Larissa Freitas de Melo - 119210167
-- Banco de Dados - Roteiro 04

-- Questão 1
SELECT * FROM department;

-- Questão 2
SELECT * FROM dependent;

-- Questão 3
SELECT * FROM dept_locations;

-- Questão 4
SELECT * FROM employee;

-- Questão 5
SELECT * FROM project;

-- Questão 6
SELECT * FROM works_on;

-- Questão 7
SELECT fname, lname FROM employee WHERE sex='M';

-- Questão 8
SELECT fname FROM employee WHERE sex='M' AND superssn IS NULL;

-- Questão 9
SELECT e.fname, s.fname FROM employee AS e, employee AS s WHERE e.superssn IS NOT NULL AND e.superssn = s.ssn;

-- Questão 10
SELECT e.fname FROM employee AS e, employee AS s WHERE e.superssn IS NOT NULL AND e.superssn = s.ssn AND s.fname='Franklin';

-- Questão 11
SELECT dname, dlocation FROM department, dept_locations WHERE department.dnumber = dept_locations.dnumber;

-- Questão 12
SELECT dname FROM department, dept_locations WHERE department.dnumber = dept_locations.dnumber AND dlocation LIKE 'S%';

-- Questão 13
SELECT fname, lname, dependent_name FROM employee, dependent WHERE essn = ssn;

-- Questão 14
SELECT (fname||minit||lname) AS full_name, salary FROM employee WHERE salary >50000;

-- Questão 15
SELECT pname, dname FROM project, department WHERE dnum = dnumber;

-- Questão 16
SELECT pname, fname FROM project, department, employee WHERE dnum = dnumber AND mgrssn = ssn AND pnumber>30;

-- Questão 17
SELECT pname, fname FROM project, works_on, employee WHERE pnumber = pno AND essn = ssn;

-- Questão 18
SELECT fname, dependent_name, relationship FROM employee, dependent, works_on WHERE pno = 91 AND works_on.essn = dependent.essn AND works_on.essn = ssn;

