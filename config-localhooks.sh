#! /bin/bash
set -x
srcpath=./hooks/
hooks="commit-msg pre-commit"

chmod +x -R $srcpath

if [ -d ".git" ]
then
        obj_hooks_dir=".git/hooks/"
elif [ -f ".git" ]
then
        obj_hooks_dir="$(cat .git | awk -F': ' '{print $2}')/hooks/"
else
        echo "not find  .git "
        exit 1
fi

cur=$(pwd)
if ! cd "$obj_hooks_dir"
then
        exit 2
fi

rm -rf $hooks

for i in $hooks
do
ln -s $cur/$srcpath/$i $i
done

cd $cur

echo "config ok"
