--A
SELECT eid
FROM emp
WHERE salary >( SELECT salary
				FROM emp
				WHERE ename='Lakmal')
				
--B
SELECT eid,ename,salary
FROM emp
WHERE salary =	(SELECT MIN(salary)
				FROM emp)
			
--C
SELECT did
FROM dept
WHERE budget > (SELECT AVG(salary)
				FROM emp)

--D
SELECT ename
FROM emp
WHERE salary <> (SELECT AVG(salary)
				FROM emp)

--E
SELECT ename
FROM emp
WHERE salary < (
    SELECT e.salary
    FROM emp e 
    JOIN dept d ON e.did= d.did
    WHERE d.department_name = 'ITSD' AND e.job_title = 'Manager'
);

SELECT * 
FROM emp