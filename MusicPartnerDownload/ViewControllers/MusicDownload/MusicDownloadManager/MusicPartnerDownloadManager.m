//
//  MusicPartnerDownloadManager.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/26.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MusicPartnerDownloadManager.h"

#define  mpDownLoadTask @"mpDownLoadTask"


@interface MusicPartnerDownloadManager() <MusicPartnerDownloadTaskDelegate>

@property (nonatomic, strong) NSMutableDictionary *mpDownloadTasks;

@end


@implementation MusicPartnerDownloadManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static MusicPartnerDownloadManager *mpartnerDownloadManager;
    dispatch_once(&onceToken, ^{
        mpartnerDownloadManager = [[self alloc] init];
    });
    return mpartnerDownloadManager;
}

-(id)init{
    self.mpDownloadTasks = [[NSMutableDictionary alloc ] init];
    self.mpDownloadArray   = [self loadDownLoadTask];
    return [super init];
    
}

-(void)initUnFinishedTask{
    for (NSDictionary *dic in [self loadUnFinishedTask]) {
        MusicPartnerDownloadTask *downLoadTask =  [[MusicPartnerDownloadTask alloc ] init];
        NSString *urlKey = [dic objectForKey:@"mpDownloadUrlString"];
        MPDownloadState downLoadStatus = [self getMPDownloadState:urlKey];
        downLoadTask.mpSessionModel.mpDownloadState = downLoadStatus;
        downLoadTask.mpSessionModel.urlString = urlKey;
        downLoadTask.mpSessionModel.extra = [dic objectForKey:@"mpDownloadExtra"];
        
        
        downLoadTask.delegate = self;
        [self.mpDownloadTasks setObject:downLoadTask forKey:urlKey];
    }
}


/**
 *  添加下载任务并下载
 *
 *  @param urlString 下载的地址
 */
-(MPDownloadState)addTaskWithDownLoadMusic:(MusicPartnerDownloadEntity *)mPDownloadEntity{
    
    MusicPartnerDownloadTask *downLoadTask = [self getDownLoadTask:mPDownloadEntity.downLoadUrlString];
    
    if (downLoadTask == nil) {
        downLoadTask = [[MusicPartnerDownloadTask alloc ] init];
        [self.mpDownloadTasks setObject:downLoadTask forKey:mPDownloadEntity.downLoadUrlString];
        MPDownloadState status =  [downLoadTask addTaskWithDownLoadMusic:mPDownloadEntity];
        downLoadTask.delegate = self;
        [self saveMPDownLoadTask];
        return status;
    }
    // 任务存在
    return  [downLoadTask addTaskWithDownLoadMusic:mPDownloadEntity];
}

-(MusicPartnerDownloadTask *)getDownLoadTask:(NSString *)urlkey{
   return  [self.mpDownloadTasks objectForKey:urlkey];
}

-(void)downLoad:(NSString *)url progressBlock:(MPartnerDownloadProgressBlock)progressBlock completeBlock:(MPartnerDownloadCompleteBlock)completeBlock{
    MusicPartnerDownloadTask *downLoadTask = [self getDownLoadTask:url];
    
    MPDownloadState downLoadStatus = [self getMPDownloadState:url];
    
    __weak typeof(self) weakSelf = self;
    [downLoadTask downLoad:url progressBlock:^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            progressBlock(progress,totalMBRead,totalMBExpectedToRead);
        });
    
    } completeBlock:^(MPDownloadState mpDownloadState ,NSString *downLoadUrlString) {
        
        if (mpDownloadState == MPDownloadStateCompleted) {
            //　删除本地任务
            [weakSelf deleteMpDownLoadTask:url];
            [weakSelf.mpDownloadTasks removeObjectForKey:url];
            
        }else{
            [weakSelf saveMPDownLoadTask];
        }
     
        
        dispatch_async(dispatch_get_main_queue(), ^{
           completeBlock(mpDownloadState,downLoadUrlString);
        });
        
        
    } mpDownloadState:downLoadStatus];
}

-(void)downloadComplete:(MPDownloadState)mpDownloadState downLoadUrlString:(NSString *)downLoadUrlString{
    //　删除本地任务
    [self deleteMpDownLoadTask:downLoadUrlString];
    [self.mpDownloadTasks removeObjectForKey:downLoadUrlString];
}

-(MPDownloadState)getMPDownloadState:(NSString *)url{
    for (NSDictionary *dic in [self loadUnFinishedTask]) {
        NSString *key = [dic objectForKey:@"mpDownloadUrlString"];
        if ([key isEqualToString:url]) {
            return (MPDownloadState)[[dic objectForKey:@"mpDownloadState"] integerValue];
        }
    }
    return MPDownloadStateFailed;
}

/**
 *  查询该资源的下载进度值
 */
