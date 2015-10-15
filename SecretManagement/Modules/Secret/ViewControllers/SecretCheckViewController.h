//
//  SecretCheckViewController.h
//  SecretManagement
//
//  Created by ssf-xiong on 15/10/8.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecretModel.h"

@interface SecretCheckViewController : UIViewController

- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *secretView;
@property (weak, nonatomic) IBOutlet UILabel *secretLabel;
@property (weak, nonatomic) IBOutlet UITextField *secretTextField;
- (IBAction)commitAction:(id)sender;

@property (strong, nonatomic) SecretModel *secretModel;
@property (assign, nonatomic) SecretType secretType;
@end
