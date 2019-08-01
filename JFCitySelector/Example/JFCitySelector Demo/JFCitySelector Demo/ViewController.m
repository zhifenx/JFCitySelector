//
//  ViewController.m
//  JFCitySelector Demo
//
//  Created by zhifenx on 2019/7/31.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "ViewController.h"

#import "JFCitySelector.h"

//  自定义Log
#ifdef RELEASE
#define NSLog(...)
#else
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#endif

#define JFWeakSelf(type)  __weak typeof(type) weak##type = type;
#define JFStrongSelf(type)  __strong typeof(type) type = weak##type;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, JFCSTableViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) JFCSConfiguration *config;
@property (nonatomic, strong) JFCSDataOpreation *dataOpreation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.config = [[JFCSConfiguration alloc] init];
    self.dataOpreation = [[JFCSDataOpreation alloc] initWithConfiguration:self.config];
    
    self.title = @"JFCitySelector";
    self.dataArr = @[@"JFCSTableViewController",
                     @"省份数据",
                     @"市数据",
                     @"县数据",
                     @"省份数据包含的首字母",
                     @"市数据包含的首字母",
                     @"县数据包含的首字母",
                     @"所有名称包含的首字母"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            JFCSTableViewController *vc = [[JFCSTableViewController alloc] initWithConfiguration:self.config delegate:self];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 1: {
            JFWeakSelf(self);
            [self.dataOpreation provinces:^(NSArray<JFCSProvince *> * _Nonnull provinces) {
                JFStrongSelf(self);
                self.textView.text = [provinces yy_modelDescription];
            }];
        }
            
            break;
        case 2: {
            JFWeakSelf(self);
            [self.dataOpreation cities:^(NSArray<JFCSCity *> * _Nonnull cities) {
                JFStrongSelf(self);
                self.textView.text = [cities yy_modelDescription];
            }];
        }
            
            break;
        case 3: {
            JFWeakSelf(self);
            [self.dataOpreation areas:^(NSArray<JFCSArea *> * _Nonnull areas) {
                JFStrongSelf(self);
                self.textView.text = [areas yy_modelDescription];
            }];
        }
            
            break;
        case 4: {
            self.textView.text = [self.dataOpreation.firstLetterArraryOfProvince yy_modelDescription];
        }
            
            break;
        case 5: {
            self.textView.text = [self.dataOpreation.firstLetterArraryOfCity yy_modelDescription];
        }
            
            break;
        case 6: {
            self.textView.text = [self.dataOpreation.firstLetterArraryOfArea yy_modelDescription];
        }
            
            break;
        case 7: {
            self.textView.text = [self.dataOpreation.firstLetterArraryOfAllCities yy_modelDescription];
        }
            
            break;
            
        default:
            break;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = self.textView;
    }
    return _tableView;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44 * self.dataArr.count - 44 - 20)];
        _textView.textColor = [UIColor redColor];
        _textView.font = [UIFont systemFontOfSize:14.0];
        _textView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    }
    return _textView;
}

#pragma mark -- JFCSTableViewControllerDelegate

- (void)viewController:(JFCSTableViewController *)viewController didSelectCity:(JFCSBaseInfoModel *)model {
    self.textView.text = [NSString stringWithFormat:@"%@",[model yy_modelDescription]];
}


@end
