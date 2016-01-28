//
//  MineViewController.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/28.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableCell.h"
#import "MusicPartnerDownloadManager.h"
#import "TaskEntity.h"
#import "DownLoadCompleteDataSource.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic , strong) DownLoadCompleteDataSource *downLoadCompleteDataSource;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.downLoadCompleteDataSource = [[DownLoadCompleteDataSource alloc ] init];
    [self mpDownLoadCompleteTask];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mpDownLoadCompleteTask) name:MpDownLoadCompleteTask object:nil];
}

-(void)mpDownLoadCompleteTask{
    [self.downLoadCompleteDataSource loadFinishedTasks];
    [self.mainTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return GTFixHeightFloat(140)+55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.downLoadCompleteDataSource.finishedTasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableCell *musicListCell = [tableView dequeueReusableCellWithIdentifier:@"MineTableCell"];
    TaskEntity *taskEntity = [self.downLoadCompleteDataSource.finishedTasks objectAtIndex:indexPath.row];
    musicListCell.name.text = taskEntity.name;
    musicListCell.img.image = [UIImage imageNamed:taskEntity.imgName];
    
    return musicListCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskEntity *taskEntity = [self.downLoadCompleteDataSource.finishedTasks objectAtIndex:indexPath.row];
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:taskEntity.mpDownLoadPath]];
    [self presentViewController:moviePlayer animated:YES completion:nil];
}

@end
