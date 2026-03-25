-- 04_distinct : 중복 칼럼 제거 후 조회

-- 메뉴 테이블 내에 존재하는 카테고리의 종류를 조회
SELECT
    DISTINCT category_code
FROM
    tbl_menu
ORDER BY
    category_code;

-- NULL 값이 존재하는 컴럼에서 사용할 경우 => NULL 값도 중복 제거 되어 1행만 남음
SELECT
	DISTINCT ref_category_code
FROM 
	tbl_category;
ORDER BY
    1; -- select 절에 나열된 컬럼 순번으로도 정렬 가능

-- [주의] 다음 열에 distinct 사용할 경우
-- 다중열의 조합 결과 행의 중복이 제거된다.
SELECT 
    category_code, 
    orderable_status
FROM
    tbl_menu;

SELECT 
    DISTINCT category_code, 
    orderable_status
FROM
    tbl_menu;