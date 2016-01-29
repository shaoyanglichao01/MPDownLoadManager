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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.01)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.downLoadCompleteDataSource.finishedTasks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return GTFixHeightFloat(140)+45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableCell *musicListCell = [tableView dequeueReusableCellWithIdentifier:@"MineTableCell"];
    TaskEntity *taskEntity = [self.downLoadCompleteDataSource.finishedTasks objectAtIndex:indexPath.section];
    musicListCell.name.text = taskEntity.name;
    musicListCell.img.image = [UIImage imageNamed:taskEntity.imgName];
    
    __weak typeof(self) weakSelf = self;
    [musicListCell configurePanDelete:^(UITableView *tableView, NSIndexPath *indexPath) {
        
        [[MusicPartnerDownloadManager sharedInstance] deleteFile:taskEntity.downLoadUrl];
        [weakSelf.downLoadCompleteDataSource.finishedTasks removeObjectAtIndex:indexPath.section];
        [weakSelf.mainTableView reloadData];
        
    }];
    return musicListCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskEntity *taskEntity = [self.downLoadCompleteDataSource.finishedTasks objectAtIndex:indexPath.section];
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:taskEntity.mpDownLoadPath]];
    [self presentViewController:moviePlayer animated:YES completion:nil];
}

@end
