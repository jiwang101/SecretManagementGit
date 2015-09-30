//
//  SecretUpdateViewController.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/30.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "SecretUpdateViewController.h"

@implementation SecretUpdateViewController
#pragma mark - life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}
#pragma mark - initView
- (void)initView{
    if (self.secretType == SecretType_Add) {
        self.headView.titleLabel.text = @"添加";
    }else{
        self.headView.titleLabel.text = @"修改";
    }
    self.headView.delegate = self;
}
#pragma mark - HeadViewDelegate
- (void)responseLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
