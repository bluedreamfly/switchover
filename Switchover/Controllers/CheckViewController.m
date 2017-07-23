//
//  CheckViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/23.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "CheckViewController.h"

@interface CheckViewController ()

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCodeView];
    
    
    // Do any additional setup after loading the view.
}

-(void) initCodeView {

    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title = @"审核中";
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"refresh" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(refresh)];
    
    [refreshButton setImage:[UIImage imageNamed:@"refresh"]];
    [refreshButton setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    
}

-(void) refresh {
    
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
