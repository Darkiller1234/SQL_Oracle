--3. ADDITIONAL SELECT - OPTION

--1)
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

--2)
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY TO_DATE(SUBSTR(STUDENT_SSN, 1,6), 'RRMMDD') DESC;

--3)
SELECT STUDENT_NAME AS 학생이름, STUDENT_NO AS 학번, STUDENT_ADDRESS AS "거주지 주소"
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE ('A%') AND SUBSTR(STUDENT_ADDRESS, 1, 3) IN ('경기도', '강원도')
ORDER BY STUDENT_NAME ASC;

--4)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '법학과'
ORDER BY PROFESSOR_SSN;

--5)
SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO ASC;

--6)
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY SUBSTR(STUDENT_NAME,2) ASC;

--7)
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

--8)
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR USING (PROFESSOR_NO)
ORDER BY PROFESSOR_NO;

--9)
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR USING (PROFESSOR_NO)
JOIN TB_DEPARTMENT ON (TB_PROFESSOR.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회';

--10)
SELECT STUDENT_NO, STUDENT_NAME, ROUND(AVG(POINT), 1) AS "전체 평점"
        FROM (SELECT STUDENT_NO, STUDENT_NAME, POINT
                FROM TB_STUDENT
                JOIN TB_GRADE USING (STUDENT_NO)
                JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                WHERE DEPARTMENT_NAME = '음악학과')
GROUP BY STUDENT_NO, STUDENT_NAME;

--11)
SELECT DEPARTMENT_NAME AS 학과이름, STUDENT_NAME AS 학생이름, PROFESSOR_NAME  AS 지도교수이름
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

--12)
SELECT STUDENT_NAME, TERM_NO AS TERM_NAME
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE CLASS_NAME = '인간관계론' AND SUBSTR(TERM_NO, 1,4) = '2007'
ORDER BY STUDENT_NAME;

--13)
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
WHERE TB_CLASS_PROFESSOR.PROFESSOR_NO IS NULL AND CATEGORY = '예체능'
ORDER BY DEPARTMENT_NAME;

--14)
SELECT STUDENT_NAME AS "학생이름", NVL(PROFESSOR_NAME, '지도교수 미지정') AS "지도교수"
FROM TB_STUDENT
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT ON (TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '서반아어학과';

--15)
SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름, DEPARTMENT_NAME AS "학과 이름", AVG(POINT)
FROM (SELECT *
        FROM TB_STUDENT
        JOIN TB_GRADE USING (STUDENT_NO)
        JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
        WHERE ABSENCE_YN = 'N')
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0
ORDER BY STUDENT_NO;

--16)
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM (SELECT *
        FROM TB_CLASS
        JOIN TB_GRADE USING (CLASS_NO)
        JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
        WHERE DEPARTMENT_NAME = '환경조경학과' AND CLASS_TYPE LIKE ('%전공%'))
GROUP BY CLASS_NO, CLASS_NAME;

--17)
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                        FROM TB_STUDENT
                        WHERE STUDENT_NAME = '최경희');
                        
--18)
SELECT STUDENT_NO, STUDENT_NAME
FROM (SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT) AS "평점"
        FROM (SELECT *
            FROM TB_STUDENT
            JOIN TB_GRADE USING (STUDENT_NO)
            JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
            WHERE DEPARTMENT_NAME = '국어국문학과')
        GROUP BY STUDENT_NO, STUDENT_NAME
        ORDER BY AVG(POINT) DESC)
WHERE ROWNUM = 1;

--19)
SELECT DEPARTMENT_NAME AS "계열 학과명", "전공평점"
FROM (SELECT DEPARTMENT_NAME, ROUND(AVG(POINT), 1) AS "전공평점"
        FROM (SELECT * 
                FROM TB_DEPARTMENT
                JOIN TB_CLASS USING (DEPARTMENT_NO)
                JOIN TB_GRADE USING (CLASS_NO)
                WHERE CATEGORY = (SELECT CATEGORY
                                    FROM TB_DEPARTMENT
                                    WHERE DEPARTMENT_NAME = '환경조경학과')
                    AND CLASS_TYPE LIKE ('%전공%'))
        GROUP BY DEPARTMENT_NAME)

        