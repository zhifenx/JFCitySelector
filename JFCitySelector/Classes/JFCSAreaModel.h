//
//  JFCSAreaModel.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSBaseInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JFCSArea : JFCSBaseInfoModel

@property (nonatomic, assign) NSInteger provinceCode;
@property (nonatomic, assign) NSInteger cityCode;

@end

@interface JFCSAreaModel : NSObject

@property (nonatomic, strong) NSArray *areas;

@end

NS_ASSUME_NONNULL_END
