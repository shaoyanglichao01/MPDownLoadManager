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

@end
