-- 14_constraints (제약 조건)

-- 1. NOT NULL : NULL 값을 허용하지 않는 제약 조건
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull
(
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);

-- 정상 수행
INSERT INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '유관수', '여', '010-1234-5678', 'yoo123@gmail.com');
-- 제약 조건 위반
-- gender는 명시적으로 NULL 입력이 가능하지만, phone 명시적 NULL 입력 불가(제약 조건 위배)
INSERT INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(2, 'user01', 'pass01', '유관수', NULL, NULL, 'yoo123@gmail.com');
-- INSERT할 컴럼으로 나열하지 않은 경우 default값이 없어서 처리되지 못 함 (제약 조건 위배)
INSERT INTO user_notnull
(user_id, user_pwd, user_name, gender, phone, email)
VALUES
('user01', 'pass01', '유관수', NULL, '010-1234-5678', 'yoo123@gmail.com');


-- 2. UNIQUE : 중복 값을 허용하지 않는 제약 조건
CREATE TABLE IF NOT EXISTS user_unique
(
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);

-- 정상 수행
INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '유관수', '여', '010-1234-5678', 'yoo123@gmail.com');
INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user02', 'pass01', '유관수', '여', '010-1234-5678', 'yoo123@gmail.com');

-- 제약 조건 위반
-- user_id에 unique 제약 조건이 있으므로 동일한 id를 입력하거나 수정하면 오류 발생
INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '유관수', '여', '010-1234-5678', 'yoo123@gmail.com');


-- 3. PRIMARY KEY : 각 행을 유일하게 식별하는 제약 조건
-- NOT NULL + UNIQUE의 의미를 가진다.
CREATE TABLE IF NOT EXISTS user_primary_key
(
    user_no INT PRIMARY KEY,                   -- 컬럼 레벨
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
    -- PRIMARY KEY(user_no, user_id)            --테이블 레벨 (여러 컬럼을 묶어서 복합키 사용 시)
);

-- 정상 수행
INSERT INTO user_primary_key
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '유관수', '여', '010-1234-5678', 'yoo123@gmail.com');
-- 제약 조건 위반
-- user_no는 pk로 설정 되어 고유하고 NULL이 아닌 값만 삽입, 수정 가능하다.
INSERT INTO user_primary_key
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '유관수', '여', '010-1234-5678', 'yoo123@gmail.com');
INSERT INTO user_primary_key
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(NULL, 'user01', 'pass01', '유관수', '여', '010-1234-5678', 'yoo123@gmail.com');


-- 4. FOREIGN KEY : 외래 키 제약 조건, 다른 테이블의 값을 참조하는 제약 조건

-- 부모테이블
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade
(
    grade_code INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT NULL
);

INSERT INTO user_grade
VALUES 
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade;

-- 자식 테이블
DROP TABLE IF EXISTS user_foreignkey1;
CREATE TABLE IF NOT EXISTS user_foreignkey1
(
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT,
    FOREIGN KEY (grade_code) REFERENCES user_grade (grade_code)
);

-- [참고]
-- fk를 컬럼 레벨에 작성 : REFERENCES 참조 대상 테이블 (참조 대상 컬럼)
-- fk를 테이블 레벨에 작성 : FOREIGN KEY(제약 대상 컬럼) REFERENCES 참조 대상 테이블 (참조 대상 컬럼)
-- 다만 MySQL 버전에 따라 컬럼 레벨에 작성시 기능하지 않는 경우 있어 테이블 레벨에 작성 권장


-- 정상 수행
-- 10, 20, 30, NULL과 같이 부모 테이블에 존재하는 행은 fk 컬럼에서 참조하여 사용 가능
INSERT INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10);
-- NOT NULL 제약이 없는 경우 NULL도 사용 가능
INSERT INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(2, 'user02', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', NULL);
-- 50은 부모 테이블에 존재하지 않는 값이므로 제약 조건 위배
INSERT INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 50);

-- 기본적으로 자식 테이블에서 fk 값으로 사용 되고 있는 값은 부모 테이블에서 삭제 or 수정 불가
-- 삭제를 명시하지 않았을 경우에는 RESTRICT가 기본
DELETE FROM user_grade WHERE grade_code = 10;

-- fk의 삭제룰을 변경해서 다시 한 번 테스트
-- 자식 테이블
DROP TABLE IF EXISTS user_foreignkey2;
CREATE TABLE IF NOT EXISTS user_foreignkey2
(
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT,
    FOREIGN KEY (grade_code) REFERENCES user_grade (grade_code)
    ON UPDATE SET NULL      -- CASCADE 값으로 변경하면 해당 행 삭제
    ON DELETE SET NULL      -- CASCADE 값으로 변경하면 해당 행 삭제
);

-- 정상 수행
INSERT INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10);

-- 처음 만들었던 1번 테이블의 제약 조건 때문에 실패할 수 있으므로 테이블 삭제 후 실행
DROP TABLE IF EXISTS user_foreignkey1;
SELECT * FROM user_foreignkey2;

--참조 되고 있는 10이라는 값을 100으로 변경 테스트
UPDATE
    user_grade
SET
    grade_code = 100
WHERE
    grade_code = 10;
-- 자식 테이블의 값이 NULL로 변경 되었음을 확인
SELECT * FROM user_foreignkey2;


-- 5. CHECK
CREATE TABLE IF NOT EXISTS user_check
(
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender CHAR(3) CHECK (gender IN ('남','여')),     -- 한글 값 3byte
    age INT CHECK (age > 19)
);

-- gender checck 제약 조건 위배
INSERT INTO user_check (user_name,gender,age)
VALUES ('유관순','여자',20)
-- age check 제약 조건 위배
INSERT INTO user_check (user_name,gender,age)
VALUES ('유관순','여',16)


-- 6. DEFAULT
CREATE TABLE IF NOT EXISTS tbl_country
(
    country_code INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) DEFAULT '한국',
    add_day DATE DEFAULT (CURRENT_DATE),
    add_time TIME DEFAULT (CURRENT_TIME)
);

INSERT INTO tbl_country
VALUES (NULL,DEFAULT,DEFAULT,DEFAULT);

SELECT * FROM tbl_country;