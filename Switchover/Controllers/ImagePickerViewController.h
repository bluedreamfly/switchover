//
//  ImagePickerViewController.h
//  Switchover
//
//  Created by zhenhui huang on 2017/7/21.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic)  UIActionSheet *actionSheet;
@property (strong, nonatomic)  UIViewController *parentCon;

-(void) open;
@end
