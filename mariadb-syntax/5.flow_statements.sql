-- 흐름 제어: case 문
SELECT 컬럼1, 컬럼2, 컬럼3
CASE 컬럼4 
    WHEN [비교값1] THEN 결과값1
    WHEN [비교값2] THEN 결과값2
    ELSE 결과값3
END
FROM 테이블명;


-- post 테이블에서 1번 user는 first author, 2번 user는 second author
SELECT id, title, contents,
    CASE author_id
    WHEN 1 THEN 'first author'
    WHEN 2 THEN 'second author'
    ELSE 'others'
END as 'author'
FROM post;


-- author_id가 있으면 그대로 출력, 없으면 '익명사용자'로 출력
-- CASE 옆에 아무 것도 안 붙여야 원하는 결과가 나온다.
select id, title, contents,
case
	when author_id is null then 'anonymous'
	else author_id
end as 'author'
from post;

-- 위 케이스 문을 IFNULL 구문으로 변환
SELECT id, title, contents, ifnull(author_id, '익명') as author_id
from post;

-- if 구문으로 변환
select id, title, contents, if(author_id is null, '익명', author_id) as author_id
from post;

-- 

