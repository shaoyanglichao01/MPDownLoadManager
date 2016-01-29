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
    [[[UIAlertView alloc ] initWithTitle:@""
                                 message:tip
                                delegate:nil
                       cancelButtonTitle:@"确定"
                       otherButtonTitles:nil, nil]  show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
