//
//  LeftItemTableViewCell.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/5.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "LeftItemTableViewCell.h"
#import <Masonry.h>

@implementation LeftItemTableViewCell

-(void)setupCell{
    [super setupCell];
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self setupUI];
}

- (void)setupUI{
    [self.contentView addSubview:self.imageIcon];
    [self.contentView addSubview:self.titleTextLable];
    
    WeakSelf
    [_imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(62);
        make.top.equalTo(weakSelf.contentView).offset(8);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25).priorityHigh();
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-8);
        
    }];
    
    [_titleTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_imageIcon);
        make.left.equalTo(_imageIcon.mas_right).offset(22);
    }];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)loadContent{
    if (self.dataAdapter.data) {
        
        LeftItemTableViewCellModel *item    = self.dataAdapter.data;
        [_imageIcon setImage:[UIImage imageNamed:item.iconImage]];
        _titleTextLable.text                = item.titleText;
        
    }

}

#pragma mark- 懒加载控件
- (UILabel *)titleTextLable{
    if (!_titleTextLable) {
        UILabel *lable              = [UILabel new];

        [lable setTextColor:[UIColor whiteColor]];
        
        _titleTextLable             =lable;
    }
    return _titleTextLable;
}

- (UIImageView *)imageIcon{
    if (!_imageIcon) {
        UIImageView *imageView      = [UIImageView new];
        
        _imageIcon                  = imageView;
    }
    return _imageIcon;
}


@end

@implementation LeftItemTableViewCellModel


@end
