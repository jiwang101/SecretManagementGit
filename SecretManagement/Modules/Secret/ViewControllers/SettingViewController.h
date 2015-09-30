//
//  SettingViewController.h
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/30.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"

@interface SettingViewController : UIViewController<HeadViewDelegate>
@property (weak, nonatomic) IBOutlet HeadView *headView;

@end
