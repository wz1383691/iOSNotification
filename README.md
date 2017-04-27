### iOS仿制通知中心 

#### 一.什么是通知机制
iOS提供一种通知机制来在实现不同对象之间一对多和跨层的通信，发送消息和接收消息的两个对象之间是完全解耦的，这是设计模式中的观察者模式的应用，系统也提供了大量的系统级通知来方便我们使用。<br>

举个例子来说，需要接收消息的对象是我们广播的听众，而发送消息的对象就像是广播的主持人，而iOS提供的NSNotificationCenter就像是广播电台，听众不需要去找具体的主持人，只需要收听某个频道就可以接收到了消息了，通知的发送者和接收者是一个一对多的关系。如下图:<br>
![](http://i2.muimg.com/567571/33d851a7dc5033e1.png)

#### 二.使用方法：

* 1.使用[NSNotificationCenter defaultCenter]获取到通知中心，他是单例的，可以管理整个app的通知。
* 2.消息接收者也就是我们的听众调用方法注册为某个频道的接收者，相当于我们把收音机调整到某个频道。
```
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString*)aName object:(nullable id)anObject;
```
这个方法接受四个参数：observer：指定通知的观察者，aSelector：处理通知的方法，aName：通知名（相当于频道），anObject：被观察的对象。<br>
obserber，aSelector不能为nil，aName为空和anObject都为空时监听所有频道的通知包括系统通知，aName为空anObject不为空时监听anObject对象的所有通知，anObject为空aName不为空时监听所有aNamed匹配的通知。

* 3.发送通知，电台的主持人开始广播了
```
- (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;
```
发送方法接收三个参数：aName和之前的接收方法的aName对应，频道对应上，anObject那个对象发出的通知，aUserInfo传递的数据。

* 4.观察者的移除，使用通知需要注意的地方就是那个对象注册了通知以后在对象销毁的时候要记得移除自己注册的通知，这一点我们会在后面需要注意的地方详细讲。

#### 三.仿制通知机制中心
通知内部肯定是维护了一个存储所有已经注册了通知的对象集合，当有人发送通知的时候根据发送通知的name来遍历对象集合，查找出注册这个通知的接收者然后调用接收者的处理方法。下面我们来动手实现 :<br>
首先我们创建通知中心类WZNotificationCenter,该类用来管理我们的通知，提供注册通知的方法和发送通知的方法.
然后我们创建通知类WZNotification，最后创建观察者模型WZObserverModel，模型用来存储每一个观察者，具体实现见代码。

####  四.通知需要注意的地方

前面我们说到了通知一定要移除，这句话其实对也不对，因为在iOS9之前观察者注册时，通知中心并不会对观察者对象做retain操作，而是对观察者对象进行unsafe_unretained引用，unsafe_unretained和weak作用类似，都是生命对一个对象的不强制引用，不会增加对象的引用计数，当观察者被释放以后，unsafe_unretained并不会被自动被置为nil，通知中心包含的这个观察者就变成了野指针，当通知中心接收到通知向野指针发送消息的时候，程序就会崩溃，这就是我们之前说的为什么要移除通知。
在iOS9之后通知中心会对观察者进行弱引用，观察者被释放以后通知中心的观察者会被置nil。向nil发送消息是不会崩溃的，具体的weak的实现原理可以去查阅相关的文档，这里我们就不展开了。

