//
//  MyWalletViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/24.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "MyWalletViewController.h"
#import "AppColor.h"
#import "UIColor+Hex.h"
#import "Masonry.h"
#import "MyWalletDetailViewController.h"

@interface MyWalletViewController ()
//@property (weak, nonatomic) IBOutlet UIView *moneyDetail;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleMoneyView;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (strong, nonatomic) UIButton *lookDetail;
@property (weak, nonatomic) IBOutlet UIView *lookWithdrawView;
@property (weak, nonatomic) IBOutlet UIView *lookMywalletDetailView;


@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCodeView];
    [self bindEvent];
    // Do any additional setup after loading the view.
}

-(void)bindEvent
{
    UITapGestureRecognizer *withdrawTab =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(lookWithdraw)];
    [self.lookWithdrawView addGestureRecognizer:withdrawTab];
    
    
    UITapGestureRecognizer *mywalletDetailTab =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(lookMywalletDetail)];
    [self.lookMywalletDetailView addGestureRecognizer:mywalletDetailTab];
    
    [self.lookDetail addTarget:self action:@selector(lookMoneyDetail:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)lookWithdraw
{
    NSLog(@"look with draw");
}
-(void)lookMywalletDetail
{
    NSLog(@"lookMywalletDetail");
}

-(void) initCodeView
{
    self.navigationItem.title = @"我的钱包";
    UIColor *color = [UIColor colorWithHexString:APP_MAIN_COLOR];
    self.topView.backgroundColor = color;
    self.middleMoneyView.backgroundColor = color;
//    self.moneyDetail.backgroundColor = color;
    self.middleMoneyView.layer.borderWidth = 5;
    self.middleMoneyView.layer.borderColor = [[UIColor colorWithHexString:@"48cafd"] CGColor];
    self.middleMoneyView.layer.cornerRadius = self.middleMoneyView.frame.size.width / 2;
    
    self.line1.backgroundColor = [UIColor colorWithHexString:APP_SEPERATOR_LINE_COLOR];
    self.line2.backgroundColor = [UIColor colorWithHexString:APP_SEPERATOR_LINE_COLOR];
    UIButton *moneyDetail = [[UIButton alloc] init];
    
    
    self.lookDetail = moneyDetail;
    [self.view addSubview:moneyDetail];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mywallet_hint"];
    
    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.text = @"资金明细";
    desLabel.font = [UIFont systemFontOfSize:12];
    desLabel.textColor = [UIColor whiteColor];
    desLabel.alpha = 0.7;
    
    [moneyDetail addSubview:imageView];
    [moneyDetail addSubview:desLabel];
    
    [moneyDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_top).offset(168);
        make.trailing.equalTo(self.topView.mas_trailing).offset(-40);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyDetail.mas_top);
        make.centerX.equalTo(moneyDetail.mas_centerX);
    }];
    
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(6);
        make.centerX.equalTo(moneyDetail.mas_centerX);
    }];
    
    
    
}

- (void)lookMoneyDetail:(UITapGestureRecognizer *)recognizer
{
//    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    MyWalletDetailViewController *myWalletDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"mywalletdetail"];
    
    [self.navigationController pushViewController:myWalletDetail animated:YES];
    
    NSLog(@"tab money detail");
    
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
