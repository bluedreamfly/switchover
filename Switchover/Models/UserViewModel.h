//
//  UserViewModel.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserViewModel : NSObject

//用户名
@property (nonatomic, strong, readwrite) NSString *name;
//用户身份证卡号
@property (nonatomic, strong, readwrite) NSString *cardNo;

//用户身份认证
-(void) authenticate;
@end
