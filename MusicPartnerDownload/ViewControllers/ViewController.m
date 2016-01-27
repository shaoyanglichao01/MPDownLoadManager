//
//  ViewController.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/26.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "ViewController.h"
#import "MusicPartnerDownloadTask.h"
#import "MusicPartnerDownloadManager.h"


#define task1 @"http://120.25.226.186:32812/resources/videos/minion_01.mp4"
#define task2 @"http://mw5.dwstatic.com/1/3/1528/133489-99-1436409822.mp4"

@interface ViewController ()

- (IBAction)s:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *t1;
@property (weak, nonatomic) IBOutlet UIProgressView *p1;
- (IBAction)zant:(UIButton *)sender;




@property (weak, nonatomic) IBOutlet UILabel *t2;
- (IBAction)s2:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *p2;

- (IBAction)z2:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [[MusicPartnerDownloadManager sharedInstance] initUnFinishedTask];

    
    self.p1.progress = [[MusicPartnerDownloadManager sharedInstance] progress:task1];
    self.t1.text   = @(self.p1.progress).stringValue;
    [[MusicPartnerDownloadManager sharedInstance] downLoad:task1 progressBlock:^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        self.p1.progress = progress;
        self.t1.text   = @(progress).stringValue;
    } completeBlock:^(MPDownloadState mpDownloadState, NSString *downLoadUrlString) {
       
    }];
    
    self.p2.progress = [[MusicPartnerDownloadManager sharedInstance] progress:task2];
    self.t2.text   = @(self.p2.progress).stringValue;
    [[MusicPartnerDownloadManager sharedInstance] downLoad:task2 progressBlock:^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        self.p2.progress = progress;
        self.t2.text   = @(progress).stringValue;
    } completeBlock:^(MPDownloadState mpDownloadState, NSString *downLoadUrlString) {
       
    }];

}


-(NSString *)getString:(MPDownloadState )status1{
    
    switch (status1) {
        case MPDownloadStateRunning:
           return  @"暂停";
            break;
        case MPDownloadStateSuspended:
            return  @"开始";
            break;
        case MPDownloadStateCompleted:
            return  @"完成";
            break;
        default:
            return @"失败";
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)s:(UIButton *)sender {
    [[MusicPartnerDownloadManager sharedInstance] start:task1];
    
}

- (IBAction)zant:(UIButton *)sender {
        [[MusicPartnerDownloadManager sharedInstance] pause:task1];
}

- (IBAction)s2:(UIButton *)sender {
        [[MusicPartnerDownloadManager sharedInstance] start:task2];
}

- (IBAction)z2:(UIButton *)sender {
        [[MusicPartnerDownloadManager sharedInstance] pause:task2];
}
@end
