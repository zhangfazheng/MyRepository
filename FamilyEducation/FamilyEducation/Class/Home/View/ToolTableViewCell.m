//
//  ToolTableViewCell.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/9.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "ToolTableViewCell.h"
#import <Masonry.h>
#import "ToolCollectionView.h"

@interface ToolTableViewCell ()
@property (nonatomic,strong) ToolCollectionView *toolCollectionView;
@property (assign, nonatomic) CGFloat toolHeight;
@end

@implementation ToolTableViewCell

- (void)setupCell{
    [super setupCell];
    
    [self setUpUI];
}

- (void)setUpUI{
    [self.contentView addSubview:self.toolCollectionView];
    
    
    WeakSelf
    [_toolCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(_toolHeight).priorityHigh();
    }];
    
}

- (ToolCollectionView *)createToolCollectionView{
    NSArray *toolArry   = @[@{@"title":@"百科全书",@"icon":@"icon-library"},
                            @{@"title":@"课程表",@"icon":@"icon-curriculum"},
                            @{@"title":@"学习计划",@"icon":@"icon-exam"},
                            @{@"title":@"成绩查询",@"icon":@"chengji"},
                            @{@"title":@"网上作业",@"icon":@"icon-homework-inline"},
                            @{@"title":@"二手市场",@"icon":@"icon-second-hand"},
                            @{@"title":@"教育说说",@"icon":@"icon-social"},
                            @{@"title":@"家长手册",@"icon":@"icon-elec"},
                            @{@"title":@"实验课表",@"icon":@"icon-lab"},
                            @{@"title":@"日历",@"icon":@"icon-calendar"},
                            @{@"title":@"失物招领",@"icon":@"icon-lost"},
                            @{@"title":@"百科全书",@"icon":@"icon-library"},
                            @{@"title":@"课程表",@"icon":@"icon-curriculum"},
                            @{@"title":@"学习计划",@"icon":@"icon-exam"},
                            @{@"title":@"成绩查询",@"icon":@"chengji"},
                            @{@"title":@"网上作业",@"icon":@"icon-homework-inline"},
                            @{@"title":@"二手市场",@"icon":@"icon-second-hand"},
                            @{@"title":@"教育说说",@"icon":@"icon-social"},
                            @{@"title":@"家长手册",@"icon":@"icon-elec"},
                            @{@"title":@"实验课表",@"icon":@"icon-lab"},
                            @{@"title":@"日历",@"icon":@"icon-calendar"},
                            @{@"title":@"失物招领",@"icon":@"icon-lost"}];
    
    CGFloat toolWith            = ScreenWidth;
    CGFloat topButtonInset      = 15;
    CGFloat leftRightInset      = 5;
    CGFloat lineSpace           = 20;
    CGFloat spacing             = toolWith<=320?10:15;
    _toolHeight = ((toolArry.count+3)/4)*70+((toolArry.count+3)/4-1)*lineSpace+topButtonInset*2;
    
    
    UICollectionViewFlowLayout *toolViewLayout = [[UICollectionViewFlowLayout alloc] init];
    toolViewLayout.minimumInteritemSpacing = spacing;
    toolViewLayout.minimumLineSpacing =lineSpace;
    toolViewLayout.sectionInset = UIEdgeInsetsMake(topButtonInset, leftRightInset, topButtonInset, leftRightInset);
    toolViewLayout.estimatedItemSize = CGSizeMake(70, 70);
    
    
    ToolCollectionView *toolView =[[ToolCollectionView alloc]initWithFrame:CGRectMake(0, 0, toolWith, _toolHeight) collectionViewLayout:toolViewLayout andDataSource:toolArry];
    
    return toolView;
    
}

#pragma mark-懒加载控件
- (ToolCollectionView *)toolCollectionView{
    if (!_toolCollectionView) {
        ToolCollectionView *imageView          = [self createToolCollectionView];
        
        WeakSelf
        imageView.toolSelectedItemBlock = ^(NSInteger index) {
            weakSelf.toolSelectedItemBlock(index);
        };
        _toolCollectionView                  = imageView;
    }
    return _toolCollectionView;
    
}


@end
