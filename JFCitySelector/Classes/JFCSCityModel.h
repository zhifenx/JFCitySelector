//
//  JFCSCityModel.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSBaseInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JFCSCity : JFCSBaseInfoModel

@property (nonatomic, assign) NSInteger provinceCode;

@end

@interface JFCSCityModel : NSObject

@property (nonatomic, strong) NSArray *cities;

@end

NS_ASSUME_NONNULL_END
