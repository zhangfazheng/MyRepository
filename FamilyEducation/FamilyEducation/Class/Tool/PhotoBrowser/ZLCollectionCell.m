//
//  ZLCollectionCell.m
//  多选相册照片
//
//  Created by long on 15/11/25.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ZLCollectionCell.h"

@implementation ZLCollectionCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
//    [self.btnSelect setImage:[UIImage imageNamed:@"ZLPhotoBrowser.bundle/compose_photo_close"] forState:UIControlStateNormal];
    
    [self.btnSelect addTarget:self action:@selector(functionMy) forControlEvents:UIControlEventTouchUpInside];
}

- (void)functionMy{
    NSLog(@"点击了我");
}
@end
