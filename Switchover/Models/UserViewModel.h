//
//  UserViewModel.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityViewModel.h"

@interface UserViewModel : NSObject

//用户名
@property (nonatomic, strong, readwrite) NSString * _Nullable name;
//用户身份证卡号
@property (nonatomic, strong, readwrite) NSString * _Nullable cardNo;

@property (nonatomic, strong, readwrite) NSString * _Nullable cardFrontImage;

@property (nonatomic, strong, readwrite) NSString * _Nullable cardBackImage;

@property (nonatomic, strong, readwrite) NSString * _Nullable cardPersonImage;

@property (nonatomic, strong) CityViewModel * _Nullable city;

//用户身份认证
-(void) authenticate:(nullable void (^)(id _Nullable responseObject))success
             failure:(nullable void (^)(NSError * _Nullable error))failure;


//身份核实
-(void) checkAuth: (nullable void (^)(id _Nullable responseObject))success
             failure:(nullable void (^)(NSError * _Nullable error))failure;

//图片上传
-(void) upload: (NSData *_Nullable)imageData success: (nullable void (^)(id _Nullable responseObject))success
             failure:(nullable void (^)(NSError * _Nullable error))failure;
@end
