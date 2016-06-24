###objc_msgSend:
	id objc_msgSend(id self, SEL op,.....);
	
###SEL
  `SEL`是一个方法选择器，可以用来查找方法。Objc中使用 `@selector()`,runtime 中使用 `sel_registerName` 来获取`SEL`类型的方法选择器。

```
	typedef struct objc_selector *SEL;
```
###id
`id`是一个指向实例的指针

```	
	typedef struck objc_object *id
```

`objc_object` 是一个包换 `isa` 指针的结构体

```	
	struct objc_object { Class isa ;};
```

`isa`不总指向实例对象所属的类

>Key-Value Observing Implementation Details

>Automatic key-value observing is implemented using a technique called isa-swizzling.
>
>The isa pointer, as the name suggests, points to the object's class which maintains a dispatch table. This dispatch table essentially contains pointers to the methods the class implements, among other data.

>When an observer is registered for an attribute of an object the isa pointer of the observed object is modified, pointing to an intermediate class rather than at the true class. As a result the value of the isa pointer does not necessarily reflect the actual class of the instance.

>You should never rely on the isa pointer to determine class membership. Instead, you should use the class method to determine the class of an object instance.

###Class
	typedef struct objc_class *Class
	
`objc_calss`关联了超类指针`super_class`,类名`name`，成员变量`ivar`，方法`methodLists`,缓存`cache`，附属的协议`protocols`等.
	
```	
	struct objc_class {
		Class isa  OBJC_ISA_AVAILABILITY;

	#if !__OBJC2__
		Class super_class										OBJC2_UNAVAILABLE;
		const char *name										 OBJC2_UNAVAILABLE;
		long version											 OBJC2_UNAVAILABLE;
		long info												OBJC2_UNAVAILABLE;
		long instance_size									   OBJC2_UNAVAILABLE;
		struct objc_ivar_list *ivars							 OBJC2_UNAVAILABLE;
		struct objc_method_list **methodLists					OBJC2_UNAVAILABLE;
		struct objc_cache *cache								 OBJC2_UNAVAILABLE;
		struct objc_protocol_list *protocols					 OBJC2_UNAVAILABLE;
	#endif

	} OBJC2_UNAVAILABLE;
```

`objc_ivar_list`是成员变量列表,里面存储着`objc_ivar`数组列表,`objc_ivar`结构体中存储单个成员变量的信息。

```	
	struct objc_ivar_list{
		int ivar_count										OBJC2_UNAVAILABLE; 
	#ifdef __LP64__
		int space											 OBJC2_UNAVAILABLE;
	#endif
		/* variable length structure */
		struct objc_ivar ivar_list[1]						 OBJC2_UNAVAILABLE;
	}														 OBJC2_UNAVAILABLE;
```

`objc_method_list`是方法列表，里面存储着`objc_method`数组列表，`objc_method`结构体中存储着方法的信息。

```	
	struct objc_method_list {
		struct objc_method_list *obsolete						OBJC2_UNAVAILABLE;

		int method_count										 OBJC2_UNAVAILABLE;
	#ifdef __LP64__
		int space												OBJC2_UNAVAILABLE;
	#endif
		/* variable length structure */
		struct objc_method method_list[1]						OBJC2_UNAVAILABLE;
	}
```

###Method
`Method`代表方法的类型

```	
	typedef struct objc_method *Method;
```

`SEL`是方法选择器。存储着方法的名字。同一个方法在不同类中实现，SEL相同。即使方法名字相同参数类型不同SEL一样相同。

`method_types`是一个char类型指针。存储着返回值与参数的类型。

`method_imp`指向了方法的实现。本质上是一个函数指针。

```
	struct objc_method{
		SEL method_name										  OBJC2_UNAVAILABLE;
		char *method_types									   OBJC2_UNAVAILABLE;
		IMP method_imp										   OBJC2_UNAVAILABLE;
	}
```

###Ivar
`Ivar`代表的是类中实例变量的类型。

```	
	typedef struct objc_ivar *Ivar;
```

`objc_ivar`

`ivar_name`存储变量名

`ivar_type`存储变量类型

```
	struct objc_ivar{
		char *ivar_name										  OBJC2_UNAVAILABLE;
		char *ivar_type										  OBJC2_UNAVAILABLE;
		int ivar_offset										  OBJC2_UNAVAILABLE;
	#ifdef __LP64__
		int space											  OBJC2_UNAVAILABLE;
	#endif
	}														  OBJC2_UNAVAILABLE;
```

根据实例查找其在类中的名字

```
	-(NSString *)nameWithInstance:(id)instance{
		unsigned int numIvars = 0;
		NSString *key = nil;
		Ivar *ivars = class_copyIvarList([self class],&numIvars);
		for(int i = 0, i < numIvars , i ++){
			Ivar thisIvar = ivars[i];
			const char *type = ivar_getTypeEncoding(thisIvar);
			NSString *stringType = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
			if(![stringType hasPrefix:@"@"]){
				continue;
			}
			if((object_getIvar(self,thisIvar) == instance)){
				key = [NSString stringWithUTF8String:ivar_getName:(thisIvar)];
				break
			}
		}
		free(ivars);
		return key;
	}
```

`class_copyIvarList`获取类的成员变量列表，不仅仅是成员变量，还包含属性，属性会在原本属性名之前加_。

`ivar_getTypeEncoding`获取实例变量的名字`ivar_name`

###IMP
`IMP`是一个指向方法实现的函数指针。当一个Objc消息发送后，最终会执行哪段代码都是有它来指定的。

```
	typedef id(*IMP)(id,SEL,...);
```
	
###Cache
`Cache`在类方法中充当类似路由表的作用，当一个方法被调用过一次后，就是缓存在Cache中，第二次调用的时候不会直接遍历方法列表，而是优先在Cache中直接查找方法实现。

```	
	typedef struct objc_caceh *Cache;
	
	struct objc_cache {
		unsigned int mask /* total = mask + 1 */						  OBJC2_UNAVAILABLE;
		unsigned int occupied											 OBJC2_UNAVAILABLE;
		Method buckets[1]												 OBJC2_UNAVAILABLE;
```	
		
###Property
`@property`标记了类中的属性，它是一个指向objc_property结构体的指针：

```
	typedef struct objc_property *Property
	typedef struct objc_property *objc_property_t
```
	
`class_copyPropertyList` 与 `protocol_copyPropertyList`方法可用来获取类中或者协议中的属性。
函数的返回值是一个指向指针的指针，返回值是一个指向数组的指针,数组中存储的是`objc_property_t`指针。

```
	objc_property_t *class_copyPropertyList(Class cls,unsigned int *outCount)
	objc_property_t *protocol_copyPropertyList(Protocol *proto , unsigned int *outCount)
```
	
`property_getName`通过属性获取属性名称。

```	
	const char *property_getName(objc_property_t property)
```

`class_getProperty``protocol_getProperty`通过属性名来获取属性

```
	objc_property_t class_getProperty(Class cls, const char *name)
	objc_property_t protocol_getProperty(Protocol *proto , const char * name, BOOL isRequiredProperty, BOOL isInstanceProperty)

```
	
`property_getAttributes`获取属性的名称和`@encode`字符串

```	
	const char *property_getAttributes(objc_property_t property)
```	
	
	
	
	
