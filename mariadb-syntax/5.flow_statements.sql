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

-- 입양 시각 구하기(1)
SELECT HOUR(DATETIME) HOUR, COUNT(*) COUNT
FROM ANIMAL_OUTS
WHERE HOUR(DATETIME) >= 9 AND HOUR(DATETIME) < 20
GROUP BY HOUR
ORDER BY HOUR;

-- 입양 시각 구하기(1) 강사님 풀이
-- CAST unsigned 기억해두기!!!
SELECT CAST(DATE_FORMAT(DATETIME, '%H') AS UNSIGNED) HOUR, COUNT(*) COUNT
FROM ANIMAL_OUTS
WHERE DATE_FORMAT(DATETIME, '%H:%i') BETWEEN '09:00' AND '19:59'
GROUP BY HOUR ORDER BY HOUR;

-- HAVING: group by를 통해 나온 통계에 대한 조건
-- ex. 2개이상 쓴사람만, 등등
select author_id, count(*)
from post
group by author_id;


-- 글을 2개 이상 쓴 사람의 아이디와 개수에 대한 통계 정보
select author_id, count(*) as count
from post
group by author_id
having count >= 2;

-- 실습: 포스팅 Price가 2000원 이상인 글을 대상으로 작성자 별로 몇건인지와 평균 price를 구하되, 3000원 이상인 데이터를 대상으로만 통계 출력
select author_id, count(*) cnt, avg(price) avg
from post
where price >= 2000
group by author_id
having avg >= 3000;

-- JOIN, WHERE, GROUP BY, HAVING 엮기
-- 실습: 두 건 이상의 글을 쓴 사람의 Id와 email을 구할 건데
-- 나이는 25세 이상인 사람만 통계에 사용. 가장 나이 많은 사람 1명의 통계만 출력

-- 틀렸지만 워크벤치에서는 돌아가는 쿼리
-- a.age도 내부적으로 값을 가지고 있었나보다..,, 잘 모르겠음
select a.id, a.email, count(*) cnt, a.age -- group by를 하면 age가 사라져서 이 쿼리가 불가능..?
from author a
inner join post p on a.id = p.author_id
where a.age >= 25
group by a.id
having cnt >= 2
order by a.age
limit 1;

-- 이렇게 하면 OK..?
select a.id, a.email, count(*) cnt, a.age
from author a
inner join post p on a.id = p.author_id
where a.age >= 25
group by a.id
having cnt >= 2
order by max(a.age) DESC
limit 1;

----------- 다중 컬럼 ---------
select a.id, a.email, count(*) cnt
from author a
inner join post p on a.id = p.author_id
where a.age >= 25
group by a.id, a.age
having cnt >= 2
order by a.age DESC
limit 1;
------------------------------


-- 다중 열 group by
select author_id, title, count(*) from post group by author_id, title;

-- 인덱스 생성
create index email_index on author(email);