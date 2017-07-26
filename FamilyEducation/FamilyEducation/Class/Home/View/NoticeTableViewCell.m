//
//  NoticeTableViewCell.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/8.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "NoticeTableViewCell.h"
#import <Masonry.h>


@interface NoticeTableViewCell ()
//@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *noticeLable;
@property (nonatomic,strong) UILabel *timeLable;
@end

@implementation NoticeTableViewCell

- (void)setupCell{
    [super setupCell];
    
    [self setUpUI];
}

- (void)setUpUI{
    //[self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.noticeLable];
    [self.contentView addSubview:self.timeLable];
    
    WeakSelf
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset(8);
        make.width.height.mas_equalTo(35);
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(8);
        make.left.equalTo(_iconImageView.mas_right).offset(8);
        make.height.mas_equalTo(21).priorityHigh();
        make.width.mas_equalTo(170);
    }];
    
    [_noticeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLable.mas_bottom).offset(8);
        make.leading.equalTo(_titleLable);
        make.height.equalTo(_titleLable);
        make.bottom.equalTo(weakSelf.contentView).offset(-8);
    }];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_noticeLable.mas_right).offset(8);
        make.right.equalTo(weakSelf.contentView).offset(-8);
        make.centerY.equalTo(_noticeLable);
        make.width.mas_equalTo(80);
    }];
    
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(weakSelf.contentView);
//        make.height.mas_equalTo(1);
//    }];
    
}


-(void)loadContent{
    if (self.data) {
        NoticeModel *item           = self.data;
        
        if (!isEmptyString(item.titleStr)) {
            self.titleLable.text    = item.titleStr;
        }
        if (!isEmptyString(item.noticeStr)) {
            self.noticeLable.text   = item.noticeStr;
        }
        if (!isEmptyString(item.timeStr)) {
            self.timeLable.text     = item.timeStr;
        }
    }
}


#pragma mark-懒加载控件
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        UIImageView *imageView          = [UIImageView new];
        imageView.image                 = [UIImage imageNamed:@"icon-info"];
        
        _iconImageView                  = imageView;
    }
    return _iconImageView;
    
}

- (UILabel *)titleLable{
    if (!_titleLable) {
        UILabel *lable                  = [UILabel new];
        lable.font                      = Font_Medium_Title;
        
        _titleLable                     = lable;
    }
    return _titleLable;
}

- (UILabel *)noticeLable{
    if (!_noticeLable) {
        UILabel *lable                  = [UILabel new];
        lable.font                      = Font_Medium_Text;
        lable.numberOfLines             = 0;
        
        _noticeLable                     = lable;
    }
    return _noticeLable;
}

- (UILabel *)timeLable{
    if (!_timeLable) {
        UILabel *lable                  = [UILabel new];
        lable.font                      = Font_Medium_Text;
        lable.textColor                 = [UIColor grayColor];
        lable.textAlignment             = NSTextAlignmentRight;
        
        _timeLable                      = lable;
    }
    return _timeLable;
}

//- (UIView *)lineView{
//    if (!_lineView) {
//        UIView *view                    = [UIView new];
//        view.backgroundColor            = [UIColor colorWithWhite:0.1 alpha:0.2];
//        
//        _lineView                       = view;
//    }
//    return _lineView;
//}

@end
