//
//  QBUserTableViewCell.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/24.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "QBUserTableViewCell.h"
#import "Masonry.h"

@implementation QBUserTableViewCell

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


-(void) initContentView {

    UIImageView *imageView = [[UIImageView alloc] init];
    self.frontImageView = imageView;
    
    UILabel *title = [[UILabel alloc] init];
    
    title.font = [UIFont systemFontOfSize:14];
    self.title = title;
    
    UILabel *des = [[UILabel alloc] init];
    
    self.des = des;
    
    UIImageView *afterImageView = [[UIImageView alloc] init];
    
    self.afterImageView = afterImageView;
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:title];
    [self.contentView addSubview:afterImageView];
    [self.contentView addSubview:des];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.leading.equalTo(self.contentView.mas_leading).offset(15);
//        make.width.equalTo(@20);
//        make.height.equalTo(@20);
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.leading.equalTo(imageView.mas_trailing).offset(10);
    }];
    
    [afterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-15);
    }];
    
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.trailing.equalTo(afterImageView.mas_leading).offset(-10);
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
@end
