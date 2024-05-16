-- insert into: 데이터 삽입
INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3) VALUES (데이터1, 데이터2, 데이터3);

-- id, name, email -> author 테이블에 1건 추가
insert into author(id, name, email, password) values(1, 'sejeong', 'clearrworld@gmail.com', '1234');

-- id, title, content, author_id -> post에 한 건 추가
insert into post(id, title, content, author_id) values(1, '곧 점심시간!', '곧 점심시간이다!', 1);
insert into post(id, title, content) values(1, '곧 점심시간!2', '곧 점심시간이다!2');

-- 테이블 제약 조건 조회
-- 시스템 전체에서 전체 테이블들의 제약조건을 트랙킹하여 저장해둔다.
select * from information_schema.key_column_usage where table_name='post';

-- 지금 쓰고 있지 않은 다른 스키마의 테이블을 조회해보기 => 스키마이름.테이블이름
select * from board.author;


-- insert문을 통해 author 데이터 4개 정도 추가하기, post 데이터 5개 추가(1개는 익명)
insert into author(id, name, email, password) values(2, 'userA', 'userA@gmail.com', '1234');
insert into author(id, name, email) values(3, 'userB', 'userB@gmail.com');
insert into author(id, name, email) values(4, 'userC', 'userC@gmail.com');
insert into author(id, name, email, password) values(5, 'userD', 'userD@gmail.com', '1234');
insert into author(id, name, email, password) values(6, 'userE', 'userE@gmail.com', '1234');

insert into post(id, title, contents, author_id) values(2, '글2', '내용2', 2);
insert into post(id, title, contents, author_id) values(3, '글3', '내용3', 3);
insert into post(id, title, contents, author_id) values(4, '글4', '내용4', 4);
insert into post(id, title, contents, author_id) values(5, '글5', '내용5', 5);
insert into post(id, title, contents) values(6, '글6', '내용6');

-- update [테이블명] set 컬럼명=데이터 where id = 1;
-- update [테이블명] set 컬럼명1=데이터1, 컬럼명2=데이터2 where id = 1;
-- UPDATE는 덮어쓰기가 아니다. 
update author set name='abc', email='abc@test.com' where id=1;
update author set email='abc2@test.com' where id=2;
update author set email='abc3@test.com' -- where문을 빠뜨리게될 경우, 모든 행에 대해 업데이트문이 실행된다. **where 조건 잘 써주어야한다!!


-- 삭제
-- delete from [테이블명] where 조건
-- where 조건이 생략될 경우, 모든 데이터가 삭제됨에 유의하자
delete from author where id=5;


-- SELECT의 다양한 조회 방법
select * from author;
select * from author 

-- 테이블 드롭 -> 만약 abc 테이블이 없으면 에러가 발생한다.
DROP TABLE abc;

-- 테이블 드롭하기
DROP TABLE IF EXISTS abc;


-- 데이터를 지우는 3가지 방법
delete from [테이블 이름]; -- 다 지우기 -> 복구가 가능. 삭제된 행에 대해 로그를 기록함
truncate table [테이블 이름]; -- 다 지우기 -> 복구 안됨. truncate의 속도가 delete보다 빠르다.
drop table [테이블 이름]; -- 


select * from author;
select * from where id > 2;
select * from author where id < 3 and name = 'userA';
-- 특정 컬럼만을 조회할 때
select name, email from author where id=3;

-- 중복 제거하고 조회하기 (글 제목에 중복이 있을 때, 그 중복을 제거하고 조회할 수 있다.)
select distinct title from post;

-- mariadb에서 

-- 정렬: order by, 데이터의 출력 결과를 특정 기준으로 정렬
-- 아무런 정렬 조건없이 select하면 pk 기준으로 오름차순 정렬이다.
-- asc: 오름차순, desc: 내림차순
select * from author order by name asc;


-- 멀티 컬럼 order by: 여러 컬럼으로 정렬
-- 
select * from post order by title; -- asc/desc 생략시 오름차순
-- 우선 제목을 기준으로 오름차순, 아이디를 기준으로 내림차순
select * from post order by title, id desc;

-- limit number: 특정 숫자로 결과값 개수 제한
-- 가장 최근에(마지막에) 가입한 회원 한명을 조회한다.
select * from author order by id desc limit 1;

-- alias(별칭)을 이용한 select: as 키워드를 사용
select name as 이름, email as 이메일 from author; 
select a.name, a.email from author as a; -- 테이블이 하나만 있을 때는 a. 생략해도 되긴한다.

-- null을 조회 조건으로 조회하기
-- 비어있지 않은 것만 조회
select * from post where author_id is not null;

-- 비어 있는 것만 조회
select * from post where author_id is null;

-- sql의 대부분 문제는 join을 알아야한다!


--------- 자료형
-- tinyint는 -128 ~ 127까지 표현할 수 있다.
-- 요즘은 디스크 용량이 커져서 int에 할당한다고 해서 큰 낭비는 없지만,
-- 불필요한 낭비는 굳이 할 필요 없기 때문에, 나이를 tinyint로 열을 추가해보자.
alter table author add column age tinyint;

-- 
insert into author(id, name, email, age) values(7, '유저', 'abcd@gamil.
com', 200);
 insert into author(id, name, email, age) values(8, '유저', 'abc@gamil.com', 125);

-- unsigned로 변경시, 255까지 표현 가능
alter table author modify column age tinyint unsigned;


-- decimal 실습
-- 소수점 아래 숫자 개수가 소수부 개수를 초과해서 들어가면 알아서 잘린다.
alter table post add column price decimal(10, 3); -- 총 10자리, 소수부 3자리

-- decimal 소수점 초과 값 입력 후 짤림 확인
-- 3.123까지만 저장된다.
insert into post(id, title, price) values(7, 'hello java', 3.123123);
-- 1234.100으로 저장된다.
update post set price=1234.1 where id = 7;

