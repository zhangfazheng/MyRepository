//
//  BaseHeaderFooterView.m
//  MyFramework
//
//  Created by 张发政 on 2017/1/4.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "BaseHeaderFooterView.h"

@implementation BaseHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupHeaderFooterView];
        [self buildSubview];
    }
    
    return self;
}

- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color {
    
    self.contentView.backgroundColor = color;
}

- (void)setupHeaderFooterView {
    
}

- (void)buildSubview {
    
}

- (void)loadContent {
    
}
@end
