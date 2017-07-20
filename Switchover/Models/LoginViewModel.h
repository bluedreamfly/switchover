//
//  LoginViewModel.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

@property (nonatomic, strong, readwrite) NSString *phone;
@property (nonatomic, strong, readwrite) NSString *password;

-(void) loginIn;

@end
