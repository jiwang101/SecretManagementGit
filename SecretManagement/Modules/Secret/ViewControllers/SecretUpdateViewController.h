//
//  SecretUpdateViewController.h
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/30.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import "SecretModel.h"


@interface SecretUpdateViewController : UIViewController<HeadViewDelegate>
@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (assign, nonatomic) SecretType secretType;
@property (strong, nonatomic) SecretModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *stImageView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *secretTextField;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;
- (IBAction)commitAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *safeKeyTextField;

@end
