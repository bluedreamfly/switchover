//
//  CompleteInfoViewController.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "BaseViewController.h"
#import "CityViewModel.h"

@interface CompleteInfoViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (strong, nonatomic, readwrite) CityViewModel *city;
@end
