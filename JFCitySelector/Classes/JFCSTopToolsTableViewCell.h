//
//  JFCSTopToolsTableViewCell.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/23.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JFCSPopularCitiesModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^topToolsCellSelectCityBlock)(NSInteger index);

@interface JFCSTopToolsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray <UIButton *>*buttonArr;

@property (nonatomic, copy) topToolsCellSelectCityBlock selectCityBlock;

- (void)setupData:(NSArray <NSString *>*)dataArr;

- (void)topToolsCellSelectCityBlock:(topToolsCellSelectCityBlock)block;

@end

NS_ASSUME_NONNULL_END
