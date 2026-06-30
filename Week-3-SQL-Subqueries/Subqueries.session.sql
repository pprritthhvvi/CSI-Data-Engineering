DROP DATABASE IF EXISTS company;

CREATE DATABASE company;

USE company;

CREATE TABLE emp( empno INT PRIMARY KEY, ename VARCHAR(30), job VARCHAR(30), mgr INT, hiredate DATE, sal INT, deptno INT );

INSERT INTO emp VALUES (7369,'SMITH','CLERK',7902,'1980-12-17',800,20), (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,30), (7521,'WARD','SALESMAN',7698,'1981-02-22',1250,30), (7566,'JONES','MANAGER',7839,'1981-04-02',2975,20), (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,30),(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,30), (7782,'CLARK','MANAGER',7839,'1981-06-09',2450,10), (7788,'SCOTT','ANALYST',7566,'1987-04-19',3000,20), (7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,10), (7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,30), (7876,'ADAMS','CLERK',7788,'1987-05-23',1100,20), (7900,'JAMES','CLERK',7698,'1981-12-03',950,30), (7902,'FORD','ANALYST',7566,'1981-12-03',3000,20), (7934,'MILLER','CLERK',7782,'1982-01-23',1300,10);

SELECT * FROM emp;

SELECT * FROM emp WHERE sal > ( SELECT AVG(sal) FROM emp );

SELECT * FROM emp WHERE sal = ( SELECT MAX(sal) FROM emp );

SELECT * FROM emp WHERE deptno IN ( SELECT deptno FROM emp WHERE job='MANAGER' );

SELECT * FROM emp WHERE sal > ANY ( SELECT sal FROM emp WHERE deptno=30 );

SELECT * FROM emp WHERE sal > ALL ( SELECT sal FROM emp WHERE deptno=30 );

SELECT e1.* FROM emp e1 WHERE sal > ( SELECT AVG(e2.sal) FROM emp e2 WHERE e1.deptno=e2.deptno );

SELECT * FROM emp WHERE deptno= ( SELECT deptno FROM emp WHERE ename='KING' );

SELECT * FROM emp WHERE sal > ( SELECT AVG(sal) FROM emp );

SELECT * FROM ( SELECT deptno, AVG(sal) avg_salary FROM emp GROUP BY deptno) d WHERE avg_salary>2000;

SELECT ename, sal, ( SELECT AVG(sal) FROM emp ) company_avg FROM emp;

SELECT ename, deptno, ( SELECT COUNT(*) FROM emp e2 WHERE e1.deptno=e2.deptno) total_emp FROM emp e1;

SELECT * FROM emp WHERE mgr= ( SELECT empno FROM emp WHERE ename='KING' );

SELECT * FROM emp WHERE deptno IN ( SELECT deptno FROM emp WHERE job='CLERK' );

SELECT * FROM emp WHERE sal= ( SELECT MIN(sal) FROM emp );

SELECT * FROM emp WHERE sal= ( SELECT MAX(sal) FROM emp );

SELECT deptno, AVG(sal) FROM emp GROUP BY deptno HAVING AVG(sal)> ( SELECT AVG(sal) FROM emp );

SELECT * FROM emp WHERE empno IN ( SELECT mgr FROM emp WHERE mgr IS NOT NULL );

SELECT ename, sal, ( SELECT MAX(sal) FROM emp ) highest_salary FROM emp;

SELECT ename, deptno, ( SELECT AVG(sal) FROM emp e2 WHERE e1.deptno=e2.deptno ) dept_avg FROM emp e1;