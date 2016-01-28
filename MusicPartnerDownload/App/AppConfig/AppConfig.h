//
//  AppConfig.h
//  dzm
//
//  Created by dzmmac on 14-9-26.
//  Copyright (c) 2014年 dzmmac. All rights reserved.
//

#ifndef dzm_AppConfig_h
#define dzm_AppConfig_h


#define USERINFOManager [UserInfoManager sharedManager]


#define WEAKSELF typeof(self) __weak weakSelf = self;
/* ----------------------------------通知 EOF ------------------------------- */



/* ----------------------------------版本 BOF ------------------------------- */

/**
 *  大于等于
 */
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

/**
 *  小于
 */
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

/**
 *  等于
 */
#define SYSTEM_VERSION_EQUAL(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
/* ----------------------------------版本 EOF ------------------------------- */


/* ----------------------------------手机型号 BOF ------------------------------- */
/**
 *  手机型号等于4
 */
#define MOBILEMODEL_4S        [[UIScreen mainScreen] currentMode].size.height < 1136 ? YES : NO

/**
 *  手机型号等于5
 */
#define MOBILEMODEL_5         [[UIScreen mainScreen] currentMode].size.height == 1136 ? YES : NO

/**
 *  手机型号5之后包含5
 */
#define MOBILEMODEL_GREATER_THAN_OR_EQUAL_TO_5  [[UIScreen mainScreen] currentMode].size.height >= 1136 ? YES : NO

/**
 *  手机型号等于6
 */
#define MOBILEMODEL_6         [[UIScreen mainScreen] currentMode].size.height == 1334 ? YES : NO

/**
 *  手机型号6之后包含6
 */
#define MOBILEMODEL_GREATER_THAN_OR_EQUAL_TO_6  [[UIScreen mainScreen] currentMode].size.height >= 1334  ? YES : NO

/**
 *  手机型号6p
 */
#define MOBILEMODEL_6P        [[UIScreen mainScreen] currentMode].size.height == 2208 ? YES : NO

/**
 *  手机型号6p之前
 */
#define MOBILEMODEL_LESS_THAN     [[UIScreen mainScreen] currentMode].size.height < 2208 ? YES : NO
/* ----------------------------------手机型号 EOF ------------------------------- */

#endif


