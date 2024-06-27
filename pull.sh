#!/bin/sh
set -e

if [ -z $PREFIX ]; then
    echo "PREFIX is not set"
    exit 1
fi

file=trigger.txt

# 循环读取文件的每一行并加上前缀字符串
for line in `cat $file`
do
    new_line="$PREFIX/$line"
    echo $new_line

    docker pull $line
    docker tag $line $new_line
    docker push $new_line

done
