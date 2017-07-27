//
//  UIViewController+Aop.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/25.
//  Copyright © 2017年 walkbydream. All rights reserved.
//
#import <objc/runtime.h>
#import "UIViewController+Aop.h"
#import "AppColor.h"
#import "UIColor+Hex.h"

@implementation UIViewController (Aop)

+(void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(aop_viewWillAppear:);
        
        SEL originalSelector1 = @selector(viewDidLoad);
        SEL swizzledSelector1 = @selector(aop_viewDidLoad);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        Method originalMethod1 = class_getInstanceMethod(class, originalSelector1);
        Method swizzledMethod1= class_getInstanceMethod(class, swizzledSelector1);
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        // ...
        // Method originalMethod = class_getClassMethod(class, originalSelector);
        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        BOOL didAddMethod1 =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod1),
                        method_getTypeEncoding(swizzledMethod1));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        if (didAddMethod1) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod1),
                                method_getTypeEncoding(originalMethod1));
        } else {
            method_exchangeImplementations(originalMethod1, swizzledMethod1);
        }
    });

}

-(void)aop_viewDidLoad {
    [self aop_viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithHexString: APP_MAIN_BGCOLOR];
}

- (void)aop_viewWillAppear:(BOOL)animated {
    [self aop_viewWillAppear:animated];
//    NSLog(@"viewWillAppear: %@", self);
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
//    
//    [self.navigationController.navigationBar setBarTintColor: [UIColor whiteColor]];
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//
    [self.navigationController.navigationBar setBarTintColor: [UIColor whiteColor]];
//    self.view.backgroundColor = [UIColor colorWithHexString: APP_MAIN_BGCOLOR];
}

@end
