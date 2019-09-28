#!/usr/bin/env bash
my_path=$(cd `dirname $0`;pwd)
mysql_bin=$my_path/lib/mysql/bin/mysql
data_path=$my_path/data
store_file=$data_path/.store_file
source $my_path/method/file.sh
user_config=$my_path/conf/user.conf


MYSQL_PORT=3308


type=$1
type_value=$2

#default variable

root_password=wobuaiwo
default_db=cm
user_account=cm
user_password=chumi001

function check_store(){
    echo "1"
}
function wirte_store(){
    touch $store_file
}


function excute_mysql(){
    if [ ! -f "$store_file" ];then
        $mysql_bin -P $MYSQL_PORT --host 127.0.0.1 -u root -e "$@"
    else
        $mysql_bin -P 3308 --host 127.0.0.1 -u root -p$root_password -e "${@}"    
    fi
}

echo $type

# read user variable

for line in `cat $user_config`;do
    annotation=`expr match "$line" "#"`
    if [ $annotation -eq 0 ];then
        eval "$line"
    fi
done



if [ "$type" == "init" ];then
    if [ ! -f $store_file ];then
        excute_mysql "alter user 'root'@'localhost' identified by '$root_password';"
        wirte_store
    fi
    # excute_mysql "create database $default_db;"
    # excute_mysql "create user '$user_account'@'%' identified by '$user_password';"
    # excute_mysql "grant all on ${default_db}.* to '$user_account'@'%'"
    echo_yellow "init successfull"
    echo_blue "root password:" "$root_password"
    echo_blue "user_account:" "$user_account"
    echo_blue "user_password:" "$user_password"
    echo_blue "default_db:" "$default_db"
fi