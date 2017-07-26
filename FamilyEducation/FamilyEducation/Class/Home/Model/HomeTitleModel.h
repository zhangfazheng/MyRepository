//
//  HomeTitleModel.h
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/8.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NoticeButtonAction)();

@interface HomeTitleModel : NSObject
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *noticeStr;
@property (nonatomic,copy) NoticeButtonAction block;
@end
