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

@interface MusicListViewController () <MusicListDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic , strong) NSArray *discoverList;


@end

@implementation MusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Discover" ofType:@".plist"];
    self.discoverList = [NSArray arrayWithContentsOfFile:path];
    
    [[MusicPartnerDownloadManager sharedInstance] initUnFinishedTask];
    [self.mainTableView setTableFooterView:[[UIView alloc ] init]];
    [self.mainTableView  reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.discoverList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicListTableCell *musicListCell = [tableView dequeueReusableCellWithIdentifier:@"MusicListTableCell"];
    musicListCell.index    = indexPath;
    musicListCell.delegate = self;
    [musicListCell showData:[self.discoverList objectAtIndex:indexPath.row]];
    return musicListCell;
}

-(void)addDownLoadTaskAction:(NSIndexPath *)indexPath{
    
    NSDictionary *entity = [self.discoverList objectAtIndex:indexPath.row];
    NSString *downLoadUrl = [entity objectForKey:@"downLoadUrl"];
    
    
    
    MusicPartnerDownloadEntity *downLoadEntity = [[MusicPartnerDownloadEntity alloc] init];
    downLoadEntity.downLoadUrlString = downLoadUrl;
    downLoadEntity.extra = entity;
    [[MusicPartnerDownloadManager sharedInstance] addTaskWithDownLoadMusic:downLoadEntity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
