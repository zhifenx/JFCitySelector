//
//  JFCSFileManager.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/30.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface JFCSFileManager : NSObject

+ (NSBundle *)jFCitySelectorBundle;

+ (UIImage *)getImageWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
