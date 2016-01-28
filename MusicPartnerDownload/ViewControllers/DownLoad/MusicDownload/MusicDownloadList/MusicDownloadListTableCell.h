//
//  MusicDownloadListTableCell.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/25.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicPartnerDownloadManager.h"
#import "TaskEntity.h"

@interface MusicDownloadListTableCell : UITableViewCell

@property (nonatomic,strong) NSString                *downloadUrl;
@property (weak, nonatomic ) IBOutlet UILabel        *musicName;
@property (weak, nonatomic ) IBOutlet UIProgressView *musicDownloadProgress;
@property (weak, nonatomic ) IBOutlet UILabel        *musicDownloadPercent;
@property (weak, nonatomic ) IBOutlet UIButton       *stopStartBtn;

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *desc;


- (IBAction)stopStartAction:(UIButton *)sender;

-(void)showData:(TaskEntity *)taskEntity;


@end
