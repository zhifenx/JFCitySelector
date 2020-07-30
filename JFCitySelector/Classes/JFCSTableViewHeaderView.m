//
//  JFCSTableViewHeaderView.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/24.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSTableViewHeaderView.h"

#import "JFCSFileManager.h"

@implementation JFCSTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame hideSwitchButton:(BOOL)hidden {
    self = [super initWithFrame:frame];
    if (self) {
        UIFont *font = [UIFont systemFontOfSize:13.0];
        CGFloat buttonW = 100;
        CGFloat buttonR = 16;
        CGFloat buttonX = frame.size.width - buttonW - buttonR;
        self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, buttonW, frame.size.height)];
        [self.rightButton setImage:[JFCSFileManager getImageWithName:@"jf_icon_down"] forState:UIControlStateNormal];
        [self.rightButton setTitle:@"切换区县" forState:UIControlStateNormal];
        [self.rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -buttonW - 20)];
        [self.rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [self.rightButton.titleLabel setFont:font];
        [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];
        [self.rightButton setHidden:hidden];
        CGFloat labelR = 5;
        CGFloat labelW = self.rightButton.frame.origin.x - labelR - buttonR;
        self.currentCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonR, 0, labelW, frame.size.height)];
        self.currentCityLabel.font = font;
        self.currentCityLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:self.currentCityLabel];
        [self updateCurrentCity:@""];
    }
    return self;
}

- (void)updateCurrentCity:(NSString *)name {
    if (name) {
        self.currentCityLabel.text = [NSString stringWithFormat:@"当前：%@",name];
    }
}

- (void)rightButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[JFCSFileManager getImageWithName:@"jf_icon_up"] forState:UIControlStateNormal];
    }else {
        [sender setImage:[JFCSFileManager getImageWithName:@"jf_icon_down"] forState:UIControlStateNormal];
    }
    if (self.headerBlock) {
        self.headerBlock(sender.selected);
    }
}

- (void)headerViewBlock:(headerViewBlock)blcok {
    if (blcok) {
        self.headerBlock = blcok;
    }
}

@end
