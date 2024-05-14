# 사용자가 현재 위치해 있는 폴더 경로 출력 명령어
pwd

# 현재 위치에서 파일, 폴더 목록 출력
ls

# ls + 자세히 출력하기
ls -l

# ls + 숨김 파일까지 자세히 출력하기
ls -al

# + 시간 순서로 정렬 등등 -> 많이 쓰는 명령어이다!
# 파일이 시간 순서로 정렬된다. (오름차순)
ls -alrt

# 디렉토리 생성
mkdir

# 디렉토리 생성 후 조회
mkdir my-dir | ls -alrt

# my-dir로 이동해보자.
cd my-dir

# 제대로 이동됐는지 확인
pwd

# 루트 디렉토리(=최상단 디렉토리)로 이동
cd /

# 다시 홈으로 돌아오자
cd ~
# 또는 
cd /home/ubuntu


# 절대 경로 폴더로 이동
# 절대 경로인 이유: 최상단 디렉토리인 /부터 시작되기 때문이다.
cd /home/ubuntu

# 상대 경로로 이동하기
# 상위 폴더로 이동
# .. -> 상위 폴더 / . -> 현재 폴더
cd ..


# my-dir에서 my-dir2로 절대 경로로 이동하기
cd /home/ubuntu/my-dir2

# my-dir에서 my-dir2로 상대 경로로 이동하기
cd ../my-dir2

# (특정 계정의) home 경로로 이동
# 만약 "abc"라는 계정으로 로그인 했을 때, 홈 경로는? : /home/abc
cd 
cd ~

# 직전 위치의 폴더로 이동 (= 방금 전까지 작업하던 디렉토리를 의미)
cd -

# 비어있는 파일 생성 (0 byte짜리 파일)
touch first-file.txt

# 파일 내용 조회
cat first-file.txt

# 터미널 창에 문자열을 출력하는 명령어
# 이렇게 터미널 창에 문구를 찍어내는 이유?
# echo 명령어를 통해서 터미널 창에 기록을 출력해놓는 용도 (실질적으로 그렇게 사용하는 경우는 적다고 한다.)
echo "hello world"

# echo를 통해 파일에 문자열을 write하는 방법
# > : 하나를 쓰면 덮어쓰기 모드, >> : 추가모드
echo "hello world" > first-file.txt
cat first-file.txt

# 추가 모드로 문자열 추가하기
echo "hello world2" >> first-file.txt
cat first-file.txt

# 지금까지 썼던 명령어를 쭉 보고 싶다면
# clear해도 그 이전도 다 보이네
# 아주 가끔 회사에서 실수를 할 수 있음 -> 구라치면 안됨 history 치면 다 나오기 때문
history

# 입력 중인 명령창 정리
clear

#######

# 삭제
# 복사
# 잘라내서 붙이기 => 이동
# 이름 바꾸기 => 이동(a.txt를 b.txt로 이동하는 것이다.)

# 1. 이동: mv 이동대상 이동된 파일명
# 사실상 이름 변경임
# mv a.txt ../a.txt
mv a.txt b.txt

# first-file.txt를 second-file.txt로 이름 변경하기
mv first-file.txt second-file.txt
# second-file.txt를 my-dir2로 이동하기
mv second-file.txt ../my-dir2

# 파일 복사 명령어: cp
# 디렉토리 복사시에는 -r 옵션을 추가
# 같은 디렉토리 경로에는 같은 이름(확장자까지 같은)의 파일이 2개 존재할 수 없다.
cp second-file.txt third-file.txt

# my-dir2를 통째로 복사해서 my-dir3를 만들어주기
cp -r my-dir2 my-dir3

# 삭제 명령어: rm. -r 옵션을 통해 디렉토리까지 삭제할 수 있다.
# 리눅스마다 차이가 있으나, 삭제할지 말지 물어보는 경우가 있음. (우분투의 경우 디폴트로 안물어보는 것 같음)
# -f 옵션: 묻지 않고 삭제가 가능하도록 함
rm third-file.txt
rm -f third-file.txt

# 디렉토리 삭제
rm -r my-dir3
rm -rf my-dir3

# 현재 디렉토리 하위에 있는 모든 파일 삭제
rm -rf *

# head는 cat처럼 파일을 출력하는 것인데, 상위 n개의 행을 조회
# tail은 하위 n개의 행을 조회

# 아무 옵션을 주지 않으면 10개의 행을 출력
head second-file.txt

# 3줄만 출력
head -3 second-file.txt



# 하위 5개 줄을 출력
tail -5 second-file.txt

# more : 파일의 한 페이지를 출력
more second-file.txt

# grep -> 문서 안에서 문자열 찾기
# grep은 find와 많이 쓰인다.


# find

# | 파이프의 역할 -> 앞의 명령어의 결과를 뒤로 넘겨줌