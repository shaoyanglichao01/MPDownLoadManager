//
//  MusicPartnerDownloadTask.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/26.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MusicPartnerDownloadTask.h"



@interface MusicPartnerDownloadTask() <NSURLSessionDelegate>

@end


@implementation MusicPartnerDownloadTask

-(id)init{
    [self configuerDownLoadSession];
    self.mpSessionModel = [[MPSessionModel alloc ] init];
    return [super init];
}


-(void)configuerDownLoadSession{
  
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
}

/**
 *  添加下载任务并下载
 *
 *  @param urlString 下载的地址
 */
-(MPDownloadState)addTaskWithDownLoadMusic:(MusicPartnerDownloadEntity *)mPDownloadEntity{
    
    // 下载
    if ([self continueDownLoad:mPDownloadEntity.downLoadUrlString]) {
    
        [self downLoad:mPDownloadEntity.downLoadUrlString progressBlock:nil completeBlock:nil mpDownloadState:MPDownloadStateRunning];
    }
    
    self.mpSessionModel.extra = mPDownloadEntity.extra;
    return self.mpSessionModel.mpDownloadState;
}

-(BOOL)continueDownLoad:(NSString *)url{
    
    BOOL continueDownLoad = YES;
    
    // 下载完成
    if ([self isCompletion:url]) {
        self.mpSessionModel.mpDownloadState = MPDownloadStateCompleted;
        
        continueDownLoad = NO;
    }
    
//    else if (self.mpSessionModel.mpDownloadState == MPDownloadStateSuspended){
//       
//        continueDownLoad = NO;
//    }else if (self.mpSessionModel.mpDownloadState == MPDownloadStateRunning){
//       
//        continueDownLoad = YES;
//    }
//    else if (self.mpSessionModel.mpDownloadState == MPDownloadStateFailed){
//        
//        continueDownLoad = NO;
//    }
    
    return continueDownLoad;
}

-(void)downLoad:(NSString *)url progressBlock:(MPartnerDownloadProgressBlock)progressBlock completeBlock:(MPartnerDownloadCompleteBlock)completeBlock mpDownloadState:(MPDownloadState)mpDownloadState{
    
    self.mpartnerDownloadProgressBlock = progressBlock;
    self.mpartnerDownloadCompleteBlock = completeBlock;
    
    // 不能继续下载
    if (![self continueDownLoad:url]) {
        return;
    }
    
    // 创建缓存目录文件
    [self createCacheDirectory];
    
    // 创建流
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:MPFileFullpath(url) append:YES];
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-", MPDownloadLength(url)];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    // 创建一个Data任务
    if (self.downLoadTask == nil) {
        
        self.downLoadTask = [self.session dataTaskWithRequest:request];
        self.mpSessionModel.urlString = url;
        self.mpSessionModel.stream    = stream;
         self.mpSessionModel.downLoadPath = MPFileFullpath(url);
        
        // 开始下载
        if (mpDownloadState == MPDownloadStateRunning) {
         
            [self start:url];
        // 暂停下载
        }else if (mpDownloadState == MPDownloadStateSuspended){
            
        }
    }
}


/**
 *  开始下载
 */
- (void)start:(NSString *)url
{
    if (self.downLoadTask) {
        self.mpSessionModel.mpDownloadState = MPDownloadStateRunning;
        [self.downLoadTask resume];

            // 下载完成
            if (self.mpartnerDownloadCompleteBlock) {
                self.mpartnerDownloadCompleteBlock(self.mpSessionModel.mpDownloadState,self.mpSessionModel.urlString);
            }
  
    }
}

/**
 *  暂停下载
 */
- (void)pause:(NSString *)url
{
    if (self.downLoadTask) {
        
        self.mpSessionModel.mpDownloadState = MPDownloadStateSuspended;
        if (self.downLoadTask.state == NSURLSessionTaskStateRunning) {
            [self.downLoadTask suspend];
        }
  
            // 下载完成
            if (self.mpartnerDownloadCompleteBlock) {
                self.mpartnerDownloadCompleteBlock(self.mpSessionModel.mpDownloadState,self.mpSessionModel.urlString);
          
            }
     
    }
}


/**
 *  创建缓存目录文件
 */
