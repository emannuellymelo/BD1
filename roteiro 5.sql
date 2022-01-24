-- Emannuelly Larissa Freitas de Melo - 119210167
-- Banco de Dados - Roteiro 05

-- Questão 1
SELECT COUNT(*) FROM employee WHERE sex='F';

-- Questão 2
SELECT AVG(salary) FROM employee WHERE sex='M' AND address LIKE '%TX';

-- Questão 3
SELECT e.superssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados FROM employee AS e GROUP BY(e.superssn) ORDER BY COUNT(*);

-- Questão 4
SELECT s.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados FROM employee AS e JOIN employee AS s ON e.superssn = s.ssn GROUP BY(s.ssn) ORDER BY COUNT(*);

-- Questão 5
SELECT s.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados FROM employee AS e LEFT OUTER JOIN employee AS s ON e.superssn = s.ssn GROUP BY(s.ssn) HAVING COUNT(*)>0 ORDER BY COUNT(*);

-- Questão 6
SELECT MIN(qtd) AS qtd FROM (SELECT COUNT(*) AS qtd FROM works_on GROUP BY(pno)) AS foo;

-- Questão 7
SELECT pno AS num_projeto, qtd AS qtd_func FROM((SELECT pno, COUNT(*) FROM works_on GROUP BY(pno)) AS p JOIN (SELECT MIN(qtd) AS qtd FROM (SELECT COUNT(*) AS qtd FROM works_on GROUP BY(pno)) AS foo) AS n ON p.COUNT = n.qtd);

-- Questão 8
SELECT p.pno AS num_proj, AVG(s.salary) AS media_sal FROM works_on AS p JOIN employee AS s ON (p.essn = s.ssn) GROUP BY p.pno;

-- Questão 9
SELECT p.pno AS proj_num, n.pname AS proj_nome, AVG(e.salary) AS media_sal FROM project AS n JOIN (works_on AS p JOIN employee AS e ON(p.essn = e.ssn)) ON (n.pnumber = p.pno) GROUP BY (p.pno, n.pname) ORDER BY AVG(e.salary);

-- Questão 10
SELECT fname, salary FROM employee AS e JOIN works_on AS p ON(p.pno!=92) WHERE salary > ALL (SELECT salary FROM employee AS f JOIN works_on AS t ON((f.ssn=t.essn) AND t.pno=92)GROUP BY(f.salary)) GROUP BY(e.ssn) ORDER BY(salary);

-- Questão 11
SELECT ssn, COUNT(w.pno) AS qtd_proj FROM employee AS e LEFT OUTER JOIN works_on AS w ON e.ssn = w.essn GROUP BY(e.ssn) ORDER BY COUNT(w.pno);

-- Questão 12
SELECT pno AS num_proj, COUNT(*) AS qtd_func FROM works_on AS w RIGHT OUTER JOIN employee AS e ON w.essn = e.ssn GROUP BY(w.pno) HAVING COUNT(*) < 5 ORDER BY COUNT(*);

-- Questão 13
SELECT fname FROM employee AS e WHERE ssn IN (SELECT essn FROM works_on WHERE pno IN (SELECT pnumber FROM project WHERE plocation='Sugarland')) AND ssn IN(SELECT essn FROM dependent);

-- Questão 14
SELECT dname FROM department AS d WHERE NOT EXISTS(SELECT dnum FROM project AS p WHERE d.dnumber = p.dnum);

-- Questão 15
SELECT fname, lname FROM employee AS e WHERE ssn != '123456789' AND NOT EXISTS(SELECT * FROM works_on AS w WHERE w.pno IN (SELECT pno FROM works_on WHERE essn='123456789' AND NOT EXISTS (SELECT * FROM works_on AS t WHERE t.essn = ssn AND t.pno = w.pno)));
