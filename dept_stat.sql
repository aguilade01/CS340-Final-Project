

DELIMITER $$
CREATE DEFINER=`cs340_abounozs`@`%` PROCEDURE `InitDept_Stats`()
    NO SQL
BEGIN	
	DELETE FROM DEPT_STATS;

	INSERT INTO DEPT_STATS
    	SELECT DEPARTMENT.Dnumber, Count(Ssn), AVG(Salary)
        FROM DEPARTMENT LEFT JOIN EMPLOYEE ON DEPARTMENT.Dnumber = EMPLOYEE.Dno
        GROUP BY DEPARTMENT.Dnumber;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`cs340_abounozs`@`%` FUNCTION `PayLevel`(`In_SSN`
VARCHAR(9)) RETURNS varchar(20) CHARSET utf8
BEGIN
DECLARE Sal decimal(10,2);
DECLARE ASal decimal(10,2);
DECLARE D int;
SELECT Salary into Sal
FROM EMPLOYEE
WHERE EMPLOYEE.Ssn = In_SSN;
SELECT Dno into D
FROM EMPLOYEE
WHERE EMPLOYEE.Ssn = In_SSN;
SELECT Avg_salary into ASal
FROM DEPT_STATS
WHERE DEPT_STATS.Dnumber = D;
IF Sal > ASal THEN
RETURN 'Above Average';
END IF;
IF Sal < ASal THEN
RETURN 'Below Average';
END IF;
RETURN 'Average';
END$$
DELIMITER ;
