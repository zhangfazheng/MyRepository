//
//  UIImage+SolidColor.m
//  OperationEquipment
//
//  Created by 张发政 on 2017/3/13.
//  Copyright © 2017年 cyberplus. All rights reserved.
//

#import "UIImage+SolidColor.h"

@implementation UIImage (SolidColor)
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color {
    
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
