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
 *  添加下载任务并下载
 *
 *  @param urlString 下载的地址
 */
-(MPDownloadState)addTaskWithDownLoadMusic:(MusicPartnerDownloadEntity *)mPDownloadEntity;

-(void)downLoad:(NSString *)url progressBlock:(MPartnerDownloadProgressBlock)progressBlock completeBlock:(MPartnerDownloadCompleteBlock)completeBlock;

-(void)initUnFinishedTask;

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
