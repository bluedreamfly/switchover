//
//  ViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/18.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Hex.h"
#import "AppColor.h"
#import "Masonry.h"
#import "ReactiveObjC.h"

@import AFNetworking;


@interface ViewController ()

@end

@implementation ViewController

//int originNum = 10;
int timeNum = 10;

NSTimer * timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginViewModel = [[LoginViewModel alloc] init];
    
    [self initView];
    
    [self initRAC];
    [self bindEvent];
    
    _phone.delegate = self;

}

-(void)initRAC {

    RAC(self.loginViewModel, phone) = [_phone rac_textSignal];
    
    RAC(self.loginViewModel, password) = [_password rac_textSignal];
    
    RACSignal *phoneSignal = RACObserve(self.loginViewModel, phone);
    
    RACSignal *passwordSignal = RACObserve(self.loginViewModel, password);
    
    @weakify(self);
    [[RACSignal merge:@[phoneSignal, passwordSignal]] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        if (self.loginViewModel.phone.length == 11 && self.loginViewModel.password.length == 4) {
            self.login.enabled = YES;
            self.login.alpha = 1;
        } else {
            self.login.enabled = NO;
            self.login.alpha = 0.2;
        }
    }];

    [phoneSignal subscribeNext:^(id  _Nullable value) {
        @strongify(self);
        NSString *phone = (NSString *)value;
    
        if (phone.length == 11) {
            [self.codeBtn setTitleColor:[UIColor colorWithHexString:APP_MAIN_COLOR] forState:UIControlStateNormal];
            
        }else {
        [self.codeBtn setTitleColor:[UIColor colorWithHexString:APP_MAIN_SECOND_COLOR] forState:UIControlStateNormal];
        }
        
    }];
}

- (void)initView {
    
    _phone = [[QBTextField alloc] init];
    [_phone setTranslatesAutoresizingMaskIntoConstraints:NO];
    _phone.backgroundColor = [UIColor colorWithHexString: @"F2F2F2"];
    _phone.layer.cornerRadius = 4.0f;
    _phone.clipsToBounds = YES;
    _phone.placeholder = @"输入手机号";
    _phone.keyboardType = UIKeyboardTypeNumberPad;
    _password = [[QBTextField alloc]init];
    [_password setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    _password.layer.cornerRadius = 4.0f;
    _password.clipsToBounds = YES;
    _password.backgroundColor = [UIColor colorWithHexString: @"F2F2F2"];
    _password.placeholder = @"输入验证码";
    
    _password.keyboardType = UIKeyboardTypeNumberPad;
    

    UIButton *login = [[UIButton alloc] init];
    _login = login;
    [login setTranslatesAutoresizingMaskIntoConstraints:NO];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor colorWithHexString:APP_MAIN_FONT_COLOR] forState:UIControlStateNormal];
    login.layer.cornerRadius = 3.0f;
    
    login.backgroundColor = [UIColor colorWithHexString: APP_MAIN_COLOR];
    [self.view addSubview:_phone];
    [self.view addSubview:_password];
    [self.view addSubview:login];
    
    UIView *phoneLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    
    phoneLeftView.backgroundColor = [UIColor colorWithHexString:LOGIN_LEFTVIEW_BGCOLOR];
    _phoneLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_icon"]];
    [_phoneLeftImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [phoneLeftView addSubview:_phoneLeftImageView];
    
    [self setFieldIconContraints:phoneLeftView child:_phoneLeftImageView];
    
    _phone.leftView = phoneLeftView;
    _phone.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    passwordLeftView.backgroundColor = [UIColor colorWithHexString:LOGIN_LEFTVIEW_BGCOLOR];
    
    _passwordLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_icon"]];
    [_passwordLeftImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [passwordLeftView addSubview:_passwordLeftImageView];
    
    [self setFieldIconContraints:passwordLeftView child:_passwordLeftImageView];
    
    _password.leftView = passwordLeftView;
    _password.leftViewMode = UITextFieldViewModeAlways;
    
    _codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [codeBtn set]
    [_codeBtn setTitleColor:[UIColor colorWithHexString: APP_MAIN_SECOND_COLOR] forState:(UIControlStateNormal)];
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _codeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [_codeBtn sizeToFit];
//    [_codeBtn layoutIfNeeded];
    _password.rightView = _codeBtn;
    _password.rightViewMode = UITextFieldViewModeAlways;
    
    
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logo.mas_bottom).offset(65);
        make.leading.equalTo(self.view.mas_leading).offset(15);
        make.trailing.equalTo(self.view.mas_trailing).offset(-15);
        make.height.greaterThanOrEqualTo(@44);
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phone.mas_bottom).offset(20);
        make.leading.equalTo(self.view.mas_leading).offset(15);
        make.trailing.equalTo(self.view.mas_trailing).offset(-15);
        make.height.greaterThanOrEqualTo(@44);
    }];
    
    
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_password.mas_bottom).offset(30);
        make.leading.equalTo(self.view.mas_leading).offset(15);
        make.trailing.equalTo(self.view.mas_trailing).offset(-15);
        make.height.greaterThanOrEqualTo(@44);
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_phone resignFirstResponder];
    [_password resignFirstResponder];
}

