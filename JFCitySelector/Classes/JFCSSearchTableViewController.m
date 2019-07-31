//
//  JFCSSearchTableViewController.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/18.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSSearchTableViewController.h"

#import "JFCSBaseInfoModel.h"
#import "JFCSConfiguration.h"
#import "JFCSDataOpreation.h"
#import "JFCSFileManager.h"

#define JFWeakSelf(type)  __weak typeof(type) weak##type = type;
#define JFStrongSelf(type)  __strong typeof(type) type = weak##type;

@interface JFCSSearchTableViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray <JFCSBaseInfoModel *>*dataArr;
@property (nonatomic, strong) UIView *searchBarBackgroundView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) JFCSConfiguration *config;
@property (nonatomic, strong) JFCSDataOpreation *dataOpreation;

@end

@implementation JFCSSearchTableViewController {
    CGFloat _searchTextFieldR;
    CGFloat _searchBarBackgroundViewH;
}

- (instancetype)initWithConfig:(JFCSConfiguration *)config dataOpreation:(JFCSDataOpreation *)dataOpreation {
    self = [super init];
    if (self) {
        _config = config;
        _searchTextFieldR = 10;
        _searchBarBackgroundViewH = 30;
        _dataOpreation = dataOpreation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self initUI];
    [self.searchTextField becomeFirstResponder];
}

- (void)initUI {
    self.navigationItem.titleView = self.searchBarBackgroundView;
    [self.searchBarBackgroundView addSubview:self.cancelButton];
    [self.searchBarBackgroundView addSubview:self.searchTextField];
}

- (void)reloadData:(NSArray <JFCSBaseInfoModel *> *)arr {
    self.dataArr = [arr mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row < self.dataArr.count) {    
        cell.textLabel.text = self.dataArr[indexPath.row].alias ? self.dataArr[indexPath.row].alias : self.dataArr[indexPath.row].name;
    }
    cell.textLabel.font = _config.tableViewCellTextLabelFont;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArr.count) {
        if (![self.dataArr[indexPath.row].name isEqualToString:_config.promptInformation]) {
            if (self.selectCityBlock) {
                self.selectCityBlock(self.dataArr[indexPath.row]);
            }
            [self dismissViewController];
        }
    }
}

- (UIView *)searchBarBackgroundView {
    if (!_searchBarBackgroundView) {
        CGFloat x = 12;
        CGFloat w = [UIScreen mainScreen].bounds.size.width - x * 2;
        _searchBarBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, w, _searchBarBackgroundViewH)];
    }
    return _searchBarBackgroundView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        CGFloat w = [self sizeWithString:_config.searchControllerCancelButtonTitle].width;
        CGFloat x = self.searchBarBackgroundView.frame.size.width - w;
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, w, _searchBarBackgroundViewH)];
        [_cancelButton setTitle:_config.searchControllerCancelButtonTitle forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:_config.searchControllerCancelButtonTitleFont];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        CGFloat w = self.searchBarBackgroundView.frame.size.width - self.cancelButton.frame.size.width - _searchTextFieldR;
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, w, _searchBarBackgroundViewH)];
        _searchTextField.placeholder = _config.searchButtonTitle;
        _searchTextField.font = _config.searchControllerCancelButtonTitleFont;
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[JFCSFileManager getImageWithName:_config.searchButtonImageName]];
        CGFloat leftImageViewH = 18;
        CGFloat leftImageViewY = (_searchBarBackgroundViewH - leftImageViewH) / 2;
        leftImageView.frame = CGRectMake(5, leftImageViewY, leftImageViewH, leftImageViewH);
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _searchBarBackgroundViewH, _searchBarBackgroundViewH)];
        [leftView addSubview:leftImageView];
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.leftView = leftView;
        _searchTextField.layer.cornerRadius = _searchBarBackgroundViewH / 2;
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchTextField.delegate = self;
        _searchTextField.returnKeyType = UIReturnKeyDone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return _searchTextField;
}

- (CGSize)sizeWithString:(NSString*)str {
    NSDictionary*attrs = @{NSFontAttributeName: _config.searchControllerCancelButtonTitleFont};
    return [str boundingRectWithSize:CGSizeMake(60, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs  context:nil].size;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark -- Action

- (void)cancelButtonAction:(UIButton *)sender {
    [self dismissViewController];
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)search:(NSString *)text {
    JFWeakSelf(self);
    [self.dataOpreation searchWithKeyword:text
                          resultBlock:^(NSArray<JFCSBaseInfoModel *> * _Nonnull dataArray) {
                              JFStrongSelf(self);
                              if (dataArray.count > 0) {
                                  self.dataArr = [NSMutableArray arrayWithArray:[dataArray mutableCopy]];
                              }else {
                                  JFCSBaseInfoModel *model = [[JFCSBaseInfoModel alloc] init];
                                  model.name = self.config.promptInformation;
                                  self.dataArr = [NSMutableArray arrayWithObject:model];
                              }
                              [self.tableView reloadData];
                          }];
}

#pragma mark -- UITextFieldTextDidChangeNotification
- (void)textFieldTextDidChangeNotification:(NSNotification *)notification {
    UITextField *textField = [notification object];
    if (textField.text.length > 0) {
        [self search:textField.text];
    }
}

#pragma mark -- Blcok

- (void)selectCityBlock:(searchControllerSelectCityBlock)blcok {
    if (blcok) {
        self.selectCityBlock = blcok;
    }
}

@end
