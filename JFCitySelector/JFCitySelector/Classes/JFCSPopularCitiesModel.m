//
//  JFCSPopularCitiesModel.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/24.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSPopularCitiesModel.h"

@implementation JFCSPopularCitiesModel

- (instancetype)initWithName:(NSString *)name type:(JFCSPopularCitiesType)type {
    self = [super init];
    if (self) {
        _name = name;
        _type = type;
    }
    return self;
}

@end
