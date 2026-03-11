-- Active: 1773042173092@@127.0.0.1@3306@practice_employdb

-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1행)
SELECT 
    a.EMP_ID, 
    a.EMP_NAME, 
    b.DEPT_TITLE 
FROM 
    employee a join department b ON a.DEPT_CODE = b.DEPT_ID 
WHERE 
    EMP_NAME LIKE '%형%';

-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9행)
SELECT
    a.EMP_NAME,
    b.JOB_NAME,
    a.DEPT_CODE,
    c.DEPT_TITLE
FROM 
    employee a
JOIN
    job b ON a.JOB_CODE = b.JOB_CODE
JOIN
    department c ON a.DEPT_CODE = c.DEPT_ID
WHERE
    a.DEPT_CODE in ('D5', 'D6', 'D7');

-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8행)
-- (INNER JOIN 결과)
SELECT 
    a.EMP_NAME,
    a.BONUS,
    b.DEPT_TITLE,
    d.NATIONAL_NAME
FROM 
    employee a
JOIN
    department b ON a.DEPT_CODE = b.DEPT_ID
JOIN
    location c ON b.LOCATION_ID = c.LOCAL_CODE
JOIN
    national d ON c.NATIONAL_CODE = d.NATIONAL_CODE
WHERE 
    a.BONUS IS NOT NULL;

-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3행)
SELECT 
    a.EMP_NAME,
    JOB_NAME,
    b.DEPT_TITLE,
    d.NATIONAL_NAME
FROM 
    employee a
JOIN
    department b ON a.DEPT_CODE = b.DEPT_ID
JOIN
    location c ON b.LOCATION_ID = c.LOCAL_CODE
JOIN
    national d ON c.NATIONAL_CODE = d.NATIONAL_CODE
JOIN
    job e ON a.JOB_CODE = e.JOB_CODE
WHERE 
    a.DEPT_CODE = 'D2';

-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20행)
SELECT
    a.EMP_NAME as 사원명,
    b.JOB_NAME as 직급명,
    a.SALARY as 급여,
    a.SALARY*(1+IFNULL(a.BONUS, 0))*12 as 연봉
FROM
    employee a
JOIN
    job b ON a.JOB_CODE = b.JOB_CODE
JOIN
    sal_grade c ON a.SAL_LEVEL = c.SAL_LEVEL
WHERE
    a.SALARY > c.MIN_SAL;

-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15행)
SELECT
    a.EMP_NAME,
    b.DEPT_TITLE,
    c.LOCAL_NAME,
    d.NATIONAL_NAME
FROM
    employee a
JOIN
    department b ON a.DEPT_CODE = b.DEPT_ID
JOIN
    location c ON b.LOCATION_ID = c.LOCAL_CODE
JOIN
    national d ON c.NATIONAL_CODE = d.NATIONAL_CODE
WHERE
    d.NATIONAL_CODE in ('KO', 'JP');

-- 7. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8행)
SELECT
    a.EMP_NAME,
    b.JOB_NAME,
    a.SALARY
FROM
    employee a
Join
    job b ON a.JOB_CODE = b.JOB_CODE
WHERE
    a.BONUS IS NULL AND a.JOB_CODE IN ('J4','J7')

-- 8. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회(2행)
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오.
SELECT
    EMPLOYEE.EMP_ID,
    EMPLOYEE.EMP_NAME,
    JOB.JOB_NAME,
    DEPARTMENT.DEPT_TITLE,
    LOCATION.LOCAL_NAME,
    EMPLOYEE.SALARY
FROM
    employee EMPLOYEE
JOIN 
    job JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE
JOIN
    department DEPARTMENT ON `EMPLOYEE`.`DEPT_CODE` = `DEPARTMENT`.`DEPT_ID`
JOIN 
    location LOCATION on `DEPARTMENT`.`LOCATION_ID` = `LOCATION`.`LOCAL_CODE`
WHERE
    `JOB`.`JOB_NAME` = '대리' and `LOCATION`.`LOCAL_NAME` IN ('ASIA1','ASIA2','ASIA3');

-- 9. 각 부서별 평균 급여와 직원 수를 조회하시오. (NULL 급여는 제외) 
-- 평균 급여가 높은 순으로 정렬하시오. (6행)
SELECT
    `DEPT_TITLE`,
    AVG(`SALARY`),
    COUNT(`EMP_NAME`) 
FROM
    employee
JOIN
    department ON `DEPT_CODE` = `DEPT_ID`
WHERE
    `SALARY` IS NOT NULL
GROUP BY
    `DEPT_CODE`
ORDER BY 
    AVG(`SALARY`) DESC;
 
-- 10. 직원 중 보너스를 받는 직원들의 연봉 총합이 1억 원을 
-- 초과하는 부서의 부서명과 연봉 총합을 조회하시오. (1행)
SELECT
    `DEPT_TITLE`,
    SUM(`SALARY` * (1 + IFNULL(`BONUS`,0)) * 12)
FROM
    employee
JOIN
    department ON `DEPT_CODE` = `DEPT_ID`
WHERE
    `BONUS` IS NOT NULL
GROUP BY
    `DEPT_CODE`
HAVING
    SUM(`SALARY` * (1 + IFNULL(`BONUS`,0)) * 12) > 100000000;

-- 11. 국내 근무하는 직원들 중 평균 급여 이상을 받는 
-- 직원들의 사원명, 급여, 부서명을 조회하시오. (서브쿼리 사용) (4행)
SELECT
    a.EMP_NAME, a.SALARY, b.DEPT_TITLE
FROM
    employee a
JOIN
    department b ON a.DEPT_CODE = b.DEPT_ID
WHERE
    a.DEPT_CODE IN ('D1','D2','D3','D4','D9')
    AND a.SALARY >= (
                SELECT 
                    AVG(SALARY)
                FROM
                    employee
                WHERE
                    DEPT_CODE IN ('D1','D2','D3','D4','D9'));

-- 12. 모든 부서의 부서명과 해당 부서에 소속된 직원 수를 조회하시오. 
-- 직원이 없는 부서도 함께 표시하시오. (9행)
SELECT 
    D.DEPT_TITLE, 
    COUNT(E.EMP_ID) AS "직원 수"
FROM 
    department D
LEFT JOIN 
    employee E ON D.DEPT_ID = E.DEPT_CODE
GROUP BY 
    D.DEPT_ID, D.DEPT_TITLE;


-- 13. 차장(J4) 이상 직급을 가진 직원과 사원(J7) 직급을 가진 
-- 직원들의 급여 합계를 비교하여 결과를 출력하시오. (SET OPERATOR 사용) (2행)
SELECT 
    AVG(`SALARY`)
FROM
    employee
WHERE
    `JOB_CODE` in ('J4','J3','J2','J1')
UNION
SELECT 
    AVG(`SALARY`)
FROM
    employee
WHERE
    `JOB_CODE` = 'J7';