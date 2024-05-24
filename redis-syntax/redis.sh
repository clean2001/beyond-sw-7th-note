sudo apt-get update
sudo apt-get install redis-server
redis-server --version

# 레디스 접속
# cli: command line interface
redis-cli

# 나가기
exit

# redis는 0번부터 15번까지의 database로 구성되어있다.
# 데이터베이스 선택
# 0번이 디폴트이다.
select 번호
select 1
select 15

# 데이터베이스 내에 모든 키를 조회할 수 있다.
keys * 

################# 일반 string 자료구조 ######################

# key:value 값 세팅 => set
# ""를 붙이지 않아도 문자열이다.
# 맵 저장소에서 key값은 유일하게 관리된다. => 이미 존재하는 키값이면 새로운 값으로 덮어쓰기 된다.
SET key값 value값
SET test_key1 test_value1

# 유저 이메일을 세팅해보자.
# 같은 키값을 넣으면 덮어쓰기 된다!
SET user:email:1 honggildong@naver.com
SET user:email:1 honggildong2@naver.com # 덮어쓰기 됨

# nx 옵션: not exist
SET user:email:1 hong@naver.com nx # 값이 안들어감. 키값이 없을때만 넣겠다는 뜻

# ex 옵션: 초단위로 만료시간을 줄 수 있다. - ttl(time to live)
# TTL 굉장히 유용하다!!!!!!
SET user:email:2 hong2@naver.com ex 20

# key 값을 통해 value를 얻기
GET key값
GET test_key1

# 특정 key 삭제
DEL user:email:1

# 현재 데이터베이스에 있는 모든 키값을 삭제
FLUSHDB


# 인스타그램 좋아요 기능 -> 아마 동시성 이슈 때문에 RDB 안썼을 것임
# 좋아요 기능은 Redis로 해야함
SET likes:posting:1 0  # 포스트 아이디 1번의 좋아요 개수가 0개였다.
INCR likes:posting:1 # 특정 키값의 value를 1만큼 증가시킨다.
DECR likes:posting:1 # 1 감소

# 문자열(예를 들어 "dd") 이런거 저장한 다음에 INCR하면 에러 나네

# redis는 모두 문자열 형태로 저장한다.

############################################################
# 재고 기능 구현
SET product:1:stock 100
DECR product:1:stock
GET product:1:stock

# INCR과 DECR은 하나씩만 줄일 수 있다.
# 그럼 회원이 5개 사면? => 다섯번 호출 => 불편하다.
# 나중에 HASH 같은 자료구조에서는 더 쉽게 연산할 수 있는 방법이 제공된다.


# bash쉘을 활용하여 재고감소 프로그램을 작성해보자.