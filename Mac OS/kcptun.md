
# 服务器端安装
服务器使用下列命令安装好kcpkun之后，按照提示做下去，密码是客户端用来连接kcptun的密码，端口一个是要监听ss的端口，一个是用来让客户端连接的端口。

```
wget --no-check-certificate https://raw.githubusercontent.com/kuoruan/kcptun_installer/master/kcptun.sh

chmod +x ./kcptun.sh

./kcptun.sh
```

# 客户端安装
从[github](https://github.com/xtaci/kcptun/releases)下载客户端
kcptun-darwin-amd64-20170329.tar.gz

命令行运行
```
./client_darwin_amd64 -l ":ss监听的本地端口" -mode fast2 -r "服务器地址:kcptun端口" --crypt 加密方式 --key "密码"
```
添加clien.json到同一文件夹
```
{
    "localaddr": ":2333",
    "remoteaddr": "45.78.21.88:826",
    "key": "930826",
    "crypt": "aes-128",
    "mode": "fast3"
}
```
启动
```
./client_darwin_amd64 -c client.json
```

# ss设置
端口监听 127.0.0.1 
端口 kcptun本地的端口
加密 ss加密方式
密码 ss密码

# 开机自启
```
nohup ~/Desktop/Document/kcptun-darwin-amd64-20170329/client_darwin_amd64 -c ~/Desktop/Document/kcptun-darwin-amd64-20170329/client.json >/dev/null 2>&1 &
```

