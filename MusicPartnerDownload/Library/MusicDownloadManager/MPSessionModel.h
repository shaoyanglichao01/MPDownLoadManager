//
//  MPSessionModel.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/26.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    MPDownloadStateRunning = 1,    /** 下载中 */
    MPDownloadStateSuspended =2,     /** 下载暂停 */
    MPDownloadStateCompleted =3,     /** 下载完成 */
    MPDownloadStateFailed  = 4        /** 下载失败 */
}MPDownloadState;

@interface MPSessionModel : NSObject

// 附加字段
@property (nonatomic , strong) NSDictionary *extra;

// 下载状态
@property (nonatomic , assign) MPDownloadState mpDownloadState;

/** 流 */
@property (nonatomic, strong ) NSOutputStream  *stream;

/** 下载地址 */
@property (nonatomic, strong ) NSString        *urlString;

/** 存放地址 */
@property (nonatomic, strong ) NSString        *downLoadPath;

/** 获得服务器这次请求 返回数据的总长度 */
@property (nonatomic, assign ) u_int64_t       totalLength;


// 下载进度
@property (nonatomic, assign ) NSInteger       process;

@end
