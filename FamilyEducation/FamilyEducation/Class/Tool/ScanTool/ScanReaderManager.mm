//
//  ScanManager.m
//  OperationEquipment
//
//  Created by 张发政 on 2017/3/23.
//  Copyright © 2017年 cyberplus. All rights reserved.
//

#import "ScanReaderManager.h"

#import <AudioToolBox/AudioServices.h>

@interface ScanReaderManager ()<RcpBarcodeDelegate,RcpRfidDelegate>
{
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    int prev_battery;
}
@end
@implementation ScanReaderManager

//创建单例
+ (instancetype)shardScanManagerWithVc:(id<RcpRfidDelegate>)controller{
    static ScanReaderManager * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ScanReaderManager alloc]init];
        [manager initSound];
        //manager.delegate = controller;
        //[manager open];
    });
    //开启读卡器
    [manager openReader];
    //重新设置代理
    [manager setDelegate:controller];
    
    
    return manager;
}


- (void)appWillTerminate:(NSNotification*) notification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)appDidEnterBackground:(NSNotification*) notification{
//    if([self.rcpBarcode isOpened]){
//        [self setReaderPower:NO];
//        [self close];
//    }
    
    if([self isOpened]){
        [self setReaderPower:NO];
        [self close];
    }
}


//初始化音效
- (void)initSound{

    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"read" withExtension: @"caf"];
    // Store the URL as a CFURLRef instance
    soundFileURLRef = (__bridge CFURLRef) tapSound;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
}



//设置代理对象
- (void)setUpDelegate:(id<RcpRfidDelegate>) controller{
    self.delegate = controller;
}

////创建绑卡器
//- (RcpBarcodeApi *)rcpBarcode{
//    static dispatch_once_t pred = 0;
//    __strong static id _sharedObject = nil;
//    
//    dispatch_once(&pred,^{
//        _sharedObject = [[RcpBarcodeApi alloc] init];
//        _rcpBarcode = _sharedObject;
//        _rcpBarcode.delegate = self;
//        [_rcpBarcode open];
//    });
//    return _sharedObject;
//}
//
////创建读卡器
//- (RcpRfidApi *)rcpRfid{
//    static dispatch_once_t pred = 0;
//    __strong static id _sharedObject = nil;
//    
//    dispatch_once(&pred,^{
//        _sharedObject = [[RcpRfidApi alloc] init];
//        _rcpRfid = _sharedObject;
//        _rcpRfid.delegate = self;
//        [_rcpRfid open];
//    });
//    return _sharedObject;
//}


#pragma mark RcpDelegate Method
//绑卡代理方法
- (void)barcodeReceived:(NSData *)barcode{
    NSLog(@"barcodeReceived");
    dispatch_async(dispatch_get_main_queue(),^{
        AudioServicesPlaySystemSound (soundFileObject);
        
        NSString *scanStr = [[NSString alloc]initWithData:barcode encoding:NSShiftJISStringEncoding];
        

    });
}
//读卡卡代理方法
- (void)epcReceived:(NSData *)epc{
    dispatch_async(dispatch_get_main_queue(),^{
        
        NSMutableString* tag = [[NSMutableString alloc] init];
        unsigned char* ptr= (unsigned char*) [epc bytes];
        
        for(int i = 0; i < epc.length; i++) {
            [tag appendFormat:@"%02X", *ptr++ & 0xFF ];
        }
        
    });
}

//读卡代理方法，接收信号强度指示器
- (void)pcEpcRssiReceived:(NSData *)pcEpc rssi:(int8_t)rssi{
    dispatch_async(dispatch_get_main_queue(),^{
        //        AudioServicesPlaySystemSound (soundFileObject);
        
        NSMutableString* tag = [[NSMutableString alloc] init];
        unsigned char* ptr= (unsigned char*) [pcEpc bytes];
        
        for(int i = 0; i < pcEpc.length; i++) {
            [tag appendFormat:@"%02X", *ptr++ & 0xFF ];
        }
        
    });
}

#pragma mark-开始读卡
- (void)startRead {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startReadTags:0x00 mtime:0x00 repeatCycle:0x01];
//      [self startReadBarcodes:0x00 mtime: repeatCycle:0x00];
    });
}
#pragma mark-停止读卡
- (void )stopRead {
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self stopReadBarcodes];
        [self stopReadTags];
    });
}

//开启读卡器
- (void)openReader{
    [self open];
}

//关闭读卡
- (void)closeReader{
    //关闭音效
    AudioServicesDisposeSystemSoundID (soundFileObject);
    //关闭指示灯
    [self setReaderPower:NO];
    [self close];
    
}

@end
