//
//  MPDownLoadManager.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/26.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MPDownLoadManager.h"

@implementation MPDownLoadManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static MPDownLoadManager *mpartnerDownloadManager;
    dispatch_once(&onceToken, ^{
        mpartnerDownloadManager = [[self alloc] init];
    });
    return mpartnerDownloadManager;
}

-(void)configLaunchStats{
    for (FLDownloadTask *download in self.mpDownloadTasks) {
         // 开始状态为暂停
        [download resumeOrPause];
        
//        [self doDown:download];
    }
}

-(NSMutableArray *)getMpDownloadTasks{
    self.mpDownloadTasks = [[[[FLDownloader sharedDownloader] tasks] allValues] mutableCopy];
    return self.mpDownloadTasks;
}

-(id)init{
    self.mpDownloadTasks = [[[[FLDownloader sharedDownloader] tasks] allValues] mutableCopy];
    [self configLaunchStats];
    return [super init];
}

-(void)addNewDownLoadTask:(NSString *)url{
    FLDownloadTask *download = [FLDownloadTask downloadTaskForURL:[NSURL URLWithString:url]];
    [download start];
    self.mpDownloadTasks = [[[[FLDownloader sharedDownloader] tasks] allValues] mutableCopy];
    [self postDownLoadNotification];
}



-(void)postDownLoadNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:MPDOWNLOADSTART object:nil];
}

@end