- (void)setFieldIconContraints: (UIView*)parent child:(UIView*)child {
    
    
    [child mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(parent.mas_centerX);
        make.centerY.equalTo(parent.mas_centerY);
        make.width.greaterThanOrEqualTo(@15);
        make.height.greaterThanOrEqualTo(@20);
    }];
}

- (void)setRowContraints: (UIView *)parent relate:(UIView *)relate child:(UIView *)child {


}


-(void)bindEvent {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
//    [_phone addTarget:self action:@selector(editFinish) forControlEvents:UIControlEventEditingChanged];
    
    [_codeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    
    [_login addTarget:self action:@selector(opLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [_phone addTarget:self action:@selector(phoneInputFocus:) forControlEvents:UIControlEventEditingDidBegin];
    
    [_password addTarget:self action:@selector(passwordInputFocus) forControlEvents:UIControlEventEditingDidBegin];
    
}

-(void) phoneInputFocus:(id)sender {
    
    [_passwordLeftImageView setImage:[UIImage imageNamed:@"password_icon"]];
    [_phoneLeftImageView setImage:[UIImage imageNamed:@"phone_selected_icon"]];

}

//-(void)setImage: (QBTextField *)container icon:(NSString *)icon {
//    
//    for(UIView *view in container.leftView.subviews) {
//        
//        if ([view isKindOfClass:[UIImageView class]]) {
//            
//            UIImageView *imageView = (UIImageView* )view;
//            [imageView setImage:[UIImage imageNamed:icon]];
//        }
//        
//        
//    }
//
//}

-(void) passwordInputFocus {
    
    [_phoneLeftImageView setImage:[UIImage imageNamed:@"phone_icon"]];
    [_passwordLeftImageView setImage:[UIImage imageNamed:@"password_selected_icon"]];

}

-(void)opLogin{
    
    NSString *phone = _phone.text;
    NSString *password = _password.text;
    
    
    [self validateUser];
    
    
    NSLog(@"%@, %@", phone, password);
    
}

-(void) validateUser {

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session POST:@"http://mobileapi.dbike.co/user/token/create" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject[@"msg"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error :%@", error);
        }
    }];
}
-(void)getCode {
    
    if (_phone.text.length == 11) {
        
        [_codeBtn setTitle:@"59" forState:UIControlStateNormal];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        
        [timer setFireDate:[NSDate distantPast]];
        
        [_codeBtn setTitleColor:[UIColor colorWithHexString:APP_MAIN_SECOND_COLOR] forState:UIControlStateNormal];

        NSLog(@"获取验证码");
    }

}

//倒计时
-(void)countDown {
    NSString *title = [NSString stringWithFormat:@"%ds重新获取", timeNum];
    if (timeNum < 10) {
      title = [NSString stringWithFormat:@"%@%@", @"0", title];
    }
    [_codeBtn setTitle:title forState:UIControlStateNormal];
    
    timeNum -= 1;
    
    if(timeNum == 0) {
        [timer invalidate];
        timer = nil;
        timeNum = 10;
        [_codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    
//    [_codeBtn sizeToFit];
//    [_codeBtn layoutIfNeeded];
//    [_codeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
}

-(void)editFinish {
//    NSLog(@"edit finish");
//    [self.view  endEditing:YES];
}

-(void)keyboardWillShow: (NSNotification *)data
{
//    NSLog(@"keyboardWillShow");

    CGRect keyboardBounds;
    
    [[data.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
//    NSNumber *duration = [data.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSNumber *curve = [data.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // 获取输入框的位置和大小
    CGRect containerFrame = _phone.frame;
    CGRect containerFrame1 = self.view.frame;
    
    // 计算出输入框的y坐标
    containerFrame.origin.y = self.view.bounds.size.height - keyboardBounds.size.height - containerFrame.size.height;
//    containerFrame1.origin.y = -100;
    
    self.view.frame = containerFrame1;
//    if (containerFrame.origin.y > self.view.bounds.size.height - keyboardBounds.size.height) {
//        
//    }
    
    
    // 动画改变位置
//    [UIView animateWithDuration:[duration doubleValue] animations:^{
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:1];
//        [UIView setAnimationCurve:[curve intValue]];
//        // 更改输入框的位置
//        _phone.frame = containerFrame;
//    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *text = textField.text;
    int newLen = (int)text.length + (int)string.length - (int)range.length;
    return newLen <= 11;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
