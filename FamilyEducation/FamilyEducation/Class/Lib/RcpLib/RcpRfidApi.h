//
//  RcpApi.h
//  AreteAudio
//
//  Created by Asterisk on 2013. 3. 18..
//  Copyright (c) 2013 Asterisk. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UartMgr.h"

@protocol RcpRfidDelegate;

@interface RcpRfidApi : NSObject <UartMgrRfidDelegate>

- (NSString*)getSDKVersion;
- (id)init;
- (BOOL)open;
- (BOOL)isOpened;
- (void)close;
- (void)plugStatusChanged:(NSInteger)status;
- (int)receive:(NSData*)data;

- (BOOL)startReadTags:(uint8_t)mtnu mtime:(uint8_t)mtime repeatCycle:(uint16_t)repeatCycle;
- (BOOL)startReadTagsWithRssi:(uint8_t)mtnu mtime:(uint8_t)mtime repeatCycle:(uint16_t)repeatCycle;
- (BOOL)startReadTagsWithTid:(uint8_t)mtnu mtime:(uint8_t)mtime repeatCycle:(uint16_t)repeatCycle;
- (BOOL)stopReadTags;
- (BOOL)getReaderInfo;
- (BOOL)getReaderInfo:(uint8_t)infoType;
- (BOOL)setReaderPower:(BOOL)on;
- (BOOL)setReaderProgMode:(uint8_t)mode;
- (BOOL)getRegion;
- (BOOL)setRegion:(uint8_t)region;
- (BOOL)getSelectParam;
- (BOOL)setSelectParam:(uint8_t)target 
	action:(uint8_t)action 
	memoryBank:(uint8_t)memoryBank 
	pointer:(uint32_t)pointer 
	length:(uint8_t)length 
	truncate:(uint8_t)truncate 
	mask:(NSData *)mask;
- (BOOL)getQueryParam;
- (BOOL)setQueryParam:(uint8_t)dr
	m:(uint8_t)m 
	trext:(uint8_t)trext 
	sel:(uint8_t)sel 
	session:(uint8_t)session 
	target:(uint8_t)target 
	q:(uint8_t)q;
- (BOOL)getChannel;
- (BOOL)setChannel:(uint8_t)channel
     channelOffset:(uint8_t)channelOffset;
- (BOOL)getFhLbtParam;
- (BOOL)setFhLbtParam:(uint16_t)readTime 
		idleTime:(uint16_t)idleTime 
		carrierSenseTime:(uint16_t) carrierSenseTime 
		rfLevel:(uint16_t)rfLevel 
		frequencyHopping:(uint8_t)frequencyHopping 
		listenBeforeTalk:(uint8_t)listenBeforeTalk 
		continuousWave:(uint8_t)continuousWave;
- (BOOL)getOutputPowerLevel;
- (BOOL)setOutputPowerLevel:(uint16_t)power;
- (BOOL)setRfCw:(uint8_t)on;
- (BOOL)readFromTagMemory:(uint32_t)accessPassword
		epc:(NSData*)epc
		memoryBank:(uint8_t)memoryBank
		startAddress:(uint16_t)startAddress
		dataLength:(uint16_t)dataLength;
- (BOOL)getFreqHoppingTable;
- (BOOL)setFreqHoppingTable:(uint8_t)tableSize
		channels:(NSData*)channels;
- (BOOL)getModulation;
- (BOOL)setModulation:(uint8_t)mode;
- (BOOL)getSession;
- (BOOL)setSession:(uint8_t)session;
- (BOOL)getAnticollision;
- (BOOL)setAnticollision:(uint8_t)mode;
- (BOOL)setAnticollision:(uint8_t)mode qStart:(uint8_t)qStart qMax:(uint8_t)qMax qMin:(uint8_t)qMin;
- (BOOL)writeToTagMemory:(uint32_t)accessPassword
		epc:(NSData*)epc
		memoryBank:(uint8_t)memoryBank
		startAddress:(uint16_t)startAddress
		dataToWrite:(NSData*)dataToWrite;
- (BOOL)killTag:(uint32_t)killPassword
		epc:(NSData*)epc;
- (BOOL)lockTagMemory:(uint32_t)accessPassword
		epc:(NSData*)epc
		lockData:(uint32_t)lockData;
- (BOOL)getTemperature;
- (BOOL)getRssi;
- (BOOL)setBeep:(uint8_t)beepOn
        setVibration:(uint8_t)vibrationOn
        setIllumination:(uint8_t)illuminationOn;
-(BOOL) setStopConditionMtnu:(uint8_t)mtnu
                    setMtime:(uint8_t)mtime
              setRepeatCycle:(uint16_t)repeatCycle;
