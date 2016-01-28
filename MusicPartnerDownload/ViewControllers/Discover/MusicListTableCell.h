//
//  MusicListTableCell.h
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/25.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicListDelegate <NSObject>

-(void)addDownLoadTaskAction:(NSIndexPath *)indexPath;

@end

@interface MusicListTableCell : UITableViewCell

@property (assign ,nonatomic) id<MusicListDelegate> delegate;

@property (strong,nonatomic) NSIndexPath *index;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *desc;

- (IBAction)downLoadAction:(UIButton *)sender;


-(void)showData:(NSDictionary *)data;

@end
