//
//  HistoryTaskViewModel.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/26.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskModel.h"
#import "ReactiveObjC.h"

@interface HistoryTaskViewModel : NSObject

@property (strong, nonatomic) NSMutableArray<NSMutableArray *> *tasks;
@property (strong, nonatomic) NSMutableDictionary *dateIndexMap;
@property (strong, nonatomic) NSMutableArray *taskSection;

-(RACSignal *)fetchTasks: (NSDictionary *)params;
-(void) resetData;
@end
