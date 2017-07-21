//
//  CityViewModel.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/21.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityViewModel : NSObject

//用户名
@property (nonatomic, strong, readwrite) NSString * _Nullable name;

@property (nonatomic, strong, readwrite) NSNumber * _Nullable code;

+(void) getCityList: (nullable void (^)(id _Nullable responseObject))success
            failure:(nullable void (^)(NSError * _Nullable error))failure;
@end
