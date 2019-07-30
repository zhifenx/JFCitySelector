//
//  JFCSAreaModel.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSAreaModel.h"

@implementation JFCSArea

@end

@implementation JFCSAreaModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"areas" : [JFCSArea class]
             };
}

@end
