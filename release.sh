#! /bin/sh



# 将要新建的tag
currenttag=$1
res=$(echo $currenttag | grep '[Vv][0-9]\+\(.[0-9]\+\)\{0,2\}')
if ! [ "$res" = "$currenttag" ]
then
    echo 'tag name err, version format is [Vv]\d+(.\d+){0,2}'
    exit 1
fi


# 获取最近一个tag,tag的格式必须是版本格式
lasttag=$(git tag  --sort=v:refname  |tail -1)

# 新建一个发布提交
read -p "Do you want to create a release commit? [Y/N]" confirm
[ $confirm == 'y' ] || [ $confirm == 'Y'] && git commit –no-verify -m "release $1"


tmpfile=$(mktemp)

# 获取change log
git log $lasttag..HEAD --oneline  > $tmpfile

# 整合log
cat $tmpfile | grep "feat" > $currenttag.featlist
cat $tmpfile | grep "fix" > $currenttag.fixlist
cat $currenttag.featlist > $tmpfile
cat $currenttag.fixlist >> $tmpfile 

# 新建tag
cat $tmpfile |  git tag $currenttag -F -

if [ $? -eq 0 ]
then 
        echo "create tag : $currenttag"
else
        echo "tag error" &&  exit 1
fi

# 删除中间文件
rm -rf $tmpfile 
rm -rf $currenttag.featlist $currenttag.fixlist 


