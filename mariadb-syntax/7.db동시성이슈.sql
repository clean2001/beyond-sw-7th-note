-- dirty read 실습
-- 워크 벤치에서 auto commit 해제 후 update 실행 ==> 커밋 안됨 (자기 트랜잭션 안에서는 임시 저장사항이 조회가 됨)
-- 터미널에서 select 했을 때 미 변경사항이 적용됐는지 확인 ==> 반영 안돼있음 (다른 세션을 열어서 다른 트랜잭션에서 보는 것이기 때문)

-- phantom read 동시성 이슈 실습
-- 실습 방법: 워크 벤치에서 시간을 두고 2번의 select가 이뤄지고, 터미널에서 중간에 insert 실행 -> 2번의 select 결과값이 동일한지 확인
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
-- 터미널에서 아래 insert문 실행
insert into author(name, email) values('kim', 'kim@naver.com');

-- lost update 이슈를 해결하기 위한 공유락(shared lock)
-- 워크 벤치에서 아래 코드 실행
start transaction;
select post_count from author where id=1 lock in share mode;
do sleep(15);
select post_count from author where id=1 lock in share mode;
commit;

-- 터미널에서 실행
select post_count from author where id=1 lock in share mode;
update author set post_count=0; where id=1 lock in share mode;

-- 배타적 잠금(exclusive lock): select for update
-- select부터 락을 거는 작업

-- lost update 이슈를 해결하기 위한 공유락(shared lock)
-- 워크 벤치에서 아래 코드 실행
start transaction;
select post_count from author where id=1 for update;
do sleep(15);
select post_count from author where id=1 for update;
commit;

-- 터미널에서 실행
select post_count from author where id=1 for update;
update author set post_count=0; where id=1 lock for update;