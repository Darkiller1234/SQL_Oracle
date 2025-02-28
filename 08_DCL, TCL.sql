/*
    <DCL : 데이터 제어문>
    
    계정에 시스템 권한 또는 객체접근 권한을 부여하거나 회수하는 구문
    
    > 시스템권한 : DB에 접근하는 권한, 객체를 생성할 수 있는 권한
    > 객체접근권한 : 특정 객체들을 조작할 수 있는 권한
    
    CREATE USER 계정명 IDENTIFIED BY 비밀번호; --> 비밀번호는 대소문자를 구분함
    GRANT 권한(CONNECT, RESOURCE) TO 계정
    
*/

SELECT *
FROM ROLE_SYS_PRIVS;

/*
    <TCL : 트랜잭션 제어문>
    -데이터베이스의 논리적 연산단위
    -데이터의 변경사항등을 하나의 트랜잭션에 묶어서 처리
    DML문 한개를 수행할 때 트랜잭션이 존재하지 않는다면 트랜잭션을 만들어서 묶음
                                  트랜잭션이 존재한다면 해당 트랜잭션에 묶어서 처리
    
    COMMIT(트랜잭션 종료 처리후 확정)
    ROLLBACK(트랜잭션에 있는 작업을 취소
    SAVEPOIONT;
    
    -COMMIT : 한 트랜잭션에 담겨있는 변경하상들을 실제 DB에 반영시키겠다는 의미
    -ROLLBACK : 한 트랜잭션에 담겨있는 변경사항들을 삭제(취소)한 후 마지막 COMMIT시점으로 돌아감
    -SAVEPOINT 포인트명 : 현재 시점에 해당 포인트명으로 임시저장 해주겠다.
*/

CREATE TABLE EMP_O1
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID));

SELECT * FROM EMP_01;

--사번이 200, 201번인 사람 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 200 OR EMP_ID = 201;

DELETE FROM EMP_01
WHERE EMP_ID IN ( 217,216,214);

-----------------------------------
DELETE FROM EMP_01
WHERE EMP_ID IN (217,216,214);

SELECT * FROM EMP_01;

SAVEPOINT SP;

INSERT INTO EMP_01
VALUES(801, '김말똥', '기술지원부');

DELETE FROM EMP_01
WHERE EMP_ID = 210;

SELECT * FROM EMP_01;

ROLLBACK TO SP;
COMMIT;
---------------------------------------------------------------
DELETE FROM EMP_01
WHERE EMP_ID = 210;

--DDL문 실행
CREATE TABLE TEST( 
    TID NUMBER
);

ROLLBACK;

SELECT * FROM EMP_01;
--DDL문(CREATEM ALTER, DROP)을 수행하는 순간 기존 트랜잭션에 있던 변경사항들은
--무조건 COMMIT이 된다.(실제 DB반연 된다.)
--즉, DDL문 수행전 변경사항들이 있다면 정확하게 픽스하고 진행해라.



















