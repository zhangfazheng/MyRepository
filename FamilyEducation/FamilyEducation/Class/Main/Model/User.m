//
//  User.m
//  HutHelper
//
//  Created by nine on 2017/1/12.
//  Copyright © 2017年 nine. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithDic:(NSDictionary*)Dic{
    self = [super init];
    if (self) {
        self.trueName=Dic[@"TrueName"];
        self.address=Dic[@"address"];
        self.className=Dic[@"class_name"];
        self.depName=Dic[@"dep_name"];
        self.headPic=Dic[@"head_pic"];
        self.head_pic_thumb=Dic[@"head_pic_thumb"];
        self.last_login=Dic[@"last_login"];
        self.studentKH=Dic[@"studentKH"];
        self.userName=Dic[@"username"];
        self.user_id=Dic[@"user_id"];
        self.sex=Dic[@"sex"];
    }
    return self;
}
@end
