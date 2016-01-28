//
//  BaseViewController.m
//  MusicPartnerDownload
//
//  Created by 度周末网络-王腾 on 16/1/28.
//  Copyright © 2016年 dzmmac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GLOBLE_BACKGROUND_COLOR;
}


-(void)showTip:(NSString *)tip{
    [self.view makeToast:tip
                duration:2.0
                position:@"bottom"
                   title:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
