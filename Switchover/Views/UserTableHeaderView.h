//
//  UserTableHeaderView.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/24.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableHeaderView : UIView

//用户头像
@property (nonatomic, strong) UIImageView *userAvator;
//用户名
@property (nonatomic, strong) UILabel *userName;
//用户身份
@property (nonatomic, strong) UILabel *userType;
//本月收入
@property (nonatomic, strong) UILabel *monthIncome;
//今日收入
@property (nonatomic, strong) UILabel *todayIncome;
//今日完成任务数
@property (nonatomic, strong) UILabel *todayFinishTask;
//今日换电数量
@property (nonatomic, strong) UILabel *todaySwitchNum;

@end
