//
//  MusicDownloadListTableCell.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/25.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MusicDownloadListTableCell.h"


@implementation MusicDownloadListTableCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)stopStartAction:(UIButton *)sender {
    
    if ([self.stopStartBtn.titleLabel.text isEqualToString:@"暂停"]) {
        [[MusicPartnerDownloadManager sharedInstance] pause:self.downloadUrl];
    }else if ([self.stopStartBtn.titleLabel.text isEqualToString:@"开始"]){
        [[MusicPartnerDownloadManager sharedInstance] start:self.downloadUrl];
    }
}


-(void)showData:(TaskEntity *)taskEntity{
    
    self.desc.text = taskEntity.desc;
    self.img.image = [UIImage imageNamed:taskEntity.imgName];
    self.downloadUrl = taskEntity.downLoadUrl;
    self.musicName.text = taskEntity.name;
    self.musicDownloadProgress.progress = taskEntity.progress;
    self.musicDownloadPercent.text =  [NSString stringWithFormat:@"%.3f",taskEntity.progress];
    
    if (taskEntity.taskDownloadState == TaskStateSuspended) {
        [self.stopStartBtn setTitle:@"开始" forState:UIControlStateNormal];
    }else if (taskEntity.taskDownloadState == TaskStateRunning){
        [self.stopStartBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    
    taskEntity.progressBlock = ^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        self.musicDownloadProgress.progress = progress;
        self.musicDownloadPercent.text = [NSString stringWithFormat:@"%.3f",progress];
    };
    
    taskEntity.completeBlock = ^(TaskDownloadState mpDownloadState,NSString *downLoadUrlString) {
        if (mpDownloadState == TaskStateSuspended) {
            [self.stopStartBtn setTitle:@"开始" forState:UIControlStateNormal];
        }else if (mpDownloadState == TaskStateRunning){
            [self.stopStartBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }
    };
    
}

@end
