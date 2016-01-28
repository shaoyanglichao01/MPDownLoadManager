//
//  DownLoadCompleteDataSource.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/28.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "DownLoadCompleteDataSource.h"

@implementation DownLoadCompleteDataSource

-(id)init{
    self.finishedTasks = [[NSMutableArray alloc ] init];
    return [super init];
}

/**
 *  读取下载完成的任务
 */
-(void)loadFinishedTasks{
    
    [self.finishedTasks removeAllObjects];
    
    NSArray *unFinishedTasks = [[MusicPartnerDownloadManager sharedInstance] loadFinishedTask];
    for (NSDictionary *taskDic in unFinishedTasks) {
        
        NSString *downLoadString = [taskDic objectForKey:@"mpDownloadUrlString"];
        NSDictionary *exra       = [taskDic objectForKey:@"mpDownloadExtra"];
        NSString *downLoadPath   = [taskDic objectForKey:@"mpDownLoadPath"];
        
        TaskEntity *taskEntity = [[TaskEntity alloc ] init];
        taskEntity.downLoadUrl = downLoadString;
        
        taskEntity.imgName  = [exra objectForKey:@"imgName"];
        taskEntity.name     = [exra objectForKey:@"name"];
        taskEntity.desc     = [exra objectForKey:@"desc"];
        taskEntity.mpDownLoadPath = downLoadPath;
        [self.finishedTasks addObject:taskEntity];
    }
}

@end
