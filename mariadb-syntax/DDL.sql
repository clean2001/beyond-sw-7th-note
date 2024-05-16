-- 데이터베이스 접속
mariadb -u root -p

-- 쿼리문 마지막에는 꼭 세미콜론을 찍어주기!
-- 스키마(database) 목록 조회
-- MariaDB, MySQL 진영에서는 스키마 == 데이터베이스이다.
SHOW DATABASES;

-- 'board'라는 이름의 데이터베이스(=스키마) 생성
-- 뒤에 'board' 이런 이름은 대소문자를 구분한다. 하지만 스키마나 테이블은 소문자인 것이 일반적이다.
CREATE DATABASE board;

-- 데이터베이스 선택
USE board;

-- 테이블 조회
SHOW TABLES;

-- 스키마 안에 글쓴이(author) 테이블, 글목록(post) 테이블 생성
-- author 테이블 생성
-- 제약 조건은 타입 옆에 나온다
-- 
CREATE TABLE author (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);

-- 테이블 컬럼 조회
DESCRIBE author;


-- MariaDB [board]> DESCRIBE author;
-- +----------+--------------+------+-----+---------+-------+
-- | Field    | Type         | Null | Key | Default | Extra |
-- +----------+--------------+------+-----+---------+-------+
-- | id       | int(11)      | NO   | PRI | NULL    |       |
-- | name     | varchar(255) | YES  |     | NULL    |       |
-- | email    | varchar(255) | YES  | UNI | NULL    |       |
-- | password | varchar(255) | YES  |     | NULL    |       |
-- +----------+--------------+------+-----+---------+-------+
-- 4 rows in set (0.013 sec)

-- 테이블 생성문 조회
SHOW CREATE TABLE author;

-- post 테이블
CREATE TABLE post(
    id INT PRIMARY KEY,
    title VARCHAR(255),
    content VARCHAR(255),
    author_id INT,
    FOREIGN KEY(author_id) REFERENCES author(id)
);

-- utf-8 설정
ALTER DATABASE [DB명] CHARACTER SET = utf8;
ALTER DATABASE [DB명] CHARACTER SET utf8mb4;

-- test1 스키마 생성, test1 스키마 삭제
CREATE DATABASE test1;
DROP DATABASE test1;


-- 컬럼 상세 조회
SHOW FULL COLUMNS FROM author;

-- 테이블 인덱스 조회
show index from author;
show index from posts;

-- ALTER문: 테이블의 구조를 변경
-- TABLE 이름 변경
alter table post rename posts;
alter table posts rename post;

-- 테이블 컬럼 추가
alter table author add column test1 varchar(50);

-- 테이블 컬럼 삭제
alter table author drop column test1;

-- 테이블 컬럼 명 변경
alter table post change column content contents varchar(255);

-- 테이블 컬럼 타입과 제약조건 변경(덮어쓰기. 이전 속성들까지 다 써줘야한다.)
alter table author modify column email varchar(255) not null;

-- 실습 : author 테이블에 address 컬럼 추가.
alter table author add column address varchar(255);

-- 실습: post 테이블에 title에 NOT NULL 제약 조건 추가. CONTENT 3000자로 변경
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);

-- 테이블 삭제
drop table 테이블명;

drop table post;

CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
);