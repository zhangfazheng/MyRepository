//
//  NSString+Verification.h
//  OperationEquipment
//
//  Created by 张发政 on 2017/3/13.
//  Copyright © 2017年 cyberplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Verification)
#pragma mark - 验证手机号码是否合法
+ (BOOL)stringValidateMobile:(NSString *)mobileNum;

#pragma mark - 计算字体size
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

//验证IP是否合法
- (BOOL)stringValidateIP;
@end
