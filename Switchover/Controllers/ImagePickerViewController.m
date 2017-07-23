//
//  ImagePickerViewController.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/21.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "ImagePickerViewController.h"
#import "UserViewModel.h"


typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);

@interface ImagePickerViewController ()
@property (strong, nonatomic) UserViewModel *userViewModel;
@property (strong, nonatomic) successBlock success;
@property (strong, nonatomic) failureBlock failure;
@end

@implementation ImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)open {
 
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"相册", @"拍照", nil];
    [self.actionSheet showInView: self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex)
    {
        [self localPhoto];
    }
    else if(1 == buttonIndex)
    {
       [self localPhoto];
    }
    
}

-(void)localPhoto
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.parentCon presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
//    NSLog(@"info %@", info);
    
    [self.parentCon dismissViewControllerAnimated:YES completion:nil];
    
    self.userViewModel = [[UserViewModel alloc] init];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [self.userViewModel upload:imageData success:^(id  _Nullable responseObject) {
        NSLog(@"result success %@", responseObject);
        
        self.success(responseObject);
    } failure:^(NSError * _Nullable error) {
//        NSLog(@"result failure %@", error);
        self.failure(error);
    }];
    
}

-(void)setCallback: (void (^)(id responseObject))success failure:(void (^)(NSError* error))failure
{
    self.success = success;
    self.failure = failure;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.parentCon dismissViewControllerAnimated:YES completion:nil];
}



@end
