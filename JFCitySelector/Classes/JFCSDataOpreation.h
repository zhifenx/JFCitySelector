//
//  JFCSDataOpreation.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/10.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JFCSData;
@class JFCSProvince;
@class JFCSCity;
@class JFCSArea;
@class JFCSBaseInfoModel;
@class JFCSConfiguration;
@class JFCSPopularCitiesModel;

NS_ASSUME_NONNULL_BEGIN

@interface JFCSDataOpreation : NSObject

/**
 初始化 需传入JFCSConfiguration的对象

 @param config config
 @return JFCSDataOpreation实例
 */
- (instancetype)initWithConfiguration:(JFCSConfiguration *)config;

/**
 省市县三级城市数据
 */
@property (nonatomic, strong, readonly) JFCSData *data;

/**
 热门城市，可通过JFCSConfiguration进行自定义
 */
@property (nonatomic, strong, readonly) NSMutableArray <JFCSPopularCitiesModel *>*popularCitiesMutaleArray;

/**
 省份名字包含的首字母
 */
@property (nonatomic, strong) NSArray <NSString *>*firstLetterArraryOfProvince;

/**
 城市名字包含的首字母
 */
@property (nonatomic, strong) NSArray <NSString *>*firstLetterArraryOfCity;

/**
 县区名字包含的首字母
 */
@property (nonatomic, strong) NSArray <NSString *>*firstLetterArraryOfArea;

/**
 所有名称包含的首字母
 */
@property (nonatomic, strong) NSArray <NSString *>*firstLetterArraryOfAllCities;

/**
 市县包含的首字母
 */
@property (nonatomic, strong) NSArray <NSString *>*firstLetterArraryOfCityOrArea;

/**
 所有省份数据

 @param block 数据回调
 */
- (void)provinces:(void(^)(NSArray <JFCSProvince *> *provinces))block;

/**
 所有市区数据
 
 @param block 数据回调
 */
- (void)cities:(void(^)(NSArray <JFCSCity *> *cities))block;

/**
 所有县城数据
 
 @param block 数据回调
 */
- (void)areas:(void(^)(NSArray <JFCSArea *> *areas))block;

/**
 市县城市名称

 @param block 数据回调
 */
- (void)cityList:(void(^)(NSArray <JFCSBaseInfoModel *> *cities))block;

/**
 按首字母分组的市县数据

 @param block 数据回调
 */
- (void)arrayOfCityAndArea:(void(^)(NSMutableArray *data))block;

#pragma mark -- 通过code查询城市model

- (JFCSProvince *)getProvinceWithCode:(NSInteger)code;

- (JFCSCity *)getCityWithCode:(NSInteger)code;

- (JFCSArea *)getAreaWithCode:(NSInteger)code;

#pragma mark -- 通过name查询城市model

- (JFCSProvince *)getProvinceWithName:(NSString *)name;

- (JFCSCity *)getCityWithName:(NSString *)name;

- (JFCSArea *)getAreaWithName:(NSString *)name;

#pragma mark -- 模糊查找

/**
 通过汉字或者pinyin搜索城市 是否开启拼音搜索通过 配置 JFCSConfiguration

 @param keyword 关键字
 @param result 结果
 */
- (void)searchWithKeyword:(NSString *)keyword resultBlock:(void(^)(NSArray <JFCSBaseInfoModel *>*dataArray))result;

/**
 通过汉字或者pinyin搜索省份

 @param string 关键字
 @return 结果
 */
- (NSArray <JFCSProvince *>*)searchProvinceWithString:(NSString *)string;

/**
 通过汉字或者pinyin搜索市区
 
 @param string 关键字
 @return 结果
 */
- (NSArray <JFCSCity *>*)searchCityWithString:(NSString *)string;

/**
 通过汉字或者pinyin搜索县区
 
 @param string 关键字
 @return 结果
 */
- (NSArray <JFCSArea *>*)searchAreaWithString:(NSString *)string;

#pragma mark -- 最近访问的城市 最多存储三个

/**
 添加新的最近访问城市

 @param model JFCSBaseInfoModel实例
 */
- (void)insertHistoryRecordCityModel:(JFCSBaseInfoModel *)model;

/**
 最近访问城市的数组

 @return 数据
 */
- (NSArray<JFCSBaseInfoModel *> *)historyRecordCities;

/**
 存储当前城市

 @param model JFCSBaseInfoModel实例
 */
- (void)cacheCurrentCity:(JFCSBaseInfoModel *)model;

/**
 当前城市

 @return JFCSBaseInfoModel实例
 */
- (JFCSBaseInfoModel *)currentCity;

#pragma mark -- 处理切换区县所需的数据

/**
 1、传入县级城市，则返回该城市所属市下同级的县级城市
 2、传入市级城市，则返回该市下所有的县级城市数据
 3、传入省，返回的则是该省下的所有市数据

 @param model JFCSBaseInfoModel实例
 @param block 县级城市数据
 */
- (void)otherCitiesWithCityModel:(JFCSBaseInfoModel *)model resultArray:(void(^)(NSArray <JFCSBaseInfoModel *>* dataArray))block;

@end

NS_ASSUME_NONNULL_END
