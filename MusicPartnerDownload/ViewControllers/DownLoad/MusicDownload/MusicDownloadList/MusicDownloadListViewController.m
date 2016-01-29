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
#import <MediaPlayer/MediaPlayer.h>

#import "DTKDropdownMenuView.h"

@interface MusicDownloadListViewController ()

@property (nonatomic , strong) MusicDownloadDataSource *dataSource;

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
    
    [self addRightItem];
    self.dataSource = [[MusicDownloadDataSource alloc ] init];
    
    __weak typeof(self) weakSelf = self;
    self.dataSource.downloadStatusChangeBlock = ^(TaskDownloadState mpDownloadState,NSString *downLoadUrlString){
        [weakSelf.mainTableView reloadData];
    };
    
    [self.mainTableView setTableFooterView:[[UIView alloc ] init]];
    [self loadNewTask];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewTask) name:MpDownLoadingTask object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewTask) name:MpDownLoadCompleteDeleteTask object:nil];
    
    
    
    
}


-(void)loadNewTask{
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskEntity *taskEntity = [self.dataSource.unFinishedTasks objectAtIndex:indexPath.row];
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:taskEntity.mpDownLoadPath]];
    [self presentViewController:moviePlayer animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)addRightItem
{
    __weak typeof(self) weakSelf = self;
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"全部删除" iconName:@"menu_delete" callBack:^(NSUInteger index, id info) {
         [weakSelf.dataSource deleAllTask];
      
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"全部开始" iconName:@"menu_download" callBack:^(NSUInteger index, id info) {
                [weakSelf.dataSource startAllTask];
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"全部暂停" iconName:@"menu_pause" callBack:^(NSUInteger index, id info) {
       [weakSelf.dataSource pauseAllTask];
    }];

    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"more"];
    
    menuView.dropWidth = 130.f;
    menuView.titleFont = [UIFont systemFontOfSize:15.f];
    menuView.textColor = GLOBLE_GRAY_COLOR_3;
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = UI_RGBA(229.f, 229.f, 229.f,1);
    menuView.textFont = [UIFont systemFontOfSize:15.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}
@end
