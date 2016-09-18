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

当你定义一个协议拓展时，有一个重要的点你需要明白。如果一个类型重新声明了在拓展中定义的方法或者属性，那么这个方法或者属性调用的时候是根据上下文的类型声明来决定的。

下面在BaseballRecord中重新定义ganmePlayed属性：

```
struct BaseballRecord : TeamRecord {
	var wins : Int
	var losses : Int
	var gamePlayed = 152
	
	func winningPercentage() -> Doubel {
		return Doubel(wins) / (Doubel(wins) + Doubel(losses))		}
}
```

变量调用的实现会根据上下文来决定：

```
//创建一个TeamRecord类型
let team1 : TeamRecord = BaseballRecord(wins: 10, losses: 5)
//创建一个BaseballRecord类型
let team2 : BaseballRecord = BaseballRecord(wins: 10, losses: 5)
//调用的是extension中的实现
team1.gamePlayed  //15 
//调用的是BaseballRecord中的实现
team2.gamePlayed	 //152
```

这个结果是因为BaseballRecord并不符合重写gamePlayed属性的条件，并且编译器也没有连接它们。作为拓展本身，gamePlayed属性只是一个计算属性而不是协议的一部分。

如果你在TeamRecord类型上调用,gamePlayed会使用TeamRecord拓展中的实现版本。同样，你如果把类型声明为BaseballRecord类型，则会使用定义在BaseballRecord中的属性。

总结：
1. 若类型为协议，若调用的方法或属性是协议的成员，则会调用指定类的实现。
2. 若类型为协议，若调用的方法或属性不是协议的成员，则会调用拓展中的默认实现。
3. 若类型为指定类，则不管所调用的方法或属性都是协议的成员，都会调用指定类中的实现。


## Type constraints 

TeamRecord的协议拓展中，你可以使用TeamRecord协议中的成员，比如wins和losses属性，winningPercentage()的实现以及gamesPlayed计算属性。很像在结构体，类或者枚举上的拓展，你写的代码就像你在为你要拓展的类编写实例方法一样。

在你写协议的拓展的时候，有一些额外的方面需要考虑:遵循协议的类型可能也是任意数量的其他类型，换一句话来说，当一个类型遵循TeamRecord协议的时候，它可能同样遵循Comparable、CustomStringConvertible、或者其它你写的协议。

Swift可以让你为遵循当前协议并且是还是指定类型的类型编写拓展。通过在协议拓展中使用类型约束(type constraint)，你可以在你的拓展实现中使用来自其他类型的方法和属性。

Example:

```
protocol PlayoffEligible{
	var minimumWinsForPlayoffs: Int {get}
}

extension TeamRecord where Self : PlayoffEligible{
	func isPlayoffEligible() -> Bool {
		return self.wins > self.minimumWinsForPlayoffs
	}
}
```

你有一个新协议，PlayoffEligible,它定义了minimumWinsForPlayoffs属性。在拥有自身遵循PlayoffEligible类型行约束的TeamRecord拓展中，所有的适用这个拓展的类型都遵循TeamRecord协议并且同样遵循PlayoffEligible协议。

TeamRecord拓展的类型约束意味着，在拓展的实现中，自身是TeamRecord类型，同样也是PlayoffEligible类型。这意味着你可以使用这两个类型中定义的方法和属性。

你可以使用类型约束来创建特定类型组合的默认实现。思考一下上面的HockeyRecord类型，它新加了一个ties属性，并且重写了winningPercentage()方法的实现。

```
struct HockeyRecord: TeamRecord {
	var wins : Int
	var losses : Int
	var ties : Int
	//HockeyRecord新加了ties属性
	//重写winningPercentage()的实现
	func winningPercentage() -> Double {
		return Double(wins) / (Double(wins) + Double(losses) + Double(ties))
	}
}
```

平局是个普遍结果不只是在曲棍球中才有，所以你可以把它变成一个协议而不是只在曲棍球类中指定实现。

```
protocol Tieble {	
	var ties: Int {get}
}
```

使用类型约束，你可以为同时遵守TeamRecord与Tieable的指定类型创建winningPercentage()的默认实现。

```
extension TeamRecord where Self : Tieable {
	func winningPercentage() -> Double{
		return Double(wins) / (Double(wins) + Double(losses) + Double(ties))
	}
}
```

现在HockeyRecord或者其他任何同事遵循TeamRecord和Tieable协议的类型，都不需要来指定实现有ties属性的winningPercentage()方法。

```
struck HockeyRecord : TeamRecord , Tieable {
	var wins : Int
	var losses : Int
	var ties : Int
}

let hockey : TeamRecord = HockeyRecord(wins: 8, losses: 7, ties: 1)
hockey.winningPercentage() // 0.5

```

你可以看到协议拓展和类型约束的组合，你可以为许多指定情况提供默认实现。

















