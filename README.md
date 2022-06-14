```shell
sudo systemctl stop firewalld

# 宿主机创建备份目录
sudo mkdir-p /home/dispatch/ftp/root/

# 防止备份失败，直接给777权限
sudo chmod 777 /home/dispatch/ftp/root/

# 用docker运行一个临时ftp服务器
sudo docker run -d -p 21:21 -p 21100-21110:21100-21110 \
  -v /home/dispatch/ftp/root/:/home/vsftpd/ftp \
  -e FTP_USER=ftp \
  -e FTP_PASS=12345 \
  -e PASV_ADDRESS=***.**.**.**\
  -e PASV_MIN_PORT=21100 \
  -e PASV_MAX_PORT=21110 \
  --name vsftpd \
  --restart=always \
  fauria/vsftpd
```
