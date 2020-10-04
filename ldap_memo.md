```sh
sudo apt update
sudo apt upgrade
sudo apt install -y openssh-server
sudo apt install -y slapd ldap-utils sssd sssd-ldap ldap-auth-client nscd
sudo apt purge slapd ldap-utils
```

```sh
sudo dpkg-reconfigure ldap-auth-config
# IP
# ldap://<IP or hostname>/

# admin nodomain
```

### NSS の設定
```sh
sudo nano /etc/nsswhich.conf
# ldap を追加
sudo service nscd restart
```

### LDAP ユーザーの確認
```sh
getent passwd
```

# 追加
```sh
# user.ldif
dn: ou=People,cd=nodomain
objectClass: organizationalUnit
ou: People
structuralObjectClass: organizationalUnit

dn: cn=testuser,ou=People,dc=nodomain
cn: testuser
gidnumber: 1000
homedirectory: /home/testuser
loginshell: /bin/bash
objectclass: account
objectclass: posixAccount
objectclass: top
uid: testuser
uidnumber: 1001
userpassword: {CRYPT}$6$1/RXprBtH/uxtsDW$VZAB0gZQ8/yMZqXiVddfyLuO6GrM.LmeAQJc9R0G3ZDfHOilkI5rwwpv3QtYGeCmK8kXwyhyCNxbUdkq69J6Y0
```

```sh
sudo ldapadd -x -D cn=admin,dc=nodomain -W -f user.ldif
sudo ldapdelete -x -D cn=admin,dc=nodomain -W "cn=testuser,ou=People,dc=nodomain"
```


```sh
sudo pam-auth-update
```

## PhpLdapAdmin
### インストール
```sh
sudo apt install -y phpldapadmin
```

ブラウザで`<IP addr | hostname>/phpldapadmin` にアクセス

`/etc/phpldapadmin/config.php` の設定

```php
$servers->setValue('server','base',array('dc=nodomain'));
$servers->setValue('login','bind_id','cn=admin,dc=nodomain');
```

### 起動と停止
```sh
sudo service apache2 start #起動
sudo service apache2 stop #停止
```
