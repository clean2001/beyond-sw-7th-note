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

-- 프로시저: 일련의 쿼리를 DB에 프로시저로 저장하는 것임
DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_count = post_count + 1 WHERE id = 1;
    -- UPDATE가 실패했는지 확인하고 실패 시 ROLLBACK 및 오류 메시지 반환
    IF (ROW_COUNT() = 0) THEN -- 쿼리가 정상적으로 실행되면 rowcount가 1이 나온다.
        ROLLBACK;
    END IF;
    -- INSERT 구문
    INSERT INTO post (id, title, contents, author_id) VALUES (9, 'ERAWE', '2231', 5);
    -- INSERT가 실패했는지 확인하고 실패 시 ROLLBACK 및 오류 메시지 반환
    IF (ROW_COUNT() = 0) THEN -- 쿼리가 정상적으로 실행되면 rowcount가 1이 나온다.
        ROLLBACK;
    END IF;
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;
-- 프로시저 호출
CALL InsertPostAndUpdateAuthor();


----

-- stored 프로시저를 활용한 트랜잭션 테스트
DELIMITER //
CREATE PROCEDURE InsertPostAndUpdateAuthor()
BEGIN
    DECLARE exit handler for SQLEXCEPTION
    BEGIN
        ROLLBACK();
    END;
    -- 트랜잭션 시작
    START TRANSACTION;
    -- UPDATE 구문
    UPDATE author SET post_count = post_count + 1 where id = 1;
    -- INSERT 구문
    insert into post(title, author_id) values('hello world java', 5);
    -- 모든 작업이 성공했을 때 커밋
    COMMIT;
END //
DELIMITER ;