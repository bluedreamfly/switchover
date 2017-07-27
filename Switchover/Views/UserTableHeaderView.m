//
//  UserTableHeaderView.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/24.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "UserTableHeaderView.h"
#import "AppColor.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "MonutShowView.h"

@interface UserTableHeaderView()
@property (nonatomic, weak) UIView *userInfoView;
@property (nonatomic, weak) UIView *taskInfoView;

@end


@implementation UserTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor colorWithHexString:APP_MAIN_BGCOLOR];
        
        [self initUserInfo:self];
        [self initTaskInfo];
    }
    return self;
}


-(void)initUserInfo: (UIView *)parent {
    UIButton *userInfoView = [[UIButton alloc] init];
    
    self.userInfoView = userInfoView;
    [parent addSubview: userInfoView];
    userInfoView.backgroundColor = [UIColor colorWithHexString:APP_MAIN_COLOR];
    [userInfoView addSubview:self.userAvator];
    [userInfoView addSubview:self.userName];
    [userInfoView addSubview:self.userType];
    
    [userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(parent.mas_leading);
        make.top.equalTo(parent.mas_top);
        make.trailing.equalTo(parent.mas_trailing);
        make.height.equalTo(@92);
    }];
    
    
    [_userAvator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userInfoView.mas_top).offset(11.5);
        make.leading.equalTo(userInfoView.mas_leading).offset(30);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userInfoView.mas_top).offset(19.05);
        make.leading.equalTo(_userAvator.mas_trailing).offset(15);
    }];
    
    [_userType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userName.mas_bottom).offset(5.5);
        make.leading.equalTo(_userAvator.mas_trailing).offset(15);
    }];
}

-(void) initTaskInfo {
    
    //task container
    UIView *taskInfoView = [[UIView alloc] init];
    taskInfoView.backgroundColor = [UIColor whiteColor];
    self.taskInfoView = taskInfoView;
    
    [self addSubview:taskInfoView];
    
    //tip label
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"数据统计截止于1小时前";
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = [UIColor colorWithHexString:@"666666"];
    
    MonutShowView *mountShowView = [[MonutShowView alloc] init];

    UILabel *monthincome = mountShowView.title;
    monthincome.text = @"62.00";
    monthincome.font = [UIFont boldSystemFontOfSize:40];
    monthincome.textColor = [UIColor colorWithHexString:APP_MAIN_COLOR];
    self.monthIncome = monthincome;
    UILabel *monthMoneyTipLabel = mountShowView.des;
    monthMoneyTipLabel.text = @"本月收入(元)";
    monthMoneyTipLabel.font = [UIFont systemFontOfSize:15];
    //sperator line
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString: @"e6e6e6"];
    
    //task
    MonutShowView *todayIncome = [self column];
    _todayIncome = todayIncome.title;
    [todayIncome initData:@{@"title": @"12.00", @"des": @"今日收入"}];
    MonutShowView *finishTask = [self column];
    _todayFinishTask = finishTask.title;
    [finishTask initData:@{@"title": @"2", @"des": @"今日完成任务数"}];
    MonutShowView *switchNum = [self column];
    _todaySwitchNum = switchNum.title;
    [switchNum initData:@{@"title": @"10", @"des": @"今日换电数"}];
    
    [taskInfoView addSubview:tipLabel];
    [taskInfoView addSubview:mountShowView];
    [taskInfoView addSubview:line];
    [taskInfoView addSubview:todayIncome];
    [taskInfoView addSubview:finishTask];
    [taskInfoView addSubview:switchNum];
    
    [taskInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userInfoView.mas_bottom).offset(10);
        make.leading.equalTo(self.userInfoView.mas_leading);
        make.trailing.equalTo(self.userInfoView.mas_trailing);
        make.height.equalTo(@181);
    }];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskInfoView.mas_top).offset(14);
        make.leading.equalTo(taskInfoView.mas_leading).offset(15);
    }];
    
    [mountShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(tipLabel.mas_bottom).offset(10);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(15);
        make.trailing.equalTo(self.mas_trailing).offset(-15);
        make.top.equalTo(mountShowView.des.mas_bottom).offset(15);
        make.height.equalTo(@0.5);
    }];
    
    [todayIncome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(14);
        make.leading.equalTo(line.mas_leading).offset(45);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
    
    [finishTask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(14);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [switchNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(14);
        make.trailing.equalTo(line.mas_trailing).offset(-45);
    }];
    
    
}

-(MonutShowView *)column {
    MonutShowView *view = [[MonutShowView alloc] init];
    UILabel *title = view.title;
    UILabel *des = view.des;
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textColor = [UIColor colorWithHexString:@"333333"];
    des.font = [UIFont systemFontOfSize:12];
    des.textColor = [UIColor colorWithHexString: @"999999"];
    
    return view;
}


#pragma getter
-(UIImageView *)userAvator {
    if (_userAvator == nil) {
        _userAvator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_picker"]];
        _userAvator.contentMode = UIViewContentModeCenter;
        _userAvator.backgroundColor = [UIColor whiteColor];
        _userAvator.layer.masksToBounds = YES;
        _userAvator.layer.cornerRadius = 30;
    }
    return _userAvator;
}

-(UILabel *)userName {
    if (_userName == nil) {
        _userName = [[UILabel alloc] init];
        _userName.text = @"黄祯辉";
        _userName.font = [UIFont systemFontOfSize: 17];
        _userName.textColor = [UIColor whiteColor];
    }
    return _userName;
}

-(UILabel *)userType {
    if (_userType == nil) {
        _userType = [[UILabel alloc] init];
        _userType.text = @"官方换电员";
        _userType.font = [UIFont systemFontOfSize: 12];
        _userType.textColor = [UIColor colorWithHexString:@"333333"];
        _userType.backgroundColor = [UIColor whiteColor];
    }
    return _userType;
}

@end
