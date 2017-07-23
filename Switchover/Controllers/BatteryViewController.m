//
//  BatteryViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/23.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "BatteryViewController.h"
#import "AppColor.h"
#import "UIColor+Hex.h"
#import "Masonry.h"

@interface BatteryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (strong, nonatomic)  UIView *arrowView;
@property (strong, nonatomic)  UITableView *tableView;


@end

@implementation BatteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCodeView];
    
    
    
    
}

-(void)initCodeView {
    
    self.navigationItem.title = @"电池";
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor blackColor]];
    UIColor *bgColor = [UIColor colorWithHexString:APP_MAIN_COLOR];
    self.topBgView.backgroundColor = bgColor;
    
    self.leftView.backgroundColor = bgColor;
    
    self.rightView.backgroundColor = bgColor;
    
    
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBgView.mas_bottom);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.arrowView = [[UIView alloc] init];
    self.arrowView.backgroundColor = [UIColor whiteColor];
    [self.topBgView addSubview:self.arrowView];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topBgView.mas_leading).offset(84);
        make.bottom.equalTo(self.topBgView.mas_bottom).offset(7);
        make.width.equalTo(@14);
        make.height.equalTo(@14);
    }];
    
    self.arrowView.transform = CGAffineTransformMakeRotation(45 * M_PI / 180);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *QBCellId = @"QBCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QBCellId];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QBCellId];
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = @"hahah";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
