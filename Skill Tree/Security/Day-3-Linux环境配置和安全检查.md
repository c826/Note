# iptables 使用配置详解

# centos firewall 与 iptables区别

# centos 修改ssh端口 sshd.service 报错
zelinux
执行一下semanage port -l | grep ssh就会发现ssh只允许监听22。
好咯，那我就把1234添加进列表里面：
semanage port -a -t ssh_port_t -p tcp 1234
再重启sshd，service ssh restart。
看一下service ssh status：

# 80端口打开能telnet 能ping通  apache访问不进去




