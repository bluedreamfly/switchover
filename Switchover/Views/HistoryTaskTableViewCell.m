//
//  HistoryTaskTableViewCell.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/25.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "HistoryTaskTableViewCell.h"
#import "MonutShowView.h"
#import "AppColor.h"
#import "UIColor+Hex.h"
#import "Masonry.h"

@implementation HistoryTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initContentView];
    }
    
    return self;
    
}

-(void) initContentView
{

//    self.contentView.layer.cornerRadius = 10;

    
    MonutShowView *view = [[MonutShowView alloc] init];
    self.moneyTitle = view.title;
    UILabel *title = view.title;
    UILabel *des = view.des;
    title.text = @"100.00";
    title.font = [UIFont boldSystemFontOfSize:35];
    title.textColor = [UIColor colorWithHexString:APP_MAIN_COLOR];
    des.font = [UIFont systemFontOfSize:13];
    des.text = @"所得奖励(元)";
    des.textColor = [UIColor colorWithHexString: @"999999"];
    
    [self.contentView addSubview:view];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"jump_arrow_icon"];
    [self.contentView addSubview:arrowImageView];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
    [self.contentView addSubview:line];
    
    UIImageView *timeImageView = [[UIImageView alloc] init];
    timeImageView.image = [UIImage imageNamed:@"history_task_time"];
    [self.contentView addSubview:timeImageView];
    
    UIView *bottomView = [[UIView alloc] init];
    
    [self.contentView addSubview:bottomView];
    [self.contentView addSubview:self.taskTime];
    [self.contentView addSubview:self.switchNum];
    [self.contentView addSubview:self.useTime];
    
//    UIEdgeInsets padding = UIEdgeInsetsMake(0, 15, 0, 15);
//    [container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView).with.insets(padding);
//    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(38.5);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-15);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.des.mas_bottom).offset(18);
        make.leading.equalTo(self.contentView.mas_leading);
        make.trailing.equalTo(self.contentView.mas_trailing);
        make.height.equalTo(@0.5);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.leading.equalTo(self.contentView.mas_leading);
        make.trailing.equalTo(self.contentView.mas_trailing);
        make.height.equalTo(@40);
    }];
    
    [timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(bottomView.mas_leading).offset(15);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    [_taskTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(timeImageView.mas_trailing).offset(5);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    [_switchNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    [_useTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.trailing.equalTo(bottomView.mas_trailing).offset(-15);
    }];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    if (highlighted) {
        self.backgroundColor= [UIColor grayColor];
    } else {
        self.backgroundColor= [UIColor whiteColor];
    }
}


#pragma -getter

- (void)setFrame:(CGRect)frame
{
//    frame.origin.y = frame.origin.y;
//    NSLog(@"setFrame%f", frame.origin.y);
    frame.origin.y += 10;//整体向下 移动10
    frame.size.height -= 10;//间隔为10
    frame.origin.x += 15;
    frame.size.width -= 30;
    [super setFrame:frame];
}

-(UILabel *)taskTime
{
    if (_taskTime == nil) {
        _taskTime = [[UILabel alloc] init];
        _taskTime.font = [UIFont systemFontOfSize:12];
        _taskTime.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _taskTime;
}

-(UILabel *)switchNum
{
    if (_switchNum == nil) {
        _switchNum = [[UILabel alloc] init];
        _switchNum.font = [UIFont systemFontOfSize:12];
        _switchNum.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _switchNum;
}

-(UILabel *)useTime
{
    if ( _useTime == nil) {
        _useTime = [[UILabel alloc] init];
        _useTime.font = [UIFont systemFontOfSize:12];
        _useTime.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _useTime;
}

@end
