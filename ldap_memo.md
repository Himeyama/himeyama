# server 側
```sh
sudo apt update
sudo apt upgrade
sudo apt install -y whiptail nano openssh-server slapd ldap-utils ldap-auth-config
# sudo apt install -y slapd ldap-utils sssd sssd-ldap ldap-auth-client nscd
# sudo apt install -y slapd ldap-utils ldap-auth-config
# sudo apt purge slapd ldap-utils
# sudo apt install -y ldap-utils ldap-auth-config
```

```sh
sudo dpkg-reconfigure ldap-auth-config
# IP
# ldap://<IP or hostname>/

# cn=admin,dc=nodomain
```

### NSS の設定
```sh
sudo nano /etc/nsswhich.conf
```

### LDAP ユーザーの確認
```sh
getent passwd
```

## 追加
```sh
dn: ou=People,cd=nodomain
objectClass: organizationalUnit
ou: People
structuralObjectClass: organizationalUnit
```

### ユーザーの追加
```sh
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
userpassword: {CRYPT}$.$...
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

## クライアント設定
```sh
sudo apt update && sudo apt upgrade -y
sudo apt install -y ldap-utils ldap-auth-config libnss-ldapd
nano /etc/nsswitch.conf
# ldap を追加

sudo apt install -y nfs-common
sudo mkdir /home/nfs
sudo nano /etc/fstab
# マウントの設定
# <IP>:/nfs /home/nfs nfs defaults 0 0
```
