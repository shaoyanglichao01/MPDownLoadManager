//
//  MusicPartnerDownloadTask.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/26.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MPSessionModel.h"
#import "MusicPartnerDownloadEntity.h"

// 缓存主目录
#define MPCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HSCache"]

// 保存文件名
#define MPFileName(url) [[url componentsSeparatedByString:@"/"] lastObject]


// 文件的存放路径（caches）
#define MPFileFullpath(url) [MPCachesDirectory stringByAppendingPathComponent:MPFileName(url)]

// 文件的已下载长度
#define MPDownloadLength(url) [[[NSFileManager defaultManager] attributesOfItemAtPath:MPFileFullpath(url) error:nil][NSFileSize] integerValue]

// 存储文件总长度的文件路径（caches）
#define MPTotalLengthFullpath [MPCachesDirectory stringByAppendingPathComponent:@"totalLength.plist"]


@protocol MusicPartnerDownloadTaskDelegate <NSObject>

-(void)downloadComplete:(MPDownloadState)mpDownloadState downLoadUrlString:(NSString *)downLoadUrlString;


@end

typedef void(^MPartnerDownloadProgressBlock)(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead);

typedef void(^MPartnerDownloadCompleteBlock)(MPDownloadState mpDownloadState,NSString *downLoadUrlString);


@interface MusicPartnerDownloadTask : NSObject

@property (nonatomic , assign) id<MusicPartnerDownloadTaskDelegate> delegate;

@property (nonatomic , copy) MPartnerDownloadProgressBlock mpartnerDownloadProgressBlock;

@property (nonatomic , copy) MPartnerDownloadCompleteBlock mpartnerDownloadCompleteBlock;


@property (nonatomic , strong) NSURLSession   *session;

// 下载相关信息
@property (nonatomic , strong) MPSessionModel *mpSessionModel;

// 下载任务
@property (nonatomic , strong) NSURLSessionDataTask *downLoadTask;


/**
 *  添加下载任务并下载
 *
 *  @param urlString 下载的地址
 */
-(MPDownloadState)addTaskWithDownLoadMusic:(MusicPartnerDownloadEntity *)mPDownloadEntity;

-(void)downLoad:(NSString *)url progressBlock:(MPartnerDownloadProgressBlock)progressBlock completeBlock:(MPartnerDownloadCompleteBlock)completeBlock mpDownloadState:(MPDownloadState)mpDownloadState;

/**
 *  查询该资源的下载进度值
 */
- (CGFloat)progress:(NSString *)url;

/**
 *  判断该文件是否下载完成
 */
- (BOOL)isCompletion:(NSString *)url;

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

@end
