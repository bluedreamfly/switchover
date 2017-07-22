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

-(void) upload:(NSData *)imageData success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nullable))failure {
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSLog(@"upload imageDATA %@", imageData);
    
    [session POST:@"http://api.test.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
        
        
        [formData appendPartWithFileData:imageData name:@"upload" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}
@end
