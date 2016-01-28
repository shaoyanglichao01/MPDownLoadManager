//
//  BaseTabBarController.h
//  didacar
//
//  Created by 度周末网络-王腾 on 15/11/27.
//  Copyright © 2015年 dzmmac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Enum_TabBar_Item) {
    /* 购票 */
    Enum_TabBar_Items_BuyTickets,
    /* 乘车 */
    Enum_TabBar_Items_Ride,
    /* 我的 */
    Enum_TabBar_Items_MyInfomation
};


@interface BaseTabBarController : UITabBarController

@end
