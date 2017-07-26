//
//  ToolCollectionView.h
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/9.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ToolSelectedItemBlock)(NSInteger index);


@interface ToolCollectionView : UICollectionView
@property (nonatomic,strong) NSArray *dataArry;
@property (nonatomic,copy) ToolSelectedItemBlock toolSelectedItemBlock;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout andDataSource :(NSArray *)data;


@end
