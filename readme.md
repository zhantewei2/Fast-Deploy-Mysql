MYSQL 单应用非DOCKER快速搭建
===

安装
---
- 在当前目录新建 resources文件夹。
- 下载mysql-xxxx-[任意generic版本].tar.xz 放置于该文件夹下
```
./install.sh
```
部署
---
```
#初始化服务配置
./deploy.sh server 
#初始化data
./deploy.sh db
```
初始化账号
--
```
./user.sh init
```
