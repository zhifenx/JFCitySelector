# JFCitySelector

*	几行代码即可将集三级城市选择、定位、搜索和字母索引于一身的城市选择器集成到你的项目中，极其简单轻便！

### JFCitySelector效果展示：
![JFCitySelector效果展示.gif](http://upload-images.jianshu.io/upload_images/1707533-1da6dc92b57bdcf0.gif?imageMogr2/auto-orient/strip)

### JFCitySelector使用方法：

*  下载[JFCitySelector](https://github.com/zhifenx/JFCitySelector)，将Demo中的**JFCityViewController**文件夹拖到你的项目中。

*  引入头文件

```
#import "JFCityViewController.h"
```

*  实例化**JFCityViewController**
*  遵循**JFCityViewControllerDelegate**
*  实现代理方法

```
- (void)cityName:(NSString *)name;
```

*  修改Info.plist文件

	1、获取定位权限：
	
	```
	Privacy - Location Always Usage Description        类型为	String

	Privacy - Location When In Use Usage Description   类型为	String
	```

	2、本地化（搜索按钮的英文变成中文）：
	
	```
	将Localization native development region   value值改成China
	```


**注意:** 因为此项目使用了[Masonry](https://github.com/SnapKit/Masonry)、[FMDB](https://github.com/ccgus/fmdb),所以需要在你的项目中导入[Masonry](https://github.com/SnapKit/Masonry)、[FMDB](https://github.com/ccgus/fmdb)开源框架，导入方法就不再赘述！

**这样你就完成了JFCitySelector城市选择器的集成工作，仅此而已！**

### Blog：[zhifenx](http://www.jianshu.com/users/aef0f8eebe6d/latest_articles)

### 项目介绍请移步简书：[iOS-（仿美团）城市选择器+自动定位+字母索引](http://www.jianshu.com/p/40bc4b6ddceb)