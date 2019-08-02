//
//  JFCSDataOpreation.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/10.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSDataOpreation.h"

#import "JFCSProvinceModel.h"
#import "JFCSCityModel.h"
#import "JFCSAreaModel.h"
#import "JFCSData.h"
#import "JFCSConfiguration.h"
#import <YYModel/YYModel.h>

//  弱引用
#define JFWeakSelf(type)  __weak typeof(type) weak##type = type;
//  强引用
#define JFStrongSelf(type)  __strong typeof(type) type = weak##type;

@interface JFCSDataOpreation ()

@property (nonatomic, strong) JFCSConfiguration *configuration;
@property (nonatomic, strong) NSMutableArray <JFCSBaseInfoModel *> *arrayOfCityAndAreaModel;
@property (nonatomic, strong) NSMutableArray *arrayOfCityAndArea;

@end

@implementation JFCSDataOpreation

- (instancetype)initWithConfiguration:(JFCSConfiguration *)config {
    self = [super init];
    if (self) {
        _configuration = config;
        _data = [JFCSData shareInstance];
    }
    return self;
}

- (void)cityList:(void(^)(NSArray <JFCSBaseInfoModel *> *cities))block {
    if (block) {
        block([self.arrayOfCityAndAreaModel mutableCopy]);
    }
}

- (void)arrayOfCityAndArea:(void(^)(NSMutableArray *data))block {
    if (block) {
        block(self.arrayOfCityAndArea);
    }
}

- (void)provinces:(void(^)(NSArray <JFCSProvince *> *provinces))block {
    if (block) {
        block(_data.provinces);
    }
}

- (void)cities:(void(^)(NSArray <JFCSCity *> *cities))block {
    if (block) {
        block(_data.cities);
    }
}

- (void)areas:(void(^)(NSArray <JFCSArea *> *areas))block {
    if (block) {
        block(_data.areas);
    }
}

#pragma mark -- Get

- (NSMutableArray<JFCSPopularCitiesModel *> *)popularCitiesMutaleArray {
    return [_configuration popularCitiesMutableArray];
}

#pragma mark -- 通过code查询城市model

- (JFCSProvince *)getProvinceWithCode:(NSInteger)code {
    __block JFCSProvince *model = [[JFCSProvince alloc] init];
    [_data.provinces enumerateObjectsUsingBlock:^(JFCSProvince * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.code == code) {
            model = obj;
            *stop = YES;
        }
    }];
    return model;
}

- (JFCSCity *)getCityWithCode:(NSInteger)code {
    __block JFCSCity *model = [[JFCSCity alloc] init];
    [_data.cities enumerateObjectsUsingBlock:^(JFCSCity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.code == code) {
            model = obj;
            *stop = YES;
        }
    }];
    return model;
}

- (JFCSArea *)getAreaWithCode:(NSInteger)code {
    __block JFCSArea *model = [[JFCSArea alloc] init];
    [_data.areas enumerateObjectsUsingBlock:^(JFCSArea * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.code == code) {
            model = obj;
            *stop = YES;
        }
    }];
    return model;
}

#pragma mark -- 通过name查询城市model

- (JFCSProvince *)getProvinceWithName:(NSString *)name {
    __block JFCSProvince *model = [[JFCSProvince alloc] init];
    [_data.provinces enumerateObjectsUsingBlock:^(JFCSProvince * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:name]) {
            model = obj;
            *stop = YES;
        }
    }];
    return model;
}

- (JFCSCity *)getCityWithName:(NSString *)name {
    __block JFCSCity *model = [[JFCSCity alloc] init];
    [_data.cities enumerateObjectsUsingBlock:^(JFCSCity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:name]) {
            model = obj;
            *stop = YES;
        }
    }];
    return model;
}

- (JFCSArea *)getAreaWithName:(NSString *)name {
    __block JFCSArea *model = [[JFCSArea alloc] init];
    [_data.areas enumerateObjectsUsingBlock:^(JFCSArea * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:name]) {
            model = obj;
            *stop = YES;
        }
    }];
    return model;
}

#pragma mark -- 模糊查找（汉字或者拼音）
- (void)searchWithKeyword:(NSString *)keyword resultBlock:(void (^)(NSArray<JFCSBaseInfoModel *> * _Nonnull))result {
    if (!_configuration.isLowercaseString) {keyword = [keyword lowercaseString];}
    NSArray *pArr = [self searchProvinceWithString:keyword];
    NSArray *cArr = [self searchCityWithString:keyword];
    NSArray *aArr = [self searchAreaWithString:keyword];
    NSMutableArray *rArr = [NSMutableArray new];
    [rArr addObjectsFromArray:pArr];
    [rArr addObjectsFromArray:cArr];
    [rArr addObjectsFromArray:aArr];
    if (result) {
        result([rArr mutableCopy]);
    }
}

