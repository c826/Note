# Swift -- Protocol-Oriented Language

Apple在WWDC2015上发布Swift 2，并宣称其将是 "**protocol-oriented programming language**" 。这个声明因为新添加的"**protocol extension**"特性而变得可能。

虽然protocol在很早的时候就应用在Swift中，这次声明以及Apple在标准库中大量使用protocol的修改，会改变我们看到类型的方式。

简单来说，*protocol-oriented programming*强调编写协议，而不是特定的类、结构体或者枚举类型。它打破了从前协议的规则并且允许你能在协议中为其编写协议的实现。

## Protocol Extension

Extension 可以让你为任意类型添加额外的计算属性与方法。

```Swift
extension String {
	func shout(){
		print (self.uppercaseString)
	}
}
```

上面这段代码拓展了String类型，并为其添加了一个额外的方法。你可以拓展系统中的任意类型，包括某些并不是由你编写的类型，并且在一个类型上可以拥有任意数量的拓展。

你可以像下面这段代码一样定义一个 protocol extension:

```Swift
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

```Swift
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

```Swift
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

```Swift
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

```Swift
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

```Swift
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

```Swift
let baseballRecord : TeamRecord = BaseballRecord(wins : 10, losses: 6)
let hockeyRecord : TeamRecord = HockeyRecord(wins : 8, losses : 7, ties : 1)
baseballRecord.winnintPercentage() //10/(10+6) == 0.625
hockeyRecord.winningPercentage()  //8/(8+7+1) == 0.5

```

## Understanding protocol extension dispatching 

当你定义一个协议拓展时，有一个重要的点你需要明白。如果一个类型重新声明了在拓展中定义的方法或者属性，那么这个方法或者属性调用的时候是根据上下文的类型声明来决定的。

下面在BaseballRecord中重新定义ganmePlayed属性：

```Swift
struct BaseballRecord : TeamRecord {
	var wins : Int
	var losses : Int
	var gamePlayed = 152
	
	func winningPercentage() -> Doubel {
		return Doubel(wins) / (Doubel(wins) + Doubel(losses))		}
}
```

变量调用的实现会根据上下文来决定：

```Swift
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

```Swift
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

```Swift
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

```Swift
protocol Tieble {	
	var ties: Int {get}
}
```

使用类型约束，你可以为同时遵守TeamRecord与Tieable的指定类型创建winningPercentage()的默认实现。

```Swift
extension TeamRecord where Self : Tieable {
	func winningPercentage() -> Double{
		return Double(wins) / (Double(wins) + Double(losses) + Double(ties))
	}
}
```

现在HockeyRecord或者其他任何同事遵循TeamRecord和Tieable协议的类型，都不需要来指定实现有ties属性的winningPercentage()方法。

```Swift
struck HockeyRecord : TeamRecord , Tieable {
	var wins : Int
	var losses : Int
	var ties : Int
}

let hockey : TeamRecord = HockeyRecord(wins: 8, losses: 7, ties: 1)
hockey.winningPercentage() // 0.5

```

你可以看到协议拓展和类型约束的组合，你可以为许多指定情况提供默认实现。

# Protocol-Oriented Benefits

你已经看到了许多协议拓展的优势了，但是*面向协议编程*的的优势又在哪里呢？

## Programming to interfaces, not implementations 

通过专注与协议而不是实现，你可以让代码约定适用于任何类型即使这些类不支持继承。

假设你要实现一个TeamRecord的基类:

```Swift
class TeamRecord {
	var wins : Int
	var losses : Int
	
	func winningPercentage() -> Double {
		return Doubel(wins) / (Doubel(wins) + Doubel(losses))
	}
	
}

struct BaseballRecord : TeamRecord {
	//无法通过编译
	//只有类才能继承TeamRecord
}
```

在这一点上，在使用TeamRecord的时候你只能使用类。

同样的，如果你想要添加ties属性，你必须添加ties到你的子类中去：

```Swift
class HockeyRecord : TeamRecord {
	var ties : Int
	
	override func winningPercentage() -> Doubel {
		return Double(wins) / (Double(wins) + Double(losses) + Double(ties))
	}
}

```
Or you'd have to create yet another base class and thus deepen your class hierarchy: 

或者你可以创建另一个基类兵器加深了你的类的继承体系:

```Swift
class TieableRecord : TeamRecord {
	var ties : Int
	
	override func winningPercentage() -> Double {
		return Double(wins) / (Double(wins) + Double(losses) + Double(ties))
	}
}

class HockeyRecord : TieableRecord {

}

```

同样的，如果你想要使用有wins、losses、ties属性的records，你需要给基类添加代码：

```Swift
extension TieableRecord {
	func TotalPoints () -> Int {
		return (2*wins) + (1*ties)
	}
}
```
这样迫使你去编写实现而不是接口。如果你想要比较两个队伍的record，你所需要关心的是wins和losses。但是使用class，你需要在定义了wins和losses的指定基类上操作。

我相信你肯定不愿听到如果你突然需要在某些运动上面支持分开wins和losses会发生什么。

使用协议，你不需要担心指定的类型甚至这个类型是个类或者结构体。所有你需要关心的只是确实存在的公共属性与方法。

## Traits, mixins and multiple inheritance 

说到对某些一次性功能的支持，比如区分胜利和失败，协议的一个真正好处在于它允许某些形式的多重继承。

当新建一个类型，你可以使用协议来为其添加所有你想要的独特的特征。

```Swift
protocol TieableRecord{
	var ties : Int {get}
}

protocol DivisionalRecord{
	var divisionalWins : Int {get}
	var divisionalLosses : Int {get}
}

protocol PointableRecord {
	func totalPoints() -> Int
}

