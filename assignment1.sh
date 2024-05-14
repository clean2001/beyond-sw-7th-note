echo "script start"


# 디렉토리, 파일 생성
mkdir ~/my-dir4
touch ~/my-dir4/file1.txt
touch ~/my-dir4/file2.txt

cd ~/my-dir4

# add contents
echo "hello file1" > file1.txt
echo "hello file2" > file2.txt

# make backup
cp file1.txt file1_backup.txt
mv file2.txt file2_rename.txt

echo "script end"


################################################

# if문
if [ 1 -gt 2 ]; then
    echo "hello world1"
else
    echo "hello world2"
fi 

###############################################

# if문과 변수 활용, 파일(-f 옵션)/디렉토리(-d 옵션) 존재 여부 확인
file_name="second-file.txt" # 담겨있다는 의미
if [ -f "$file_name" ]; then # $: 다시 그 값을 불러오는 것이다.
    echo "$file_name exists"
else
    echo "$file_name does not exist"
fi

###############################################

# 반복문
for a in {1..100}
do
    echo "hello world $a"
done


###############################################

# if 문 실습

# echo로 start 출력
# 만약에 test_dir이 현재 폴더에 있다면 해당 폴더로 이동
# 없으면 폴더 생성 후 이동
# echo로 end 출력

echo "start script"
dirname="test-dir"
if [ -d "$dirname" ];then
    cd $dirname
else
    mkdir $dirname
    cd $dirname
fi

################################################

# for문 활용한 count 세기
count=0
for a in {1..100}
do
    ((count++))
done
echo "count is $count"

# for문 활용한 모든 파일, 디렉토리 목록 출력하기
for a in *
do
    echo "a is $a"
done

# for문 활용한 file의 개수와 directory의 개수 세기

##########
# 디렉토리의 개수와 그 외 파일의 개수 세기
directory_cnt=0;
file_cnt=0;
for a in *
do
    if [ -d "$a" ];then
        ((directory_cnt++))
    else
         ((file_cnt++))
    fi
done

echo "directory count is $directory_cnt"
echo "etc file count is $file_cnt"

########
