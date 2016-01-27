//
//  MusicDownloadListViewController.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/25.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MusicDownloadListViewController.h"
#import "MusicDownloadListTableCell.h"
#import "MusicDownloadDataSource.h"

@interface MusicDownloadListViewController ()

@property (nonatomic , strong) MusicDownloadDataSource *dataSource;
- (IBAction)deleAll:(UIBarButtonItem *)sender;

@end

@implementation MusicDownloadListViewController

+(MusicDownloadListViewController *)shareManager{
    static MusicDownloadListViewController *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[UIStoryboard storyboardWithName:@"MusicDownloadList" bundle:nil] instantiateInitialViewController];
    });
    return instance;
}

-(void)startDownLoad{
    [self.mainTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[MusicDownloadDataSource alloc ] init];
    
    __weak typeof(self) weakSelf = self;
    self.dataSource.downloadStatusChangeBlock = ^(TaskDownloadState mpDownloadState,NSString *downLoadUrlString){
        [weakSelf.mainTableView reloadData];
    };
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataSource  loadUnFinishedTasks];
    [self.mainTableView reloadData];
    [self.dataSource startDownLoadUnFinishedTasks];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.unFinishedTasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicDownloadListTableCell *musicListCell = [tableView dequeueReusableCellWithIdentifier:@"MusicDownloadListTableCell"];
    TaskEntity *taskEntity    = [self.dataSource.unFinishedTasks objectAtIndex:indexPath.row];
    musicListCell.downloadUrl = taskEntity.downLoadUrl;
    musicListCell.musicName.text = taskEntity.downLoadUrl;
    musicListCell.musicDownloadProgress.progress = taskEntity.progress;
    musicListCell.musicDownloadPercent.text =  [NSString stringWithFormat:@"%.3f",taskEntity.progress];
    
    if (taskEntity.taskDownloadState == TaskStateSuspended) {
        [musicListCell.stopStartBtn setTitle:@"开始" forState:UIControlStateNormal];
    }else if (taskEntity.taskDownloadState == TaskStateRunning){
        [musicListCell.stopStartBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    
    taskEntity.progressBlock = ^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        
            musicListCell.musicDownloadProgress.progress = progress;
            musicListCell.musicDownloadPercent.text = [NSString stringWithFormat:@"%.3f",progress];
      
    };
    
    taskEntity.completeBlock = ^(TaskDownloadState mpDownloadState,NSString *downLoadUrlString) {
        if (mpDownloadState == TaskStateSuspended) {
            [musicListCell.stopStartBtn setTitle:@"开始" forState:UIControlStateNormal];
        }else if (mpDownloadState == TaskStateRunning){
            [musicListCell.stopStartBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }
    };
    
    return musicListCell;
}




//
//-(void)downLoad:(MusicDownloadListTableCell *)cell s:(NSString *)downLoadString{
//
//        
//        [[MusicPartnerDownloadManager sharedInstance] downLoad:downLoadString progressBlock:^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                cell.musicDownloadProgress.progress = progress;
//                cell.musicDownloadPercent.text = @(progress).stringValue;
//            });
//            
//        } completeBlock:^(MPDownloadState mpDownloadState,NSString *downLoadUrlString) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [cell.stopStartBtn setTitle:[MusicDownloadListTableCell getTitleWithDownloadState:mpDownloadState] forState:UIControlStateNormal];
//                
//                
//            });
//        }];
//  
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)deleAll:(UIBarButtonItem *)sender {
    [self.dataSource deleAllTask];
    
}
@end
