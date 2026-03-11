-- Active: 1773024378107@@127.0.0.1@3306@menudb
-- 16_DCL(데이터 제어 언어)
-- GRANT : 사용자에게 권한을 부여하는 명령어
-- REVOKE : 이미 부여된 권한을 회수하는 명령어
-- SHOW GRANTS : 현재 계정에 부여된 권한을 확인
-- 권한 관리는 최소 권한 원칙을 권장

-- 이 스크립트는 권한이 있는 계정(root)으로 실행한다.

-- 1. 계정 생성
CREATE USER 'user1'@'%' IDENTIFIED BY 'pass01';
-- DROP USER IF EXISTS 'user1'@'%'

-- 권한 확인
SHOW GRANTS FOR 'user1'@'%';

-- 권한 부여
-- menudb 데이터베이스의 모든 객체를 조회할 수 있는 권한을 user01에 부여
GRANT SELECT ON menudb.* TO 'user1'@'%';
