//
//  MusicDownloadDataSource.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/27.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MusicDownloadDataSource.h"

@implementation MusicDownloadDataSource

-(id)init{
    self.unFinishedTasks = [[NSMutableArray alloc] init];
    return [super init];
}

-(void)loadUnFinishedTasks{
    
    [self.unFinishedTasks removeAllObjects];

    NSArray *unFinishedTasks = [[MusicPartnerDownloadManager sharedInstance] loadUnFinishedTask];
    for (NSDictionary *taskDic in unFinishedTasks) {
        NSString *status         = [taskDic objectForKey:@"mpDownloadState"];
        NSString *downLoadString = [taskDic objectForKey:@"mpDownloadUrlString"];
        NSString *exra  = [taskDic objectForKey:@"mpDownloadExtra"];
        NSLog(@"exra%@",exra);
        
        TaskEntity *taskEntity = [[TaskEntity alloc ] init];
        taskEntity.downLoadUrl = downLoadString;
        taskEntity.taskDownloadState = [self getTaskDownloadState:status];
        taskEntity.progress = [[MusicPartnerDownloadManager sharedInstance] progress:downLoadString];
        [self.unFinishedTasks addObject:taskEntity];
    }
    
}

-(TaskDownloadState)getTaskDownloadState:(NSString *)status{
    NSInteger state = [status integerValue];
    return (TaskDownloadState)state;
}

-(void)deleAllTask{
    [[MusicPartnerDownloadManager sharedInstance] deleAllTask];
    [self loadUnFinishedTasks];
    
    if (self.downloadStatusChangeBlock) {
        self.downloadStatusChangeBlock(0,nil);
    }
}

/**
 *  开始下载未完成的任务 1.之前的状态是正在下载的则继续下载。否则暂停下载
 */
-(void)startDownLoadUnFinishedTasks{
    
    for (TaskEntity *taskEntity in self.unFinishedTasks) {
        [[MusicPartnerDownloadManager sharedInstance] downLoad:taskEntity.downLoadUrl progressBlock:^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
            
            taskEntity.progressBlock(progress,totalMBRead,totalMBExpectedToRead);
        } completeBlock:^(MPDownloadState mpDownloadState, NSString *downLoadUrlString) {
            taskEntity.taskDownloadState = (TaskDownloadState)mpDownloadState;
            if (mpDownloadState == MPDownloadStateCompleted) {
                [self deleteFinishedTasks:downLoadUrlString];
            }
            taskEntity.completeBlock(taskEntity.taskDownloadState,downLoadUrlString);
            
            if (self.downloadStatusChangeBlock) {
                self.downloadStatusChangeBlock(taskEntity.taskDownloadState,downLoadUrlString);
            }
        }];
    }
}

-(void)deleteFinishedTasks:(NSString *)url{
    NSMutableArray *tasks = [[NSMutableArray alloc ] init];
    for (TaskEntity *taskEntity in self.unFinishedTasks){
        if (![taskEntity.downLoadUrl isEqualToString:url]) {
            [tasks addObject:taskEntity];
        }
    }
    self.unFinishedTasks = tasks;
 
}

@end
