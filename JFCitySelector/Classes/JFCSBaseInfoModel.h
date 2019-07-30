//
//  JFCSBaseInfoModel.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/11.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFCSBaseInfoModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSString *firstLetter;

/**
 重复的城市名称，用此区别
 */
@property (nonatomic, copy) NSString *alias;

@end

NS_ASSUME_NONNULL_END
