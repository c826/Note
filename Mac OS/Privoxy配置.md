# 安装与配置 privoxy

brew install privoxy

编辑 /usr/local/etc/privoxy/config 文件 添加：
```
listen-address 0.0.0.0:8118     8118 是privoxy监听的端口
forward-socks5 / localhost:1080 .    1080是shadowsocks 使用的端口
```
# 启动privoxy

sudo /usr/local/sbin/privoxy /usr/local/etc/privoxy/config

创建/Library/LaunchAgents/local.privoxy.plist文件，添加：
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>local.arcueid.privoxy</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/sbin/privoxy</string>
        <string>--no-daemon</string>
        <string>/usr/local/etc/privoxy/config</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>/usr/local/Cellar/privoxy/privoxy.log</string>
    <key>StandardOutPath</key>
    <string>/usr/local/Cellar/privoxy/privoxy.log</string>
</dict>
</plist>
```

launchctl load /Library/LaunchAgents/local.privoxy.plist


# 开机自启

编辑 /.bash_profile 文件，添加：

```
export http_proxy='http://localhost:8118'
export https_proxy='http://localhost:8118'

function proxy_off(){
    unset http_proxy
    unset https_proxy
    echo -e "privoxy off"
}

function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://127.0.0.1:8118"
    export https_proxy=$http_proxy
    echo -e "privoxy on"
}
```
使用了zsh 需要配置zshrc  source ~/.bash_profile 不然无法生效


