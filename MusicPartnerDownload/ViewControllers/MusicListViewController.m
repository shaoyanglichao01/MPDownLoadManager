//
//  MusicListViewController.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/25.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "MusicListViewController.h"
#import "MusicListTableCell.h"

#import "MusicDownloadListViewController.h"

#import "MusicPartnerDownloadManager.h"

@interface MusicListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

- (IBAction)showDownLoadListAction:(UIButton *)sender;

@property (nonatomic , strong) NSArray *list;


@end

@implementation MusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.list = @[@"http://mw5.dwstatic.com/1/3/1528/133489-99-1436409822.mp4",
                  @"http://120.25.226.186:32812/resources/videos/minion_01.mp4",
                  @"http://pic6.nipic.com/20100330/4592428_113348097000_2.jpg"];
    
    [[MusicPartnerDownloadManager sharedInstance] initUnFinishedTask];
    
    [self.mainTableView setTableFooterView:[[UIView alloc ] init]];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicListTableCell *musicListCell = [tableView dequeueReusableCellWithIdentifier:@"MusicListTableCell"];
    return musicListCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *string = [self.list objectAtIndex:indexPath.row];
    
    
    MusicPartnerDownloadEntity *entity = [[MusicPartnerDownloadEntity alloc] init];
    entity.downLoadUrlString = string;
    entity.extra = @{@"name":[NSString stringWithFormat:@"kitt%@",@(indexPath.row)]};
    
    [[MusicPartnerDownloadManager sharedInstance] addTaskWithDownLoadMusic:entity];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

- (IBAction)showDownLoadListAction:(UIButton *)sender {
    
    MusicDownloadListViewController *musicDownloadListViewController = [MusicDownloadListViewController shareManager];
   
    [self.navigationController pushViewController:musicDownloadListViewController animated:YES];
}
@end
