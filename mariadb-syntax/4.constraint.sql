-- not null 조건 추가
alter table 테이블명 modify column 컬럼명타입 not null;

-- author.id에 제약 조건 추가시 fk로 인해 문제 발생시
-- fk 먼저 제거 후에 author.id에 제약 조건 추가
-- foreign key 먼저 드롭
-- 제약 조건 조회
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'post';
-- foreign key 삭제
alter table post drop foreign key post_ibfk_1;

-- auto increment
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;
alter table post modify author_id bigint; -- author_id도 bigint로 바꾸어주기

-- 삭제된 fk 제약 조건을 다시 추가해주기
alter table post add constraint [제약조건이름] foreign_key(a)
alter table post add constraint post_author_fk foreign key(author_id) references author(id);

insert into author(name, email) values('hello', 'hello@naver.com');


-- uuid
-- uuid(universally unique identifier): 데이터베이스 관리에서 널리 사용되는 유니크 식별자. 특정 항목을 전세계적으로 유일하게 식별할 수 있도록 설계되어 있다.
-- 단점: INT, LONG에 비해 많은 용량 차지
-- uuid의 장점, 어떤 서비스에 적합한지를 찾아보기
-- column을 추가하면 기존에 있던 로우까지 다 디폴트값으로 채워짐
alter table post add column user_id char(36) default (UUID());
insert into post(title) values('abc');

-- pk, fk, unique 칼럼은 자동으로 index가 생성된다 -> 목차 페이지가 생성(검색의 성능을 높일 수 있다.)

-- unique 제약 조건
alter table author modify column email varchar(255) unique;

-- on delete cascade 테스트 -> 부모테이블의 id를 수정하면? 수정 안됨
-- 1. 제약 조건을 먼저 drop
alter table post drop foreign key post_author_fk;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;

-- 삭제: on delete cascade
select * post;
delete from author where id=2;
select * post;

-- 업데이트: on update cascade
-- 1. 제약 조건을 먼저 drop
alter table post drop foreign key post_author_fk;
-- 2. 옵션을 추가해서 FK 재설정
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade on update cascade;
select * from post;


-- 실습
-- on delete set null, update cascade
-- 1. 제약 조건을 먼저 drop
alter table post drop foreign key post_author_fk;
-- 2. 옵션을 추가해서 FK 재설정
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update cascade