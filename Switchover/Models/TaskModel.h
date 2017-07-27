//
//  TaskModel.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/26.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject
@property (nonatomic, readwrite) NSString * _Nullable taskId;
@property (nonatomic, readwrite) NSString * _Nullable time;
@property (nonatomic, readwrite) NSNumber * _Nullable reward;
@property (nonatomic, readwrite) NSNumber * _Nullable switchNum;
@property (nonatomic, readwrite) NSNumber * _Nullable useTime;

-(void) getTaskList: (NSDictionary *_Nullable) params
            success: (nullable void (^)(id _Nullable responseObject))success
            failure:(nullable void (^)(NSError * _Nullable error))failure;
@end
