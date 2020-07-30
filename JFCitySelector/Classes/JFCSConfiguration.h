//
//  JFCSConfiguration.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class JFCSPopularCitiesModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 数据相关配置

@interface JFCSConfiguration : NSObject

/**
 是否可以拼音搜索，默认 YES
 */
@property (nonatomic, assign) BOOL isPinyinSearch;

/**
 搜索时字母是否区分大小写 默认 NO 不区分大小写
 */
@property (nonatomic, assign) BOOL isLowercaseString;

/**
 关闭热门城市，默认 NO
 */
@property (nonatomic, assign) BOOL hidePopularCities;

/**
 关闭最近访问 默认 NO
 */
@property (nonatomic, assign) BOOL hideHistoricalRecord;

/**
 热门城市，默认 北京、上海、广州、深圳、杭州
 注意：1、name要和本地数据的一致；
 2、type 省级传 JFCSPopularCitiesTypeProvince，市级传 JFCSPopularCitiesTypeCity，县级传 JFCSPopularCitiesTypeArea“
 */
@property (nonatomic, strong) NSMutableArray <JFCSPopularCitiesModel *>*popularCitiesMutableArray;

/**
 默认 ”热门城市”
 */
@property (nonatomic, copy) NSString *popularCitiesTitle;

/**
 热门城市位于Table view 左侧index标识 默认取popularCitiesTitle 的前两个字符，若popularCitiesTitle length < 2 则为”*“
 */
@property (nonatomic, copy) NSString *popularCitiesAbbreviation;

/**
 默认 最近访问
 */
@property (nonatomic, copy) NSString *historicalRecordTitle;


/**
 最近访问位于Table view 左侧index标识 默认取historicalRecordTitle 的前两个字符，若historicalRecordTitle length < 2 则为”#“
 */
@property (nonatomic, copy) NSString *historicalRecordAbbreviation;

/**
 热门城市cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat popularCitiesCellHeight;

/**
 最近访问记录的最大值 默认 3
 */
@property (nonatomic, assign) NSInteger maxHistoricalRecordCount;


#pragma mark - JFCSTableViewController 相关配置

/**
 隐藏区域切换按钮 默认 NO
 */
@property (nonatomic, assign) BOOL hideAreaSwitchButton;

/**
 JFCSTableViewController 顶部 title view 的button
 */
@property (nonatomic, strong) UIButton *searchButton;

/**
 JFCSTableViewController leftBarButtonItem icon
 */
@property (nonatomic, copy) NSString *leftBarButtonItemImageName;

/**
 JFCSTableViewController 顶部searchButton title
 */
@property (nonatomic, copy) NSString *searchButtonTitle;

/**
 JFCSTableViewController 顶部searchButton icon name
 */
@property (nonatomic, copy) NSString *searchButtonImageName;

/**
 JFCSTableViewController 顶部searchButton backgroundColor
 */
@property (nonatomic, strong) UIColor *searchButtonBackgroundColor;

/**
 JFCSTableViewController 顶部searchButton title backgroundColor
 */
@property (nonatomic, strong) UIColor *searchButtonTitleColor;

/**
 JFCSTableViewController 左侧 index color
 */
@property (nonatomic, strong) UIColor *sectionIndexColor;

/**
 Table view cell text label的字体
 */
@property (nonatomic, strong) UIFont *tableViewCellTextLabelFont;

#pragma mark -- JFCSSearchTableViewController 相关配置

/**
 JFCSSearchTableViewController 顶部搜索取消按钮文字 默认”取消“
 */
@property (nonatomic, strong) NSString *searchControllerCancelButtonTitle;

/**
 JFCSSearchTableViewController 数据库里没有该数据时搜索页面提示的信息 默认”抱歉，未找到相关位置，可尝试修改后重试“
 */
@property (nonatomic, strong) NSString *promptInformation;

/**
 JFCSSearchTableViewController 顶部搜索取消按钮font 默认[UIFont systemFontOfSize:12.0]
 */
@property (nonatomic, strong) UIFont *searchControllerCancelButtonTitleFont;

/**
 统一计算cell的高度方法
 
 @param count 展示的城市个数
 @return cell高度
 */
- (CGFloat)calculateCellHeightWithCount:(NSInteger)count;

@end
NS_ASSUME_NONNULL_END
