
//  NetWorkManager.m
//  MyFramework
//
//  Created by 张发政 on 2017/1/9.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "NetWorkManager.h"

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

#import "Interface.h"
#import "UIImage+compressIMG.h"
#import "NSString+path.h"
#import "MBProgressHUD+MJ.h"

@implementation NetWorkManager

#pragma mark - shareManager
/**
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类的实例
 */

+(instancetype)shareManager
{
    
    static NetWorkManager * manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSUserDefaults *userDefaults    = [NSUserDefaults standardUserDefaults];
        NSString *ip = [userDefaults stringForKey:@"ip"];
        NSString *port = [userDefaults stringForKey:@"port"];
        
        NSString * baseUrlString = [BaseURL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        if (!isEmptyString(ip) && !isEmptyString(port)) {
            baseUrlString = [NSString stringWithFormat:@"%@:%@/Operation",ip,port];
        }
        
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseUrlString]];
        
    });
    
    return manager;
}


#pragma mark - 重写initWithBaseURL
/**
 *
 *
 *  @param url baseUrl
 *
 *  @return 通过重写夫类的initWithBaseURL方法,返回网络请求类的实例
 */

-(instancetype)initWithBaseURL:(NSURL *)url
{
    
    if (self = [super initWithBaseURL:url]) {
        
        
        
#warning 可根据具体情况进行设置
        
        NSAssert(url,@"您需要为您的请求设置baseUrl");
        
        /**设置请求超时时间*/
        
        self.requestSerializer.timeoutInterval = 15;
        
        /**设置相应的缓存策略*/
        
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        
        /**分别设置请求以及相应的序列化器*/
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        
        response.removesKeysWithNullValues = YES;
        
        self.responseSerializer = response;
        
        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        
        //[self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
#warning 此处做为测试 可根据自己应用设置相应的值
        
        /**设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
        
        //[self.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
        
        
        
        /**设置接受的类型*/
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
        
    }
    
    return self;
}


#pragma mark - 网络请求的类方法---get/post

/**
 *  网络请求的实例方法
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param paraments    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 *  @param progress 进度
 */

- (void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock progress:(downloadProgress)progress
{
    //如果用户未登录，不让发送请求
//    if (!([LoginUserModel getUserModelInstance].isLogin || [urlString isEqualToString:@"phone/PhoneLoginController/phoneLogin.do"])) {
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:LOSE_EFFICACY_COOKIE object:nil];
//        [MBProgressHUD hideHUD];
//        failureBlock(nil);
//        return;
//    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    switch (type) {
            
        case HttpRequestTypeGet:
        {
            
            
            [self GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                
                progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (successBlock) {
                    //如果cookie失效
                    if([responseObject[@"resultCode"] isEqualToString:@"-2"]){
                        
                        //发送cookie失效的通知
                        [MBProgressHUD hideHUD];
                        [NSThread sleepForTimeInterval:1.5];
                        [MBProgressHUD showNoImageMessage:@"cookei失效，请重新登录"];
                        
                        NSString *filePath = [@"person.plist" appendDocuments];
                        BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
                        if (blHave) {
                            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                        }
                        
                        //发送通知让用户重新登录
                        [[NSNotificationCenter defaultCenter] postNotificationName:LOSE_EFFICACY_COOKIE object:nil];
                        
                    }else{
                        successBlock(responseObject);
                    }
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failureBlock(error);
            }];
            
            break;
        }
            
        case HttpRequestTypePost:
            
        {
            
            [self POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                
                progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    //如果cookie失效
                    if([responseObject[@"resultCode"] isEqualToString:@"-2"]){
                        
                        //发送cookie失效的通知
                        [MBProgressHUD hideHUD];
//                        [NSThread sleepForTimeInterval:1.5];
//                        [MBProgressHUD showNoImageMessage:@"cookei失效，请重新登录"];
                        
                        NSString *filePath = [@"person.plist" appendDocuments];
                        BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
                        if (blHave) {
                            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                        }
                        
                        //发送通知让用户重新登录
                        [[NSNotificationCenter defaultCenter] postNotificationName:LOSE_EFFICACY_COOKIE object:nil];
                        
                    }else{
                        successBlock(responseObject);
                    }
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failureBlock(error);
                
            }];
        }
            
    }
    
}


#pragma mark - 多图上传
/**
 *  上传图片
 *
 *  @param operations   上传图片等预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @parm width      图片要被压缩到的宽度
 *  @param urlString    上传的url---请填写完整的url
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 *
 */
