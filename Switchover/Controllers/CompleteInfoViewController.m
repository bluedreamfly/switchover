//
//  CompleteInfoViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/20.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "CompleteInfoViewController.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "AppColor.h"
#import "QBTableViewCell.h"
#import "SelectCityViewController.h"
#import "ReactiveObjC.h"
#import "ImagePickerViewController.h"
#import "UserViewModel.h"
#import "CheckViewController.h"
#import "CheckFailureViewController.h"

@interface CompleteInfoViewController () 
@property (weak, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) UIButton *selectCityBtn;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *checkBtn;
@property (strong, nonatomic) UILabel *cityLabel;

@property (strong, nonatomic)  UIActionSheet *actionSheet;
@property (strong, nonatomic)  ImagePickerViewController *imagePicker;
@property (strong, nonatomic)  UserViewModel *userViewModel;


@end

@implementation CompleteInfoViewController
{
  NSMutableArray *dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initCodeView];
    
    [self bindEvent];
    
    [self initRAC];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.navigationItem.title = @"完善资料";
    self.navigationItem.hidesBackButton = YES;
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    if (self.city.name != nil) {
        self.cityLabel.text = self.city.name;
        self.userViewModel.city = self.city;
    }

}

-(void) bindEvent {

    [self.selectCityBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    
    [self.checkBtn addTarget:self action:@selector(checkUser) forControlEvents:UIControlEventTouchUpInside];
}


-(void) checkUser {
   
    [self.userViewModel checkAuth:^(id  _Nullable responseObject) {
        NSLog(@"checkUser %@", responseObject);
        if ([responseObject[@"status"] intValue] == 0) {
//            CheckViewController *checkController = [[CheckViewController alloc] init];
            
//            CheckViewController *checkController =  [self.storyboard instantiateViewControllerWithIdentifier:@"checking"];
//            
            CheckFailureViewController *checkFailure = [
                                                        self.storyboard instantiateViewControllerWithIdentifier:@"checkFailure"];
            
            
            [self.navigationController pushViewController:checkFailure animated:YES];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];

}

-(void) selectCity {
    
//    NSLog(@"hello world");
    
    SelectCityViewController *selectCity = [[SelectCityViewController alloc] init];
//    [selectCity.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:selectCity animated:YES];

}

-(void) initData {
    dataArray = [[NSMutableArray alloc]init];
    
    [dataArray addObject:@{
//                           @"type":,
                           @"title": @"上传身份证正面照片",
                           @"imageName": @"card_front",
                           @"des": @"请保证身份证正面文字清晰可见"
                           }];
    [dataArray addObject:@{
                           @"title": @"上传身份证反面照片",
                           @"imageName": @"card_back",
                           @"des": @"请保证身份证反面文字清晰可见"
                           }];
    [dataArray addObject:@{
                           @"title": @"上传正脸与身份证合照",
                           @"imageName": @"person_card",
                           @"des": @"请保证您的脸部和身份证清晰可见，不可重叠遮挡"
                           }];

}

-(void)initRAC {
    
    self.userViewModel = [[UserViewModel alloc] init];
    
    RACSignal *city = RACObserve(self.userViewModel, city);
//    self.userViewModel.cardPersonImage
    RACSignal *cardFront = RACObserve(self.userViewModel, cardFrontImage);
    RACSignal *cardBack = RACObserve(self.userViewModel, cardBackImage);
    RACSignal *cardPerson = RACObserve(self.userViewModel, cardPersonImage);
    
    [[RACSignal merge:@[city, cardFront, cardBack, cardPerson]] subscribeNext:^(id  _Nullable x) {
        if (self.userViewModel.city != nil &&
            self.userViewModel.cardFrontImage != nil &&
            self.userViewModel.cardBackImage != nil &&
            self.userViewModel.cardPersonImage != nil) {
            
//            NSLog(@"initRAC%@", x);
            
            self.checkBtn.enabled = YES;
            self.checkBtn.alpha = 1;
            
        }
    }];
//    [city subscribeNext:^(id  _Nullable x) {
//        NSLog(@"initRAC%@", x);
//    }];
//    
//    [cardFront subscribeNext:^(id  _Nullable x) {
//        NSLog(@"initRAC%@", x);
//    }];
    
    
}


-(void)initCodeView {
    
    //城市btn view
    UIButton *btn = [[UIButton alloc] init];
    self.selectCityBtn = btn;
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.shadowOffset =  CGSizeMake(1, 1);
    btn.layer.shadowOpacity = 0.1;
    btn.layer.shadowColor = [[UIColor blackColor] CGColor];
    [self.view addSubview:btn];
    
    UILabel *position = [[UILabel alloc] init];
    self.cityLabel = position;
    position.text = @"工作地点";
    position.textColor = [UIColor colorWithHexString:@"333333"];
    
    UILabel *select = [[UILabel alloc] init];
    select.text = @"请选择";
    select.textColor = [UIColor colorWithHexString:@"333333"];
    
    UIImage *arrowImage= [UIImage imageNamed:@"jump_arrow_icon"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:arrowImage];
    
    
    //bottom view
    UIView *bottomView = [[UIView alloc] init];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"E1E1E1"];
    self.tableView = [[UITableView alloc] init];
    
    self.checkBtn = [[UIButton alloc] init];
    [self.checkBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    self.checkBtn.backgroundColor = [UIColor colorWithHexString: APP_MAIN_COLOR];
    self.checkBtn.layer.cornerRadius = 3;
    self.checkBtn.alpha = 0.45;
    self.checkBtn.enabled = NO;
    
    [btn addSubview:position];
    [btn addSubview:imageView];
    [btn addSubview:select];
    [self.container addSubview:self.tableView];
    
    [self.container addSubview:bottomView];
    
    [bottomView addSubview:_checkBtn];
    [bottomView addSubview:line];
    
    //相关约束
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.container.mas_top).offset(0);
        make.leading.equalTo(self.container.mas_leading).offset(0);
        make.trailing.equalTo(self.container.mas_trailing).offset(0);
        make.height.greaterThanOrEqualTo(@44);
    }];
    
    [position mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(btn.mas_leading).offset(15);
        make.centerY.equalTo(btn.mas_centerY);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(btn.mas_trailing).offset(-15);
        make.centerY.equalTo(btn.mas_centerY);
        make.width.greaterThanOrEqualTo(@6);
        make.height.greaterThanOrEqualTo(@12);
    }];
    
    
    [select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(imageView.mas_leading).offset(-5);
        make.centerY.equalTo(btn.mas_centerY);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(2);
        make.leading.equalTo(self.container.mas_leading).offset(0);
        make.trailing.equalTo(self.container.mas_trailing).offset(0);
        make.bottom.equalTo(self.container.mas_bottom).offset(-64);
    }];
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.container.mas_top).offset(0);
        make.leading.equalTo(self.container.mas_leading).offset(0);
        make.trailing.equalTo(self.container.mas_trailing).offset(0);
        make.height.greaterThanOrEqualTo(@44);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.container.mas_leading).offset(0);
        make.trailing.equalTo(self.container.mas_trailing).offset(0);
        make.bottom.equalTo(self.container.mas_bottom).offset(0);
        make.height.greaterThanOrEqualTo(@64);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).offset(0);
        make.trailing.equalTo(bottomView.mas_trailing).offset(0);
        make.leading.equalTo(bottomView.mas_leading).offset(0);
        make.height.greaterThanOrEqualTo(@1);
    }];
    
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(bottomView.mas_trailing).offset(-15);
        make.leading.equalTo(bottomView.mas_leading).offset(15);
        make.centerY.equalTo(bottomView.mas_centerY);
        make.height.greaterThanOrEqualTo(@44);
    }];
    
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"tableview count %ld", dataArray.count);
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *QBCellId = @"QBCell";
    QBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QBCellId];
    if (nil == cell) {
        cell = [[QBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QBCellId];
    }

    
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@", indexPath.row + 1, dataArray[indexPath.row][@"title"]];
    cell.desLabel.text = dataArray[indexPath.row][@"des"];
    if (indexPath.row < 2) {
        cell.referenceImgView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    }
    [cell.uploadBtn setImage:[UIImage imageNamed:@"image_picker"] forState:UIControlStateNormal];
//    cell.uploadImageView.image = [UIImage imageNamed:@"image_picker"];
//    cell.uploadImageView.image = [UIImage imageNamed:@"person_card"];
    cell.referenceImgView.image = [UIImage imageNamed:dataArray[indexPath.row][@"imageName"]];
    
    [cell.uploadBtn setTag:indexPath.row];
    
    [cell.uploadBtn addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void) upload:(UIButton *)sender{
    
    NSLog(@"upload %ld", sender.tag);
    
    self.imagePicker = [[ImagePickerViewController alloc] init];
    @weakify(self);
    [self.imagePicker setCallback:^(id responseObject) {
        @strongify(self);
        NSLog(@"completeinfo%@", responseObject);
        
        NSString *strUrl = [NSString stringWithFormat:@"%@?%@", responseObject[@"data"][@"url"], @"imageView2/1/w/167/h/100"];
        
        if (sender.tag == 0) {
            self.userViewModel.cardFrontImage = strUrl;
        }
        if (sender.tag == 1) {
            self.userViewModel.cardBackImage = strUrl;
        }
        
        if (sender.tag == 2) {
            self.userViewModel.cardPersonImage = strUrl;
        }
        
        NSURL* aURL = [NSURL URLWithString: strUrl];
        NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
        
        UIImage *image = [UIImage imageWithData:data];
        
        CGSize size = CGSizeMake(167, 100);
        
        UIGraphicsBeginImageContext(size);
        // 绘制改变大小的图片
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        [sender setImage:scaledImage forState:UIControlStateNormal];
        

        
    } failure:^(NSError *error) {
        
    }];
    
    self.imagePicker.parentCon = self;
    
    [self.imagePicker open];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 198;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
