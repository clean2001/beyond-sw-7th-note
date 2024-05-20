-- author table에 post_count라는 컬럼(int) 추가
alter table author modify column post_count int not null default 0;


-- post에 글 쓴 후에, author 테이블에 post_count 값에 +1 -> 
-- 커밋되지도, 롤백 되지도 않은 상태로 끝나게 된다.
start transaction;
update author set post_count=post_count+1 where id=7;
insert into post (title, author_id) values('트랜잭션 테스트', 1); -- 1은 없는 애
commit;
-- 또는
rollback;


-- 커밋 상태로 끝남
-- 
start transaction;
update author set post_count=post_count+1 where id=7;
insert into post (title, author_id) values('트랜잭션 테스트', 7);
commit;
-- 또는
rollback;