#!/bin/bash
cd `dirname $0`

if [ -z $1 ] ; then
    echo "usage: $0 path_to_dir_with_files"
fi

ROOT_DIR=$1

prev_date="0000-00-00"
cnt=0
for s in `cat $ROOT_DIR/* | sed "s/localhost_access_//" | sort`
do

    d=`echo $s | sed "s/.tar.gz:.*//"`
    n=`echo $s | sed "s/.*://"`
    if [[ "$prev_date" == "0000-00-00" ]] ; then
        prev_date=$d
    fi
    if [[ "$prev_date" != "$d" ]] ; then
        echo "$prev_date $cnt"
        prev_date=$d
        cnt=0
    fi
    let "cnt=$cnt+$n"
done

echo "$prev_date $cnt"

