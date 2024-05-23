# local에서 sql 덤프 파일 생성
mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql

# 한글이 깨질 때 -> -r 옵션 주기
mysqldump -u root -p board -r dumpfile.sql

# 리눅스에서 마리아디비 서버 설치
sudo apt-get install mariadb-server

# 마리아디비 서버 시작
sudo systemctl start mariadb


# 덤프파일 옮기기
mysql -u root -p board < dumpfile.sql
