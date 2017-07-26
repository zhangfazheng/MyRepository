//
//  HomeTitleHeaderView.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/8.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "HomeTitleHeaderView.h"
#import <Chameleon.h>
#import <Masonry.h>



@interface HomeTitleHeaderView ()
@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIButton *noticeButton;
@property (nonatomic,copy) NoticeButtonAction block;
@end


@implementation HomeTitleHeaderView

- (void)buildSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.backgroundImageView];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.noticeButton];
    
    WeakSelf
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(-11);
        make.top.bottom.equalTo(weakSelf.contentView);
//        make.width.mas_equalTo(206);
        make.height.mas_equalTo(40).priorityHigh();
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(24);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(21);
    }];
    
    [_noticeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-8);
        make.centerY.equalTo(weakSelf.contentView);
    }];
}

- (void)loadContent{
    if (self.data) {
        HomeTitleModel *model       =self.data;
        
        if (!isEmptyString(model.titleStr)) {
            self.titleLable.text    = model.titleStr;
        }
        if (!isEmptyString(model.noticeStr)) {
            self.noticeButton.hidden= NO;
            [self.noticeButton setTitle:model.noticeStr forState:UIControlStateNormal];
            [self.noticeButton addTarget:self action:@selector(buttonClickAction) forControlEvents:UIControlEventTouchUpInside];
            self.block              = model.block;
        }else{
            self.noticeButton.hidden= YES;
        }
        
    }
}

- (void)buttonClickAction{
    if (self.block) {
        self.block();
    }
    
}

#pragma mark-懒加载控件
- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        UIImageView *imageView          = [UIImageView new];
        imageView.image                 = [UIImage imageNamed:@"main3"];
        [imageView setContentMode:UIViewContentModeCenter];
        imageView.layer.masksToBounds   = YES;
        
        _backgroundImageView            = imageView;
        
    }
    return _backgroundImageView;
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        UILabel *lable                  = [UILabel new];
        //lable.textColor                 = FlatGreen;
        lable.font                      = Font_Medium_Text;
        
        
        _titleLable                     = lable;
    }
    return _titleLable;
}

- (UIButton *)noticeButton{
    if (!_noticeButton) {
        UIButton *button                = [UIButton new];
        button.hidden                   = YES;
        [button setTitleColor:FlatGreen forState:UIControlStateNormal];
        
        [button.titleLabel setFont:Font_Small_Title];
        
        _noticeButton                   = button;
    }
    
    return _noticeButton;
}


@end
