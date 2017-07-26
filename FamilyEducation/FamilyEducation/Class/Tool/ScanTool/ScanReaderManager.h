//
//  ScanManager.h
//  OperationEquipment
//
//  Created by 张发政 on 2017/3/23.
//  Copyright © 2017年 cyberplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RcpBarcodeApi.h"
#import "RcpRfidApi.h"

@interface ScanReaderManager : RcpRfidApi
@property (nonatomic,assign) BOOL plugged;


+ (instancetype)shardScanManagerWithVc:(id<RcpRfidDelegate>) controller;
- (void )stopRead;
- (void)startRead;
- (void)openReader;
- (void)closeReader;
@end
