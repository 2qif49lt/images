#!/bin/sh
set -e

if [ -z $PREFIX ]; then
    echo "PREFIX is not set"
    exit 1
fi

replace_slash() {
    input="$1"
    echo $1 | sed 's/\//-s-/g'
}

file=trigger.txt

# 循环读取文件的每一行并加上前缀字符串
for line in `cat $file`
do
    new_line="$PREFIX/$(replace_slash $line)"
    echo $new_line | sed -e 's/\(.\)/\1 /g'

    docker pull $line
    docker tag $line $new_line
    docker push $new_line

done
