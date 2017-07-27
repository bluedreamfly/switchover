//
//  QBUserTableViewCell.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/24.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBUserTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) UIImageView *frontImageView;
@property (nonatomic, weak, readwrite) UIImageView *afterImageView;
@property (nonatomic, weak, readwrite) UILabel *title;
@property (nonatomic, weak, readwrite) UILabel *des;
@end
