//
//  CityViewModel.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/21.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "CityViewModel.h"
#import "AFNetworking.h"


@implementation CityViewModel

+(void) getCityList: (void (^)(id _Nullable))success failure: (void (^)(NSError * _Nonnull))failure
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:@"http://api.test.com/city" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}

@end
