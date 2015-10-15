//
//  SecretUpdateViewController.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/30.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "SecretUpdateViewController.h"

#import "NSString+Util.h"
#import "UIViewController+Message.h"

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
        self.safeKeyTextField.hidden = YES;
    }else{
        self.headView.titleLabel.text = @"修改";
        self.titleTextField.text = self.model.secretString;
        self.titleTextField.enabled = NO;
        self.remarkTextField.text = self.model.detailString;
        self.safeKeyTextField.hidden = NO;
    }
    self.headView.delegate = self;
}
#pragma mark - HeadViewDelegate
- (void)responseLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)commitAction:(id)sender {
    if ([NSString isBlankString:self.titleTextField.text]) {
        [self showText:@"标题不能为空"];
        return;
    }
    if ([NSString isBlankString:self.secretTextField.text]) {
        [self showText:@"秘密不能为空"];
        return;
    }
    if (self.secretType == SecretType_Add && [SecretModel checkSecret:self.titleTextField.text]) {
        [self showText:@"此标题已经存在，请换个标题"];
        return;
    }
    if (self.secretType == SecretType_Update) {
        if ([NSString isBlankString:self.safeKeyTextField.text]) {
            [self showText:@"安全密码不能为空"];
            return;
        }
        if (![self.safeKeyTextField.text isEqualToString:[SecretModel getSecretSafeKey]]) {
            [self showText:@"安全密码不正确，请重新输入"];
            self.safeKeyTextField.text = @"";
            return ;
        }
    }
    SecretModel *model = [[SecretModel alloc] init];
    model.titleString = self.titleTextField.text;
    model.secretString = self.secretTextField.text;
    model.detailString = self.remarkTextField.text;
    model.imageName = @"CM_bank";
    [SecretModel updateSecret:model success:^(BOOL isSuccess) {
        [self showText:@"提交成功" completeBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(NSError *error) {
        [self showError:error];
    }];
}
@end
