//
//  RcpApi.h
//  AreteAudio
//
//  Created by Asterisk on 2013. 3. 18..
//  Copyright (c) 2013 Asterisk. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RcpBarcodeApi.h"
#import "UartMgr.h"

@protocol RcpBarcodeDelegate;

@interface RcpBarcodeApi : NSObject <UartMgrBarcodeDelegate>

- (NSString*)getSDKVersion;
- (id)init;
- (BOOL)open;
- (BOOL)isOpened;
- (void)close;
- (BOOL)startReadBarcodes:(uint8_t)mtnu mtime:(uint8_t)mtime repeatCycle:(uint16_t)repeatCycle;
- (BOOL)stopReadBarcodes;
- (BOOL)setReaderPower:(BOOL)on;
- (BOOL)setBeep:(uint8_t)beepOn
        setVibration:(uint8_t)vibrationOn
        setIllumination:(uint8_t)illuminationOn;
@property (nonatomic, assign) BOOL isConnected;
@property (nonatomic, weak) id<RcpBarcodeDelegate> delegate;
@property (nonatomic, strong) NSString *model;
@end

@protocol RcpBarcodeDelegate <NSObject>
@optional
- (void)readerConnected:(uint8_t)status;
- (void)pluggedBarcode:(BOOL)plug;
- (void)barcodeReceived:(NSData *)barcode;
- (void)batteryChargeReceived:(int)battery;
- (void)startedReadBarcodes:(uint8_t)statusCode;
- (void)stoppedReadBarcodes:(uint8_t)statusCode;
- (void)errReceived:(uint8_t)errCode;
- (void)errDetailReceived:(NSData *)errCode;
@end

