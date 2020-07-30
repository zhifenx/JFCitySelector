# JFCitySelector


[![Version](https://img.shields.io/cocoapods/v/JFCitySelector.svg?style=flat)](https://cocoapods.org/pods/JFCitySelector)
[![License](https://img.shields.io/cocoapods/l/JFCitySelector.svg?style=flat)](https://cocoapods.org/pods/JFCitySelector)
[![Platform](https://img.shields.io/cocoapods/p/JFCitySelector.svg?style=flat)](https://cocoapods.org/pods/JFCitySelector)

# 简介
[JFCitySelector](https://github.com/zhifenx/JFCitySelector)
是一个轻量、灵活、可自定义的三级城市选择器（City selector、City picker）。
# 特点
*  汉字、拼音搜索
*  首字母索引
*  可自定义热门城市
*  可自定义最近访问
*  可使用提供的UI界面，亦可用提供的数据接口自己实现UI界面。

#  页面展示
![屏幕快照 2019-08-01 下午2.20.22.png](https://upload-images.jianshu.io/upload_images/1707533-c326e7a4e8726dc1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 项目结构
![项目结构.png](https://upload-images.jianshu.io/upload_images/1707533-0cf40b179c67442b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


# 安装
##### CocoaPods安装
*  在 Podfile 中添加 pod 'JFCitySelector'。
*  执行 pod install 或 pod update。
*  导入 JFCitySelector.h。

##### 手动安装
*  下载 JFCitySelector 文件夹内的所有内容。
*  将 JFCitySelector 内的Classes、Resources文件夹添加(拖放)到你的工程。
*  导入 JFCitySelector.h。

##### 系统要求
*  该项目最低支持iOS 8.0

# 具体使用
##### 1、 使用已有的UI `JFCSTableViewController `
*  遵循`JFCSTableViewControllerDelegate`，
*  使用`initWithConfiguration: delegate:`初始化`JFCSTableViewController`;若直接使用 `init`初始化`JFCSTableViewController`,`JFCSConfiguration`则为默认配置。

``` 
//自定义配置...
JFCSConfiguration *config = [[JFCSConfiguration alloc] init];
//关闭拼音搜索
config.isPinyinSearch = NO;
//配置热门城市
config.popularCitiesMutableArray = [self defealtPopularCities];

JFCSTableViewController *vc = [[JFCSTableViewController alloc] initWithConfiguration:config delegate:self];
[self.navigationController pushViewController:vc animated:YES];   

#pragma mark -- JFCSTableViewControllerDelegate

- (void)viewController:(JFCSTableViewController *)viewController didSelectCity:(JFCSBaseInfoModel *)model {
//选择城市后...
NSLog(@"name %@ code %zd pinyin %@ alias %@ firstLetter %@",model.name, model.code, model.pinyin, model.alias, model.firstLetter);
}

//自定义热门城市
- (NSMutableArray <JFCSPopularCitiesModel *> *)defealtPopularCities {
JFCSPopularCitiesModel *bjModel = [[JFCSPopularCitiesModel alloc] initWithName:@"北京" type:JFCSPopularCitiesTypeCity];
JFCSPopularCitiesModel *shModel = [[JFCSPopularCitiesModel alloc] initWithName:@"上海" type:JFCSPopularCitiesTypeCity];
JFCSPopularCitiesModel *gzModel = [[JFCSPopularCitiesModel alloc] initWithName:@"广州" type:JFCSPopularCitiesTypeCity];
JFCSPopularCitiesModel *szModel = [[JFCSPopularCitiesModel alloc] initWithName:@"深圳" type:JFCSPopularCitiesTypeCity];
JFCSPopularCitiesModel *hzModel = [[JFCSPopularCitiesModel alloc] initWithName:@"杭州" type:JFCSPopularCitiesTypeCity];
return [NSMutableArray arrayWithObjects:bjModel, shModel, gzModel, szModel, hzModel, nil];
}
```

##### 2、 使用`JFCSDataOpreation`提供的数据接口，自建UI。
*  使用`initWithConfiguration:`，传入`JFCSConfiguration`实例，初始化`JFCSDataOpreation`

```
JFCSConfiguration *config = [[JFCSConfiguration alloc] init];
config.isPinyinSearch = NO;
//自定义配置...
JFCSDataOpreation *dataOpreation = [[JFCSDataOpreation alloc] initWithConfiguration:config];

[dataOpreation provinces:^(NSArray<JFCSProvince *> * _Nonnull provinces) {
//数据源...
}];

//code...
```

##### 3、注意
*  `JFCSConfiguration `的属性`popularCitiesMutableArray `数组，元素必须是`JFCSPopularCitiesModel `类型；
*  `JFCSPopularCitiesModel `初始化方法：`initWithName: type:`,传入的城市名称必须要和数据源内的name对应上，因为牵扯到城市名称所对应的code，所以在自定义城市前可以先打印所需城市的`JFCSBaseInfoModel `数据；type也必须是`JFCSPopularCitiesType`,分别为`JFCSPopularCitiesTypeProvince`（省级）、`JFCSPopularCitiesTypeCity`（市级）和`JFCSPopularCitiesTypeArea`（县级）。

## 简书
[JFCitySelector轻量、灵活、可自定义的三级城市选择器
](https://www.jianshu.com/p/413db5c2480b)

## 许可证

JFCitySelector  使用 MIT 许可证，详情见 LICENSE 文件。
