>最近在集成一个C++写的音乐播放器，而这个播放器又是由四个模块组成的，我们又需要将他们编译成静态库放入项目中进行调试，所以这边用到了子库依赖。

我想了一个有趣的例子，大体有这四个部分是：
>1、周杰伦为《淘汰》作曲
>2、林夕为《淘宝》写词
>3、陈奕迅演唱歌曲《淘汰》
>4、我有一个索尼mp3播放器
>5、播放器播放《淘汰》

状态5 播放《淘汰》和3、4条件紧密相关的，而条件3又是和1、2条件关联的。其中5发生在主项目，而 1、2、3、4则是子库，下面开始具体说明。

####1、创建项目
首先我们先创建一个主项目
>DependencyLibraryDemo

 ![项目 DependencyLibraryDemo](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_2.png?raw=true)


创建四个framework子项目 
>ZhouJielunLib
>LinXiLib
>ChenEasonLib
>SonyMp3PlayerLib

 ![子项目](https://raw.githubusercontent.com/Jupengpeng/ImagesResourse/master/DependencyLibraryDemo_sourse/lib_1.png)

####2、加入子项目
从主项目工程中中添加子项目工程文件
 ![步骤1](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_3.png?raw=true)
 ![步骤2](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_4.png?raw=true)
####3、子项目方法映射
周杰伦的方法：
```
- (BOOL)WritingSongOfTaoTai;

```
林夕的方法：
```
- (BOOL)WritingLyricsOfTaoTai;
```
根据需求，陈奕迅演唱《淘汰》这俩条件缺一不可，所以：
```

- (BOOL)singASongCalledTaoTai{    
    ZhouJielunObject *zhou = [[ZhouJielunObject alloc] init];
    _songWrited =[zhou WritingSongOfTaoTai];
  
    LinXiObject *lin = [[LinXiObject alloc] init];
    _lyricWrited = [lin WritingLyricsOfTaoTai];
      
    if (_songWrited && _lyricWrited) {
        NSLog(@"陈奕迅演唱了《淘汰》");
        return YES;
    }else{
        return NO;
    }
}
```
这个时候要映射周杰伦和林夕的两个方法，需要在陈奕迅的工程里加入周杰伦和林夕的头文件，如图所示：

 ![添加头文件](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_5.png?raw=true)

为了映射成功，根据framework编译原则，我们把头文件暴露出来出来：
 ![头文件操作](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_6.png?raw=true)
然后加入依赖库
 ![加入依赖库](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_7.png?raw=true)
 ![加入依赖库](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_12.png?raw=true)

其他的子项目也把头文件 Move to republic group 
####4、主项目工程操作
首先添加两个依赖库，分别为ChenEasonLib.framework和SonyMp3PlayerLib.framework
 ![依赖库添加](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_8.png?raw=true)

然后导入头文件
```
#import <ChenEasonLib/ChenEasonLib.h>
#import <SonyMp3PlayerLib/SonyMp3PlayerLib.h>
```
陈奕迅唱《淘汰》和我有个索尼播放器是播放《淘汰》的必要条件
```
   ChenEasonObject *chen = [[ChenEasonObject alloc] init];
    _songHasBeenSung = [chen singASongCalledTaoTai];
    
    SonyMp3Player *player= [[SonyMp3Player alloc] init];
    _havePlayer = [player isMyPlayer];

    if (_havePlayer && _songHasBeenSung) {
        
        NSLog(@"播放器播放《淘汰》了");
    }
```
####5、项目运行以及环境介绍

控制台结果：
 ![运行结果](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_9.png?raw=true)


当前状态我是运行在模拟器上的，没有问题
#####但是当我运行在真机时，程序崩溃了

 ![运行崩溃](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_10.png?raw=true)

这个时候需要 点击Target ——> Build Phases ——> New Copy File Phase ，加入四个.framework
 ![添加 copy files](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_11.png?raw=true)
 ![添加结果](https://github.com/Jupengpeng/ImagesResourse/blob/master/DependencyLibraryDemo_sourse/lib_13.png?raw=true)

##### 如有问题请指教，欢迎下载 [Demo ](https://github.com/Jupengpeng/DependencyLibraryDemo.git)
