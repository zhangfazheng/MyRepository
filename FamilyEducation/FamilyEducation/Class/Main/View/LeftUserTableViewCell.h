//
//  LeftUserTableViewCell.h
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/5.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "BaseCell.h"

@interface LeftUserTableViewCell : BaseCell
@property (strong, nonatomic) UIImageView *headIcon;
@property (strong, nonatomic) UILabel *userNameLable;
@end


@interface LeftUserTableViewCellModel : NSObject
@property (copy,nonatomic) NSString *iconImage;
@property (copy,nonatomic) NSString *userName;
@end
