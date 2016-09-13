# Swift -- Protocol-Oriented Language

Apple在WWDC2015上发布Swift 2，并宣称其将是 "**protocol-oriented programming language**" 。这个声明因为新添加的"**protocol extension**"特性而变得可能。

虽然protocol在很早的时候就应用在Swift中，这次声明以及Apple在标准库中大量使用protocol的修改，会改变我们看到类型的方式。

简单来说，*protocol-oriented programming*强调编写协议，而不是特定的类、结构体或者枚举类型。它打破了从前协议的规则并且允许你能在协议中为其编写协议的实现。

## Protocol Extension

Extension 可以让你为任意类型添加额外的计算属性与方法。

```
extension String {
	func shout(){
		print (self.uppercaseString)
	}
}
```

上面这段代码拓展了String类型，并为其添加了一个额外的方法。你可以拓展系统中的任意类型，包括某些并不是由你编写的类型，并且在一个类型上可以拥有任意数量的拓展。

你可以像下面这段代码一样定义一个 protocol extension:

```
protocol TeamRecord {
	var wins : Int {get}
	var losses : Int {get}
	func winningPercentage () -> Double
}

extension TeamRecord {
	var gamePlayed : Int {
		return wins + losses
	}
}
```

与你拓展一个类、结构体或者枚举类似，你使用*extension*关键字，然后在后面跟着你要拓展的协议的名字。在拓展的括号范围内，你定义了协议所有的额外成员。

与协议自身相比，定义一个协议拓展最大的不同在于，*拓展包含了成员的具体实现*。在上面的例子中，你定义一个新的计算属性，这个计算属性将 wins 与 losses相加来返回总共的游戏局数。

虽然你还没有为一个接受协议的具体类型来编写代码，但是你可以在拓展中使用协议的中的成员。因为编译器知道任何遵守TeamRecord协议的类型，都会有TeamRecord种的所有成员。

现在你可以编写一个遵守TeamRecord协议的简单类型,并且不需要实现就可以使用 ganmePlayed 属性。

```
struct BaseBallRecord : TeamRecord {
	var wins : Int 
	var losses : Int 
	
	func winningPercentage() -> Double {
		return Double(wins) / (Double(wins) + Double(losses))
	}
}

let record = BaseBallRecord(wins : 5 ,losses : 10)
record.gamePlayed // 15
```

当BaseBallRecord遵循TeamRecord协议之后，你就可以使用在协议拓展中定义的gamePlayed属性了。
你可以看到协议拓展在协议中定义一个"免费"的行为是多么的实用，这还仅仅是一个开始。接下来，你将会学到协议拓展可以为协议自身的成员提供实现。

## Default Implementations

协议是为遵循它的任意类型定义一个约定的途径。如果协议中定义了一个方法或者一个属性，任何遵循协议的类型都必须实现该方法或者属性。

请看下面两个TeamRecord类型的例子:

```
protocol TeamRecord {
  var wins: Int { get }
  var losses: Int { get }
  func winningPercentage() -> Double
} 

struct BaseballRecord : TeamRecord {
	var wins : Int
	var losses : Int
	let seasonLength = 162
	
	func winningPercentage() -> Double{
		return Doubel(wins) / (Double(wins) + Doubel(losses))
	}
}

struct BasketballRecord : TeamRecord {
	var wins : Int
	var losses : Int
	let seasonLength = 82
	
	func winningPercentage() -> Doubel {
		return Doubel(wins) / (Doubel(wins) + Doubel(losses))
	}
}
```

这两个TeamRecord类型的winningPercentage()方法的实现是一样的。你可以想象一下如果有很多的类型来同样的实现这个方法。那将会是大量的重复代码。

还好,Swift有一个解决办法:

```
protocol TeamRecord {
  var wins: Int { get }
  var losses: Int { get }
  func winningPercentage() -> Double
} 

extension TeamRecord {
	func winningPercentage() -> Double{		return Doubel(wins) / (Doubel(wins) + Doubel(losses))
	}
}

```

虽然很像在之前例子里定义的协议拓展，不同的是*winningPercentage()*是TeamRecord协议的一个成员。通过在协议的拓展中实现协议的成员，你为该成员创建了默认实现(default implementation)。

这与函数的默认参数类似:如果你在你的类型中不实现 winningPercentage() 方法，然后它将会使用你在协议拓展中提供的默认实现。

换句话来说，你再也不需要在遵循TeamRecord协议的类型中指定winningPercentage()方法的实现了。

```
struct BaseballRecord: TeamRecord {
	var wins : Int
	var losses : Int
	let seasonLength = 162
}

struct BasketballRecord: TeamRecord {
	var wins : Int
	var losses : Int
	let seasonLength = 82
}
```

默认实现可以让你在添加协议的时候可以减少很多重复的样版代码。从名字你可以猜到，默认实现并不会阻止一个类型自己实现协议的成员。一些团队记录可能要求用稍微不同的共识来计算胜率，比如在体育运动中包括平局也是可能的结果。

```
struct HockeyRecord: TeamRecord {
	var wins : Int
	var losses : Int
	var ties : Int
	
	func winningPercentage() -> Double {
		return Double(wins) / (Double(wins) + Double(losses) + Double(ties))
	}
}
```

现在，如果你调用HockeyRecord类型的 winningPercentage()方法，它会用wins,losses,ties来计算胜率。如果你使用其他没有自己实现winningPercentage()方法的类型，它就会使用默认实现。

```
let baseballRecord : TeamRecord = BaseballRecord(wins : 10, losses: 6)
let hockeyRecord : TeamRecord = HockeyRecord(wins : 8, losses : 7, ties : 1)
baseballRecord.winnintPercentage() //10/(10+6) == 0.625
hockeyRecord.winningPercentage()  //8/(8+7+1) == 0.5

```

## Understanding protocol extension dispatching 



## Type constraints 


