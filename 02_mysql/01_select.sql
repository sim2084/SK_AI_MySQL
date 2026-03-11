-- 01_SELECT : 특정 테이블에서 원하는 데이터 조회

-- 단일 열 데이터 검색
SELECT menu_name FROM tbl_menu;

-- 다중 열 데이터 검색
SELECT menu_code, menu_name, menu_price FROM tbl_menu;

-- tbl_menu의 모든 컬럼 조회 (*)
SELECT * FROM tbl_menu;

-- 단독 SELECT 문 사용

-- 연사자 테스트
SELECT 7 + 3;
SELECT 7 - 3;

-- 내장 함수 테스트
SELECT now();
SELECT CONCAT('유',' ','관순') name;

-- 컬럼에 별칭 부여
SELECT NOW() as 현재시간;
SELECT CONCAT('유',' ','관순') name;
SELECT CONCAT('유',' ','관순') 'full_name';