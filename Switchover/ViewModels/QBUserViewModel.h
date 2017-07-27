//
//  QBUserViewModel.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/24.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserViewModel.h"

@interface QBUserViewModel : NSObject
@property (strong, nonatomic, readwrite) NSMutableArray *linkList;
@property (strong, nonatomic, readwrite) UIImage *avatorImage;
@property (strong, nonatomic, readwrite) NSString *userName;
@property (strong, nonatomic, readwrite) NSString *userType;
@property (strong, nonatomic, readwrite) NSString *monthIncome;
@property (strong, nonatomic, readwrite) NSString *todayIncome;
@property (strong, nonatomic, readwrite) NSString *todayFinishTasks;
@property (strong, nonatomic, readwrite) NSString *todaySwitchNums;
@property (strong, nonatomic, readwrite) NSNumber *walletAmount;
@property (strong, nonatomic) UserViewModel *userModel;

-(void) fetchUserInfo;

@end
