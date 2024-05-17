-- blob 이미지 저장 실습
ALTER TABLE author add column profile_photo BLOB;
INSERT INTO author(profile_phto) VALUES(LOAD_FILE('/path/to/your/file'));

-- ENUM: 삽입 될 수 있는 데이터의 종류를 한정하는 데이터 타입이다.
-- role 컬럼을 추가한다고 하자
alter table author add column `role` enum('user', 'admin') not null;

insert into author (id, email, role) values(13, 'test@test.com', 'user'); -- 정상 실행
insert into author (id, email, role) values(14, 'test@test.com', 'user1'); -- 에러가 발생

-- not null default 'user' 등의 옵션도 추가 가능하다.

alter table author modify column `role` enum('user', 'admin') not null default 'user';

-- data 타입
-- author 테이블에 birth_day 컬럼을 date로 추가
alter table author add column birth_date DATE;
-- 날짜 타입의 insert는 문자열 형식으로 insert 1999/08/01
insert into author (id, email, birth_date) values (16, 'ddd@ttt.com', '2001/03/05');
insert into author (id, email, birth_date) values (17, 'd@ttt.com', '2001.03.05');
insert into author (id, email, birth_date) values (18, 'dd@ttt.com', '01.03.05');
insert into author (id, email, birth_date) values (19, 'dd@ttt.com', '01-03-05');

-- datatime 타입
-- author, post 둘다 datetime으로 created_time 컬럼 추가
alter table author add column created_time datetime;
alter table post add column created_time datetime;
-- 
insert into author (id, email, created_time) values(20, 'ggg@gg.com', '24/05/17 10:10');
insert into post (id, title) values(7, '제목', '24/05/17 10:10:15');

-- default current_timestamp;
alter table author modify column created_time datetime default current_timestamp;
alter table post modify column created_time datetime default current_timestamp;

-- 비교 연산자
-- and 또는 && 둘다 가능
select * from post where id >= 2 and id <= 4;
select * from post where id between 2 and 4; -- between: 경계값 포함
select * from post where not(id < 2 or id > 4);

-- or 또는 ||
-- NOT 또는 !
select * from post where !(id < 2 or id > 4);

-- NULL인지 아닌지
select * from post where contents is null;
select * from post where contents is not null;

-- in(리스트 형태), not in(리스트 형태)
select * from post where id in(1, 2, 3, 4);
select * from post where id not in(1, 2, 3, 4);

-- LIKE: 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '글%'; -- '글'로 시작하는 title을 검색한다.
select * from post where title like '%a'; -- 'a'로 끝나는
select * from post where title like '%llo%'; -- llo가 중간에 있는 title을 검색한다(양쪽 끝도 포함)
select * from post where title not like '%o'; -- o로 끝나는 title이 아닌 title 검색


-- REGEXP: Regular Expression 정규 표현식의 약자. 정규 표현식을 활용한 조회
select * from author where name regexp '[a-z]'; -- 영문 이름 찾기
select * from author where name regexp '[가-힣]'; -- 한글 이름 찾기



-- IFNULL(a, b): 만약 a가 null이면 b 반환, null이 아니면 a 반환
select title, contents, ifnull(author_id, '익명') as '저자' from post;

-- 날짜 변환: 숫자 -> 날짜 타입 / 문자 -> 날짜 변환
-- CAST와 CONVERT
select cast(20200101 as date); -- 2020-01-01
select cast(id as date) from author where id=20200101;
select cast('20200101' as date);

select convert(20200101, date); -- 2020-01-01
select convert(id, date) from author where id=20200101;
select convert('20200101', date);


-- datetime 조회 방법: 2024에 해당하는 데이터를 찾고 싶다.
select * from post where created_at like '2024%'
select * from post where created_time <= '2024-12-31' and created_time >= '2024-01-01';
select * from post where created_time between '2024-01-01' and '2024-12-31';

-- date format
-- Y, m, d -> Y만 대문자
select date_format(created_time, '%Y-%m') as `date` from post; -- 년과 월만 조회
select * from post where date_format(created_time, '%Y') = '2024'; -- 2024년에 쓰여진 데이터를 조회

-- 오늘 날짜 출력, now()
select now(); -- 현재 날짜 시간을 출력한다.
select date_format(now(), '%Y-%m-%d %H-%i-%s');

-- 제약 조건(constraint)
-- on delete restrict
-- on update restrict
-- 위의 2개가 디폴트이다.
