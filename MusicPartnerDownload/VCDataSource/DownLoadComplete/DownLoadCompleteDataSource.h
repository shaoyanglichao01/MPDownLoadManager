//
//  DownLoadCompleteDataSource.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/28.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicPartnerDownloadManager.h"
#import "TaskEntity.h"

@interface DownLoadCompleteDataSource : NSObject

// 未完成的任务
@property (nonatomic , strong) NSMutableArray *finishedTasks;

/**
 *  读取下载完成的任务
 */
-(void)loadFinishedTasks;

@end
