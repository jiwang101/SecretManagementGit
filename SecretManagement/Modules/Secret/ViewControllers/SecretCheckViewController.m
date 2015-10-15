//
//  SecretCheckViewController.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/10/8.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "SecretCheckViewController.h"

#import "NSString+Util.h"
#import "UIViewController+Message.h"

@implementation SecretCheckViewController

#pragma mark - life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

#pragma mark - initview
- (void)initView{
    self.secretView.hidden = YES;
    //添加点击事件
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    self.secretView.userInteractionEnabled = YES;
    [self.secretView addGestureRecognizer:tgr];
    
    [self.secretTextField becomeFirstResponder];
}

#pragma mark - actions
- (void)tapGestureAction{
    UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
    //把字符串放置到剪贴板上：
    pasteboard.string = self.secretModel.secretString;
    [self showText:@"已成功复制到剪切板"];
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)commitAction:(id)sender {
    if ([NSString isBlankString:self.secretTextField.text]) {
        [self showText:@"请输入安全密码"];
        return;
    }
    if (![self.secretTextField.text isEqualToString:[SecretModel getSecretSafeKey]]) {
        [self showText:@"安全密码错误，请重新输入"];
        self.secretTextField.text = @"";
        self.secretView.hidden = YES;
    }else{
        if (self.secretType == SecretType_Check) {
            self.secretLabel.text = self.secretModel.secretString;
            self.secretView.hidden = NO;
            [self.view endEditing:YES];
            self.secretTextField.text = @"";
        }else if (self.secretType == SecretType_Delete)
        {
            [SecretModel deleteSecret:self.secretModel success:^(BOOL isSuccess) {
                if (isSuccess) {
                    [self showText:@"删除成功" completeBlock:^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                }else{
                    [self showText:@"删除失败，请重试"];
                }
            } failure:^(NSError *error) {
                [self showError:error];
            }];
        }
        
    }
}
@end
