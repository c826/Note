# 逆向系列

- [ ] 企业微信 -> 定位逆向 
	
	* hook Core Location 方法定位信息
	* hook 企业微信判断位置方法

- [ ] [消息撤回](http://yulingtianxia.com/blog/2016/05/06/Let-your-WeChat-for-Mac-never-revoke-messages/)
- [ ] [自动抢红包](http://www.jianshu.com/p/189afbe3b429)

# iDoList 系列
- [ ] NSDate
	
	* NSDate 默认时区  如何切换时区 如何得到指定时间

- [ ] UIBarButtonItem
	
	*  UIBarButtonItem 结构 如何修改 font color
	*  UINavigation appearance如何同一修改 BarButtonItem 样式
	 
1. 首页 基本没什么问题
2. 收集箱 ->  整理按钮的位置，整理过程的提示和转跳样式
3. 下一步行动 -> cell显示样式 透视样式
4. 日历 -> 日历显示样式
5. 等待他人 -> cell显示样式
6. 完成 -> cell显示样式
7. 也许将来  基本搞定
8. 9.项目管理 -> 添加样式
10. 回收站 -> 清空逻辑

- [x] 项目管理页面 添加样式
- [x] 整理按钮 整理逻辑
- [ ] 等待他人页面调整
- [ ] 已完成页面调整
- [ ] 提示弹框 -> PKHUD
	 
# github 系列

- [ ] STMURLCache

# normal

- [ ] AppCode 软件


# 问题答疑 
1. Swift 中 NSDate 与 Date区别

	Swift在Foundation框架上提供了一个*Date*结构体，用来桥接*NSDate*类。值类型*Date*提供了与引用类型*NSDate*一样的功能，并且在Swift代码中两者可以互相转换来与OC的API协同工作。这个行为与Swift如何桥接标准字符串，数字和集合类型与其对应的Foundation类。

2. Swift 中有哪些值类型 与 引用类型
 
 * value type : String, enum, Struct
 
 * reference type : closure, class

