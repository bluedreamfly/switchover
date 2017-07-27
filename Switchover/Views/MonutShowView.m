//
//  MonutShowView.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/24.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "MonutShowView.h"
#import "Masonry.h"
@implementation MonutShowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initCodeView];
    }
    return self;
}

-(void)initCodeView {
    UILabel *title = [[UILabel alloc] init];
    UILabel *des = [[UILabel alloc] init];
    
    self.title = title;
    self.des = des;
    [self addSubview:title];
    [self addSubview:des];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
//        make.height.equalTo(@30);
    }];
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(title.mas_bottom).offset(0);
    }];
}

-(void) initData: (NSDictionary *) data{
    self.title.text = data[@"title"];
    self.des.text = data[@"des"];
}
@end
