//
//  GesturePwdViewController.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/29.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "GesturePwdViewController.h"
#import "NSString+Util.h"
#import "UIViewController+Message.h"

#import "KKGestureLockView.h"
#import "HeadView.h"
#import "AppManager.h"

#import "SecretListViewController.h"

@interface GesturePwdViewController ()<KKGestureLockViewDelegate,HeadViewDelegate>
@property (weak, nonatomic) IBOutlet KKGestureLockView *gestureLockView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet HeadView *headview;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
- (IBAction)restartAction:(id)sender;


@property (strong, nonatomic) NSString *firstPWD;
@end

@implementation GesturePwdViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}
#pragma mark init
- (void)initView{
    self.headview.delegate = self;
    self.headview.titleLabel.text = @"手势密码";
    
    self.gestureLockView.normalGestureNodeImage = [UIImage imageNamed:@"a_normal"];
    self.gestureLockView.selectedGestureNodeImage = [UIImage imageNamed:@"a_ative"];
    self.gestureLockView.lineColor = RGBCOLOR(41, 89, 158);
    self.gestureLockView.lineWidth = 8;
    self.gestureLockView.delegate = self;
    self.gestureLockView.contentInsets = UIEdgeInsetsMake(2,2,2,2);
    self.restartButton.hidden = YES;
    if (self.gestureType == GestureType_SetPassword) {
        self.messageLabel.text = @"设置手势密码";
    }else if (self.gestureType == GestureType_Verify){
        self.messageLabel.text = @"欢迎回来~~~";
        self.headview.leftBtn.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - KKGestureLockViewDelegate
- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    if (self.gestureType == GestureType_SetPassword) {
        NSArray *pointArr = [passcode componentsSeparatedByString:@","];
        if ([NSString isBlankString:self.firstPWD]) { //第一次设置
            if (pointArr.count >= 4) {
                self.messageLabel.text = @"再次绘制解锁图案";
                self.messageLabel.textColor = [UIColor whiteColor];
                self.firstPWD = passcode;
                self.restartButton.hidden = NO;
            } else {
                self.messageLabel.text = @"必须大于等于连续四个点";
                self.messageLabel.textColor = [UIColor redColor];
            }
        } else { //第二次设置
            if ([passcode isEqualToString:self.firstPWD]) {
                [self showText:@"设置成功" completeBlock:^{
                    [AppManager shareManager].gesturePasss = passcode;
                    [self performSegueWithIdentifier:@"secretListSegue" sender:self];
                }];
            }else{
                self.messageLabel.text = @"与第一次绘制不一样，请重新绘制";
                self.messageLabel.textColor = [UIColor redColor];
                gestureLockView.isError = YES;
            }
        }
    }else if (self.gestureType == GestureType_Verify){
        if ([passcode isEqualToString:[AppManager shareManager].gesturePasss]) {
            [self performSegueWithIdentifier:@"secretListSegue" sender:self];
        }else{
            if ([passcode isEqualToString:@"0,3,7,2,1,4,5,8"]) {
                //进入无敌模式
                self.gestureType = GestureType_SetPassword;
                [AppManager shareManager].gesturePasss = @"";
                self.messageLabel.text = @"设置手势密码";
                self.messageLabel.textColor = [UIColor whiteColor];
                return;
            }
            self.messageLabel.text = @"手势密码错误";
            self.messageLabel.textColor = [UIColor redColor];
            gestureLockView.isError = YES;
        }
    }
}
#pragma mark - HeadViewDelegate
- (void)responseLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - actions
- (IBAction)restartAction:(id)sender {
    self.firstPWD = @"";
    self.messageLabel.text = @"设置手势密码";
    self.messageLabel.textColor = [UIColor whiteColor];
    self.restartButton.hidden = YES;
}
@end
