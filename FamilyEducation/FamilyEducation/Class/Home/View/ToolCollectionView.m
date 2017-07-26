//
//  ToolCollectionView.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/9.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "ToolCollectionView.h"
#import "ToolCollectionViewCell.h"

@interface ToolCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ToolCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout andDataSource :(NSArray *)data{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        _dataArry       = data;
        self.delegate   = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[ToolCollectionViewCell class] forCellWithReuseIdentifier:@"ToolCollectionViewCell"];
        
    }
    return self;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArry.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ToolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolCollectionViewCell" forIndexPath:indexPath];
    cell.titleLable.text            = self.dataArry[indexPath.row][@"title"];
    cell.iconImageView.image        = [UIImage imageNamed:self.dataArry[indexPath.row][@"icon"]];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.toolSelectedItemBlock) {
        self.toolSelectedItemBlock(indexPath.item);
    }
}


#pragma mark-懒加载
- (NSArray *)dataArry{
    if (!_dataArry) {
        _dataArry = [NSArray array];
    }
    return _dataArry;
}



@end
