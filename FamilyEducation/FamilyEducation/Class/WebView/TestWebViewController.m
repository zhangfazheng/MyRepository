//
//  TestWebViewController.m
//  FamilyEducation
//
//  Created by 张发政 on 2017/5/12.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "TestWebViewController.h"
#import "UIView+Frame.h"
#import <WKWebViewJavascriptBridge.h>
#import <AVFoundation/AVFoundation.h>
#import "CoreJPush.h"



@interface TestWebViewController ()<CoreJPushProtocol>

@property WKWebViewJavascriptBridge *webViewBridge;
@end

@implementation TestWebViewController

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)setup{
    [super setup];
    _webViewBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_webViewBridge setWebViewDelegate:self];
    
    [self registerNativeFunctions];
    
    [CoreJPush addJPushListener:self];
    
}


#pragma mark - private method
- (void)registerNativeFunctions
{
    [self registScanFunction];
    
    [self registShareFunction];
    
    [self registLocationFunction];
    
    [self regitstBGColorFunction];
    
    [self registPayFunction];
    
    [self registShakeFunction];
    
    [self imagePathFunction];
}

- (void)registLocationFunction
{
    [_webViewBridge registerHandler:@"locationClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 获取位置信息
        
        NSString *location = @"广东省深圳市南山区学府路XXXX号";
        // 将结果返回给js
        responseCallback(location);
    }];
}

- (void)registScanFunction
{
    
    // 注册的handler 是供 JS调用Native 使用的。
    [_webViewBridge registerHandler:@"scanClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"扫一扫");
        NSString *scanResult = @"http://www.baidu.com";
        responseCallback(scanResult);
    }];
}

- (void)registShareFunction
{
    [_webViewBridge registerHandler:@"shareClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        // 在这里执行分享的操作
        NSString *title = [tempDic objectForKey:@"title"];
        NSString *content = [tempDic objectForKey:@"content"];
        NSString *url = [tempDic objectForKey:@"url"];
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"分享成功:%@,%@,%@",title,content,url];
        responseCallback(result);
    }];
}

- (void)regitstBGColorFunction
{
    __weak typeof(self) weakSelf = self;
    [_webViewBridge registerHandler:@"colorClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        
        CGFloat r = [[tempDic objectForKey:@"r"] floatValue];
        CGFloat g = [[tempDic objectForKey:@"g"] floatValue];
        CGFloat b = [[tempDic objectForKey:@"b"] floatValue];
        CGFloat a = [[tempDic objectForKey:@"a"] floatValue];
        
        weakSelf.wkWebView.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
    }];
}

- (void)registPayFunction
{
    [_webViewBridge registerHandler:@"payClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        
        NSString *orderNo = [tempDic objectForKey:@"order_no"];
        long long amount = [[tempDic objectForKey:@"amount"] longLongValue];
        NSString *subject = [tempDic objectForKey:@"subject"];
        NSString *channel = [tempDic objectForKey:@"channel"];
        // 支付操作...
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"支付成功:%@,%@,%@",orderNo,subject,channel];
        responseCallback(result);
    }];
}

- (void)registShakeFunction
{
    [_webViewBridge registerHandler:@"callSuccess" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"扫一扫");
        NSString *scanResult = @"{'pushString':'照相'}";
        responseCallback(scanResult);
        
    }];
}

- (void)imagePathFunction
{
    [_webViewBridge registerHandler:@"callCamera" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"扫一扫");
        NSString *scanResult = @"{'pushString':'扫一扫'}";
        responseCallback(scanResult);
        
    }];
}

//推送代理方法
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{

    //NSString *message = [NSString stringWithFormat:@"did%@", [userInfo[@"aps"] objectForKey:@"alert"]];
    NSString *message = [ NSString stringWithFormat:@"{'pushString':'%@'}",[userInfo[@"aps"] objectForKey:@"alert"]];
    [_webViewBridge callHandler:@"PushMessage" data:message responseCallback:^(id responseData) {
        
    }];
    
}


@end
