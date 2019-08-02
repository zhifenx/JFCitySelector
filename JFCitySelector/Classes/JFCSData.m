//
//  JFCSData.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSData.h"

#import "JFCSFileManager.h"
#import <YYModel/YYModel.h>

#define JF_SINGLETON_IMP(_type_) + (_type_ *)shareInstance{\
static _type_ *theshareInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theshareInstance = [[super alloc] init];\
});\
return theshareInstance;\
}

@interface JFCSData ()

@property (nonatomic, strong) JFCSProvinceModel *provincemodel;
@property (nonatomic, strong) JFCSCityModel *citymodel;
@property (nonatomic, strong) JFCSAreaModel *areaModel;

@end

@implementation JFCSData

JF_SINGLETON_IMP(JFCSData);

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    NSString *provincePlistPath = [[JFCSFileManager jFCitySelectorBundle] pathForResource:@"provinces" ofType:@"plist"];
    NSString *cityPlistPath = [[JFCSFileManager jFCitySelectorBundle] pathForResource:@"cities" ofType:@"plist"];
    NSString *areaPlistPath = [[JFCSFileManager jFCitySelectorBundle] pathForResource:@"areas" ofType:@"plist"];
    NSDictionary *provinceDic = [[NSDictionary alloc] initWithContentsOfFile:provincePlistPath];
    NSDictionary *cityDic = [[NSDictionary alloc] initWithContentsOfFile:cityPlistPath];
    NSDictionary *areaDic = [[NSDictionary alloc] initWithContentsOfFile:areaPlistPath];
    self.provincemodel = [JFCSProvinceModel yy_modelWithJSON:provinceDic];
    self.citymodel = [JFCSCityModel yy_modelWithJSON:cityDic];
    self.areaModel = [JFCSAreaModel yy_modelWithJSON:areaDic];
}

#pragma mark -- Get

- (NSArray <JFCSProvince *>*)provinces {
    if (!_provinces) {
        _provinces = [NSArray new];
        NSSortDescriptor *sortDes = [[NSSortDescriptor alloc] initWithKey:@"pinyin" ascending:YES];
        _provinces = [[self.provincemodel.provinces sortedArrayUsingDescriptors:@[sortDes]] mutableCopy];
    }
    return _provinces;
}

- (NSArray <JFCSCity *>*)cities {
    if (!_cities) {
        _cities = [NSArray new];
        NSSortDescriptor *sortDes = [[NSSortDescriptor alloc] initWithKey:@"pinyin" ascending:YES];
        _cities = [[self.citymodel.cities sortedArrayUsingDescriptors:@[sortDes]] mutableCopy];
    }
    return _cities;
}

- (NSArray <JFCSArea *>*)areas {
    if (!_areas) {
        _areas = [NSArray new];
        NSSortDescriptor *sortDes = [[NSSortDescriptor alloc] initWithKey:@"pinyin" ascending:YES];
        _areas = [[self.areaModel.areas sortedArrayUsingDescriptors:@[sortDes]] mutableCopy];
    }
    return _areas;
}

@end
