# swift 100 tips 

##柯里化 Currying

```objective-c
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
##~~selector~~
swift中使用#selector来调用selector

```objective-c
let method = #selector(callMe)
let oneParam = #selector(callMeWithOneParam(_:))
let twoParam = #selector(callMeWithTwoParam(_:two:))
```
如果#selector对应的是swift中的私有方法(private)，那么则需要在private前加 @objc 。因为selector是OC中runtime的概念，所以如果方法只在swift中可见时，就会报错。

如果方法名在作用域内是唯一的，则可以使用方法名作为#selector参数。如果不是唯一则不能使用。编译会报错。

```objective-c
let method = #selector(callMe)
let oneParam = #selector(callMeWithOneParam)
let twoParam = #selector(callMeWithTwoParam)
```





