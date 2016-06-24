# Core Data

你使用Core Data 在你的程序中来管理模型对象(MVC)。Core Data是一个面向对象的、持续的框架。除此之外，它

* 允许你高效的从持久化存储中查询模型对象并且修改后保存到存储中。
* 提供基础的模型对象修改追踪。它自动支持撤销和返回，并且维持对象之间的相应关系。
* 允许你编辑你的模型对象时保持独立，如果你想要保持独立非常有用，例如，当你在在这个视图汇总修改并且不影响数据展现在另一个视图上。
* 允许你任何时候在内存中保持你模型对象的子集。这个有效的你的程序内存保持尽可能低的占用。
* 拥有基本的数据存储版本控制和迁徙。这个基础功能让你更容易将老版本的数据文件更新到现有版本。

为了支持这个功能，Core Data 使用叫做 *管理对象模型* (managed object model)的模式来描述你应用程序中的实体。

# Core Data stack

Core Data 栈是由以下这些对象组成的：一个或者更多_管理对象上下文_(managed object context)连接到一个依次连接到一个或者更多_持久化存储_对象的单独的_持久化存储助理_。栈中包含了所有Core Data 中你需要查找、创建和熟练使用的管理对象。它最少包含：

* 一个包含保存记录的外部_持久化存储_

* 一个映射你程序中存储与对象之间关系的_持久化对象存储_

* 一个聚集所有存储的_持久化存储助理_

* 一个描述存储中实体的_管理对象模型_

* 一个提供缓存区给管理模型的_管理对象上下文_ 

  ​
![single_persistent_stack-2](media/single_persistent_stack-2.jpg)

  ​



栈由每个栈有且仅有一个的_持久化存储助理_ (persistent store coordinator)来有效的定义。创建一个新的持久化存储助理意味着创建一个新的栈。因此，这里只有一个模型，虽然它可能由多个模型聚集而成。因此可能有多个存储，多个对象存储以及多个管理对象上下文。

管理对象上下文通常直接与持久化存储助理连接，但是可能连接到另一个父子关系的上下文。



# Managed object

管理对象(managed object)是展现持久化存储(persistent store)中记录的模型对象。管理对象是 _NSManagedObject_类或者 _NSManagedObject_子类的实例。管理对象在管理对象上下文(managed object context)中注册。在任何给定的上下文中，最多只有一个管理对象的实例与持久化存储中的记录相对应。

![mapping_moc_record](media/mapping_moc_record.jpg)


管理对象告诉实体描述对象实体展现什么。这样，_NSManagedObject_ 可以表示任何实体，你不需要一个实体的子类。如果你想要实现自定义行为才使用子类，例如计算导出的属性值或者实现确认的逻辑。



# Managed object context

管理对象上下文(managed object context)在Core Data应用程序中展现一个单独对象的空间，或者缓存空间。管理对象上下文是 _NSManagedObjectContext_ 类的实例。它主要的职责就是管理_管理对象_（managed object）的集合。这些管理对象展现一个或多个持久化存储的内部一致性视图。上下文非常强大，在管理对象的声明周期中是一个中心角色，用于管理生命周期中的管理确认，翻转关系处理，以及撤销和重做。

从你的角度来看，上下文在Core Data栈中是一个中心对象。它是你用来创建和查找管理对象，和管理撤销与重做操作的对象。在给定的上下文中，最多只有一个管理对象用来呈现任何给定的持久化存储中的记录。 

![mapping_moc_record](media/mapping_moc_record-1.jpg)



上下文连接到父对象存储。这个父对象存储一般是持久化存储助理，但也可能是另一个上下文。当你查询对象的时候，上下文询问他的父对象存储来返回满足查询条件的对象。你对管理对象所作的修改在你保存上下文之前不会存储到父对象存储中去。

在一些程序中，你可能只有一个单独的上下文。在其他的应用程序中，你可能会拥有多过一个的上下文。你可能想要维护管理对象的分散集合并且想要编辑这些对象。或者你想要用一个上下文执行后台操作，当用户在使用另一个上下文的时候。



