//
//  JFCSProvinceModel.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSBaseInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JFCSProvince : JFCSBaseInfoModel

@end

@interface JFCSProvinceModel : NSObject

@property (nonatomic, strong) NSArray *provinces;

@end

NS_ASSUME_NONNULL_END
