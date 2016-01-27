//
//  MusicPartnerDownloadEntity.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/27.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicPartnerDownloadEntity : NSObject

// 下载的地址
@property (nonatomic , strong) NSString *downLoadUrlString;

// 附加字段
@property (nonatomic , strong) NSDictionary *extra;

@end
