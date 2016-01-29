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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mpDownLoadCompleteTask) name:MpDownLoadCompleteTask object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mpDeleteCompleteTask) name:MpDownLoadCompleteDeleteTask object:nil];
    
    self.delegate = self;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSInteger selectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
    if (selectedIndex == 2) {
        [self reSetMpDownLoadCompleteTaskCount];
    }
}

-(void)reSetMpDownLoadCompleteTaskCount{
    
    NSNumber *count =  [[NSUserDefaults standardUserDefaults] objectForKey:@"mpDownLoadCompleteTaskCountFlag"];
    [[NSUserDefaults standardUserDefaults] setObject:count forKey:@"mpDownLoadCompleteTaskCount"];
    [self.viewControllers objectAtIndex:2].tabBarItem.badgeValue =  nil;
}

-(void)mpDeleteCompleteTask{
    NSInteger taskCount = [[MusicPartnerDownloadManager sharedInstance] getFinishedTaskCount];
    [[NSUserDefaults standardUserDefaults] setObject:@(taskCount) forKey:@"mpDownLoadCompleteTaskCount"];
    
}

-(void)mpDownLoadCompleteTask{
    NSInteger taskCount = [[MusicPartnerDownloadManager sharedInstance] getFinishedTaskCount];
    [[NSUserDefaults standardUserDefaults] setObject:@(taskCount) forKey:@"mpDownLoadCompleteTaskCountFlag"];
    NSNumber *count =  [[NSUserDefaults standardUserDefaults] objectForKey:@"mpDownLoadCompleteTaskCount"];
    
    NSInteger currentTaskCount = taskCount - [count integerValue];
    if (currentTaskCount > 0) {
        [self.viewControllers objectAtIndex:2].tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)currentTaskCount];
    }else{
        [self.viewControllers objectAtIndex:2].tabBarItem.badgeValue =  nil;
    }
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
