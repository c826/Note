# swift 100 tips 

##柯里化 Currying

*柯里化*: 把接受多个参数的函数简化为接受单一参数，并返回接收余下参数而且返回结果的新函数的函数。
Swift currying : 将*影响函数结果*的条件作为参数,并返回相应功能函数的技术。

``` Swift
protocol TargetAction {
    func perfromAction()
}

struct TargetActionWrapper<T:AnyObject> : TargetAction{
    weak var target : T?
    
    let action : (T) -> () -> ()
    
    func perfromAction() {
        if let t = target {
            action(t)()
        }
    }
    
}

enum ControlEvent {
    case ToucheUpInside
    case ValueChanged
}

class control {
    var actions = [ControlEvent : TargetAction]()
    
    func setTarget<T:AnyObject>(target : T , action : (T) -> () -> () ,controlEvent : ControlEvent){
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent : ControlEvent)  {
        actions[controlEvent] = nil
    }
    
    func prefromActionForControlEvent(controlEvent : ControlEvent){
        actions[controlEvent]?.perfromAction()
    }
    
}

```

## Sequence


##把protocol中的方法用mutating声明
mutating : 让方法可以修改struck 和 enum 中的变量的值。
如果protocol 中的方法不用mutating来声明的话,如果struck或者enum实现该方法时就无法改变变量的值。
protocol中的方法与struck中的方法都需要用mutating来声明。但是在class 中无需用mutating来声明protocol中方法

``` Swift
protocol changeColor {
	var color : UIColor {get}
	
	mutating func changeMyColor() -> Void
}

stuck car : changeColor{
	var color = UIColor.redColor()
	
	mutating func changeMyColor() -> Void{
		color = UIColor.blackColor()
	}
}
```







##~~selector~~
swift中使用#selector来调用selector

``` Swift
let method = #selector(callMe)
let oneParam = #selector(callMeWithOneParam(_:))
let twoParam = #selector(callMeWithTwoParam(_:two:))
```
如果#selector对应的是swift中的私有方法(private)，那么则需要在private前加 @objc 。因为selector是OC中runtime的概念，所以如果方法只在swift中可见时，就会报错。

如果方法名在作用域内是唯一的，则可以使用方法名作为#selector参数。如果不是唯一则不能使用。编译会报错。

``` Swift
let method = #selector(callMe)
let oneParam = #selector(callMeWithOneParam)
let twoParam = #selector(callMeWithTwoParam)
```





