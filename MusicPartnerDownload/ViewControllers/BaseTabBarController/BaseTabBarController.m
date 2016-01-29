//
//  BaseTabBarController.m
//  didacar
//
//  Created by 度周末网络-王腾 on 15/11/27.
//  Copyright © 2015年 dzmmac. All rights reserved.
//

#import "BaseTabBarController.h"
#import "AppColorConfig.h"
#import "UITabBarController+MPDownLoad.h"

@interface BaseTabBarController () <UITabBarControllerDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarItems];
   
    [self setUpMPDownLoadStateBade];
    

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -------------设置TabBar控制的各个视图控制器-------------------
-(void)setTabBarItems{
    
    UINavigationController *navDiscover = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateInitialViewController];
    [self configureNavigationBar:navDiscover];
    
    UINavigationController *navDownLoad =  [[UIStoryboard storyboardWithName:@"MusicDownloadList" bundle:nil] instantiateInitialViewController];
    [self configureNavigationBar:navDownLoad];
    
    
    UINavigationController *navMine = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateInitialViewController];
    [self configureNavigationBar:navMine];
    
    self.viewControllers = [NSArray arrayWithObjects:
                            navDiscover,
                            navDownLoad,
                            navMine,
                            nil];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(-3, 0, 3, 0);
    
    UITabBarItem *discoverTabBar = [[UITabBarItem alloc ] initWithTitle:@"发现" image:[UIImage imageNamed:@"tabbar_discvoer"]  selectedImage:[UIImage imageNamed:@"tabbar_discvoer_on"]];
    navDiscover.tabBarItem = discoverTabBar;
    discoverTabBar.imageInsets = insets;
    
    UITabBarItem *downLoadTabBar = [[UITabBarItem alloc ] initWithTitle:@"下载" image:[UIImage imageNamed:@"tabbar_download"] selectedImage:[UIImage imageNamed:@"tabbar_download_on"]];
    navDownLoad.tabBarItem = downLoadTabBar;
    downLoadTabBar.imageInsets = insets;
    
    UITabBarItem *mineTabBar = [[UITabBarItem alloc ] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_mine"] selectedImage:[UIImage imageNamed:@"tabbar_mine_on"]];
    navMine.tabBarItem = mineTabBar;
    mineTabBar.imageInsets = insets;
    
    [self.tabBar setSelectedImageTintColor:GLOBLE_TABBAR_COLOR];
    
    // 改变tabBar 上title的颜色 和 字体大小
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:GLOBLE_GRAY_COLOR_3, NSForegroundColorAttributeName, [UIFont systemFontOfSize:11], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,GLOBLE_TABBAR_COLOR,NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    // 改变UITabBarItem的title的位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -4)];

    
    self.tabBar.shadowImage      = [UIImage new];
    self.tabBar.backgroundImage  = [UIImage new];
    
    
    //tabBar背景色
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.bounds.size.width, 0.47)];
    lineView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:0.8];
    [bgView addSubview:lineView];
    [self.tabBar insertSubview:bgView atIndex:0];

}


-(void)configureNavigationBar:(UINavigationController *)navigationController{
    [navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIImage *image = [UIImage imageNamed:@"navigationbar_background"];
    
    [navigationController.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    //设置阴影的高度
    navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 1);
    //设置透明度
    navigationController.navigationBar.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    navigationController.navigationBar.layer.shadowOpacity = 0.2;
    navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)].CGPath;
}

@end
