# 存活

* i: 进入insert模式，ESC退回到Normal模式。
* wq: 保存并退出。
* dd: 删除当前行，并保存到剪切板中。
* p: 粘贴剪切板中的内容。
* yy: 拷贝当前行 相当于ddp
* H: 左
* L: 右
* J: 上
* K: 下
* help: 帮助

# 感觉良好

* a: 在光标前插入
* o: 在当前行前插入一个新行
* O: 在当前行后插入一个新行
* cw: 替换当前光标位置到一个单词结尾的字符

* 0: 到行头
* ^: 到本行第一个不是blank字符的位置
* $: 到行尾
* g_: 到行位最后一个不是blank的字符位置
* /patten: Normal模式下搜索patten字符（按n查找下一个）

* u: Undo
* clr+r: redo

* :e+/path/file: 打开一个文件
* :saveas /path/: 文件另存为
* :x , ZZ , :wq : 保存并退出 
* :q!: 退出不保存 
* :qa!: 退出所有
* :bn: 多文件切换到前一个
* :bp: 多文件切换到后一个

![702042-d28dbdaf1393b2ba](media/702042-d28dbdaf1393b2ba.png)

g_


 
# proxy
alias setproxy="export http_proxy=socks5://127.0.0.1:1080; export https_proxy=$http_proxy;"
alias unsetproxy="unset http_proxy; unset https_proxy;"

# Git proxy
 alias unsetgitproxy="git config --global --replace-all http.proxy ''; git config --global --replace-all https.proxy '';"

