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
    self.progressBarView = [[TYMProgressBarView alloc] initWithFrame:CGRectMake(86 , 80, [UIScreen mainScreen].bounds.size.width - 157, 8.0f)];
    [self.contentBgView addSubview:self.progressBarView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)stopStartAction:(UIButton *)sender {

    if (self.taskEntity.taskDownloadState == TaskStateRunning) {
          [[MusicPartnerDownloadManager sharedInstance] pause:self.downloadUrl];
        [self.stopStartBtn setImage:[UIImage imageNamed:@"menu_pause"] forState:UIControlStateNormal];
    }else if (self.taskEntity.taskDownloadState == TaskStateSuspended){
         [[MusicPartnerDownloadManager sharedInstance] start:self.downloadUrl];
        [self.stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
    }else{
        [[MusicPartnerDownloadManager sharedInstance] start:self.downloadUrl];
        [self.stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
    }
    
    
}


-(void)showData:(TaskEntity *)taskEntity{
    
    self.taskEntity = taskEntity;
    
    self.desc.text = taskEntity.desc;
    self.img.image = [UIImage imageNamed:taskEntity.imgName];
    self.downloadUrl = taskEntity.downLoadUrl;
    self.musicName.text = taskEntity.name;
    self.progressBarView.progress = taskEntity.progress;
    self.musicDownloadPercent.text =  [NSString stringWithFormat:@"%.3f",taskEntity.progress];
    
    if (taskEntity.taskDownloadState == TaskStateSuspended) {
        [self.stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
    }else if (taskEntity.taskDownloadState == TaskStateRunning){
        [self.stopStartBtn setImage:[UIImage imageNamed:@"menu_pause"] forState:UIControlStateNormal];
    }else{
         [self.stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
    }
    
    __weak typeof(self) weakSelf = self;
    taskEntity.progressBlock = ^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        weakSelf.progressBarView.progress = progress;
        weakSelf.musicDownloadPercent.text = [NSString stringWithFormat:@"%.3f",progress];
    };
    
    taskEntity.completeBlock = ^(TaskDownloadState mpDownloadState,NSString *downLoadUrlString) {
        if (mpDownloadState == TaskStateSuspended) {
            
            weakSelf.taskEntity.taskDownloadState = TaskStateSuspended;
           [weakSelf.stopStartBtn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
        }else if (mpDownloadState == TaskStateRunning){
            weakSelf.taskEntity.taskDownloadState = TaskStateRunning;
            [weakSelf.stopStartBtn setImage:[UIImage imageNamed:@"menu_pause"] forState:UIControlStateNormal];
        }
    };
    
}

@end
