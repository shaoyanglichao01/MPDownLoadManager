//
//  AppColorConfig.h
//  dzm
//
//  Created by dzmmac on 15/1/26.
//  Copyright (c) 2015年 dzmmac. All rights reserved.
//

#ifndef dzm_AppColorConfig_h
#define dzm_AppColorConfig_h

#define UI_RGBA(r,g,b,a)           [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]


#define UI_RGBA_HEX(rgbValue)       [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/**
 *  全局导航颜色
 */
#define GLOBLE_NAVIGATION_COLOR    UI_RGBA_HEX(0x2AA515)


/**
 *  TabBar颜色
 */
#define GLOBLE_TABBAR_COLOR        UI_RGBA_HEX(0xE9632A)


/**
 *  全局背景颜色
 */
#define GLOBLE_BACKGROUND_COLOR    UI_RGBA(241, 241, 241, 1)

/**
 *  灰色1 cccccc
 */
#define GLOBLE_GRAY_COLOR_1      UI_RGBA_HEX(0xCCCCCC)

/**
 *  灰色2 999999
 */
#define GLOBLE_GRAY_COLOR_2      UI_RGBA_HEX(0x999999)
#define GLOBLE_GRAY_COLOR_2_HEX  @"#999999"

/**
 *  灰色3 666666
 */
#define GLOBLE_GRAY_COLOR_3      UI_RGBA_HEX(0x666666)
#define GLOBLE_GRAY_COLOR_3_HEX  @"#666666"

#define GLOBLE_GRAY_COLOR_5      UI_RGBA_HEX(0x55555)
#define GLOBLE_GRAY_COLOR_5_HEX  @"#555555"


/**
 *  文本颜色
 */
#define GLOBLE_TEXT_COLOR        UI_RGBA(51,51,51,1)
#define GLOBLE_TEXT_COLOR_HEX    @"#333333"

#endif
