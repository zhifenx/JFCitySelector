//
//  JFCSSearchTableViewController.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/18.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JFCSBaseInfoModel;
@class JFCSConfiguration;
@class JFCSDataOpreation;

typedef void(^searchControllerSelectCityBlock)(JFCSBaseInfoModel *model);

@interface JFCSSearchTableViewController : UITableViewController

@property (nonatomic, copy) searchControllerSelectCityBlock selectCityBlock;

- (instancetype)initWithConfig:(JFCSConfiguration *)config dataOpreation:(JFCSDataOpreation *)dataOpreation;

- (void)reloadData:(NSArray <JFCSBaseInfoModel *> *)arr;

- (void)selectCityBlock:(searchControllerSelectCityBlock)blcok;

@end

NS_ASSUME_NONNULL_END
