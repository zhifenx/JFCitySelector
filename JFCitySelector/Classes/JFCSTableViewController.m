//
//  JFCSTableViewController.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/10.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSTableViewController.h"

#import "JFCSDataOpreation.h"
#import "JFCSBaseInfoModel.h"
#import "JFCSAreaModel.h"
#import "JFCSPopularCitiesModel.h"
#import "JFCSConfiguration.h"
#import "JFCSSearchTableViewController.h"
#import "JFCSTopToolsTableViewCell.h"
#import "JFCSTableViewHeaderView.h"
#import "JFCSFileManager.h"


#define JFWeakSelf(type)  __weak typeof(type) weak##type = type;
#define JFStrongSelf(type)  __strong typeof(type) type = weak##type;

#define kHeaderCitiesSectionIndex @"切换区县"

@interface JFCSTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataMutableArray;
@property (nonatomic, strong) NSMutableArray *firstLetterMutableArrary;
@property (nonatomic, strong) NSMutableArray *sectionFirstLetterMutableArrary;
@property (nonatomic, strong) NSMutableArray <NSString *> *popularCitiesNameMutableArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*historyRecordNameMutableArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*headerCitiesNameMutableArray;
@property (nonatomic, strong) NSMutableArray <JFCSBaseInfoModel *>*historyRecordMutableArray;
@property (nonatomic, strong) NSMutableArray <JFCSBaseInfoModel *>*headerCitiesMutableArray;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) JFCSSearchTableViewController *resultVC;
@property (nonatomic, strong) JFCSTopToolsTableViewCell *popularCitiesCell;
@property (nonatomic, strong) JFCSTopToolsTableViewCell *historyRecordCell;
@property (nonatomic, strong) JFCSTopToolsTableViewCell *headerCitiesCell;
@property (nonatomic, strong) JFCSTableViewHeaderView *headerView;

@property (nonatomic, strong) JFCSDataOpreation *dataOpreation;
@property (nonatomic, strong) JFCSConfiguration *config;
@property (nonatomic, weak) id<JFCSTableViewControllerDelegate> delegate;
@property (nonatomic, strong) JFCSBaseInfoModel *currentCityModel;

@end

@implementation JFCSTableViewController

