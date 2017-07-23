//
//  TaskViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/23.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "TaskViewController.h"
#import "AppColor.h"
#import "UIColor+Hex.h"
#import "BaseViewController.h"
#import "UserViewController.h"

@interface TaskViewController ()

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCodeView];
    // Do any additional setup after loading the view.
}

-(void) initCodeView {
    
    self.navigationItem.title = @"任务";
    UIBarButtonItem *batteryButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(pushBattery)];
    
    [batteryButton setImage:[UIImage imageNamed:@"battery_entry_icon"]];
    [batteryButton setTintColor:[UIColor colorWithHexString:APP_MAIN_SECOND_COLOR]];
    
    
    UIBarButtonItem *userButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(pushUser)];
    
    [userButton setImage:[UIImage imageNamed:@"user_entry_icon"]];
    [userButton setTintColor:[UIColor colorWithHexString: APP_MAIN_SECOND_COLOR]];
    self.navigationItem.rightBarButtonItem = batteryButton;
    self.navigationItem.leftBarButtonItem = userButton;
    
}

-(void) pushBattery {

    BaseViewController *batteryController = [self.storyboard instantiateViewControllerWithIdentifier:@"battery"];
    
    [self.navigationController pushViewController:batteryController animated:YES];

}

-(void) pushUser {

    UserViewController *userController = [[UserViewController alloc] init];
    
    [self.navigationController pushViewController:userController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
