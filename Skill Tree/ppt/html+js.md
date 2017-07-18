## HTML + JAVASCRIPT

## html

#### 什么是HTML？
- HTML 指的是超文本标记语言 (Hyper Text Markup Language)
- HTML 不是一种编程语言，而是一种标记语言 (markup language)
- 标记语言是一套标记标签 (markup tag),例如 `<div></div>` `<p></p>`
- HTML 使用标记标签来描述网页


#### 一些简单的标签
```
<html>  //<html> 与 </html> 之间的文本描述网页
<body>  //<body> 与 </body> 之间的文本是可见的页面内容

<h1>这是一个标题</h1>   //<h1> 与 </h1> 之间的文本被显示为标题

<p>这是一个段落</p>   //<p> 与 </p> 之间的文本被显示为段落

</body>
</html>

```

### HTML中的标签

- HTML标题 是通过 `<h1> - <h6>` 等标签进行定义的。

```
<h1>我是一级标题</h1>
<h2>我是二级标题</h2>
<h3>我是三级标题</h3>
<h4>我是四级标题</h4>
<h5>我是无级标题</h5>
<h6>我是六级标题</h6>
```
- HTML 段落是通过 `<p>` 标签进行定义的。

```
<p>我是段落一</p>  
<p>我也可以是一段文字描述。。。</p>
```
- HTML 链接是通过 `<a>` 标签进行定义的。

```
<a href="https://www.ichunqiu.com/">点我跳转到i春秋官网</a>
```
- HTML 图像是通过 `<img>` 标签进行定义的。

`<img src="dog.jpg" width="300" height="200" alt="这是一条小狗" />`
- HTML 列表是通过 `<ul>` 和 `<ol>` 标签进行定义的。其中`ul`一般用来表示无序列表，`ol`用来表示有序列表

```
<ul>
    <li>第一条</li>
    <li>第二条</li>
    <li>第三条</li>
</ul>
```

- HTML 表格是通过 `table` `thead` `tbody` `th` 'td' 等标签来定义的
```

<table border="1">
    <tr>
        <td>100</td>
    </tr>
</table>
 <h4>表头：</h4>
<table border="1">
    <tr>
        <th>姓名</th>
        <th>电话</th>
        <th>电话</th>
    </tr>
    <tr>
        <td>张三</td>
        <td>555 47 854</td>
        <td>123 77 234</td>
    </tr>
</table>

 + 单元格可以设置"colspan" 和 "rowspan" 属性来横跨单元格

 <h4>横跨两列的单元格：</h4>
<table border="1">
    <tr>
        <th>姓名</th>
        <th colspan="2">电话</th>
    </tr>
    <tr>
        <td>张三</td>
        <td>555 77 854</td>
        <td>555 77 855</td>
    </tr>
</table>


```
#### HTML form表单

在html中表单占有很大的重要性，从最开始的简单网页的交互，到现在发杂多变的网站交互，都离不开form表单的应用，我们单独把form拿出来讲解。
```
<form action="www.baidu.com" method="get" enctype="application/x-www-form-urlencoded"> 
```
> action 属性表明表单将要提交到哪里  
> method表示提交用的方法分别为get和post可选  
> enctype规定在发送表单数据前对数据进行编码的格式:

   + `application/x-www-form-urlencoded`默认的表单格式    
   所有字符都会进行编码（空格转换为 "+" 加号，特殊符号转换为 ASCII HEX 值）。
   + `text/plain`   
   空格转换为 "+" 加号，但不对特殊字符编码。
   + `multipart/form-data`  
   不对字符编码。在使用包含文件上传控件的表单时，必须使用该值
- 输入框 `<input/>` 标签  最常用

  `<input>` 标签规定了用户可以在其中输入数据的输入字段。  
  输入字段可通过多种方式改变，取决于 type 属性。

  + `type="text"` 普通的文本输入框
  + `type="password"` 带星号的密码输入框
  + `type="radio"` 单选框   
  同一类型要有统一的name属性，表明是一类
  + `type="chckbox"` 复选框  
  添加checked属性会默认选中
  + `type="file"` 文件上传选择
  + `type="email"` 带简单验证的邮箱输入
- `<texteara>` 标签 input只能单行输入，texteara可以多行输入

```
<form action="www.baidu.com" method="get" enctype="multipart/form-data">
    <p>您的意见对我很重要:
    </p>
    <textarea name="" cols="20" rows="5">
            请将意见输入此区域
        </textarea>
</form>
```   
- 块级元素：`<h>` `<body>` `<p>` `<div>` `<form>` `<ul>`
      `<ol>` `<li>` `<table>` `<tr>` 
- 行内元素： `<a>` `<i>` `<span>` `<em>` `<input>` `<button>` `<label>` `<img>` `<select>` `<textarea>` `<br>` `<strong>` `<td>` `<th>`

### JAVASCRIPT

#### 什么是JavaScript

JavaScript 是脚本语言
JavaScript 是一种轻量级的编程语言。
JavaScript 是可插入 HTML 页面的编程代码。
JavaScript 插入 HTML 页面后，可由所有的现代浏览器执行。
JavaScript 很容易学习。

#### 写入 HTML 输出

```js
document.write("<h1>This is a heading</h1>");
document.write("<p>This is a paragraph</p>");
```
#### 对事件作出反应
```js
<button type="button" onclick="alert('Welcome!')">点击这里</button>
```

#### 改变 HTML 内容
```js
x=document.getElementById("demo")  //查找元素
x.innerHTML="Hello JavaScript";    //改变内容
```

#### 改变 HTML 样式
```js
x=document.getElementById("demo")  //找到元素
x.style.color="#ff0000";           //改变样式
```
#### 验证输入
```js
if isNaN(x) {alert("Not Numeric")};
```
### 
HTML 中的脚本必须位于 <script> 与 </script> 标签之间。
脚本可被放置在 HTML 页面的 <body> 和 <head> 部分中。

```js
<script>
alert("My First JavaScript");
</script>
```


```js
<!DOCTYPE html>
<html>
<body>
.
.
<script>
document.write("<h1>This is a heading</h1>");
document.write("<p>This is a paragraph</p>");
</script>
.
.
</body>
</html>
```

#### JavaScript 注释
JavaScript 不会执行注释。
我们可以添加注释来对 JavaScript 进行解释，或者提高代码的可读性。
单行注释以 // 开头。
```js
// 输出标题：
document.getElementById("myH1").innerHTML="Welcome to my Homepage";
// 输出段落：
document.getElementById("myP").innerHTML="This is my first paragraph.";
```
