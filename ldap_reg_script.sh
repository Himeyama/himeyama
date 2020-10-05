#!/usr/bin/env bash

function ary_include(){
    for i in ${ary[*]}; do
        if [[ $i == $1 ]]; then
            return 0
        fi
    done
    false
}

username=""
cancel=1
while [[ $username = "" ]]; do
    username=$(whiptail --inputbox ユーザー名を入力してください 8 0 3>&1 1>&2 2>&3)
    [[ $? -ne 0 ]] && cancel=0 && break
done
[[ $cancel = 0 ]] && echo キャンセルしました && exit

password=""
while [[ $password = "" ]]; do
    password=$(whiptail --passwordbox パスワードを入力してください 8 0 3>&1 1>&2 2>&3)
    [[ $? -ne 0 ]] && cancel=0 && break
done
[[ $cancel = 0 ]] && echo キャンセルしました && exit
ssha=$(slappasswd -s ${password})

# list=$(getent passwd | grep ":[1-9][0-9][0-9][0-9]:" | cut -d: -f3)

un=0
declare -a ary=($(getent passwd | cut -d: -f3 | sort -n))
for uid in {1100..65533}; do
    un=$uid
    ary_include $uid
    [[ $? == 1 ]] && break
done

c="ou=People,dc=nodomain"
g="ou=Group,dc=nodomain"
h="/home/nfs/"

echo -e "dn: cn=${username},${g}\n\
cn: ${username}\n\
gidnumber: ${un}\n\
objectclass: posixGroup\n\
objectclass: top\n\
\n\
dn: cn=${username},${c}\n\
cn: ${username}\n\
gidnumber: ${un}\n\
homedirectory: ${h}${username}\n\
loginshell: /bin/bash\n\
objectclass: account\n\
objectclass: posixAccount\n\
objectclass: top\n\
uid: ${username}\n\
uidnumber: ${un}\n\
userpassword: ${ssha}"
