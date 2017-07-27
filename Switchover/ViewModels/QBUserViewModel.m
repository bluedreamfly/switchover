//
//  QBUserViewModel.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/24.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "QBUserViewModel.h"
#import "CustomUtil.h"

@implementation QBUserViewModel

-(instancetype)init {
    
    if (self = [super init]) {
        self.linkList = [[NSMutableArray alloc]init];
        [self.linkList addObject:@{@"title": @"我的钱包", @"frontImage": @"wallet"}];
        [self.linkList addObject:@{@"title": @"历史任务", @"frontImage": @"history_task"}];
        [self.linkList addObject:@{@"title": @"联系客服", @"frontImage": @"contact"}];
        [self.linkList addObject:@{@"title": @"设置", @"frontImage": @"setting"}];
        
        self.userName = @"";
        self.userType = @"未认证";
        self.monthIncome = @"0.00";
        self.todayIncome = @"0.00";
        self.todayFinishTasks = @"0";
        self.todaySwitchNums = @"0";
        self.userModel = [[UserViewModel alloc] init];
    }
    return self;
}

-(void) fetchUserInfo
{
    
    [self.userModel getUserInfo:^(id  _Nullable responseObject) {

        if ([responseObject[@"status"] intValue] == 0) {
            
            NSDictionary *data = responseObject[@"data"];
            self.userName = data[@"userName"];
            self.userType = [data[@"status"] intValue] == 0 ? @"未认证" : @"官方换电员";
            NSString *strUrl = [NSString stringWithFormat:@"%@?%@", data[@"avatorImage"], @"imageView2/1/w/60/h/60"];
            NSURL* aURL = [NSURL URLWithString: strUrl];
            NSData* imageData = [[NSData alloc] initWithContentsOfURL:aURL];
            UIImage *image = [UIImage imageWithData:imageData];
            self.avatorImage = image;
            self.monthIncome = [CustomUtil formatMoney:data[@"monthIncome"]];
            self.todayIncome = [CustomUtil formatMoney:data[@"todayIncome"]];
            self.todayFinishTasks = [NSString stringWithFormat:@"%@", data[@"todayFinishTask"]];
            self.todaySwitchNums = [NSString stringWithFormat:@"%@", data[@"todaySwitchNum"]];
            self.walletAmount = data[@"walletMount"];
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
