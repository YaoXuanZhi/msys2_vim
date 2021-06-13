#!/bin/bash

# sed 需要对斜杆和括号等字符进行转义后才能正常正则替换
replace_escape_string(){
    eval $2=\"$(eval echo "\${$1}" | sed "s/\//\\\\\//g; s/(/\\\\(/g; s/)/\\\\)/g")\"
}

# 在文件头上加入其它镜像源
push_front_mirror_url(){
    _source_config_file=$1
    _backup_config_file=$(dirname $1)/bak_$(basename $1)
    _old_mirror_pattern=$2
    _new_mirror_host=$3

    # 备份原本的镜像源配置
    if [ ! -f ${_backup_config_file} ]; then
        cp $_source_config_file ${_backup_config_file}
    fi

    # 找到镜像源配置模板
    mirror_temp_url=$(grep -r -P "$_old_mirror_pattern" ${_backup_config_file})

    replace_escape_string _old_mirror_pattern _old_mirror_pattern
    replace_escape_string _new_mirror_host _new_mirror_host

    # 根据模板镜像源修改成新的镜像源
    new_mirror_url=$(echo $mirror_temp_url | sed "s/$_old_mirror_pattern/\\1$_new_mirror_host\\3/g")

    # 在文件头上插入新的镜像源链接
    (echo $new_mirror_url && cat ${_backup_config_file}) > $_source_config_file
}

main(){
    # 腾讯云镜像源
    # new_mirror_host="https://mirrors.cloud.tencent.com/msys2"

    # 清华镜像源
    new_mirror_host="https://mirrors.tuna.tsinghua.edu.cn/msys2"

    old_mirror_pattern="(Server.*)(http.*repo.msys2.org)(.*)"

    if [ ${#} == 1 ]; then
        new_mirror_host=$1
    fi

    # 遍历pacman的镜像源配置
    for file in /etc/pacman.d/mirror*; do
        push_front_mirror_url $file $old_mirror_pattern $new_mirror_host
    done
}

main $1
