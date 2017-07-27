//
//  CustomUtil.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/25.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "CustomUtil.h"

@implementation CustomUtil

+(NSString *) formatMoney: (NSNumber *)money
{
    NSString *moneyStr = [NSString stringWithFormat:@"%@", money];
    if ([moneyStr rangeOfString:@"."].length > 0) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.roundingMode = NSNumberFormatterRoundFloor;
        formatter.maximumFractionDigits = 2;
        return [formatter stringFromNumber:money];
    }
    return [NSString stringWithFormat:@"%@%@", moneyStr, @".00"];
}

@end