extension PointableRecord where Self : TieableRecord , TeamRecord{
	func totalPoints() -> Int {
		return (2*wins) + (1*losses)
	}
}

struct HockeyRecord : TeamRecord , TieableRecord , DivisionalRecord , Equatable {
	var wins : Int
	var losses : Int
	var ties : Int
	var divisionalWins : Int
	var divisionalLosses : Int
	
	func == (lhs : HockeyRecord , rhs : HockeyRecord)() -> Bool{
		return lhs.wins == rhs.wins &&
				lhs.losses == rhs.losses &&
				lhs.ties == rhs.ties
	}
}

```

这个HockeyRecord是一个TeamRecord类型，同样它也是个TieableRecord类型，它可能追踪分开的wins和losses，可通过 == 来比较。

当你这样使用协议的时候，通常被称为*混合(minxins)*或者*特性(traits)*。这些术语说明你可以为一个类型添加协议，这样他们之间不会互相依赖。

* 混合(Mixin) : 一个协议像Equable或者CustomStringVonvertible等，为类定义了额外的特性，但是没有包含任何代码或者实现

*	特性(traits) : 一个为类型添加了"免费"方法的协议。上面Pointable协议就是一个例子。因为你提供了计算totalPoints的能力，仅仅让HockeyRecord遵循Pointable协议。

一个类型可以接受了行为数量是不限的。这种方式可以将你的类型用协议来分成小块来定义逻辑。

## Simplicity

当你编写一个方法来计算胜率的时候，你只需要wins,losses,ties属性。当你编写代码来输出一个人的全名时，你只需要姓和名。

如果你要在一个更加复杂的对象上完成这些任务时，与不相关的代码连接在一起会很容易出错。

```Swift
	func winningPercentage() -> Double {
		var percentage = Double(wins) / (Double(wins) + Double(losses))
		//不相关的代码
		self.above500 = percentage > 0.500 
		return percentage
	}
```

这个above500属性可能在板球中会需要，但是不是在曲棍球中。然而，这样会让这个方法变成具体的特定运动。你可以看到这个方法的协议拓展有多简单：它只需要处理一次计算。拥有简单的默认实现可以让你在你的类型中在一个地方使用公共代码。

你不需要知道遵循协议的类型是一个HockeyRecord类型，或者StudentAthlete类型，或者是一个类、结构体或者枚举。因为在协议拓展中的代码只操作协议本身，任何遵循这个协议的类型都会遵循你的代码。

你会在你的代码生涯中一次又一次的发现，越简单的代码就代表着越少的Bug。

# Why Swift is a protocol-oriented language 

你已经知道了协议与协议拓展的作用了，但是你可能会想知道：Swift是一个面向协议的语言到底意味着什么？

协议拓展极大的影响了你编写容易理解并且耦合性低的代码，并且协议拓展启用了很多设计模式这些都映射在Swift语言当中。

首先，你可以对比面向协议编程与面向对象编程。后者专注于对象的设计与对象的相互作用，所以类是任何面向对象语言的中心。

虽然类也是Swift的一部分，你会发现在标准库中类只是非常小的一个部分。相反，Swift的主要是由结构体和协议的集合构成。

* Classes: 6 
* Enum: 8 
* Structs: 103 
* Protocol: 86 

你在许多Swift的核心类型中可以看到这个意义，比如 Int和Array。思考一下下面Array的定义

```Swift
public struct Array<Element> : CollectionType, Indexable, SequenceType,
MutableCollectionType, MutableIndexable, _DestructorSafeContainer {
	// ... 
} 
```
可以看出来：

1. Array是结构体
2. Array遵循很多协议

Array实际上是结构体意味着它是值类型，当然也意味着它不能被继承也不能是子类。与上面的第二点相联系，Array接受协议来定义许多常见的功能，而不是通过继承自公共基类的行为。

为什么这是有意义的？它允许Swift为Array添加许多公共的Swift行为。比如，Dictionary和Array都遵循CollectionType协议，但是只有Array遵循MutableInedable协议，以为这它有startIndex和endIndex属性。在另一方面，Dictionary遵循DictionaryLiteralConvertible协议意味着它有键值对。

这些添加的定义行为允许Array和Dictionary在某些方面相似并且在另一些方面不同。如果Swift使用子类，那Dictionary和Array要么使用同一个基类要么就是完全不同。使用协议和协议拓展，你可以把他们都当成CollectionType来对待。

以协议为中心的设计，而不是以指定的类，结构体或者枚举为中心，你的代码立即变得更加简洁和低耦合性，因为方法使用很多类型而不是指定的类型。你的代码也会更加具有衔接性，因为操作都是在你正要拓展的协议与协议的约束中的属性和方法上进行的，忽略了任何遵循该协议的类型的内部实现。

理解面向协议编程是帮助你变成一个更好的Swift开发者的强力技能，并且让你有一个新思路来思考如何来设计你的代码。

>Note: 很多的中立Swift开发者会称Swift为"多范式"语言。你已经理解继承和面向对象技术和现在的面向协议编程。Swift将会全部支持这些特性！

# Key points 

* *协议拓展(Protocol extensions)*让你可以为协议编写实现代码，甚至可以为协议要求的方法编写默认实现。

* 协议拓展是*面向协议编程*的主要驱动力，并且可以让你编写的代码可以作用于遵循协议的任意类型。

* 协议拓展的*类型约束(Type constraints)*提供了额外的场景并且可以让你编写更多的指定实现。
• You can decorate a type with traits and mixins to extend behavior without requiring inheritance. 
* 你可以使用*特性(traits)*与*混合(mixins)*不需要通过继承,就能为一个类型增加额外的行为。


以上内容源自[Ray Wenderlich](https://www.raywenderlich.com/store/swift-apprentice)




















