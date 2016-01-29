//
//  MineTableCell.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/28.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRCellSlideGestureRecognizer.h"
@interface MineTableCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;

-(void)configurePanDelete:(DRCellSlideActionBlock)drCellSlideActionBlock;

@end