- (NSArray <JFCSProvince *>*)searchProvinceWithString:(NSString *)string {
    if (!_configuration.isLowercaseString) {string = [string lowercaseString];}
    __block NSMutableArray <JFCSProvince *>* arr = [NSMutableArray new];
    [_data.provinces enumerateObjectsUsingBlock:^(JFCSProvince * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name containsString:string] || (([obj.pinyin containsString:string] && self.configuration.isPinyinSearch) && self.configuration.isPinyinSearch)) {
            [arr addObject:obj];
        }
    }];
    return arr;
}

- (NSArray <JFCSCity *>*)searchCityWithString:(NSString *)string {
    if (!_configuration.isLowercaseString) {string = [string lowercaseString];}
    __block NSMutableArray <JFCSCity *>* arr = [NSMutableArray new];
    [_data.cities enumerateObjectsUsingBlock:^(JFCSCity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name containsString:string] || ([obj.pinyin containsString:string] && self.configuration.isPinyinSearch)) {
            [arr addObject:obj];
        }
    }];
    return arr;
}

- (NSArray <JFCSArea *>*)searchAreaWithString:(NSString *)string {
    if (!_configuration.isLowercaseString) {string = [string lowercaseString];}
    __block NSMutableArray <JFCSArea *>* arr = [NSMutableArray new];
    [_data.areas enumerateObjectsUsingBlock:^(JFCSArea * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name containsString:string] || ([obj.pinyin containsString:string] && self.configuration.isPinyinSearch)) {
            [arr addObject:obj];
        }
    }];
    return arr;
}

#pragma mark -- Lazy

- (NSMutableArray *)arrayOfCityAndArea {
    if (!_arrayOfCityAndArea) {
        _arrayOfCityAndArea = [[NSMutableArray alloc] init];
        for (NSString *str in self.firstLetterArraryOfCityOrArea) {
            NSMutableArray *tempArr = [NSMutableArray new];
            for (JFCSBaseInfoModel *model in self.arrayOfCityAndAreaModel) {
                if ([model.firstLetter isEqualToString:str]) {
                    [tempArr addObject:model];
                }
            }
            [_arrayOfCityAndArea addObject:tempArr];
        }
    }
    return _arrayOfCityAndArea;
}

- (NSMutableArray <JFCSBaseInfoModel *>*)arrayOfCityAndAreaModel {
    if (!_arrayOfCityAndAreaModel) {
        _arrayOfCityAndAreaModel = [[NSMutableArray alloc] init];
        [_arrayOfCityAndAreaModel addObjectsFromArray:_data.cities];
        [_arrayOfCityAndAreaModel addObjectsFromArray:_data.areas];
    }
    return _arrayOfCityAndAreaModel;
}

