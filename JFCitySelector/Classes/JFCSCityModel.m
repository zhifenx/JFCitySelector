//
//  JFCSCityModel.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSCityModel.h"

@implementation JFCSCity

@end

@implementation JFCSCityModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cities" : [JFCSCity class]
             };
}

@end
