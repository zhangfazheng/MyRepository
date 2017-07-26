//
//  HomePageViewController.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/8.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "HomePageViewController.h"
#import "CExpandHeader.h"
#import "UITableView+CellClass.h"
#import "NoticeTableViewCell.h"
#import "HomeTitleHeaderView.h"
#import "ToolCollectionView.h"
#import "ToolTableViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "CoreJPush.h"
#import "TestWebViewController.h"

#define NAVBAR_CHANGE_POINT 200

@interface HomePageViewController ()<CoreJPushProtocol>
@property (nonatomic,strong) CExpandHeader *header;
@property (nonatomic,strong) NSMutableArray <CellDataAdapter *> * items;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CoreJPush addJPushListener:self];
}

- (void)setup{
    [super setup];
    
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    [self setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.tableview registerCellsClass:@[cellClass(@"NoticeTableViewCell", nil),cellClass(@"ToolTableViewCell", nil)]];
    [self.tableview registerClass:[HomeTitleHeaderView class] forHeaderFooterViewReuseIdentifier:@"HomeTitleHeaderView"];
    self.tableview.estimatedRowHeight           = 100;
    self.tableview.estimatedSectionHeaderHeight = 40;
    self.tableview.backgroundColor              = [UIColor colorWithWhite:1 alpha:0.1];
    self.tableview.sectionFooterHeight          = 10;
    self.tableview.tableHeaderView              = [UIView new];
    //self.tableview.contentInset                 = UIEdgeInsetsMake(0, 0, 0, TabTabBarH);
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVBAR_CHANGE_POINT)];
    [imageView setImage:[UIImage imageNamed:@"bg"]];
    
    _header = [CExpandHeader expandWithScrollView:self.tableview expandView:imageView];
    
    [self.tableview setTableFooterView:[UIView new]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NoticeModel * model =[NoticeModel new];
        model.titleStr = @"家长助手";
        model.noticeStr = @"欢迎使用";
        model.timeStr   = @"2017-05-08";
        
        CellDataAdapter *adapter=[NoticeTableViewCell dataAdapterWithCellReuseIdentifier:nil data:model cellHeight:100 type:0];
        
        return [tableView dequeueAndLoadContentReusableCellFromAdapter:adapter indexPath:indexPath controller:self];
    }else{
        ToolTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ToolTableViewCell" forIndexPath:indexPath];
        WeakSelf
        cell.toolSelectedItemBlock = ^(NSInteger index) {
            TestWebViewController *web =[[TestWebViewController alloc]init];
            [web loadWebURLSring:@"http://1.wechat000.applinzi.com/demo%20(1).html"];
            [weakSelf.navigationController pushViewController:web animated:YES];
        };
        return cell;
        //return [self createToolCollectionView];
    }
}

//- (UITableViewCell *)createToolCollectionView{
//    NSArray *toolArry   = @[@{@"title":@"百科全书",@"icon":@"icon-library"},
//                            @{@"title":@"课程表",@"icon":@"icon-curriculum"},
//                            @{@"title":@"学习计划",@"icon":@"icon-exam"},
//                            @{@"title":@"成绩查询",@"icon":@"chengji"},
//                            @{@"title":@"网上作业",@"icon":@"icon-homework-inline"},
//                            @{@"title":@"二手市场",@"icon":@"icon-second-hand"},
//                            @{@"title":@"教育说说",@"icon":@"icon-social"},
//                            @{@"title":@"家长手册",@"icon":@"icon-elec"},
//                            @{@"title":@"实验课表",@"icon":@"icon-lab"},
//                            @{@"title":@"日历",@"icon":@"icon-calendar"},
//                            @{@"title":@"失物招领",@"icon":@"icon-lost"}];
//    
//    CGFloat toolWith= ScreenWidth;
//    CGFloat topButtonInset      = 10;
//    CGFloat leftRightInset      = 5;
//    CGFloat spacing             = 20;
//    CGFloat toolHeight = ((toolArry.count+3)/4)*70+((toolArry.count+3)/4-1)*20+20;
//    
//    
//     UICollectionViewFlowLayout *toolViewLayout = [[UICollectionViewFlowLayout alloc] init];
//    toolViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    toolViewLayout.minimumInteritemSpacing = 20;
//    toolViewLayout.minimumLineSpacing =20;
//    toolViewLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
//    toolViewLayout.estimatedItemSize = CGSizeMake(70, 70);
//    
//    
//    ToolCollectionView *toolView =[[ToolCollectionView alloc]initWithFrame:CGRectMake(0, 0, toolWith, toolHeight) collectionViewLayout:toolViewLayout andDataSource:toolArry];
//
//    UITableViewCell *cell =[[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, toolWith, toolHeight)];
//    
//    [cell.contentView addSubview:toolView];
//    
//    return cell;
//    
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeTitleHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HomeTitleHeaderView"];
    if (!headView) {
        headView = [[HomeTitleHeaderView alloc]initWithReuseIdentifier:@"HomeTitleHeaderView"];
    }
    HomeTitleModel *model =[HomeTitleModel new];
    if (section == 0) {
        model.titleStr = @"通知";
        model.block = ^{
            NSLog(@"查看详细通知");
        };
        model.noticeStr = @"查看全部通知";
    }else{
        model.titleStr = @"常用";
    }
    
    headView.data = model;
    [headView loadContent];
    
    return headView;
}


-(void)dealloc{
    
    [CoreJPush removeJPushListener:self];
}




-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"ViewController: %@",userInfo);
    
}


#pragma mark- headview不随tableView滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    //NSLog(@"%f",offsetY);
    if (offsetY > -64) {
        CGFloat alpha = MIN(1, 1 - ((- offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

@end
