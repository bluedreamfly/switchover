//
//  MonutShowView.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/24.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonutShowView : UIView

@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *des;

-(void) initData:(NSDictionary *) data;
@end
