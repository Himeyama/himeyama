# NFS 設定

## サーバー側設定

```sh
sudo apt install -y nfs-kernel-server
sudo mkdir /nfs
sudo chmod 777 /nfs
```

```sh
# /etc/exports
/nfs    (rw,sync,insecure,no_subtree_check,no_root_squash)

sudo exportfs -rav
```

```sh
sudo service nfs-kernel-server restart
```

## クライアント側設定
```sh
sudo apt install -y nfs-common
```

```sh
sudo mkdir /home/nfs
sudo mount -t nfs hyperv:/nfs /home/nfs
```

```sh
# /etc/fstab
<IP>:/nfs /home/nfs nfs defaults 0 0
```

