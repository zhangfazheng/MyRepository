//
//  ToolCollectionViewCell.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/9.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "ToolCollectionViewCell.h"
#import <Masonry.h>

@implementation ToolCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLable];
    
    WeakSelf
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.width.mas_equalTo(47);
        make.height.mas_equalTo(35).priorityHigh();
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImageView.mas_bottom).offset(8);
        make.left.right.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        make.width.mas_equalTo(70).priorityHigh();
        make.height.mas_equalTo(27).priorityHigh();
    }];
}


#pragma mark- 懒加载控件
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        UIImageView *imageView      = [UIImageView new];
        
        _iconImageView              = imageView;
    }
    return _iconImageView;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        UILabel *lable              = [UILabel new];
        lable.textAlignment         = NSTextAlignmentCenter;
        lable.font                  = Font_Medium_Text;
        
        _titleLable                 = lable;
    }
    return _titleLable;
}


@end
