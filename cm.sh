#!/usr/bin/env bash

type=$@
my_path=$(cd `dirname $0`;pwd)
mysqld_bin=$my_path/lib/mysql/bin/mysqld
real_conf_file=$my_path/lib/conf/mysql.conf


if [ "$type" == "start" ];then
    echo $real_conf_file
    nohup $mysqld_bin --defaults-file=$real_conf_file > /dev/null &

elif [ "$type" == "stop" ];then
    pid=`ps -ef |grep $mysql_bin\ --defaults-file=$real_conf_file |grep -v grep|awk '{print $2}'`
    if [ ! $pid ];then
        echo "mysql not running"
    else
        echo "mysql pid: $pid"
        kill $pid
        echo "stop successfull"
    fi

fi