- (NSArray<NSString *> *)firstLetterArraryOfAllCities {
    if (!_firstLetterArraryOfAllCities) {
        _firstLetterArraryOfAllCities = [[NSArray alloc] init];
        NSMutableSet *tempSet = [NSMutableSet new];
        [tempSet addObjectsFromArray:self.firstLetterArraryOfProvince];
        [tempSet addObjectsFromArray:self.firstLetterArraryOfCity];
        [tempSet addObjectsFromArray:self.firstLetterArraryOfArea];
        _firstLetterArraryOfAllCities = [[tempSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
    }
    return _firstLetterArraryOfAllCities;
}

- (NSArray <NSString *> *)firstLetterArraryOfCityOrArea {
    if (!_firstLetterArraryOfCityOrArea) {
        _firstLetterArraryOfCityOrArea = [[NSArray alloc] init];
        NSMutableSet *tempSet = [NSMutableSet new];
        [tempSet addObjectsFromArray:self.firstLetterArraryOfCity];
        [tempSet addObjectsFromArray:self.firstLetterArraryOfArea];
        _firstLetterArraryOfCityOrArea = [[[tempSet allObjects] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    }
    return _firstLetterArraryOfCityOrArea;
}

- (NSArray <NSString *>*)firstLetterArraryOfProvince {
    if (!_firstLetterArraryOfProvince) {
        _firstLetterArraryOfProvince = [NSMutableArray arrayWithArray:[self firstLetterArrary:_data.provinces]];
    }
    return _firstLetterArraryOfProvince;
}

- (NSArray <NSString *>*)firstLetterArraryOfCity {
    if (!_firstLetterArraryOfCity) {
        _firstLetterArraryOfCity = [[NSArray alloc] init];
        _firstLetterArraryOfCity = [self firstLetterArrary:_data.cities];
    }
    return _firstLetterArraryOfCity;
}

- (NSArray <NSString *>*)firstLetterArraryOfArea {
    if (!_firstLetterArraryOfArea) {
        _firstLetterArraryOfArea = [[NSArray alloc] init];
        _firstLetterArraryOfArea = [self firstLetterArrary:_data.areas];
    }
    return _firstLetterArraryOfArea;
}

- (NSArray <NSString *>*)firstLetterArrary:(NSArray *)arr {
    __block NSMutableSet *set = [NSMutableSet new];
    [arr enumerateObjectsUsingBlock:^(JFCSBaseInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [set addObject:obj.firstLetter];
    }];
    return [[set allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

#pragma mark -- 最近访问的城市 最多存储三个

#define kHistoryRecordCities @"historyRecordCities"
#define kCurrentCity @"currentCity"

- (void)cacheCurrentCity:(JFCSBaseInfoModel *)model {
    [[NSUserDefaults standardUserDefaults] setObject:[model yy_modelToJSONString] forKey:kCurrentCity];
}

- (JFCSBaseInfoModel *)currentCity {
    JFCSBaseInfoModel *model = [JFCSBaseInfoModel yy_modelWithJSON:[[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCity]];
    return model;
}

- (NSArray<JFCSBaseInfoModel *> *)historyRecordCities {
    NSMutableArray <JFCSBaseInfoModel *>*arr = [NSMutableArray new];
    NSArray *tempArr = [self jf_getHistoryRecordCities];
    [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JFCSBaseInfoModel *model = [JFCSBaseInfoModel yy_modelWithJSON:obj];
        [arr addObject:model];
    }];
    return arr;
}

- (void)insertHistoryRecordCityModel:(JFCSBaseInfoModel *)model {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[[self jf_getHistoryRecordCities] mutableCopy]];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JFCSBaseInfoModel *tModel = [JFCSBaseInfoModel yy_modelWithJSON:obj];
        if ([tModel.name isEqualToString:model.name]) {
            [arr removeObject:obj];
            *stop = YES;
        }
    }];
    NSString *json = [model yy_modelToJSONString];
    [arr insertObject:json atIndex:0];
    if (arr.count > _configuration.maxHistoricalRecordCount) {
        arr = [[arr subarrayWithRange:NSMakeRange(0, _configuration.maxHistoricalRecordCount)] mutableCopy];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[arr copy] forKey:kHistoryRecordCities];
}

- (NSArray *)jf_getHistoryRecordCities {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kHistoryRecordCities];
}

#pragma mark -- 处理切换区县所需的数据

- (void)otherCitiesWithCityModel:(JFCSBaseInfoModel *)model resultArray:(void (^)(NSArray<JFCSBaseInfoModel *> * _Nonnull))block {
    if (model.code > 999 && model.code < 10000) {//市级
        if (block) {
            block([self otherAreasWithCode:model.code]);
        }
    }else if (model.code > 99999 && model.code < 1000000) {//县级
        if (block) {
            block([self otherAreasWithCode:model.code / 100]);
        }
    }else if (model.code > 0 && model.code < 100) {//省级
        if (block) {
            block([self otherCitiesWithCode:model.code]);
        }
    }
}

- (NSArray *)otherCitiesWithCode:(NSInteger)code {
    __block NSMutableArray <JFCSBaseInfoModel *>*cities = [NSMutableArray new];
    [_data.cities enumerateObjectsUsingBlock:^(JFCSCity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((obj.code / 100) == code) {
            [cities addObject:obj];
        }
    }];
    return [cities mutableCopy];
}

- (NSArray *)otherAreasWithCode:(NSInteger)code {
    __block NSMutableArray <JFCSBaseInfoModel *>*areas = [NSMutableArray new];
    [_data.areas enumerateObjectsUsingBlock:^(JFCSArea * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((obj.code / 100) == code) {
            [areas addObject:obj];
        }
    }];
    return [areas mutableCopy];
}

@end
