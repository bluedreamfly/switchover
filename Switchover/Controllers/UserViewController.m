//
//  UserViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/23.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "UserViewController.h"
#import "Masonry.h"
#import "AppColor.h"
#import "UIColor+Hex.h"
#import "UserTableHeaderView.h"
#import "MonutShowView.h"
#import "QBUserTableViewCell.h"
#import "QBUserViewModel.h"
#import "MyWalletViewController.h"
#import "HistoryTaskViewController.h"
#import "BatteryViewController.h"
#import "ReactiveObjC.h"

@interface UserViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) QBUserViewModel *userViewModel;
//@property (strong, nonatomic) NSString *money;
//@property (table)
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userViewModel = [[QBUserViewModel alloc] init];
    
    [self initCodeView];
    
    [self initRAC];
    
    [self.userViewModel fetchUserInfo];
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {
    
//    [self.userViewModel fetchUserInfo];
//    [self.tableView reloadData];
    
//    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithHexString:APP_MAIN_COLOR]];
//    
////    [self.navigationController.navigationBar setAlpha:1];
//    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
}

//-(void)viewWillDisappear:(BOOL)animated




-(void)viewWillDisappear:(BOOL)animated {

    [self.navigationController.navigationBar setBarTintColor: [UIColor whiteColor]];
}


-(void) initRAC
{
    UserTableHeaderView *headerView = (UserTableHeaderView *)self.tableView.tableHeaderView;
    
    RAC(headerView.userAvator, image) = RACObserve(self, userViewModel.avatorImage);
    RAC(headerView.userName, text) = RACObserve(self, userViewModel.userName);
    RAC(headerView.userType, text) = RACObserve(self, userViewModel.userType);
    RAC(headerView.monthIncome, text) = RACObserve(self, userViewModel.monthIncome);
    RAC(headerView.todayIncome, text) = RACObserve(self, userViewModel.todayIncome);
    RAC(headerView.todayFinishTask, text) = RACObserve(self, userViewModel.todayFinishTasks);
    RAC(headerView.todaySwitchNum, text) = RACObserve(self, userViewModel.todaySwitchNums);
    [RACObserve(self, userViewModel.walletAmount) subscribeNext:^(id  _Nullable x) {
        [self.tableView reloadData];
    }];
}

-(void) initCodeView {

    
    self.tableView = [[UITableView alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UserTableHeaderView *tableHeaderView = [[UserTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 292)];
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:APP_MAIN_BGCOLOR];
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *QBCellId = @"QBUserCell";
    QBUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QBCellId];
    if (nil == cell) {
        cell = [[QBUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QBCellId];
    }
    
    
    cell.title.text = self.userViewModel.linkList[indexPath.row][@"title"];
    cell.frontImageView.image = [UIImage imageNamed:self.userViewModel.linkList[indexPath.row][@"frontImage"]];
    
    cell.afterImageView.image = [UIImage imageNamed:@"jump_arrow_icon"];
    
    NSNumber *money = self.userViewModel.walletAmount;
    if (indexPath.row == 0 && money != nil) {
        
        if ([money doubleValue] < 0) {
            cell.des.textColor = [UIColor redColor];
        }
        cell.des.text = [NSString stringWithFormat:@"%@%@", money, @"元"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MyWalletViewController *myWalletController = [self.storyboard instantiateViewControllerWithIdentifier:@"myWallet"];
        [self.navigationController pushViewController:myWalletController animated:YES];
    }
    
    if (indexPath.row == 1) {
        HistoryTaskViewController *historyTaskController = [[HistoryTaskViewController alloc] init];
        [self.navigationController pushViewController:historyTaskController animated:YES];
    }
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
