//
//  MusicPartnerDownloadManager.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/26.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicPartnerDownloadTask.h"
#import "MusicPartnerDownloadEntity.h"


// 正在下载任务通知
#define MpDownLoadingTask @"MpDownLoadingTask"

// 完成下载任务通知
#define MpDownLoadCompleteTask @"MpDownLoadCompleteTask"

// 删除已经下载好的任务通知
#define MpDownLoadCompleteDeleteTask @"MpDownLoadCompleteDeleteTask"

typedef enum {
    MPTaskNoExistTask = 1,      /** 任务不存在 */
    MPTaskExistTask   = 2,      /** 任务存在 */
    MPTaskCompleted   = 3,      /** 下载完成 */
}MPTaskState;


@interface MusicPartnerDownloadManager : NSObject

// 所有下载的数据状态
@property (nonatomic, strong) NSMutableArray *mpDownloadArray;

/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 *  获取任务状态
 *
 *  @param urlString 下载地址
 *
 *  @return 任务状态
 */
-(MPTaskState)getTaskState:(NSString *)urlString;

/**
 *  添加下载任务并下载
 *
 *  @param urlString 下载的地址
 */
-(MPDownloadState)addTaskWithDownLoadMusic:(MusicPartnerDownloadEntity *)mPDownloadEntity;

-(void)downLoad:(NSString *)url progressBlock:(MPartnerDownloadProgressBlock)progressBlock completeBlock:(MPartnerDownloadCompleteBlock)completeBlock;

-(void)initUnFinishedTask;

// 获取正在下载的任务数量
-(NSInteger)getDownLoadingTaskCount;

// 获取下载完成的任务数量
-(NSInteger)getFinishedTaskCount;

/**
 *  查询该资源的下载进度值
 */
- (CGFloat)progress:(NSString *)url;

/**
 *  开始下载
 */
- (void)start:(NSString *)url;

/**
 *  暂停下载
 */
- (void)pause:(NSString *)url;

/**
 *  删除该资源
 *
 *  @param url 下载地址
 */
- (void)deleteFile:(NSString *)url;

/**
 *  删除所有的任务
 */
-(void)deleAllTask;

/**
 *  开始所有任务
 */
-(void)startAllTask;

/**
 *  暂停所有任务
 */
-(void)pauseAllTask;


/**
 *  判断该文件是否下载完成
 */
- (BOOL)isCompletion:(NSString *)url;

/**
 *  获取文件的下载主目录
 *
 *  @return
 */
-(NSString *)getDownLoadPath;

/**
 *  读取所有的任务
 *
 *  @return
 */
-(NSMutableArray *)loadDownLoadTask;

/**
 *  读取未完成的下载任务
 *
 *  @return
 */
-(NSArray *)loadUnFinishedTask;

/**
 *  读取完成的下载任务
 *
 *  @return
 */
-(NSArray *)loadFinishedTask;

@end
