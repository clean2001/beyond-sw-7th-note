# 사용자 추가
sudo useradd 사용자명

# 패스워드 지정
sudo passwd 사용자명

# 사용자 목록 조회
# 리눅스란 운영체제에 사용자가 등록이 됨. 
cat /etc/passwd/

# 사용자 변경(switch user)
su - sejeong2
su sejeong2

# 이전 사용자로 나가기
exit

# 파일 권한 관리
# 외우자!!
# 세 파트로 나누어짐 ==> (소유자 / 그룹 / others)
# 각각의 권한은 rwx로 이루어져있다.
# r: 4 / w: 2 / x: 1 -> 모든 권한을 가지면 7
chmod 777 test.sh
chmod u+x test.sh # 유저에게 실행권한을 추가하겠다.
chmod g-w test.sh # 그룹에서 쓰기 권한을 빼겠다.

# 디렉토리에 들어가려면 rx 권한 둘다 줘야한다.

# 파일 소유자/그룹 관리
# 소유자와 그룹 변경
# 빈번하게 사용하지는 않는다.
chown 소유자:그룹 파일명
chown sejeong2:sejeong2 second-file.txt
