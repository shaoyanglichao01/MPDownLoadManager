//
//  MPDownLoadManager.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/26.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLDownloader.h"

// 开始下载通知
#define MPDOWNLOADSTART @"MPDOWNLOADSTART"


@interface MPDownLoadManager : NSObject

@property (nonatomic , strong ) NSMutableArray *mpDownloadTasks;

/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;

// 添加新的下载任务
-(void)addNewDownLoadTask:(NSString *)url;

// 获取下载任务
-(NSMutableArray *)getMpDownloadTasks;

@end
