//
//  GesturePwdViewController.h
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/29.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GestureType) {
    GestureType_SetPassword,    //设置手势密码
    GestureType_Verify,         //验证手势密码
};

@interface GesturePwdViewController : UIViewController

/**
 *  手势模式
 */
@property (nonatomic, assign) GestureType gestureType;

@end
