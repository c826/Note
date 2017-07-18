# SQL注入
利用程序未判断用户输入，从而导致用户输入的恶意sql语句会被服务器执行，导致信息泄露。

* 判断是否为注入点：在url参数后添加任意字符，比如'单引号，如若出现错误信息，则说明存在sql注入点。
* Access 判断是否存在表：and exists (select * form xxx)
* 确定表之后判断是否存在字段 ： and exists (select xxx from table)
* 判断数据长度：(select top 1 len(xxx) from table) > 10 *10为猜测长度*
* 逐位猜解敏感信息： (select top 1 asc (mid(xx,1,1)) from table) > 90 *top等价于limit，限制位数，mid 截取字符串，> 90 为ASCII编码* 

# SQLMap 使用





