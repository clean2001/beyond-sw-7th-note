# local에서 sql 덤프 파일 생성
mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql

# 한글이 깨질 때 -> -r 옵션 주기
mysqldump -u root -p board -r dumpfile.sql