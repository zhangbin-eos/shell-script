#!/bin/bash

indent_cmd="indent -linux -bls -blf -bl -bli0"
filepath=$(pwd)

workpath="$HOME/.indent_workpath/"

mkdir -p $workpath

for file in $*
do
        echo "indent file \"$file\""
        tempfile=$(mktemp tmp.XXXXXXXXXX)

        cd $workpath
        cp $filepath/$file ./$tempfile


        #删除^M
        sed -i "s/\r//g" $tempfile

        #windows 下indent读取文件异常
        cat $tempfile | $indent_cmd -o $filepath/$file

        rm -rf $tempfile
        cd $filepath
done
