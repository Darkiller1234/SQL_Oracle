/*
    <GROUP BY절>
    그룹기준을 제시할 수 있는 구문(해당 그룹기준별로 어러 그룹으로 묶을 수 있음)
    여러개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; --전체사원을 하나의 그룹으로 묶어서 총 합을 구한 것

--각 부서별로 급여 총합
--각 부서들이 전부 그룹
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--각 부서별 사원수
SELECT DEPT_CODE, COUNT(EMP_ID), SUM(SALARY)    --3
FROM EMPLOYEE           --1
GROUP BY DEPT_CODE      --2 
ORDER BY DEPT_CODE;     --4 ORDER BY 무조건 마지막실행 -> 정렬은 마지막 해주는 것이 아니면 의미X



--각 직급별 총 사원수, 보너스를 받는 사람수, 급여합, 평균급여, 최저급여, 최고급여 (정렬 = 직급 오름차순)
SELECT JOB_CODE, COUNT(EMP_ID), COUNT(BONUS), SUM(SALARY), ROUND(AVG(SALARY)), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--GROUP BY절에 함수식 사용 가능
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

--GROUP BY절에 여러컬럼을 기술할 수 있다.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;

--==========================================================================
/*
    [HAVING 절]
    그룹에 대한 조건을 제시할 때 사용되는 구문(주로 그룹함수식을 가지고 조건을 만든다)
*/

--각 부서별 평균 급여(부서코드, 평균급여)
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--각 부서별 평균급여가 300만원 이상인 부서들만 조회(부서코드, 평균급여)
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE AVG(SALARY) >= 3000000
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

--직급별 직급코드, 총급여합(단, 직급별 급여합이 1000만원 이상인 직급만 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

--부서별 보너스를 받는 사원이 없는 부서의 부서코드
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

--------------------------------------------------------------------------
/*
    SELECT * | 조회하고싶은 컬럼들 | 함수식 | 산술연산     --5
    FROM 조회하고싶은 테이블 | DUAL                      --1
    WHERE 조건식                                       --2
    GROUP BY 그룹의 기준이 되는 컬럼 | 함수식             --3
    HAVING 조건식                                      --4
    ORDER BY 컬럼 | 별칭 | 순서 [ASC | DESC] [NULLS FIRST | NULLS LAST] --6
*/

-------------------------------------------------------------------------

/*
    집합연산자
    여러개의 쿼리문을 하나의 쿼리문으로 만드는 연산자
    
    -UNION : OR | 합집합(두 쿼리문 수행한 결과값을 더함
    -INTERSECT : AND | 교집합(두 쿼리문의 수행한 결과값에 중본된 결과값
    -UNION ALL : 합집합 + 교집합 (중복되는거 상관않고 전부 더한 결과값
    -MINUS : 차집합(선행결과값에 후행결과값을 뺀 나머지)
*/

--1. UNION
--부서코드가 D5인 사원 또는 급여가 300만원 초과한 사원들의 사번, 이름, 부서코드 급여 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

--부서코드가 D5인 사원들의 사번, 이름, 부서코드 급여 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--급여가 300만원 초과한 사원들의 사번, 이름, 부서코드 급여 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE  SALARY > 3000000;


SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE  SALARY > 3000000;


--2. INTERSECT(교집합)
--부서코드가 D5이면서 급여가 300만원 초과한 사원들의 사번, 이름, 부서코드 급여 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE  SALARY > 3000000;


-------------------------------------------------------------------------
--집합연산자 사용시 주의사항
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE  SALARY > 3000000
ORDER BY EMP_ID;
--컬럼의 개수가 동일해야 한다.
--컬럼 자ㄹ리마다 동일한 타입으로 기술해야한다.
--정렬하고싶다면 ORDER BY는 마지막에 기술한다.


--3. UNION ALL : 여러개의 쿼리결과를 무조건 다 더한다

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE  SALARY > 3000000
ORDER BY EMP_ID;

--4. MINUS : 선행 SELECT 결과에서 후행 SELECT결과를 뺀 나머지
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE  SALARY > 3000000
ORDER BY EMP_ID;


