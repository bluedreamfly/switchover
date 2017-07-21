//
//  UserViewModel.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "UserViewModel.h"
#import "AFNetworking.h"

@implementation UserViewModel

-(void) authenticate:(void (^)(id _Nullable))success failure: (void (^)(NSError * _Nonnull))failure
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSDictionary *paramas = @{
                              @"name": self.name,
                              @"cardNo": self.cardNo
                              };
    
    [session POST:@"http://api.test.com/user/auth" parameters:paramas progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
    
}
@end
