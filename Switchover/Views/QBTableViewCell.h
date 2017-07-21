//
//  QBTableViewCell.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBTableViewCell : UITableViewCell

@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *desLabel;

@property (strong, nonatomic)  UIImageView *referenceImgView;
@property (strong, nonatomic)  UIImageView *uploadImageView;
@property (strong, nonatomic)  UIButton *uploadBtn;
@end
