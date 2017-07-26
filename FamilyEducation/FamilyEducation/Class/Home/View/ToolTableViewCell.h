//
//  ToolTableViewCell.h
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/9.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "BaseCell.h"

typedef void(^ToolTableSelectedItemBlock)(NSInteger index);

@interface ToolTableViewCell : BaseCell
@property (nonatomic,copy) ToolTableSelectedItemBlock toolSelectedItemBlock;
@end
