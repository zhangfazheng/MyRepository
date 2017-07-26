//
//  LeftUserTableViewCell.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/5.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "LeftUserTableViewCell.h"
#import <Masonry.h>
#import "User.h"

@interface LeftUserTableViewCell()
@property (strong, nonatomic) UIImageView *editImageView;
@end

@implementation LeftUserTableViewCell

-(void)setupCell{
    [super setupCell];
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self setupUI];
}

- (void)setupUI{
    [self.contentView addSubview:self.headIcon];
    [self.contentView addSubview:self.userNameLable];
    [self.contentView addSubview:self.editImageView];
    
    [_headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.contentView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80).priorityHigh();
        
    }];
    
    [_userNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(31).priorityHigh();
        
        make.top.equalTo(_headIcon.mas_bottom).offset(22);
    }];
    
    [_editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLable.mas_right);
        make.width.height.mas_equalTo(16);
        make.centerY.equalTo(_userNameLable);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)loadContent{
    if (self.dataAdapter.data) {
        
        User *item    = self.dataAdapter.data;
        [_headIcon setImage:[UIImage imageNamed:@"head"]];
        _userNameLable.text                 = isEmptyString(item.trueName)?@"小明": item.trueName;
        
    }
    
}


#pragma mark- 懒加载控件
- (UILabel *)userNameLable{
    if (!_userNameLable) {
         UILabel *lable             = [UILabel new];
        lable.textAlignment         = NSTextAlignmentCenter;
        
        [lable setTextColor:[UIColor whiteColor]];
        
        _userNameLable              =lable;
    }
    return _userNameLable;
}

- (UIImageView *)headIcon{
    if (!_headIcon) {
        UIImageView *imageView      = [UIImageView new];
        imageView.image             = [UIImage imageNamed:@"head"];
        
        _headIcon                   = imageView;
    }
    return _headIcon;
}

- (UIImageView *)editImageView{
    if (!_editImageView) {
        UIImageView *imageView              = [UIImageView new];
        imageView.image                     = [UIImage imageNamed:@"pencil"];
        
        _editImageView                      = imageView;
        
    }
    
    return _editImageView;
}

@end


@implementation LeftUserTableViewCellModel



@end

