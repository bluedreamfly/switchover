//
//  CheckFailureViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/23.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "CheckFailureViewController.h"
#import "AppColor.h"
#import "UIColor+Hex.h"

@interface CheckFailureViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *reApplyBtn;

@end

@implementation CheckFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCodeView];
    
    self.navigationItem.title = @"审核失败";
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.
}


-(void) initCodeView {
    
    self.tipLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.reApplyBtn.backgroundColor = [UIColor colorWithHexString:APP_MAIN_COLOR];
    
    self.reApplyBtn.tintColor = [UIColor whiteColor];
    self.reApplyBtn.layer.cornerRadius = 3;
//    [self.reApplyBtn setTitleColor: forState:<#(UIControlState)#>]

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
