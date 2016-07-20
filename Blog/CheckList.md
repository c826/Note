#### 代码规范

####风格就错题

``` objective-c
typedef enum{
	 UserSex_Man,
	 UserSex_Woman
}UserSex;

@interface UserMOdel :NsObject

@property(nonatomic, strong)NSString *name;
@property (assign, nonatomic) int age;
@property (nonatomic, assign) UserSex sex;

-(id)initUserModelWithUserName: (NSString *)name withAge:(int)age;

-(void)doLogIn;

@end
```

修改

```
typedef NS_ENUM(NSInteger, UserSex ){
    UserSex_Man ,
    UserSex_Woman,
};

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) UserSex sex;

- (id)initUserModelWithUserName:(NSString *)name withAge:(int)age;

- (void)doLogIn;


@end
```

#####1. @property 后面可以有哪些修饰符?

nonatomic,atomic                 原子性修饰符
assign,retain,copy,strong,weak   内存修饰符
readOnly,readWrite               读写权限修饰符


#####2.什么情况使用weak关键字,相比assign有什么不同？

>使用：
>1.在ARC中,在有可能出现循环引用的时候，往往要通过让其中一端使用weak来解决，比如：delegate代理属性
>2.自身已经对它进行了强引用，没有必要再强引用一次，此时也会使用weak。如自定义 IBOutlet控件属性
>不同点:
>weak 表明该属性是一种 "非拥有关系"。为这种属性设置新值时，设置方法既不保留新值，也不释放旧值。与assign类似，但是在属性所指像的对象被销毁时，属性值会被至为nil。assign不会。
>weak只能修饰OC对象

#####3.怎么用copy关键字


######4.这个写法会出什么问题： @property (copy) NSMutableArray *array;
修改array属性，并不会对array指向的内容作出修改。

#####5.如何让自己的类用copy修饰符?如何重写带copy关键字的setter?

```
-(void)setxxx:(id)xxx{
		[_xxx release];
		_xxx = [xxx copy];
}

```
#####@property的本质是什么? ivar、getter、setter是如何生成并添加到这个类中的?

#####@protocol 和 category 中如何使用 @property ?

#####runtime 如何实现weak属性

