//
//  SafeKeySettingViewController.h
//  SecretManagement
//
//  Created by ssf-xiong on 15/10/8.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
@interface SafeKeySettingViewController : UIViewController<HeadViewDelegate>
@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
- (IBAction)commitAction:(id)sender;

@end
