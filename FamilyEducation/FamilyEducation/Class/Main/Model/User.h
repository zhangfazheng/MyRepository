//
//  User.h
//  HutHelper
//
//  Created by nine on 2017/1/12.
//  Copyright © 2017年 nine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property NSString *trueName; //姓名
@property NSString *address;//省份
@property NSString *className;//班级
@property NSString *depName;//学院
@property NSString *headPic;//头像无压缩
@property NSString *head_pic_thumb;//头像
@property NSString *last_login;//最后一次登录
@property NSString *sex;//性别
@property NSString *studentKH;//学号
@property NSString *userName;//昵称
@property NSString *user_id;//说说id
-(instancetype)initWithDic:(NSDictionary*)Dic;
@end