- (instancetype)initWithConfiguration:(JFCSConfiguration *)config delegate:(id<JFCSTableViewControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        _config = config;
        _delegate = delegate;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _config = [[JFCSConfiguration alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[JFCSFileManager getImageWithName:_config.leftBarButtonItemImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    
    if (_config.searchButton) {
        self.searchButton = _config.searchButton;
    }
    self.navigationItem.titleView = self.searchButton;
    
    [self.view addSubview:self.tableView];
    [self initData];
}

#pragma mark -- UITableViewDelegate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataMutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dataMutableArray[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section < self.dataMutableArray.count) {
        if (indexPath.row < [self.dataMutableArray[indexPath.section] count]) {
            
            
            if (self.headerCitiesMutableArray.count > 0 && [self.sectionFirstLetterMutableArrary[indexPath.section] isEqualToString:kHeaderCitiesSectionIndex]) {//切换城市
                if (!_headerCitiesCell) {
                    _headerCitiesCell = [[JFCSTopToolsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JFCSTopToolsTableViewCell"];
                    [_headerCitiesCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    JFWeakSelf(self);
                    [self.headerCitiesCell topToolsCellSelectCityBlock:^(NSInteger index) {
                        JFStrongSelf(self);
                        [self selectCityCallBack:self.headerCitiesMutableArray[index]];
                    }];
                }
                [_headerCitiesCell setupData:self.headerCitiesNameMutableArray];
                return _headerCitiesCell;
            } else if (!_config.hidePopularCities && _config.popularCitiesMutableArray.count > 0 && [self.sectionFirstLetterMutableArrary[indexPath.section] isEqualToString:_config.popularCitiesTitle]) {//热门城市
                if (!_popularCitiesCell) {
                    _popularCitiesCell = [[JFCSTopToolsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JFCSTopToolsTableViewCell"];
                    [_popularCitiesCell setupData:self.popularCitiesNameMutableArray];
                    [_popularCitiesCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    JFWeakSelf(self);
                    [self.popularCitiesCell topToolsCellSelectCityBlock:^(NSInteger index) {
                        JFStrongSelf(self);
                        [self didSelectPopularCities:self.config.popularCitiesMutableArray[index]];
                    }];
                }
                return _popularCitiesCell;
            }else if (!_config.hideHistoricalRecord && self.historyRecordNameMutableArray.count > 0 && [self.sectionFirstLetterMutableArrary[indexPath.section] isEqualToString:_config.historicalRecordTitle]) {//最近访问
                if (!_historyRecordCell) {
                    _historyRecordCell = [[JFCSTopToolsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JFCSTopToolsTableViewCell"];
                    [_historyRecordCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    JFWeakSelf(self);
                    [self.historyRecordCell topToolsCellSelectCityBlock:^(NSInteger index) {
                        JFStrongSelf(self);
                        [self selectCityCallBack:self.historyRecordMutableArray[index]];
                    }];
                }
                [_historyRecordCell setupData:self.historyRecordNameMutableArray];
                return _historyRecordCell;
            } else {
                JFCSBaseInfoModel *model = self.dataMutableArray[indexPath.section][indexPath.row];
                cell.textLabel.text = model.alias ? : model.name;
                cell.textLabel.font = _config.tableViewCellTextLabelFont;
            }
            

        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionFirstLetterMutableArrary[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.firstLetterMutableArrary;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.dataMutableArray.count) {
        if (indexPath.row < [self.dataMutableArray[indexPath.section] count] && ![self.sectionFirstLetterMutableArrary[indexPath.section] isEqualToString:_config.popularCitiesTitle]) {
            JFCSBaseInfoModel *model = self.dataMutableArray[indexPath.section][indexPath.row];
            [self selectCityCallBack:model];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44;
    if (indexPath.section < self.dataMutableArray.count) {
        if (indexPath.row < [self.dataMutableArray[indexPath.section] count]) {
            if (!_config.hidePopularCities && _config.popularCitiesMutableArray.count > 0 && [self.sectionFirstLetterMutableArrary[indexPath.section] isEqualToString:_config.popularCitiesTitle]) {//热门城市
               height = _config.popularCitiesCellHeight;
            }
            
            if (!_config.hideHistoricalRecord && self.historyRecordNameMutableArray.count > 0 && [self.sectionFirstLetterMutableArrary[indexPath.section] isEqualToString:_config.historicalRecordTitle]) {//最近访问
                height = [self.config calculateCellHeightWithCount:self.historyRecordNameMutableArray.count];
            }
            
            if (self.headerCitiesNameMutableArray.count > indexPath.section && [self.sectionFirstLetterMutableArrary[indexPath.section] isEqualToString:kHeaderCitiesSectionIndex]) {
                height = [self.config calculateCellHeightWithCount:self.headerCitiesNameMutableArray.count];
            }
            
        }
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    CGFloat height = 30;
    if (self.sectionFirstLetterMutableArrary.count > section && [self.sectionFirstLetterMutableArrary[section] isEqualToString:kHeaderCitiesSectionIndex]) {
        height = 0;
    }
    return height;
}

#pragma mark -- Data

- (void)initData {
    self.popularCitiesNameMutableArray = [NSMutableArray new];
    self.historyRecordMutableArray = [NSMutableArray new];
    self.historyRecordNameMutableArray = [NSMutableArray new];
    self.headerCitiesNameMutableArray = [NSMutableArray new];
    self.dataOpreation = [[JFCSDataOpreation alloc] initWithConfiguration:_config];
    self.currentCityModel =  [self.dataOpreation currentCity];
    self.historyRecordMutableArray = [[self.dataOpreation historyRecordCities] mutableCopy];
    [self.historyRecordMutableArray enumerateObjectsUsingBlock:^(JFCSBaseInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.historyRecordNameMutableArray addObject:obj.alias ? : obj.name];
    }];
    [self.config.popularCitiesMutableArray enumerateObjectsUsingBlock:^(JFCSPopularCitiesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.popularCitiesNameMutableArray addObject:obj.name];
    }];
    JFWeakSelf(self);
    [self.dataOpreation arrayOfCityAndArea:^(NSMutableArray * _Nonnull data) {
        JFStrongSelf(self);
        [self configData:data];
    }];
    [self.headerView updateCurrentCity:self.currentCityModel.alias ? : self.currentCityModel.name];
}

- (void)configData:(NSMutableArray *)dataArr {
    self.dataMutableArray = [NSMutableArray arrayWithArray:[dataArr mutableCopy]];
    self.firstLetterMutableArrary = [self.dataOpreation.firstLetterArraryOfCityOrArea mutableCopy];
    self.sectionFirstLetterMutableArrary = [self.dataOpreation.firstLetterArraryOfCityOrArea mutableCopy];
    if (!self.config.hidePopularCities && self.config.popularCitiesMutableArray.count > 0) {
        [self insertPopularCitiesCellData];
    }
    if (!self.config.hideHistoricalRecord && [self.dataOpreation historyRecordCities].count > 0) {
        [self insertHistoricalRecordCellData];
    }
    [self.tableView reloadData];
}

- (void)insertPopularCitiesCellData {
    [self.dataMutableArray insertObject:@[@"****** 我是热门城市 Cell ******"] atIndex:0];
    [self.firstLetterMutableArrary insertObject:_config.popularCitiesAbbreviation atIndex:0];
    [self.sectionFirstLetterMutableArrary insertObject:_config.popularCitiesTitle atIndex:0];
}

- (void)insertHistoricalRecordCellData {
    [self.dataMutableArray insertObject:@[@"****** 我是最近访问 Cell ******"] atIndex:0];
    [self.firstLetterMutableArrary insertObject:_config.historicalRecordAbbreviation atIndex:0];
    [self.sectionFirstLetterMutableArrary insertObject:_config.historicalRecordTitle atIndex:0];
}

- (void)insertHeaderCitiesCellData {
    [self.dataMutableArray insertObject:@[@"****** 我是切换区县 Cell ******"] atIndex:0];
    [self.firstLetterMutableArrary insertObject:@"区县" atIndex:0];
    [self.sectionFirstLetterMutableArrary insertObject:kHeaderCitiesSectionIndex atIndex:0];
}

#pragma mark -- Lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.sectionIndexColor = _config.sectionIndexColor;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[JFCSTopToolsTableViewCell class] forCellReuseIdentifier:@"JFCSTopToolsTableViewCell"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 240, 30)];
        [_searchButton setTitle:_config.searchButtonTitle forState:UIControlStateNormal];
        [_searchButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_searchButton setTitleColor:_config.searchButtonTitleColor forState:UIControlStateNormal];
        [_searchButton setImage:[JFCSFileManager getImageWithName:_config.searchButtonImageName] forState:UIControlStateNormal];
        [_searchButton setBackgroundColor:_config.searchButtonBackgroundColor];
        [_searchButton.layer setCornerRadius:30 / 2];
        [_searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (JFCSTableViewHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[JFCSTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40) hideSwitchButton:self.config.hideAreaSwitchButton];
        JFWeakSelf(self);
        [_headerView headerViewBlock:^(BOOL selected) {
            JFStrongSelf(self);
            if (selected) {
                [self showOtherCityCell];
            }else {
                [self hiddenOtherCityCell];
            }
        }];
    }
    return _headerView;
}

#pragma mark - Action

- (void)selectCityCallBack:(JFCSBaseInfoModel *)model {
    self.currentCityModel = model;
    [self.dataOpreation cacheCurrentCity:model];
    [self.headerView updateCurrentCity:model.alias ? : model.name];
    if (!_config.hideHistoricalRecord) {
        [self.dataOpreation insertHistoryRecordCityModel:model];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didSelectCity:)]) {
        [self.delegate viewController:self didSelectCity:model];
    }
    [self leftBarButtonItemAction];
}

- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchButtonAction:(UIButton *)sender {
    JFCSSearchTableViewController *searchVC = [[JFCSSearchTableViewController alloc] initWithConfig:_config dataOpreation:_dataOpreation];
    [searchVC selectCityBlock:^(JFCSBaseInfoModel * _Nonnull model) {
        [self selectCityCallBack:model];
    }];
    UINavigationController *nvi = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:nvi animated:NO completion:nil];
}

- (void)didSelectPopularCities:(JFCSPopularCitiesModel *)popularCitiesModel {
    NSArray *arr = [NSArray new];
    
    switch (popularCitiesModel.type) {
        case JFCSPopularCitiesTypeProvince: {
            arr = [self.dataOpreation searchProvinceWithString:popularCitiesModel.name];
        }
            break;
        case JFCSPopularCitiesTypeCity: {
            arr = [self.dataOpreation searchCityWithString:popularCitiesModel.name];
        }
            break;
        case JFCSPopularCitiesTypeArea: {
            arr = [self.dataOpreation searchAreaWithString:popularCitiesModel.name];
        }
            break;
        default:
            break;
    }
    
    if (arr.count > 0) {
        [self selectCityCallBack:(JFCSBaseInfoModel *)arr[0]];
    }
}

#pragma maek -- 切换区县

- (void)showOtherCityCell {
    JFWeakSelf(self);
    [self.dataOpreation otherCitiesWithCityModel:self.currentCityModel
                                     resultArray:^(NSArray<JFCSBaseInfoModel *> * _Nonnull dataArray) {
                                         JFStrongSelf(self);
                                         if (dataArray.count > 0) {
                                             [self insertHeaderCitiesCellData];
                                             self.headerCitiesMutableArray = [dataArray mutableCopy];
                                             [self.headerCitiesNameMutableArray removeAllObjects];
                                             [dataArray enumerateObjectsUsingBlock:^(JFCSBaseInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                 [self.headerCitiesNameMutableArray addObject:obj.name];
                                             }];
                                             
                                             [self.tableView beginUpdates];
                                             [self.tableView insertSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                                             [self.tableView endUpdates];
                                         }
                                     }];
}

- (void)hiddenOtherCityCell {
    if (self.headerCitiesMutableArray.count > 0) {
        [self.headerCitiesNameMutableArray removeAllObjects];
        [self.headerCitiesMutableArray removeAllObjects];
        [self.dataMutableArray removeObjectAtIndex:0];
        [self.sectionFirstLetterMutableArrary removeObjectAtIndex:0];
        [self.firstLetterMutableArrary removeObjectAtIndex:0];
        [self.tableView beginUpdates];
        [self.tableView deleteSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }
}

@end
