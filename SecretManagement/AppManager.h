//
//  AppManage.h
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/29.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

/**
 *  手势密码
 */
@property (nonatomic, assign) NSString *gesturePasss;

/**
 *  单例
 *
 *  @return 单例
 */
+ (AppManager*) shareManager;
@end
