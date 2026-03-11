-- root와 분리된 새로운 계정 생성
CREATE USER 'ohgiraffers'@'%' IDENTIFIED BY  'ohgiraffers';
-- 현재 존재하는 데이터 베이스 확인
SHOW DATABASES;

-- 사용할 데이터베이스 선택
USE mysql;

-- 계정 정보 확인
SELECT * FROM user;

-- 새로운 데이터베이스(스키마) 생성
CREATE DATABASE menudb;

-- 새롭게 생성한 스키마에 새롭게 생성한 계정이 권한을 가지도록 설정
GRANT ALL PRIVILEGES ON menudb.* TO 'ohgiraffers'@'%';

GRANT ALL PRIVILEGES ON practice_employdb.* TO 'ohgiraffers'@'%';

-- 권한 부여 확인
SHOW GRANTS FOR 'ohgiraffers'@'%';

USE menudb;
USE practice_employdb;