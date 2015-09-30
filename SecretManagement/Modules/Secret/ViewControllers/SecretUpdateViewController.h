//
//  SecretUpdateViewController.h
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/30.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"

typedef NS_ENUM(NSUInteger, SecretType) {
    SecretType_Add,
    SecretType_Update,
};
@interface SecretUpdateViewController : UIViewController<HeadViewDelegate>
@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (assign, nonatomic) SecretType secretType;

@end
