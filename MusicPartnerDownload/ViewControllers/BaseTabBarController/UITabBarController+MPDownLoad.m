//
//  UITabBarController+MPDownLoad.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/28.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "UITabBarController+MPDownLoad.h"
#import "MusicPartnerDownloadManager.h"

@implementation UITabBarController (MPDownLoad)

-(void)setUpMPDownLoadStateBade{
    
    [self mpDownLoadingTask];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mpDownLoadingTask) name:MpDownLoadingTask object:nil];
}

-(void)mpDownLoadingTask{
     NSInteger taskCount = [[MusicPartnerDownloadManager sharedInstance] getDownLoadingTaskCount];
    if (taskCount > 0) {
        [self.viewControllers objectAtIndex:1].tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)taskCount];
    }else{
        [self.viewControllers objectAtIndex:1].tabBarItem.badgeValue =  nil;
    }
}

@end
