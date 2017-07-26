//
//  AbstractModel.m
//  MyFramework
//
//  Created by 张发政 on 2017/1/16.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "AbstractModel.h"

@implementation AbstractModel
// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}
- (NSUInteger)hash {
    return [self yy_modelHash];
}
- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}
- (NSString *)description {
    return [self yy_modelDescription];
}
@end
