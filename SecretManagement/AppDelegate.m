//
//  AppDelegate.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/29.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import "NSString+Util.h"
#import "AppManager.h"

#import "GesturePwdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initSystem];
    [self startSystem];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initSystem{
    //统一键盘管理，避免输入框被遮住
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:40];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:NO];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)startSystem{
    UIStoryboard *mainSB= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    
    GesturePwdViewController *rootVC = (GesturePwdViewController*)[mainSB instantiateViewControllerWithIdentifier:@"GesturePwdViewController"];
    if ([NSString isBlankString:[AppManager shareManager].gesturePasss]) {
        rootVC.gestureType = GestureType_SetPassword;
    }else{
        rootVC.gestureType = GestureType_Verify;
    }
    [nav setViewControllers:@[rootVC]];
}
@end
