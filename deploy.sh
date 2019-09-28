#!/usr/bin/env bash

type=$@
my_path=$(cd `dirname $0`;pwd)
conf_path=$my_path/conf
data_path=$my_path/data
real_conf_path=$my_path/lib/conf
real_conf_file=$real_conf_path/mysql.conf
log_path=$data_path/log

mysqld_bin=$my_path/lib/mysql/bin/mysqld


source $my_path/method/file.sh

port=3308
basedir=$my_path/lib/mysql
datadir=$data_path/db
user=root
pidfile=$data_path/mysql.pid
tmpdir=$data_path/tmp
socket=$data_path/tmp/mysql.sock
mysqlx_port=33080
mysqlx_socket=$data_path/tmp/mysqlx.sock
max_connections=600
max_connect_errors=1000
log_error=$log_path/error.log

# ovelay 重置变量
if [ -f $conf_path/mysql-overlay.conf ];then
    for line in `cat $conf_path/mysql-overlay.conf`;do
        annotation=`expr match "$line" ".*#"`
        title=`expr match "$line" "\[.*\]"`
        if [ $annotation -eq 0 ]&&[ $title -eq 0 ];then
            eval "$line"
        fi
    done
fi



file_content=""

base_config(){
    file_content="
[mysqld]
port=$port
basedir=$basedir
datadir=$datadir
user=$user
pid-file=$pidfile
tmpdir=$tmpdir
socket=$socket
max_connections=$max_connections
max_connect_errors=$max_connect_errors
mysqlx_port=$mysqlx_port
mysqlx_socket=$mysqlx_socket
log-error=${log_error}

[client]
default-character-set=utf8
port=$port
socket=$socket

[mysql]
default-character-set=utf8
socket=$socket
"
}


deploy_server(){
echo "deploy server"
# create_dir $basedir
# create_dir $datadir
# create_dir $tmpdir

create_dir $my_path/lib
create_dir $real_conf_path

base_config

cat>$real_conf_file<<EOF
$file_content    
EOF
echo "write file: $real_conf_file"
echo "deploy server successfull"
}

deploy_db(){
    echo "deploy database"
    if [ -d "$datadir" ]; then
            echo "datadir already exists.If you want to continue ,please delete if first."
    else
        create_dir $data_path
        $mysqld_bin --initialize-insecure --user=root --basedir=$basedir --datadir=$datadir
        create_dir $tmpdir
        create_file $socket
        create_file $mysqlx_socket
        create_dir $log_path
    fi
}

if [ "$type" == "db" ];then
    deploy_db
elif [ "$type" == "server" ];then
    deploy_server
fi
