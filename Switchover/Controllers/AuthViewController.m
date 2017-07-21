//
//  AuthViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "AuthViewController.h"
#import "CompleteInfoViewController.h"
#import "UserViewModel.h"
#import "UIColor+Hex.h"
#import "AppColor.h"
#import "ReactiveObjC.h"
#import "MBProgressHUD.h"

@interface AuthViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNoLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *cardNoInput;
@property (weak, nonatomic) IBOutlet UIButton *authBtn;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (strong, nonatomic) UserViewModel *userViewModel;
@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setView];
    
    self.userViewModel = [[UserViewModel alloc] init];
    
    [self initRAC];
}

-(void) initRAC {
    
    RAC(self.userViewModel, name) = [self.nameInput rac_textSignal];
    
    RAC(self.userViewModel, cardNo) = [self.cardNoInput rac_textSignal];
    
    RACSignal *nameSignal = RACObserve(self.userViewModel, name);
    
    RACSignal *cardNoSignal = RACObserve(self.userViewModel, cardNo);
    
    @weakify(self);
    [[RACSignal merge:@[nameSignal, cardNoSignal]] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        if (self.userViewModel.name.length > 0 && self.userViewModel.cardNo.length == 18) {
            self.authBtn.enabled = YES;
            self.authBtn.alpha = 1;
        } else {
            self.authBtn.enabled = NO;
            self.authBtn.alpha = 0.2;
        }
    }];
}


- (void) setView {
    
    self.nameLabel.textColor = [UIColor colorWithHexString: APP_MAIN_SECOND_COLOR];
    
    self.cardNoLabel.textColor = [UIColor colorWithHexString:APP_MAIN_SECOND_COLOR];
    
    self.seperatorLine.backgroundColor = [UIColor colorWithHexString:APP_SEPERATOR_LINE_COLOR];
    self.authBtn.layer.cornerRadius = 3;
    self.authBtn.backgroundColor = [UIColor colorWithHexString:APP_MAIN_COLOR];
    
    self.authBtn.alpha = 0.45;
    [self.authBtn setTitleColor: [UIColor colorWithHexString:APP_MAIN_FONT_COLOR] forState:UIControlStateNormal];
    
}


- (IBAction)authIdentity:(UIButton *)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    
    
    [self performSegueWithIdentifier:@"completeInfo" sender: self];
//    [self.userViewModel authenticate:^(id  _Nullable responseObject) {
//        
////        NSLog(@"result %@", responseObject[@"status"]);
//        if ([responseObject[@"status"] intValue] == 0) {
//            
//            hud.label.text = @"认证成功";
//        } else {
//            hud.label.text = responseObject[@"msg"];
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [NSThread sleepForTimeInterval:1];
//            [hud hideAnimated:YES];
//            if ([responseObject[@"status"] intValue] == 0) {
////                CompleteInfoViewController *completeInfoController = [[CompleteInfoViewController alloc] init];
////                [self.navigationController pushViewController: completeInfoController  animated:YES];
//                
//                [self performSegueWithIdentifier:@"completeInfo" sender: self];
//            }
//            
//        });
//    
//    } failure:^(NSError * _Nullable error) {
//        NSLog(@"request fail %@", error);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
}


@end
