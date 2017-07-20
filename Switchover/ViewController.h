//
//  ViewController.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/18.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBTextField.h"
#import "LoginViewModel.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *logo;


@property (strong, nonatomic) QBTextField *phone;

@property (strong, nonatomic) QBTextField *password;

@property (strong, nonatomic) UIImageView *phoneLeftImageView;

@property (strong, nonatomic) UIImageView *passwordLeftImageView;

@property (strong, nonatomic) UIButton *codeBtn;

@property (strong, nonatomic) UIButton *login;

@property (strong, nonatomic) LoginViewModel *loginViewModel;





@end

