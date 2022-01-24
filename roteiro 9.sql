-- Emannuelly Larissa Freitas de Melo - 119210167
-- Banco de Dados - Roteiro 09

-- Questão 1
--a)
CREATE VIEW vw_dptmgr AS SELECT dnumber, fname as mngr_name FROM DEPARTMENT, EMPLOYEE WHERE mgrssn = ssn;

--b)
CREATE VIEW vw_empl_houston AS SELECT ssn, fname FROM employee WHERE address LIKE '%Houston%';

--c)
CREATE VIEW vw_deptstats AS SELECT dnumber, dname, COUNT(*) as num_func FROM employee, department WHERE department.dnumber = employee.dno GROUP BY(department.dnumber);

--d)
CREATE VIEW vw_projstats AS SELECT pno, COUNT(*) FROM works_on, employee WHERE works_on.essn = employee.ssn GROUP BY(works_on.pno);

-- Questão 2
-- Consultas em a)
SELECT * FROM vw_dptmgr;

-- Consultas em b)
SELECT * FROM vw_empl_houston;

-- Consultas em c)
SELECT * FROM vw_deptstats;

-- Consultas em d)
SELECT * FROM vw_projstats;

-- Questão 3
DROP VIEW vw_dptmgr;
DROP VIEW vw_empl_houston;
DROP VIEW vw_deptstats;
DROP VIEW vw_projstats;

-- Questão 4
CREATE OR REPLACE FUNCTION check_age(essn CHAR(9))
RETURNS VARCHAR(7) AS 
$$
DECLARE 
age INTEGER;
BEGIN
    SELECT EXTRACT(YEAR FROM AGE(bdate)) FROM employee INTO age WHERE essn = employee.ssn;
    IF(age >= 50) THEN RETURN 'SENIOR';
    ELSIF(age >= 0 AND age < 50) THEN RETURN 'YOUNG';
    ELSIF(age is NULL) THEN RETURN 'UNKOWN';
    ELSE RETURN 'INVALID';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Comandos:
SELECT check_age('666666609');
SELECT check_age('555555500');
SELECT check_age('987987987');
SELECT check_age('x');
SELECT check_age(null);
SELECT ssn FROM employee WHERE check_age(ssn) = 'SENIOR';

-- Questão 5
-- Verificando a existencia de subordinados
CREATE FUNCTION check_subordinate(essn CHAR(9))
RETURNS BOOLEAN AS
$$
DECLARE
num_of_sub INTEGER;
BEGIN
    SELECT COUNT(*) FROM employee e INTO num_of_sub WHERE e.superssn = essn;
    IF num_of_sub > 0 THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- verificacao central
CREATE FUNCTION check_mgr()
RETURNS trigger AS 
$$
DECLARE
chk_employee_dpt INTEGER;
BEGIN
SELECT count(*) FROM employee e INTO chk_employee_dpt WHERE e.ssn = NEW.mgrssn AND e.dno = NEW.dnumber;
    IF(chk_employee_dpt = 0 OR NEW.mgrssn IS NULL) THEN
        raise exception 'manager must be a department''s employee';
    END IF;
    IF(check_age(NEW.mgrssn) <> 'SENIOR') THEN
        raise exception 'manager must be a SENIOR employee';
    END IF;
    IF(NOT check_subordinate(NEW.mgrssn)) THEN
        raise exception 'manager must have supervisees';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON department FOR EACH ROW EXECUTE PROCEDURE check_mgr();

-- TESTES
-- A. DROP TRIGGER check_mgr ON department;
-- B. INSERT INTO department VALUES ('Test', 2, '999999999', now());
-- C. 
-- INSERT INTO employee VALUES ('Joao','A','Silva','999999999','10-OCT-1950','123 Peachtree, Atlanta, GA','M',85000,null,2);
-- INSERT INTO employee VALUES ('Jose','A','Santos','999999998','10-OCT-1950','123 Peachtree, Atlanta, GA','M',85000,'999999999',2);

-- D. CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON department FOR EACH ROW EXECUTE PROCEDURE check_mgr();

-- E. Execucao de comandos e seus resultados:
-- Execucao 1
-- emannuellylfdm_db=> UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;
-- UPDATE 1

-- Execucao 2
-- emannuellylfdm_db=> UPDATE department SET mgrssn = null WHERE dnumber=2;
-- ERROR:  manager must be a department's employee

-- Execucao 3
-- emannuellylfdm_db=> UPDATE department SET mgrssn = '999' WHERE dnumber=2;
-- ERROR:  manager must be a department's employee

-- Execucao 4
-- emannuellylfdm_db=> UPDATE department SET mgrssn = '111111100' WHERE dnumber=2;
-- ERROR:  manager must be a department's employee

-- Execucao 5
-- UPDATE employee SET bdate = '10-OCT-2000' WHERE ssn = '999999999';
-- UPDATE 1
-- UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;
-- ERROR:  manager must be a SENIOR employee

-- Execucao 6
-- UPDATE employee SET bdate = '10-OCT-1950' WHERE ssn = '999999999';
-- UPDATE 1
-- emannuellylfdm_db=> UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;
-- UPDATE 1

-- Execucao 7
-- emannuellylfdm_db=> DELETE FROM employee WHERE superssn = '999999999';
-- DELETE 1
-- emannuellylfdm_db=> UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;
-- ERROR:  manager must have supervisees

-- Execucao 8
-- emannuellylfdm_db=> DELETE FROM employee WHERE ssn = '999999999';
-- DELETE 1

-- Execucao 9
-- emannuellylfdm_db=> DELETE FROM department where dnumber=2;
-- DELETE 1
