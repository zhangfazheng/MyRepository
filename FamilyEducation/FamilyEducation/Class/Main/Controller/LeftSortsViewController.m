//
//  LeftSortsViewController.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/5.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"


#import "LeftUserTableViewCell.h"
#import "LeftItemTableViewCell.h"
#import "UITableView+CellClass.h"
#import "Config.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#import <SDWebImageDownloader.h>


@interface LeftSortsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray<CellDataAdapter *> *itemsArry;
@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview           = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image                  = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    UITableView *tableview           = [[UITableView alloc] init];
    self.tableview                   = tableview;
    tableview.frame                  = self.view.bounds;
    tableview.dataSource             = self;
    tableview.delegate               = self;
    tableview.separatorStyle         = UITableViewCellSeparatorStyleNone;
    //[tableview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tableview];
    
    [self loadData];
}

- (void)loadData{
    [_tableview registerCellsClass:@[cellClass(@"LeftUserTableViewCell", nil),cellClass(@"LeftItemTableViewCell", nil)]];
    
    _tableview.estimatedRowHeight =44;
    
    [self.itemsArry addObject:[LeftUserTableViewCell dataAdapterWithCellReuseIdentifier:@"LeftUserTableViewCell" data:[Config getUser] cellHeight:0 type:0]];
    
    LeftItemTableViewCellModel *itemModel0      = [LeftItemTableViewCellModel new];
    [self.itemsArry addObject:[LeftItemTableViewCell dataAdapterWithCellReuseIdentifier:@"LeftItemTableViewCell" data:itemModel0 cellHeight:0 type:0]];
    
    LeftItemTableViewCellModel *itemModel1      = [LeftItemTableViewCellModel new];
    itemModel1.iconImage                        = @"shares";
    itemModel1.titleText                        = @"分享应用";
    [self.itemsArry addObject:[LeftItemTableViewCell dataAdapterWithCellReuseIdentifier:@"LeftItemTableViewCell" data:itemModel1 cellHeight:0 type:0]];
    
    LeftItemTableViewCellModel *itemModel2      = [LeftItemTableViewCellModel new];
    itemModel2.iconImage                        = @"sign-out";
    itemModel2.titleText                        = @"切换用户";
    [self.itemsArry addObject:[LeftItemTableViewCell dataAdapterWithCellReuseIdentifier:@"LeftItemTableViewCell" data:itemModel2 cellHeight:0 type:0]];
    
    LeftItemTableViewCellModel *itemModel3      = [LeftItemTableViewCellModel new];
    itemModel3.iconImage                        = @"about";
    itemModel3.titleText                        = @"关于";
    [self.itemsArry addObject:[LeftItemTableViewCell dataAdapterWithCellReuseIdentifier:@"LeftItemTableViewCell" data:itemModel3 cellHeight:0 type:0]];
    
    LeftItemTableViewCellModel *itemModel4      = [LeftItemTableViewCellModel new];
    itemModel4.iconImage                        = @"feedback";
    itemModel4.titleText                        = @"反馈";
    [self.itemsArry addObject:[LeftItemTableViewCell dataAdapterWithCellReuseIdentifier:@"LeftItemTableViewCell" data:itemModel4 cellHeight:0 type:0]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==0) {
//        return 150;
//    }else{
//        return 45;
//    }
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    LeftUserTableViewCell *userCell;
//    LeftItemTableViewCell *itemCell;
//    if (!userCell) {
//        userCell=[LeftUserTableViewCell tableViewCell];
//    }
//    if (!itemCell) {
//        itemCell=[LeftItemTableViewCell tableViewCell];
//    }
//    userCell.backgroundColor             = [UIColor clearColor];
//    itemCell.backgroundColor             = [UIColor clearColor];
//    
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults]; //得到用户数据
//    if (indexPath.row == 0) {
//        if(!Config.getTrueName){
//            userCell.Username.text              = @"个人中心";
//        }else{
//            userCell.Username.text                = Config.getTrueName;
//        }
//        userCell.Head.image=[self getImg];
//        return userCell;
//    } else if (indexPath.row == 2) {
//        itemCell.Text.text              = @"分享应用";
//        itemCell.Img.image=[UIImage imageNamed:@"shares"];
//        return itemCell;
//    } else if (indexPath.row == 3) {
//        itemCell.Text.text                = @"切换用户";
//        itemCell.Img.image=[UIImage imageNamed:@"sign-out"];
//        return itemCell;
//    } else if (indexPath.row == 4) {
//        itemCell.Text.text                = @"关于";
//        itemCell.Img.image=[UIImage imageNamed:@"about"];
//        return itemCell;
//    } else if (indexPath.row == 5) {
//        itemCell.Text.text                = @"反馈";
//        itemCell.Img.image=[UIImage imageNamed:@"feedback"];
//        return itemCell;
//    }else{
//        return itemCell;
//    }
    return [tableView dequeueAndLoadContentReusableCellFromAdapter:_itemsArry[indexPath.row] indexPath:indexPath controller:self];
    
}

