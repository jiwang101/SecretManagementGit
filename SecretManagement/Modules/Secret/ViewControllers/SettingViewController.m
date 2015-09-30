//
//  SettingViewController.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/30.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController
#pragma mark - life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}
#pragma mark - initView
- (void)initView{
    self.headView.titleLabel.text = @"设置";
    self.headView.delegate = self;
}
#pragma mark - HeadViewDelegate
- (void)responseLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
