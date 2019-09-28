#!/usr/bin/env bash
my_path=$(cd `dirname $0`;pwd)
resources_path=$my_path/resources
lib_path=$my_path/lib
mysql_path=$lib_path/mysql

source $my_path/method/file.sh


create_dir $my_path/lib

#rewrite mysql_path

function check_lib(){
    if [ -d "$mysql_path" ];then
        echo "clear old mysql_path: $mysql_path"
        rm -rf $mysql_path
    fi
}

function uncompress_tar(){
    tar_path=$@
    tar -xvf $tar_path
    cd $resources_path
    file_list=`ls`
    for i in `ls`;do
        index=`expr match "$i" mysql`
        item_path=$resources_path/$i
        if [ $index -gt 0 ]&&[ -d "$item_path" ];then
            check_lib
            mv $item_path $mysql_path
        fi
    done
}
function uncompress_xz(){
    echo "xz install package;This may take some time, please be patient..."
    xz_path=$@
    xz -d $xz_path
}


cd $resources_path
file_list=`ls`

for i in $file_list;do
    index=`expr match "$i" mysql`
    item_path=$resources_path/$i
    
    if [ $index -gt 0 ]&&[ -f "$item_path" ];then
        suffix=`get_suffix $i`
        if [ "$suffix" == "tar" ];then
            uncompress_tar $item_path
        elif [ "$suffix" == "xz" ];then
            uncompress_xz $item_path
            uncompress_tar ${item_path%.*}
        fi
        echo "install successfull~"
        break
    fi
done



