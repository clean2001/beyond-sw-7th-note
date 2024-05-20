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
from author a
inner join post p on a.id = p.author_id
where a.age >= 25;

-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력, 2024-05-01 이후에 만들어진 글만 출력하시오
select p.title, a.email, p.created_time
from post p
left join author a on p.author_id = a.id
where p.created_time >= '2024-05-01';
