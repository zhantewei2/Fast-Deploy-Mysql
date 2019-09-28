function create_dir(){
    dir_path=$@
    if [ ! -e "$dir_path" ];then
        mkdir $dir_path
        echo "create dir: $dir_path"
    fi
}

function create_file(){
    file_path=$@
    if [ ! -e "$file_path" ];then
        touch $file_path
        echo "create file: $file_path"
    fi

}

function get_suffix(){
    value=$@
    suffix=`echo ${value##*.}`
    echo $suffix
}

function echo_yellow(){
    echo -e "\033[33m$@\033[0m"
}
function echo_red(){
    echo -e "\033[31m$@\033[0m"
}

function echo_blue(){
    echo -e "\033[34m$1\033[0m" "\033[33m$2\033[0m"
}