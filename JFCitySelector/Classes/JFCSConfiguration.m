//
//  JFCSConfiguration.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSConfiguration.h"

#import "JFCSPopularCitiesModel.h"

@implementation JFCSConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        _isPinyinSearch = YES;
        _isLowercaseString = NO;
        _hidePopularCities = NO;
        _hideHistoricalRecord = NO;
        _hideAreaSwitchButton = NO;
        _searchButtonBackgroundColor = [UIColor whiteColor];
        _searchButtonTitleColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        _sectionIndexColor = [UIColor colorWithRed:0/255.0f green:132/255.0f blue:255/255.0f alpha:1];
        _maxHistoricalRecordCount = 3;
        
        self.popularCitiesMutableArray = [self defealtPopularCities];
        self.popularCitiesTitle = @"热门城市";
        self.historicalRecordTitle = @"最近访问";
        
        _leftBarButtonItemImageName = @"jf_icon_navi_return";
        _searchButtonImageName = @"jf_icon_search_button";
        _searchButtonTitle = @"城市名/拼音";
        _searchControllerCancelButtonTitle = @"取消";
        _searchControllerCancelButtonTitleFont = [UIFont systemFontOfSize:14.0];
        _tableViewCellTextLabelFont = [UIFont systemFontOfSize:14.0];
        _promptInformation = @"抱歉，未找到相关位置，可尝试修改后重试";
    }
    return self;
}

#pragma mark -- Set

- (void)setPopularCitiesMutableArray:(NSMutableArray<JFCSPopularCitiesModel *> *)popularCitiesMutableArray {
    _popularCitiesMutableArray = popularCitiesMutableArray;
    _popularCitiesCellHeight = [self calculateCellHeightWithCount:popularCitiesMutableArray.count];
}

- (void)setIsPinyinSearch:(BOOL)isPinyinSearch {
    _isPinyinSearch = isPinyinSearch;
    _searchButtonTitle = isPinyinSearch ? _searchButtonTitle : @"城市名";
}

- (void)setPopularCitiesTitle:(NSString *)popularCitiesTitle {
    _popularCitiesTitle = popularCitiesTitle;
    _popularCitiesAbbreviation = popularCitiesTitle.length >= 2 ? [popularCitiesTitle substringToIndex:2] : @"*";
}

- (void)setHistoricalRecordTitle:(NSString *)historicalRecordTitle {
    _historicalRecordTitle = historicalRecordTitle;
    _historicalRecordAbbreviation = historicalRecordTitle.length >= 2 ? [historicalRecordTitle substringToIndex:2] : @"#";
}

#pragma mark -- Get

- (NSMutableArray <JFCSPopularCitiesModel *> *)defealtPopularCities {
    JFCSPopularCitiesModel *bjModel = [[JFCSPopularCitiesModel alloc] initWithName:@"北京" type:JFCSPopularCitiesTypeCity];
    JFCSPopularCitiesModel *shModel = [[JFCSPopularCitiesModel alloc] initWithName:@"上海" type:JFCSPopularCitiesTypeCity];
    JFCSPopularCitiesModel *gzModel = [[JFCSPopularCitiesModel alloc] initWithName:@"广州" type:JFCSPopularCitiesTypeCity];
    JFCSPopularCitiesModel *szModel = [[JFCSPopularCitiesModel alloc] initWithName:@"深圳" type:JFCSPopularCitiesTypeCity];
    JFCSPopularCitiesModel *hzModel = [[JFCSPopularCitiesModel alloc] initWithName:@"杭州" type:JFCSPopularCitiesTypeCity];
    return [NSMutableArray arrayWithObjects:bjModel, shModel, gzModel, szModel, hzModel, nil];
}

#pragma mark -- Action

- (CGFloat)calculateCellHeightWithCount:(NSInteger)count {
    NSInteger tempCount = count / 3;
    if ((count % 3) > 0) {
        tempCount += 1;
    }
    return tempCount * 48;
}

@end
