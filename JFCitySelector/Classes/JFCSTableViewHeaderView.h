//
//  JFCSTableViewHeaderView.h
//  jfcityselector
//
//  Created by zhifenx on 2019/7/24.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^headerViewBlock)(BOOL selected);

@interface JFCSTableViewHeaderView : UIView

@property (nonatomic, strong) UILabel *currentCityLabel;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) headerViewBlock headerBlock;

- (instancetype)initWithFrame:(CGRect)frame hideSwitchButton:(BOOL)hidden;

- (void)updateCurrentCity:(NSString *)name;

- (void)headerViewBlock:(headerViewBlock)blcok;
@end

NS_ASSUME_NONNULL_END
