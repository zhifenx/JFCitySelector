//
//  JFCSData.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JFCSProvinceModel.h"
#import "JFCSCityModel.h"
#import "JFCSAreaModel.h"

NS_ASSUME_NONNULL_BEGIN

#define JF_SINGLETON_DEF(_type_) + (_type_ *)shareInstance;\
+(instancetype) alloc __attribute__((unavailable("call shareInstance instead")));\
+(instancetype) new __attribute__((unavailable("call shareInstance instead")));\
-(instancetype) copy __attribute__((unavailable("call shareInstance instead")));\
-(instancetype) mutableCopy __attribute__((unavailable("call shareInstance instead")));\

@interface JFCSData : NSObject

JF_SINGLETON_DEF(JFCSData);

@property (nonatomic, strong) NSArray <JFCSProvince *>*provinces;
@property (nonatomic, strong) NSArray <JFCSCity *>*cities;
@property (nonatomic, strong) NSArray <JFCSArea *>*areas;

@end

NS_ASSUME_NONNULL_END
