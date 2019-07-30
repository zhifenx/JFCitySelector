//
//  JFCSProvinceModel.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSProvinceModel.h"

@implementation JFCSProvince

@end

@implementation JFCSProvinceModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"provinces" : [JFCSProvince class]
             };
}

@end
