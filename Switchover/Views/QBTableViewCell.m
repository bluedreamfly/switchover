//
//  QBTableViewCell.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "QBTableViewCell.h"
#import "Masonry.h"
#import "AppColor.h"
#import "UIColor+Hex.h"

@implementation QBTableViewCell

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

    //titleLabel
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //desLabel
    self.desLabel = [[UILabel alloc] init];
    self.desLabel.font = [UIFont systemFontOfSize:12];
    self.desLabel.textColor = [UIColor colorWithHexString:APP_MAIN_SECOND_COLOR];
    
    //参考图片
    UIView *imageWrap = [[UIView alloc] init];
    
    self.referenceImgView = [[UIImageView alloc] init];
    imageWrap.backgroundColor = [UIColor colorWithHexString:LOGIN_LEFTVIEW_BGCOLOR];
    [imageWrap addSubview:self.referenceImgView];
    
    //图片上传
    self.uploadBtn = [[UIButton alloc] init];
    self.uploadBtn.backgroundColor = [UIColor colorWithHexString:LOGIN_LEFTVIEW_BGCOLOR];
    self.uploadImageView = [[UIImageView alloc] init];
    self.uploadImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.uploadBtn addSubview:self.uploadImageView];
    
    //参考范例
    UILabel *tipLalel = [[UILabel alloc] init];
    tipLalel.text = @"参考范例";
    tipLalel.font = [UIFont systemFontOfSize:12];
    tipLalel.textColor = [UIColor colorWithHexString:APP_MAIN_SECOND_COLOR];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.desLabel];
    [self.contentView addSubview: imageWrap];
    [self.contentView addSubview:self.uploadBtn];
    [self.contentView addSubview: tipLalel];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-15);
        make.leading.equalTo(self.contentView.mas_leading).offset(15);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-15);
        make.leading.equalTo(self.contentView.mas_leading).offset(15);
    }];
    
    [imageWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.contentView.mas_leading).offset(15);
        make.height.greaterThanOrEqualTo(@100);
        make.width.greaterThanOrEqualTo(@167);
    }];
    
    [self.referenceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageWrap.mas_top).offset(0);
        make.leading.equalTo(imageWrap.mas_leading).offset(0);
        make.width.equalTo(imageWrap.mas_width);
        make.height.equalTo(imageWrap.mas_height);
    }];
    
    [self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.desLabel.mas_bottom).offset(10);
        make.leading.equalTo(imageWrap.mas_trailing).offset(10);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-15);
        make.height.equalTo(imageWrap.mas_height);
        make.width.equalTo(imageWrap.mas_width);
    }];
    
    [self.uploadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.uploadBtn.mas_centerX);
        make.centerY.equalTo(self.uploadBtn.mas_centerY);
    }];
    
    [tipLalel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageWrap.mas_bottom).offset(10);
        make.leading.equalTo(self.contentView.mas_leading).offset(70);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-15);
    }];

    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
