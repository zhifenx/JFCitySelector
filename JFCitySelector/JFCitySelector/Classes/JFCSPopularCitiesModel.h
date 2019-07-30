//
//  JFCSPopularCitiesModel.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/24.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JFCSPopularCitiesType) {
    JFCSPopularCitiesTypeProvince  = 0,
    JFCSPopularCitiesTypeCity = 1,
    JFCSPopularCitiesTypeArea = 2,
};

@interface JFCSPopularCitiesModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) JFCSPopularCitiesType type;

- (instancetype)initWithName:(NSString *)name type:(JFCSPopularCitiesType)type;

@end

NS_ASSUME_NONNULL_END
