//
//  BaseViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "BaseViewController.h"
#import "UIColor+Hex.h"
#import "AppColor.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {

    [self.navigationController.navigationBar setBarTintColor: [UIColor whiteColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

-(void) initView {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationController.navigationBar setBarTintColor: [UIColor whiteColor]];
    self.view.backgroundColor = [UIColor colorWithHexString: APP_MAIN_BGCOLOR];
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
