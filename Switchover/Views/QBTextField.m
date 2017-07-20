//
//  QBTextField.m
//  Switchover
//
//  Created by zhenhui huang on 2017/7/18.
//  Copyright © 2017年 walkbydream. All rights reserved.
//

#import "QBTextField.h"

@implementation QBTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
//    iconRect.origin.x += 15;
    return iconRect;
    
}
//
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super rightViewRectForBounds:bounds];
    
    iconRect.origin.x -= 15;
    return iconRect;
    
}


- (CGRect)textRectForBounds:(CGRect)bounds{
    
    CGRect rect = [super textRectForBounds:bounds];
    
    rect.size.width = rect.size.width - 30.0f;
    
    rect.origin.x += 16;
    rect.origin.y = 0;
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    CGRect rect = [super editingRectForBounds:bounds];
    rect.size.width = rect.size.width - 30.0f;
    rect.origin.x += 16;
    rect.origin.y = 0;
    return rect;
}

@end
