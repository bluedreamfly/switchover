//
//  HistoryTaskViewModel.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/26.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "HistoryTaskViewModel.h"
#import "AFNetworking.h"
#import "CustomUtil.h"


@implementation HistoryTaskViewModel


-(instancetype)init
{

    if (self = [super init]) {
        [self resetData];
    }
    return self;
}


-(RACSignal *)fetchTasks: (NSDictionary *)params
{

    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session GET:@"http://api.test.com/task/list" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self handleData:responseObject[@"data"]];
            [subscriber sendNext: self.tasks];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
//            [dataTask cancel];
        }];
    }];
}


-(void)resetData
{
    self.tasks = [[NSMutableArray alloc] init];
    self.dateIndexMap = [[NSMutableDictionary alloc] init];
    self.taskSection = [[NSMutableArray alloc] init];
}

-(void) handleData: (id)data
{
    NSMutableArray *arr = (NSMutableArray *)data;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDateFormatter *sectionDate = [[NSDateFormatter alloc]init];
    [sectionDate setDateFormat:@"yyyy-MM-dd"];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *originData = (NSDictionary *)arr[i];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970: [(NSString *)originData[@"time"] doubleValue] / 1000];
        
        NSString *time = [dateFormatter stringFromDate:date];
        NSString *sectionStr = [sectionDate stringFromDate:date];
        
        
        NSDictionary *task = @{
                               @"reward": [CustomUtil formatMoney:originData[@"reward"]],
                               @"time": time,
                               @"switchNum": originData[@"switchNum"],
                               @"useTime": originData[@"useTime"]
                               };
        [self mapSection:sectionStr task:task];
    }

}

-(void) mapSection: (NSString *)sectionDate task: (NSDictionary *)task
{
    NSNumber *index = self.dateIndexMap[sectionDate];
    if ( index != nil) {
        [[self.tasks objectAtIndex:[index intValue]] addObject: task];
    } else {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:task];
        [self.tasks addObject:arr];
        
        self.dateIndexMap[sectionDate] = [NSNumber numberWithInteger:self.tasks.count - 1];
        
        [self.taskSection addObject:sectionDate];
    }
    
}

@end
