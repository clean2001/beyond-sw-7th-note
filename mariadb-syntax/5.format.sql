-- date_format(created_time, '%m) -> 이렇게만 찾으면 '05' 이렇게 출력됨. 그런데 '5'만 출력하고 싶다면 CAST를 쓸 것
select cast(date_format(created_time, '%m') as unsigned) from post;

-- Y, m, d, H, i, s -> 기억하기



