//
//  JFCSTableViewController.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/10.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JFCSConfiguration;
@class JFCSBaseInfoModel;
@protocol JFCSTableViewControllerDelegate;

@interface JFCSTableViewController : UIViewController

- (instancetype)initWithConfiguration:(JFCSConfiguration *)config delegate:(id<JFCSTableViewControllerDelegate>)delegate;

@end

@protocol JFCSTableViewControllerDelegate<NSObject>

- (void)viewController:(JFCSTableViewController *)viewController didSelectCity:(JFCSBaseInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
