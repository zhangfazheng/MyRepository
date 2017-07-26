//
//  ToolCollectionViewCell.h
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/9.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ToolSelectedItem)(NSInteger index);

@interface ToolCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,copy) ToolSelectedItem block;
@end