- (CGFloat)progress:(NSString *)url{
    MusicPartnerDownloadTask *downLoadTask = [[MusicPartnerDownloadTask alloc ] init];
    return [downLoadTask progress:url];
}

/**
 *  开始下载
 */
- (void)start:(NSString *)url{
    
    MusicPartnerDownloadTask *downLoadTask = [self getDownLoadTask:url];
    [downLoadTask start:url];
}

/**
 *  暂停下载
 */
- (void)pause:(NSString *)url{
    MusicPartnerDownloadTask *downLoadTask = [self getDownLoadTask:url];
    [downLoadTask pause:url];

}

/**
 *  判断该文件是否下载完成
 */
- (BOOL)isCompletion:(NSString *)url{
    MusicPartnerDownloadTask *downLoadTask = [[MusicPartnerDownloadTask alloc ] init];
    return [downLoadTask isCompletion:url];
}

/**
 *  获取文件的下载主目录
 *
 *  @return
 */
-(NSString *)getDownLoadPath{
    return MPCachesDirectory;
}

/**
 *  删除该资源
 *
 *  @param url 下载地址
 */
- (void)deleteFile:(NSString *)url{
    MusicPartnerDownloadTask *downLoadTask = [self getDownLoadTask:url];
    [downLoadTask deleteFile:url];
    [self.mpDownloadTasks removeObjectForKey:url];
    [self deleteMpDownLoadTask:url];
}

//　删除本地
-(void)deleteMpDownLoadTask:(NSString *)url{
    NSString *filename = [self filePathWithFileName:mpDownLoadTask];
    
    NSInteger index = [self isExit:url];
    if (index != -1) {
        [self.mpDownloadArray removeObjectAtIndex:index];
    }
    [self.mpDownloadArray writeToFile:filename atomically:NO];
}


//　保存本地任务
-(void)saveMPDownLoadTask{
    NSString *filename = [self filePathWithFileName:mpDownLoadTask];
    for (NSString *string in self.mpDownloadTasks.allKeys) {
        MusicPartnerDownloadTask *downLoadTask = [self.mpDownloadTasks objectForKey:string];
        NSMutableDictionary *mpSession = [[NSMutableDictionary alloc ] init];
        [mpSession setObject:@(downLoadTask.mpSessionModel.mpDownloadState) forKey:@"mpDownloadState"];
        [mpSession setObject:string         forKey:@"mpDownloadUrlString"];
        [mpSession setObject:downLoadTask.mpSessionModel.extra forKey:@"mpDownloadExtra"];
        
        
        NSInteger index = [self isExit:string];
        if (index == -1) {
            [self.mpDownloadArray addObject:mpSession];
        }else{
            [self.mpDownloadArray replaceObjectAtIndex:index withObject:mpSession];
        }
    }
    [self.mpDownloadArray writeToFile:filename atomically:NO];
}

-(NSInteger)isExit:(NSString *)urlString{
    
    for (NSInteger i = 0; i < self.mpDownloadArray.count; i ++) {
        NSDictionary *dic = self.mpDownloadArray[i];
        NSString *url = [dic objectForKey:@"mpDownloadUrlString"];
        if ([url isEqualToString:urlString]) {
            return i;
        }
    }
    return -1;
}

//　读取本地任务
-(NSMutableArray *)loadDownLoadTask{
    NSString *filename = [self filePathWithFileName:mpDownLoadTask];
    NSMutableArray *dic = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    if (dic == nil) {
        return [[NSMutableArray alloc ] init];
    }
    return dic;
}

-(NSString *)filePathWithFileName:(NSString *)fileName
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    return filename;
}


-(NSArray *)loadUnFinishedTask{

    NSMutableArray *unFinishedTasks = [[NSMutableArray alloc ] init];
    for (NSDictionary *dicMsg in [self loadDownLoadTask]) {
        if (![[dicMsg objectForKey:@"mpDownloadState"] isEqualToNumber:@(3)]) {
            [unFinishedTasks addObject:dicMsg];
        }
    }
    return unFinishedTasks;
}

-(NSArray *)loadFinishedTask{

    NSMutableArray *unFinishedTasks = [[NSMutableArray alloc ] init];
    for (NSDictionary *dicMsg in [self loadDownLoadTask]) {
        if ([[dicMsg objectForKey:@"mpDownloadState"] isEqualToNumber:@(3)]) {
            [unFinishedTasks addObject:dicMsg];
        }
    }
    return unFinishedTasks;
}

/**
 *  删除所有的任务
 */
-(void)deleAllTask{
    for (NSString *downLoadString in self.mpDownloadTasks.allKeys) {
        [[MusicPartnerDownloadManager sharedInstance] deleteFile:downLoadString];
    }
}

@end
