//
//  LeftItemTableViewCell.h
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/5.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "BaseCell.h"

@interface LeftItemTableViewCell : BaseCell
@property (strong, nonatomic) UIImageView *imageIcon;
@property (strong, nonatomic) UILabel *titleTextLable;
@end


@interface LeftItemTableViewCellModel : NSObject
@property (copy,nonatomic) NSString *iconImage;
@property (copy,nonatomic) NSString *titleText;
@end
