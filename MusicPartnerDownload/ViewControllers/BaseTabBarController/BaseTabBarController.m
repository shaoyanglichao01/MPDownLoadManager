//
//  BaseTabBarController.m
//  didacar
//
//  Created by 度周末网络-王腾 on 15/11/27.
//  Copyright © 2015年 dzmmac. All rights reserved.
//

#import "BaseTabBarController.h"
#import "AppColorConfig.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -------------设置TabBar控制的各个视图控制器-------------------
-(void)setTabBarItems{
    
    UINavigationController *navBuyTickets = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateInitialViewController];
    
    UINavigationController *navRide =  [[UIStoryboard storyboardWithName:@"MusicDownloadList" bundle:nil] instantiateInitialViewController];
    
    UINavigationController *navMyInfomation = [[UIStoryboard storyboardWithName:@"MyInfo" bundle:nil] instantiateInitialViewController];
  
    self.viewControllers = [NSArray arrayWithObjects:
                            navBuyTickets,
                            navRide,
                            navMyInfomation,
                            nil];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(-3, 0, 3, 0);
    
    UITabBarItem *buyTicketsTabBar = [[UITabBarItem alloc ] initWithTitle:@"发现" image:[UIImage imageNamed:@"tabBar_buyTickets_noraml"]  tag:Enum_TabBar_Items_BuyTickets];
    navBuyTickets.tabBarItem = buyTicketsTabBar;
    buyTicketsTabBar.imageInsets = insets;
    
    UITabBarItem *rideTabBar = [[UITabBarItem alloc ] initWithTitle:@"下载" image:[UIImage imageNamed:@"tabBar_ride_noraml"] tag:Enum_TabBar_Items_Ride];
    navRide.tabBarItem = rideTabBar;
    rideTabBar.imageInsets = insets;
    
    UITabBarItem *myInfomationTabBar = [[UITabBarItem alloc ] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabBar_myInfomation_noraml"] tag:Enum_TabBar_Items_MyInfomation];
    navMyInfomation.tabBarItem = myInfomationTabBar;
    myInfomationTabBar.imageInsets = insets;
    
    [self.tabBar setSelectedImageTintColor:GLOBLE_NAVIGATION_COLOR];
    
    // 改变tabBar 上title的颜色 和 字体大小
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:GLOBLE_GRAY_COLOR_2, NSForegroundColorAttributeName, [UIFont systemFontOfSize:11], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,GLOBLE_NAVIGATION_COLOR,NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    // 改变UITabBarItem的title的位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -4)];

    
}

@end