-(BOOL)getStopCondition;
- (BOOL)genericTrasport:(uint8_t)TS
        ap:(uint32_t)accessPassword
        RM:(uint8_t)RM
        epc:(NSData*)epc
        SZ :(uint8_t)SZ
        GC:(NSData*)GC;
- (void)setGpadc;
- (BOOL)getRssiOffset;
- (BOOL)setRssiOffset;
- (BOOL)setOptimumFrequencyHoppingTable;
-(BOOL) GetFrequencyHoppingMode;
- (BOOL)SetFrequencyHoppingMode:(uint8_t)mode;
- (BOOL)updateRegistry:(uint8_t)update;
@property (nonatomic, assign) BOOL isConnected;
@property (nonatomic, weak) id<RcpRfidDelegate> delegate;
@end

@protocol RcpRfidDelegate <NSObject>
@optional
- (void)pluggedRfid:(BOOL)plug;
- (void)pcEpcReceived:(NSData *)pcEpc;
- (void)epcReceived:(NSData *)epc;
- (void)epcReceived:(NSData *)epc rssi:(int8_t)rssi;
- (void)epcReceived:(NSData *)epc tid:(NSData*)tid;
- (void)pcEpcRssiReceived:(NSData *)pcEpc rssi:(int8_t)rssi;
- (void)readerConnected:(uint8_t)status;
- (void)readerConnected;
- (void)ackReceived:(uint8_t)commandCode;
- (void)errReceived:(uint8_t)errCode;
- (void)errDetailReceived:(NSData *)errCode;
- (void)readerInfoReceived:(NSData *)data;
- (void)readerInfoReceived:(int16_t)onTime
                   offTime:(int16_t)offTime
                 senseTime:(int16_t)senseTime
                  lbtLebel:(int16_t)lbtLebel
                  fhEnable:(BOOL)fhEnable
                 lbtEnable:(BOOL)lbtEnable
                  cwEnable:(BOOL)cwEnable;


- (void)frequencyHoppingModeReceived:(uint8_t)statusCode;
- (void)regionReceived:(uint8_t)region;
- (void)selectParamReceived:(NSData *)selParam;
- (void)queryParamReceived:(NSData *)qryParam;
- (void)channelReceived:(uint8_t)channel channelOffset:(uint8_t)channelOffset;
- (void)fhLbtReceived:(NSData *)fhLb;
- (void)txPowerLevelReceived:(NSData*)power;
- (void)tagMemoryReceived:(NSData *)data;
- (void)hoppingTableReceived:(NSData *)table;
- (void)modulationParamReceived:(uint8_t)param;
- (void)anticolParamReceived:(uint8_t)param;
- (void)anticolParamReceived:(uint8_t)mode start:(uint8_t)start max:(uint8_t)max min:(uint8_t)min;
- (void)tempReceived:(uint8_t)temp;
- (void)rssiReceived:(uint16_t)rssi;
- (void)registeryItemReceived:(NSData *)item;
- (void)batteryChargeReceived:(int)battery;
- (void)genericReceived:(NSData*)data;
- (void)startedReadTags:(uint8_t)statusCode;
- (void)didSetOutputPowerLevel:(uint8_t)status;
- (void)writedReceived:(uint8_t)statusCode;
- (void)stoppedReadTags:(uint8_t)statusCode;
- (void)lockedReceived:(uint8_t)statusCode;
- (void)killedReceived:(uint8_t)statusCode;
- (void)didSetRegionReceived:(uint8_t)statusCode;
- (void)didSetSelParamReceived:(uint8_t)statusCode;
- (void)didSetQueryParamReceived:(uint8_t)statusCode;
- (void)didSetChParamReceived:(uint8_t)statusCode;
- (void)didSetFhLbtReceived:(uint8_t)statusCode;
- (void)didSetTxPwrReceived:(uint8_t)statusCode;
- (void)didSetCwReceived:(uint8_t)statusCode;
- (void)didSetHoppintTbleReceived:(uint8_t)statusCode;
- (void)didSetModulationReceived:(uint8_t)statusCode;
- (void)didSetAntiColModeReceived:(uint8_t)statusCode;
- (void)sessionReceived:(uint8_t)session;
- (void)didsetStopConditionMtnu:(uint8_t)statusCode;
- (void)stopConditionReceived:(NSData *)data;

- (void)didSetOptiFreqHPTable:(uint8_t)statusCode;
- (void)didSetFreqHPTable:(uint8_t)statusCode;
- (void)didSetFreqHPMode:(uint8_t)statusCode;
- (void)didSetSession:(uint8_t)statusCode;

- (void)didSetRegistry:(uint8_t)statusCode;


@end