# Persistent store coordinator

一个持久化存储助理(persistent store coordinator)关联着持久化对象存储(persistent object stores) 管理着对象模型(object model)，并且为管理对象上下文(manageed object contexts)呈现一个界面,比如把一组持久化存储(persistent stores) 显示作为一个单独的聚合存储。一个持久化存储助理(persitent store coordinator)是	_NSPersistentStoreCoordinator_ 类的一个实例。 它引用一个描述实体存储与管理的对象模型(object model)。

这个助理在 Core Data Stack 中是一个中心对象。在很多应用程序中你只有一个单独的存储,但是在复杂的应用程序中可能有几个，每个都包含着不同的实体。持久化存储助理扮演的角色是管理这些存储(store)并且展现给管理对象上下文(managed object context)一个统一的存储。当你查找记录时，Core Data在所有的存储中查找结构,除非你指定你需要查找的存储。

![advanced_persistent_stack](media/advanced_persistent_stack.jpg)




# Fetch request

查询请求(fetch request)告诉管理对象上下文你想要查询的管理对象实体。可选的，它指定了其他方面，比如对象属性规定的值必须要有和你想要排序返回的对象。查询对象(fetch request)是 _NSFetchRequestF_ 类的一个实例。它指定的实体由_NSEntityDescription_类的实例来展现的，任何参数限定由_NSPredicate_ 对象展现，排序由一个或多个_NSSortDescription_ 实例数组展现。这些类似于一个表名，WHERE从句和ORDER BY从句由数据库SELECT分开进行。

你发送消息给管理对象上下文(managed object context)来执行查询请求。上下文返回一个包含匹配请求的对象的数组。 

![fetch_flow_of_data](media/fetch_flow_of_data.jpg)



# Persistent Store

持久化存储(persistent store)是用来存储需要存储的管理对象(managed context)的仓库。你可以认为持久化存储是一个每条记录都保存着管理对象最后保存的值的数据库文件。Core Data 提供三种类型的持久化存储：二进制、XML、SQLite。如果你想Core Data可以支持自定义的文件格式或服务，你可以实现你自己的存储类型。Core Data还提供一种内存存储，这种内存存储会在程序结束时消失。

存储中的实体是由管理对象模型(managed object model)定义并创建的。如果你在你的程序中修改了模型，那么你将无法打开任何你用原来模型创建的存储。所以，你必须首先将存储的内容迁移到新的格式中去。



# Managed object model

管理对象模型(managed object model)你在你应用程序中使用的从同一设计图中描述的管理对象的对象集合。模型允许Core Data将持久化存储中的记录映射到你在程序中使用的管理对象。它是实体描述对象(_NSEntityDescription_ 的实例)的集合。实体描述描述了实体(你可以认为是数据库中的表)的名字，这个名字的类用来呈现在你应用程序中的实体，和实体所拥有的属性(标识和关系)。

![single_persistent_stack](media/single_persistent_stack-3.jpg)



# Persistent object store

持久化对象存储(persistent object store)是你应用程序中的对象与持久化存储中的记录的映射。Core Data支持的不同的文件类型有不同的持久化对象存储类。如果你想支持你自定义的文件类型，你同样可以实现自己的持久化对象存储类。

你不是直接创建持久化对象存储，而是，当你发送 _addPersistentStoreWithType:configuration:URL:options:error:消息给持久化存储助理(persistent store coordinator)时，Core Data创建合适类型存储给你。



# Mapping model

Core Data 映射模型描述了从源管理对象模型迁移数据到目标管理对象模型模式的需要的转变。当你创建新版本的管理对象模型时，你需要把持久化存储从旧模式迁移到新模式。关于简单的模型修改，Core Data可以推断出要求的映射(就像描述在Core Data中的模型版本与数据迁移编程指导)。关于复杂的模型修改，你需要自己提供映射模型来描述如何执行迁移。

