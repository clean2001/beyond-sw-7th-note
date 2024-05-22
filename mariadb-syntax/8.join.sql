-- 두 테이블을 합해서 원하는 결과값을 뽑아낼 거임
-- inner join: 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기

-- 글을 쓴 적 있는 사람을 고르고 그사람이 쓴 글 갖다 붙이기
select * from author inner join post on author.id=post.author_id;

-- author_id가 있는 포스트를 찾아서 그 포스트의 author 정보까지 보여주기
select * from post inner join author on author.id=post.author_id;

select * from author s inner join post p on a.id=p.author_id;

-- Inner join
-- 글쓴이가 있는!! 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id=a.id;

-- Outer join
-- 모든 글 목록을 출력하고, 만약 글쓴이가 있다면 이메일을 출력한다.
-- outer라는 단어는 일반적으로 생략하고 쓴다.
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id=a.id;
select p.id, p.title, p.contents, a.email from post p left join author a on p.author_id=a.id;

-- Post 정보는 다 나오고, 
select p.*, a.email from post p left outer join author a on p.author_id=a.id;

-- join된 상황에서 where 조건 - 순서: ON 뒤에 WHERE 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 이메일을 출력. 저자의 나이는 25세 이상만
select p.title, a.email, a.age
from author a -- 어차피 이너조인이기 때문에 여기다 포스트 먼저 써도 된다.
inner join post p on a.id = p.author_id
where a.age >= 25;

-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력, 2024-05-01 이후에 만들어진 글만 출력하시오
select p.title, ifnull(a.email, '익명') email, p.created_time
from post p -- 
left join author a on p.author_id = a.id
where p.created_time >= '2024-05-01';


select p.title, a.email, p.created_time
from post p -- 
left join author a on p.author_id = a.id
where p.title is not null and author_id is not null and p.created_time >= '2024-05-01';


-- 조건에 맞는 도서와 저자 리스트 출력
SELECT BOOK_ID, AUTHOR_NAME, DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d')
FROM BOOK B
INNER JOIN AUTHOR A
ON B.AUTHOR_ID = A.AUTHOR_ID -- 문제에서 author_id가 not null이기 때문에 left join도 상관 없다.
WHERE CATEGORY = '경제'
ORDER BY PUBLISHED_DATE;

-- union: 중복 제외한 두 테이블의 select를 결합 (밑으로 갖다 붙이는 거임!!)
-- 컬럼의 개수와 타입이 같아야함의 유의
-- union all: 중복 포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;

-- author 테이블의 name, email 그리고 post 테이블의 title, contents 유니온
-- 속성이름은 먼저 나온 쿼리인 'name', 'email'로 들어가는구나.
-- 금융 회사 같은 엄청 복잡한 시스템을 가진 회사에선 union 이런 쿼리 볼 수 있음
select name, email from author
union
select title, contents from post;

-- 유지 보수성: 서비스를 유지하고, 서비스를 고치고
-- 코드의 간결성과 직관성


-- 서브 쿼리: select문 안에 또 다른 select문을 서브 쿼리라 한다.
-- 1. select절 안에 서브쿼리
-- author email과 해당 author가 쓴 글의 개수를 출력

-- 성능은 좀 떨어짐
select email, (select count(*) from post p where p.author_id = a.id) as count from author a;

-- 위에꺼를 조인으로 푸는 방법: 

select author.email, if(p.id is null, 0, count(p.id))
from author left join post as p on p.author_id = author.id
group by author.id;

-- 2. from절 안에 서브쿼리
select a.name from (select * from author) as a;


-- 3. where절 안에 서브 쿼리
-- 글을 쓴적이 있는 author만 조회
select distinct a.* from author a innser join post p on a.id = p.author_id;
-- 위 쿼리를 아래처럼 변환
select * from author where id in (select author_id from post); -- author_id만 조회해야지, 다른거 조회하면 in 조건에 어긋남

-- 일반적으로 서브 쿼리보다는 조인이 성능이 더 낫다고 함
-- 가장 많이 쓰는 방법은 select절, where절에서 쓰는 방법이다.
-- 서브 쿼리는 반드시 또 다른 괄호로 감싸져 있어야 한다.
-- WHERE 절: IN, NOT IN으로 가장 많이 활용된다.

-------------------------------------------------------------------
-- 문제 프로그래머스: 없어진 기록 찾기
-- 1. 조인 풀이
SELECT O.ANIMAL_ID, O.NAME
FROM ANIMAL_OUTS O
LEFT JOIN ANIMAL_INS I ON O.ANIMAL_ID = I.ANIMAL_ID
WHERE I.INTAKE_CONDITION IS NULL
ORDER BY O.ANIMAL_ID, O.NAME;

-- 2. 서브 쿼리 풀이
SELECT O.ANIMAL_ID, O.NAME
FROM ANIMAL_OUTS O
WHERE O.ANIMAL_ID NOT IN(SELECT ANIMAL_ID FROM ANIMAL_INS)
ORDER BY O.ANIMAL_ID, O.NAME;

--------------------------------------------------------------------

-- GROUP BY

-- 집계함수
-- 아래 두 쿼리의 결과는 같다
select count(*) from author;
select count(id) from author;

select sum(price) from post;
select avg(price) from post; -- 평균 구하기
select round(avg(price), 0) from post; -- 소수점 0번째에서 반올림 (정수부만 출력)

-- group by와 집계함수
-- 내부적으로는 모든 row를 가지고 있다(ex. 모든 로우를 들고 있기 때문에 sum을 할 수 있다.)
select author_id, count(*) cnt, sum(price) `sum`, round(avg(price), 0) `avg`, min(price) `min`, max(price) `max`
from post
group by author_id;

select id from author a left join post p on a.id = p.author_id group by 

-- where와 group by
-- 연도별 post 글 출력. 연도가 null인 데이터는 제외
select date_format(created_time, '%Y'), count(*)
from post
where created_time is not null
group by date_format(created_time, '%Y');

-- date_format 부분이 중복된다.
select date_format(created_time, '%Y') year, count(*)
from post
where created_time is not null
group by year;

SELECT CAR_TYPE, COUNT(*) CARS
FROM CAR_RENTAL_COMPANY_CAR
-- 문자열 뒤지는건 성능 안좋다.
WHERE OPTIONS LIKE '%통풍시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%가죽시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE;