-(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )width withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailurBlock:(requestFailure)failureBlock withUpLoadProgress:(uploadProgress)progress;
{
    
    //如果用户未登录，不让发送请求
//    if (![LoginUserModel getUserModelInstance].isLogin) {
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:LOSE_EFFICACY_COOKIE object:nil];
//        return;
//    }
    //1.创建管理者对象
    
    //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [self POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSUInteger i = 0 ;
        
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imageArray) {
            
            //image的分类方法
            UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
            
            NSData * imgData        = UIImageJPEGRepresentation(resizedImage, 1.0);
            
            //拼接data
            [formData appendPartWithFileData:imgData name:@"picflie" fileName:@"image.png" mimeType:@" image/jpeg"];
            //[formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
            
            i++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //如果cookie失效
        if([responseObject[@"resultcode"] isEqualToString:@"-2"]){
            
            //发送cookie失效的通知
            [MBProgressHUD hideHUD];
            [NSThread sleepForTimeInterval:1.5];
            [MBProgressHUD showNoImageMessage:@"cookei失效，请重新登录"];
            
            NSString *filePath = [@"person.plist" appendDocuments];
            BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
            if (blHave) {
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            }
            
            //发送通知让用户重新登录
            [[NSNotificationCenter defaultCenter] postNotificationName:LOSE_EFFICACY_COOKIE object:nil];
        }else{
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        
    }];
}



#pragma mark - 视频上传

/**
 *  视频上传
 *
 *  @param operations   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param urlString     上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */

+(void)uploadVideoWithOperaitons:(NSDictionary *)operations withVideoPath:(NSString *)videoPath withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock withUploadProgress:(uploadProgress)progress
{
    
    
    /**获得视频资源*/
    
    AVURLAsset * avAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:videoPath]];
    
    /**压缩*/
    
    //    NSString *const AVAssetExportPreset640x480;
    //    NSString *const AVAssetExportPreset960x540;
    //    NSString *const AVAssetExportPreset1280x720;
    //    NSString *const AVAssetExportPreset1920x1080;
    //    NSString *const AVAssetExportPreset3840x2160;
    
    AVAssetExportSession  *  avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
    
    /**创建日期格式化器*/
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    /**转化后直接写入Library---caches*/
    
    NSString *  videoWritePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/output-%@.mp4",[formatter stringFromDate:[NSDate date]]]];
    
    
    avAssetExport.outputURL = [NSURL URLWithString:videoWritePath];
    
    
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    
    
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        
        
        switch ([avAssetExport status]) {
                
                
            case AVAssetExportSessionStatusCompleted:
            {
                
                
                
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                
                [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    
                    //获得沙盒中的视频内容
                    
                    [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoWritePath] name:@"write you want to writre" fileName:videoWritePath mimeType:@"video/mpeg4" error:nil];
                    
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                    progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                    
                    successBlock(responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    failureBlock(error);
                    
                }];
                
                break;
            }
            default:
                break;
        }
        
        
    }];
    
}

#pragma mark - 文件下载


/**
 *  文件下载
 *
 *  @param operations   文件下载预留参数---视具体情况而定 可移除
 *  @param savePath     下载文件保存路径
 *  @param urlString        请求的url
 *  @param successBlock 下载文件成功的回调
 *  @param failureBlock 下载文件失败的回调
 *  @param progress     下载文件的进度显示
 */

+(void)downLoadFileWithOperations:(NSDictionary *)operations withSavaPath:(NSString *)savePath withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock withDownLoadProgress:(downloadProgress)progress
{
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    
    [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return  [NSURL URLWithString:savePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            
            failureBlock(error);
        }
        
    }];
    
}


#pragma mark -  取消所有的网络请求

/**
 *  取消所有的网络请求
 *  a finished (or canceled) operation is still given a chance to execute its completion block before it iremoved from the queue.
 */

+(void)cancelAllRequest
{
    
    [[NetWorkManager shareManager].operationQueue cancelAllOperations];
    
}



#pragma mark -   取消指定的url请求/
/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的完整url
 */

+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string
{
    
    NSError * error;
    
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    
    NSString * urlToPeCanced = [[[[NetWorkManager shareManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    
    
    for (NSOperation * operation in [NetWorkManager shareManager].operationQueue.operations) {
        
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            
            //请求的url匹配
            
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                
                [operation cancel];
                
            }
        }
        
    }
}



@end
