//
//  MusicListTableCell.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/25.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MusicListTableCell.h"

@implementation MusicListTableCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)downLoadAction:(UIButton *)sender {
    [self.delegate addDownLoadTaskAction:self.index];
}


-(void)showData:(NSDictionary *)data{
    self.name.text = [data objectForKey:@"name"];
    self.desc.text = [data objectForKey:@"desc"];
    self.img.image = [UIImage imageNamed:[data objectForKey:@"imgName"]];
}

@end
