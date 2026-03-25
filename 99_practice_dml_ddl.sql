-- 새로운 스키마 생성
CREATE DATABASE user_infodb;
GRANT ALL PRIVILEGES ON user_infodb.* TO 'practice'@'%';

-- 테이블 삭제
DROP TABLE IF EXISTS member_info;
DROP TABLE IF EXISTS team_info;

-- 테이블 생성
-- team_info
CREATE TABLE IF NOT EXISTS team_info
(
    TEAM_CODE   INT AUTO_INCREMENT PRIMARY KEY COMMENT '소속 코드',
    TEAM_NAME    VARCHAR(100) NOT NULL COMMENT '소속명',
    TEAM_DETAIL    VARCHAR(500) COMMENT '소속 상세 정보',
    USE_YN  CHAR(2) DEFAULT ('Y') CHECK (USE_YN IN ('Y','N')) COMMENT '사용 여부'
) COMMENT '소속 정보';

INSERT INTO team_info
(TEAM_CODE,TEAM_NAME,TEAM_DETAIL,USE_YN)
VALUES
(NULL,'음악감상부','클래식 및 재즈 음악을 감상하는 사람들의 모임','Y'),
(NULL,'맛집탐방부','맛집을 찾아다니는 사람들의 모임','N'),
(NULL,'행복찾기부',NULL,'Y');

SELECT * FROM team_info;


-- member_info
CREATE TABLE IF NOT EXISTS member_info
(
    MEMBER_CODE   INT AUTO_INCREMENT PRIMARY KEY COMMENT '회원 코드',
    MEMBER_NAME    VARCHAR(70) NOT NULL COMMENT '회원 이름',
    BIRTH_DATE    DATE COMMENT '생년월일',
    DIVISION_CODE  CHAR(2) COMMENT '구분 코드',
    DETAIL_INFO  VARCHAR(500) COMMENT '상세 정보',
    CONTACT VARCHAR(50) NOT NULL COMMENT '연락처',
    TEAM_CODE   INT NOT NULL COMMENT '소속 코드',
    ACTIVE_STATUS   CHAR(2) NOT NULL DEFAULT('Y') CHECK (ACTIVE_STATUS IN ('Y','N','H')) COMMENT '활동 상태',
    FOREIGN KEY (TEAM_CODE) REFERENCES team_info (TEAM_CODE)
) COMMENT '회원 정보';

INSERT INTO member_info
(MEMBER_CODE,MEMBER_NAME,BIRTH_DATE,DIVISION_CODE,DETAIL_INFO,CONTACT,TEAM_CODE,ACTIVE_STATUS)
VALUES
(NULL,'송가인','1990-01-30',1,'안녕하세요 송가인입니다~','010-9494-9494',1,'H'),
(NULL,'임영웅','1992-05-03',NULL,'국민아들 임영웅입니다~','hero@trot.com',1,'Y'),
(NULL,'태진아',NULL,NULL,NULL,'(1급 비밀)',3,'Y');

SELECT * FROM member_info;