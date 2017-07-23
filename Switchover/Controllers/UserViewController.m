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


@interface UserViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCodeView];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {
    
//    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithHexString:APP_MAIN_COLOR]];
//    
////    [self.navigationController.navigationBar setAlpha:1];
//    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
}

//-(void)viewWillDisappear:(BOOL)animated

-(void)viewWillDisappear:(BOOL)animated {

    [self.navigationController.navigationBar setBarTintColor: [UIColor whiteColor]];
}

-(void) initCodeView {

    
    self.tableView = [[UITableView alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView *tableHeaderView = [[UIView alloc] init];
    
    self.tableView.tableHeaderView = tableHeaderView;
    
    [self initUserInfo: tableHeaderView];
    
    
    [self.view addSubview:self.tableView];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

}

-(void)initUserInfo: (UIView *)parent {
    UIButton *userInfoView = [[UIButton alloc] init];
    
    [parent addSubview: userInfoView];
    userInfoView.backgroundColor = [UIColor colorWithHexString:APP_MAIN_COLOR];
    
    UIImageView *avatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_picker"]];
    avatorImageView.contentMode = UIViewContentModeCenter;
    avatorImageView.backgroundColor = [UIColor whiteColor];
    avatorImageView.layer.masksToBounds = YES;
    avatorImageView.layer.cornerRadius = 30;
    
    UILabel *userName = [[UILabel alloc] init];
    userName.text = @"黄祯辉";
    userName.font = [UIFont systemFontOfSize: 17];
    userName.textColor = [UIColor whiteColor];
    
    UILabel *userType = [[UILabel alloc] init];
    userType.text = @"官方换电员";
    userType.font = [UIFont systemFontOfSize: 12];
    userType.textColor = [UIColor colorWithHexString:@"333333"];
    userType.backgroundColor = [UIColor whiteColor];
//    userType.
    [userInfoView addSubview:avatorImageView];
    [userInfoView addSubview:userName];
    [userInfoView addSubview:userType];
    
    [userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(parent.mas_leading);
        make.top.equalTo(parent.mas_top);
        make.trailing.equalTo(parent.mas_trailing);
        make.height.equalTo(@92);
    }];
    
    
    [avatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userInfoView.mas_top).offset(11.5);
        make.leading.equalTo(userInfoView.mas_leading).offset(30);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userInfoView.mas_top).offset(19.05);
        make.leading.equalTo(avatorImageView.mas_trailing).offset(15);
    }];
    
    [userType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userName.mas_bottom).offset(5.5);
        make.leading.equalTo(avatorImageView.mas_trailing).offset(15);
    }];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *QBCellId = @"QBCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QBCellId];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QBCellId];
    }
    
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = @"hahah";
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
