//
//  UIView+Frame.h
//  MyFramework
//
//  Created by 张发政 on 2017/1/6.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (assign,nonatomic) CGFloat x;

@property (assign,nonatomic) CGFloat y;

@property (assign,nonatomic) CGFloat width;

@property (assign,nonatomic) CGFloat height;

@property CGFloat centerX;

@property CGFloat centerY;

+(instancetype) viewFromXib;

- (BOOL)isShowingOnKeyWindow;
@end