//-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return row;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AppDelegate *tempAppDelegate     = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];  //得到用户数据
//    NSString *name=[defaults objectForKey:@"trueName"];
//    
//    static NSString *Identifier      = @"Identifier";
//    UITableViewCell *cell            = [tableView dequeueReusableCellWithIdentifier:Identifier];
//    LeftUserTableViewCell *userCell=[LeftUserTableViewCell tableViewCell];
//    if (cell == nil) {
//        cell                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
//    }
//    
//    if (indexPath.row == 0) { //个人界面
//        [self.tableview reloadData];
//        UIStoryboard *mainStoryBoard              = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        CourseViewController *secondViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"User"];
//        AppDelegate *tempAppDelegate     = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [tempAppDelegate.mainNavigationController pushViewController:secondViewController animated:NO];
//        
//    }
//    
//    if (indexPath.row == 2) {  //分享
//        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_Sina)]];
//        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//            [self shareWebPageToPlatformType:platformType];
//        }];
//    }
//    
//    if (indexPath.row == 3) {  //切换用户
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"切换用户" message:@"是否要退出当前账号" preferredStyle:  UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            NSString *appDomain       = [[NSBundle mainBundle] bundleIdentifier];
//            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];  //删除本地数据缓存
//            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            LoginViewController *firstlogin                = [[LoginViewController alloc] init];
//            [tempAppDelegate.mainNavigationController pushViewController:firstlogin animated:YES];
//            [UMessage removeAllTags:^(id responseObject, NSInteger remain, NSError *error) {//删除友盟标签缓存
//            }];
//        }]];
//        [self presentViewController:alert animated:true completion:nil];
//        
//    }
//    if (indexPath.row == 4) {  //关于
//        UIStoryboard *mainStoryBoard              = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        CourseViewController *secondViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"About"];
//        AppDelegate *tempAppDelegate              = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [tempAppDelegate.mainNavigationController pushViewController:secondViewController animated:YES];
//    }
//    if (indexPath.row == 5) {  //反馈
//        UIStoryboard *mainStoryBoard              = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        CourseViewController *secondViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Feedback"];
//        AppDelegate *tempAppDelegate              = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [tempAppDelegate.mainNavigationController pushViewController:secondViewController animated:YES];
//    }
//    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 130;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor             = [UIColor clearColor];
    return view;
}




-(NSString*)getHeadUrl{
    //NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return @"www.baidu.com";
}
-(void)downHead{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //SDWebImageManager *manager = [SDWebImageManager sharedManager];
    SDWebImageDownloader *downLoader = [SDWebImageDownloader sharedDownloader];
    NSString *image_url=@"www.baidu.com";
    NSURL *url                   = [NSURL URLWithString: image_url];//接口地址
    
//    [manager downloadImageWithURL:url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        NSData *data = UIImagePNGRepresentation(image);
//        if (data!=NULL&&![image_url isEqualToString:@"www.baidu.com"]) {
//            [defaults setObject:data forKey:@"head_img"];
//            [defaults synchronize];
//        }
//    }];
    
    [downLoader downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        //NSData *data = UIImagePNGRepresentation(image);
        if (data!=NULL&&![image_url isEqualToString:@"www.baidu.com"]) {
            [defaults setObject:data forKey:@"head_img"];
            [defaults synchronize];
        }
    }];
    
}

-(UIImage*) circleImage:(UIImage*) image{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rect = CGRectMake(0, 0, image.size.width , image.size.height );
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
-(UIImage*)getImg{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults]; //得到用户数据
    NSString *Url=@"www.baidu.com";
    if ((!Config.getHeadPicThumb)||[Config.getHeadPicThumb isEqualToString:@""]) {
        return [self circleImage:[UIImage imageNamed:@"img_defalut"]];
    }else if ([defaults objectForKey:@"head_img"]!=NULL){
        return [self circleImage:[UIImage imageWithData:[defaults objectForKey:@"head_img"]]];
    }else{
        NSURL *imageUrl = [NSURL URLWithString:Url];
        UIImage *Img=[UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        NSData *data = UIImagePNGRepresentation(Img);
        [defaults setObject:data forKey:@"head_img"];
        [defaults synchronize];
        return [self circleImage:Img];
    }
}


#pragma mark- 懒加载
- (NSMutableArray<CellDataAdapter *> *)itemsArry{
    if (!_itemsArry) {
        _itemsArry = [NSMutableArray array];
    }
    
    return _itemsArry;
}

@end
