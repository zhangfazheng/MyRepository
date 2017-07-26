//
//  Config.m
//  HutHelper
//
//  Created by nine on 2017/2/10.
//  Copyright © 2017年 nine. All rights reserved.
//

 
#import "User.h"
#import "Config.h"
#import "AppDelegate.h"
static int Is ;

@implementation Config
#pragma mark - 特殊设置
+ (void)setIs:(int )bools
{
    Is = bools;
}
+ (int )getIs
{
    return Is;
}
#pragma mark - 用户信息
+(User*)getUser{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *userData=[defaults objectForKey:@"kUser"];
    User *user=[[User alloc ]initWithDic:userData];
    return user;
}
+(NSString*)getStudentKH{
    User *user=self.getUser;
    return user.studentKH;
}
+(NSString*)getUserName{
    User *user=self.getUser;
    return user.userName;
}
+(NSString*)getTrueName{
    User *user=self.getUser;
    return user.trueName;
}
+(NSString*)getAddress{
    User *user=self.getUser;
    return user.address;
}
+(NSString*)getClassName{
    User *user=self.getUser;
    return user.className;
}
+(NSString*)getDepName{
    User *user=self.getUser;
    return user.depName;
}
+(NSString*)getHeadPicThumb{
    User *user=self.getUser;
    return user.head_pic_thumb;
}
+(NSString*)getLastLogin{
    User *user=self.getUser;
    return user.last_login;
}
+(NSString*)getSex{
    User *user=self.getUser;
    return user.sex;
}
+(NSString*)getUserId{
    User *user=self.getUser;
    return user.user_id;
}

+(NSString*)getRememberCodeApp{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"remember_code_app"];
}
#pragma mark - 持续化存储
+(void)saveUser:(NSDictionary*)userData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:userData forKey:@"kUser"];
    [defaults synchronize];
}
+(void)saveRememberCodeApp:(NSString*)rememberCodeApp{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:rememberCodeApp forKey:@"remember_code_app"];
    [defaults synchronize];
}
+(void)saveCourse:(NSArray*)course{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:course forKey:@"kCourse"];
    [defaults synchronize];
}
+(void)saveCourseXp:(NSArray*)course{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:course forKey:@"kCourseXp"];
    [defaults synchronize];
}
+(void)saveWidgetCourse:(NSArray*)course{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.HutHelper"];
    [shared setObject:course forKey:@"kCourse"];
    [shared synchronize];
}
+(void)saveWidgetCourseXp:(NSArray*)course{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.HutHelper"];
    [shared setObject:course forKey:@"kCourseXp"];
    [shared synchronize];
}
+(void)saveSay:(NSDictionary*)sayData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:sayData forKey:@"Say"];
    [defaults synchronize];
}
+(void)saveSayLikes:(NSDictionary*)sayLikesData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:sayLikesData forKey:@"SayLikes"];
    [defaults synchronize];
}
+(void)saveHand:(NSArray*)handData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:handData forKey:@"Hand"];
    [defaults synchronize];
}
+(void)saveScore:(NSData*)scoreData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:scoreData forKey:@"Score"];
    [defaults synchronize];
}
+(void)saveExam:(NSData*)examData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:examData forKey:@"Exam"];
    [defaults synchronize];
}
+(void)saveLost:(NSArray*)lostData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:lostData forKey:@"Lost"];
    [defaults synchronize];
}
+(void)saveNowWeek:(int)nowWeek{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setInteger:nowWeek forKey:@"NowWeek"];
    [defaults synchronize];
}
#pragma mark - 获得存储数据
+(NSArray*)getCourse{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"kCourse"];
}
+(NSArray*)getCourseXp{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"kCourseXp"];
}
#pragma mark - 版本信息
+(void)saveCurrentVersion:(NSString*)currentVersion{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:currentVersion forKey:@"last_run_version_key"];
    [defaults synchronize];
}
#pragma mark - 界面
+(void)pushViewController:(NSString*)controller{
    UIStoryboard *mainStoryBoard              = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *secondViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:controller];
    AppDelegate *tempAppDelegate              = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.mainNavigationController pushViewController:secondViewController animated:YES];
}
#pragma mark - 通知
+(void)addNotice{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *noticeDictionary=@{@"time":@"2017-03-17 24:00",
                                            @"title":@"工大助手",
                                            @"body":@"工大助手V1.9.9更新日志\n\n- 新增了校园说说点赞功能 \n- 修复了Widget时间问题 \n- 修改了校园说说配色\n- 修改了校园说说相同课程相同颜色  \n- 新增了切换用户提示语\n\n如果您对App有任何建议或者发现了Bug\n可以在侧栏-反馈中告诉我们，我向您保证每个Bug都会尽快修复，每个意见都会得到回复，另外在AppStore中求个好评🙏"
    };
    
    NSDictionary *noticeDictionary2=@{@"time":@"2017-02-20 08:00",
                                     @"title":@"开发者的一些话",
                                     @"body":@"首先感谢你在新的学期里继续使用工大助手,由于团队每个人的分工不同，整个iOS端仅由我一个人的负责开发。对此，如果之前版本App有给你带来不便的地方，希望您能够理解。\n\n在新的版本中，我修改了大量的界面并对程序进行了优化。如果您还发现有任何Bug，可以通过【左滑菜单-反馈】向我反馈，我向您保证，您反馈的每一个Bug我都会修复，提的每一个建议，我们都会认真考虑。\n\n同时如果App给您有带来了便利，希望您可以在【左滑菜单-关于-去AppStore评分】给App进行评分，对一个整天码代码的程序猿来说，这是最好的鼓励了🙏\n"
                                     };
    NSArray *array = @[noticeDictionary,noticeDictionary2];
    [defaults setObject:array forKey:@"Notice"];//通知列表
    [defaults synchronize];
}
#pragma mark - 设置
+(void)setNoSharedCache{
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0
                                                            diskCapacity:0
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
}
@end
