# ldap memo 2

## セットアップ
```sh
# chdomain.ldif
dn: olcDatabase={1}mdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=bcl,dc=sci,dc=yamaguchi-u,dc=ac,dc=jp

dn: olcDatabase={1}mdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=admin,dc=bcl,dc=sci,dc=yamaguchi-u,dc=ac,dc=jp

dn: olcDatabase={1}mdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: password
```

```sh
# base.ldif
dn: dc=bcl,dc=sci,dc=yamaguchi-u,dc=ac,dc=jp
objectClass: dcObject
objectClass: organization
dc: bcl
o: bcl

dn: ou=admin,dc=bcl,dc=sci,dc=yamaguchi-u,dc=ac,dc=jp
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: LDAP administrator
userPassword: {SSHA}+Kr1Gzgovvuugw66l7Majz/xbzAkS8pT
```

```sh
ldapmodify -Y EXTERNAL -H ldapi:/// -f chdomain.ldif
ldapadd -x -D cn=admin,dc=nodomain -W -f base.ldif
```

`/etc/phpldapadmin/config.php`を開き、以下を追加。

```php
$servers->setValue('server','base',array('dc=bcl,dc=sci,dc=yamaguchi-u,dc=ac,dc=jp'));
$servers->setValue('login','bind_id','cn=admin,dc=bcl,dc=sci,dc=yamaguchi-u,dc=ac,dc=jp');
```

## Docker

### 起動
```sh
docker start ldap
docker attach ldap
```

### イメージ化
```sh
docker commit ldap ubuntu:ldaptestN
```
