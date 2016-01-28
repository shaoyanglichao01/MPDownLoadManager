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
    
    [self.mainTableView setTableFooterView:[[UIView alloc ] init]];
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
    [musicListCell showData:taskEntity];
    return musicListCell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)deleAll:(UIBarButtonItem *)sender {
    [self.dataSource deleAllTask];
    
}
@end
