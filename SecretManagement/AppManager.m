//
//  AppManage.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/29.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "AppManager.h"
#import "ConstantDefined.h"
#import "NSString+Util.h"

@implementation AppManager
+(AppManager *)shareManager{
    static AppManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[AppManager alloc] init];
        }
    });
    return instance;
}
- (instancetype)init{
    if (self = [super init]) {
        NSString *gestureString = [[NSUserDefaults standardUserDefaults] valueForKey:kUserDefaultGesturePass];
        if (![NSString isBlankString:gestureString]) {
            self.gesturePasss = gestureString;
        }else{
            self.gesturePasss = @"";
        }
    }
    return self;
}
-(void)setGesturePasss:(NSString *)gesturePasss{
    _gesturePasss = gesturePasss;
    [[NSUserDefaults standardUserDefaults] setValue:gesturePasss forKey:kUserDefaultGesturePass];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