- (void)createCacheDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:MPCachesDirectory]) {
        [fileManager createDirectoryAtPath:MPCachesDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
}


#pragma mark - 代理
#pragma mark NSURLSessionDataDelegate
/**
 * 接收到响应
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{

    // 打开流
   [self.mpSessionModel.stream open];
    
    // 获得服务器这次请求 返回数据的总长度
    NSInteger totalLength = [response.allHeaderFields[@"Content-Length"] integerValue] + MPDownloadLength(self.mpSessionModel.urlString);
    self.mpSessionModel.totalLength = totalLength;
    
    // 存储总长度
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:MPTotalLengthFullpath];
    if (dict == nil) dict = [NSMutableDictionary dictionary];
    dict[MPFileName(self.mpSessionModel.urlString)] = @(totalLength);
    [dict writeToFile:MPTotalLengthFullpath atomically:YES];
    // 接收这个请求，允许接收服务器的数据
    
    self.mpSessionModel.mpDownloadState = MPDownloadStateRunning;
    
    completionHandler(NSURLSessionResponseAllow);
}

/**
 * 接收到服务器返回的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // 写入数据
    [self.mpSessionModel.stream write:data.bytes maxLength:data.length];
    
    // 下载进度
    NSUInteger receivedSize = MPDownloadLength(self.mpSessionModel.urlString);
    NSUInteger expectedSize = self.mpSessionModel.totalLength;
    CGFloat progress = 1.0 * receivedSize / expectedSize;
    self.mpSessionModel.process = progress;
 
        if (self.mpartnerDownloadProgressBlock) {
            self.mpartnerDownloadProgressBlock(progress,receivedSize,expectedSize);
            
        }

    
   
   
}

/**
 * 请求完毕（成功|失败）
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    
    if (!self.mpSessionModel) return;
    if ([self isCompletion:self.mpSessionModel.urlString]) {
        
        self.mpSessionModel.mpDownloadState = MPDownloadStateCompleted;
  
            // 下载完成
            if (self.mpartnerDownloadCompleteBlock) {
                
                self.mpartnerDownloadCompleteBlock(MPDownloadStateCompleted,self.mpSessionModel.urlString);
            }
   
        
        
        if ([self.delegate respondsToSelector:@selector(downloadComplete:downLoadUrlString:)]) {
            [self.delegate downloadComplete:MPDownloadStateCompleted downLoadUrlString:self.mpSessionModel.urlString];
        }
    } else if (error){
        
        self.mpSessionModel.mpDownloadState = MPDownloadStateFailed;
    
            // 下载失败
            if (self.mpartnerDownloadCompleteBlock) {
                
                self.mpartnerDownloadCompleteBlock(MPDownloadStateFailed,self.mpSessionModel.urlString);
            }

        
       
    }
    
    // 关闭流
    [self.mpSessionModel.stream close];
    self.mpSessionModel.stream = nil;
}

/**
 *  判断该文件是否下载完成
 */
- (BOOL)isCompletion:(NSString *)url
{
    if ([self fileTotalLength:url] && MPDownloadLength(url) == [self fileTotalLength:url]) {
        return YES;
    }
    return NO;
}

/**
 *  获取该资源总大小
 */
- (NSInteger)fileTotalLength:(NSString *)url
{
    return [[NSDictionary dictionaryWithContentsOfFile:MPTotalLengthFullpath][MPFileName(url)] integerValue];
}

/**
 *  查询该资源的下载进度值
 */
- (CGFloat)progress:(NSString *)url
{
    return [self fileTotalLength:url] == 0 ? 0.0 : 1.0 * MPDownloadLength(url) /  [self fileTotalLength:url];
}

#pragma mark - 删除
/**
 *  删除该资源
 */
- (void)deleteFile:(NSString *)url
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [self.downLoadTask cancel];
    
    if ([fileManager fileExistsAtPath:MPFileFullpath(url)]) {
        
        // 删除沙盒中的资源
        [fileManager removeItemAtPath:MPFileFullpath(url) error:nil];
        
        // 删除资源总长度
        if ([fileManager fileExistsAtPath:MPTotalLengthFullpath]) {
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:MPTotalLengthFullpath];
            [dict removeObjectForKey:MPFileName(url)];
            [dict writeToFile:MPTotalLengthFullpath atomically:YES];
        }
    }
}
@end
