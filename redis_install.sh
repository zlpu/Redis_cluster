#!/bin/bash
clear
echo -e "\033[31m============离线安装redis=========\033[0m"
echo -e "\033[33m
环境检查：
1.是否已经将redis源码包上传到/root目录下
2.检查是否安装了编译环境 gcc-c++
\033[0m"

sleep 10
ls /root/| grep redis
echo -e "\033[31m
创建redis解压编译目录
\033[0m"
sleep 8
clear

mkdir -p /usr/local/src/redis
echo -e "\033[31m
创建redis安装目录
\033[0m"
mkdir -p /app/redis
sleep 8
clear

echo -e "\033[31m
解压到指定目录
\033[0m"
tar -zxvf /root/redis*.gz -C /usr/local/src/redis
sleep 8
clear

echo -e "\033[31m
预编译环境
\033[0m"
cd /usr/local/src/redis/redis*/deps
make hiredis jemalloc linenoise lua
sleep 8
clear

echo -e "\033[31m
编译
\033[0m"
cd /usr/local/src/redis/redis*
make
sleep 8
clear

echo -e "\033[31m
安装到指定目录
\033[0m"
make install PREFIX=/app/redis
sleep 8
clear

echo -e "\033[31m
检查安装目录下是否有相关的启动文件
\033[0m"
ls /app/redis/bin
sleep 8
clear 

echo -e "\033[31m
将配置文件拷贝到安装目录下的conf目录下
\033[0m"
mkdir -p /app/redis/conf
echo -e "\033[31m
拷贝初始配置，使用默认端口
\033[0m"
cp /usr/local/src/redis/redis*/redis.conf /app/redis/conf/redis.conf
sleep 8
clear

echo -e "\033[31m
开启后台运行，启动redis-server,使用默认端口
\033[0m"
sed -i 's/daemonize no/daemonize yes/g' /app/redis/conf/redis.conf
/app/redis/bin/redis-server /app/redis/conf/redis.conf 

sleep 8
clear

echo -e "\033[31m
测试连接是否正常
\033[0m"
if [ $(/app/redis/bin/redis-cli -h 127.0.0.1 -p 6379 ping) = 'PONG' ];
then
   echo -e "\033[32m
	     安装成功！
	     安装路径：/app/redis/
	     源码编译路径：/usr/local/src/redis
             \033[0m"
   echo -e "
             \033[36m
	     =================================
	     如需启动多个redis,请使用如下命令；
	     ================================
	     cp /usr/local/src/redis/redis*/redis.conf /app/redis/conf/redis-自定义端口号.conf
	     /app/redis/bin/redis-server /app/redis/conf/redis-端口号.conf
	    \033[0m"
else
   echo -e "\033[31m
             安装失败
            \033[0m"
fi
