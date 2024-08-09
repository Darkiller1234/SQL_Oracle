--서브쿼리
--1.
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) FROM EMPLOYEE) * 0.2;

--2.
SELECT EMP_ID, EMP_NAME, EXTRACT(YEAR FROM SYSDATE) - CASE
                            WHEN SUBSTR(EMP_NO, 8,1) IN (1,2) THEN
                                1900 + TO_NUMBER(SUBSTR(EMP_NO, 1,2))
                            ELSE
                                2000 + TO_NUMBER(SUBSTR(EMP_NO, 1,2))
                                END + 1 AS "나이"
        , DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING (JOB_CODE)
WHERE EXTRACT(YEAR FROM SYSDATE) - CASE
                            WHEN SUBSTR(EMP_NO, 8,1) IN (1,2) THEN
                                1900 + TO_NUMBER(SUBSTR(EMP_NO, 1,2))
                            ELSE
                                2000 + TO_NUMBER(SUBSTR(EMP_NO, 1,2))
                                END + 1 = (SELECT MIN(EXTRACT(YEAR FROM SYSDATE) - CASE
                            WHEN SUBSTR(EMP_NO, 8,1) IN (1,2) THEN
                                1900 + TO_NUMBER(SUBSTR(EMP_NO, 1,2))
                            ELSE
                                2000 + TO_NUMBER(SUBSTR(EMP_NO, 1,2))
                                END + 1) FROM EMPLOYEE );
                                
---------------------------------------------------------------------------





