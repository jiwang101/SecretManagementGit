//
//  SafeKeySettingViewController.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/10/8.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "SafeKeySettingViewController.h"
#import "NSString+Util.h"
#import "UIViewController+Message.h"
#import "SecretModel.h"

@implementation SafeKeySettingViewController
#pragma mark life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    self.headView.titleLabel.text = @"设置安全密码";
    self.headView.leftBtn.hidden = YES;
    self.headView.rightBtn.hidden = NO;
    [self.headView.rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    
}
#pragma mark HeadViewDelegate
- (void)responseRightButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)commitAction:(id)sender {
    if ([NSString isBlankString:self.firstTextField.text] || [NSString isBlankString:self.secondTextField.text]) {
        [self showText:@"请输入完整信息"];
        return;
    }
    if (![self.firstTextField.text isEqualToString:self.secondTextField.text]) {
        [self showText:@"两次输入的不一样"];
        return;
    }
    [SecretModel updateSafeKey:self.firstTextField.text success:^(BOOL isSuccess) {
        if (isSuccess) {
            [self showText:@"设置成功" completeBlock:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }else{
            [self showText:@"保存密码失败"];
        }
    } failure:^(NSError *error) {
        [self showError:error];
    }];
}
@end
