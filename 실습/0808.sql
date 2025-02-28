--1.
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE)
WHERE EMP_NAME LIKE ('전%') AND EMP_NO LIKE ('7%') AND SUBSTR(EMP_NO, 8, 1) IN ('2','4');
--WHERE SUBSTR(EMP_NO, 1,2) BETWEEN 70 AND 79 ~~

--2.
/*
SELECT EMP_ID, EMP_NAME, TO_CHAR(SYSDATE, 'YY') - 
CASE WHEN TO_NUMBER(SUBSTR(EMP_NO, 1, 2)) >= 50 THEN TO_NUMBER(SUBSTR(EMP_NO, 1, 2)) - 100
ELSE TO_NUMBER(SUBSTR(EMP_NO, 1, 2))
END  AS 나이,
DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE);

SELECT TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')
FROM EMPLOYEE;
*/

SELECT EMP_ID, EMP_NAME, 
    EXTRACT(YEAR FROM SYSDATE) - 
    EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))
    AS 나이 ,
    DEPT_TITLE, JOB_NAME
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE)
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) 
= (
        SELECT MIN(EXTRACT(YEAR FROM SYSDATE) - 
        EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')))
        FROM EMPLOYEE
);

SELECT MIN( 
    EXTRACT(YEAR FROM SYSDATE) - 
    EXTRACT(YEAR FROM TO_DATE(SUBSTR(E1.EMP_NO, 1, 2), 'RR')))
    AS 나이 
    
FROM EMPLOYEE E1
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE)
JOIN EMPLOYEE E2 ON (E1.EMP_NAME = E2.EMP_NAME);

--3.
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_CODE)
WHERE EMP_NAME LIKE ('%형%');

--4.
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE IN ('D5', 'D6')
ORDER BY DEPT_CODE;

--5.
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

--6.
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

--7.
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
LEFT JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국', '일본');

--8.
SELECT E1.EMP_NAME, E2.EMP_NAME
FROM EMPLOYEE E1
LEFT JOIN EMPLOYEE E2 ON (E1.DEPT_CODE = E2.DEPT_CODE AND E1.EMP_NAME != E2.EMP_NAME)
ORDER BY E1.EMP_ID;

SELECT E.EMP_NAME, E.DEPT_CODE, D.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE D ON (E.DEPT_CODE = D.DEPT_CODE)
WHERE E.EMP_NAME != D.EMP_NAME
ORDER BY E.EMP_ID;

--9.
SELECT EMP_NAME, JOB_NAME, SALARY, JOB_CODE
FROM EMPLOYEE 
LEFT JOIN JOB  USING (JOB_CODE)
WHERE NVL(BONUS, 0) = 0 AND JOB_CODE IN ('J4', 'J7');

--10.
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;