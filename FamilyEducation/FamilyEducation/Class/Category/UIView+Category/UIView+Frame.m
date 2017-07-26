//
//  UIView+Frame.m
//  MyFramework
//
//  Created by 张发政 on 2017/1/6.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}
-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}
-(void)setWidth:(CGFloat)width{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}
-(void)setHeight:(CGFloat)height{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (CGFloat)height{
    return self.frame.size.height;
}

-(CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)gf_centerX
{
    CGPoint rect = self.center;
    rect.x = gf_centerX;
    self.center = rect;
}


-(CGFloat)centerY
{
    return self.center.y;
}

-(void)setCenterY:(CGFloat)gf_centerY
{
    CGPoint rect = self.center;
    rect.y = gf_centerY;
    self.center = rect;
}


+(instancetype)viewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}


@end
