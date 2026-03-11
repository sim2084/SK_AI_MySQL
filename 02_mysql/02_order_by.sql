-- 02_order_by : 결과 집합(result set)을 기준에 따라 정렬

SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    -- menu price_ASC;
    menu_price DESC;

-- 메뉴 가격이 같은 경우 메뉴야 
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC,
    menu_name ASC;

-- 연산 결과로 정렬
SELECT
    menu_code,
    menu_name,
    menu_price *menu_code
FROM
    tbl_menu
ORDER BY
    -- menu_price * menu_code;
    연산결과; -- SELECT 절의 별칭을 사용할 수 있다 

SELECT FIELD('A','B'.'C','D')
SELECT FIELD('b','A','B'.'C')
SELECT FIELD('C','A','B'.'C')

-- field 내장 함수를 order by 절에서 사용하면
-- 숫자, 크기, 문자 순서와 무관하게 특정한 값을 우선적으로  정렬하는 용도로 사용 가능하다.
SELECT
    menu_name,
    orderable_status,
    FIELD(orderable_status,'N',"Y")
FROM
    tbl_menu
ORDER BY
    FIELD(orderable_status, 'N',"Y");

-- Null 값을 포함한 정렬
SELECT
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
ORDER BY
-- 오름차순 시 Null 처음(default) - Null 값을 더 작게 취급
    -- red_category_code ASC;
-- 오름차순 Null 뒤로 (IS NULL로 True, False 판단)
    -- ref_category_code IS NULL, ref_category_code ASC;
-- 내림차순 시 Null 뒤로(default) - Null 값을 더 작게 취급
    -- ref_category_code DESC;
-- 내림차순 시 Null 처음 (IS NULL로 True, False 판단)
    ref_category_code IS NULL, ref_category_code DESC;