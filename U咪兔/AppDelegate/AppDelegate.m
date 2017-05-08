//
//  AppDelegate.m
//  U米兔
//
//  Created by 谭培 on 2017/3/30.
//  Copyright © 2017年 RhettTamp. All rights reserved.
//

#import "AppDelegate.h"
#import "UMTLoginViewController.h"
#import "UMTRootViewController.h"
#import <BmobMessageSDK/Bmob.h>
#import "UMTSaveUserInfoHelper.h"
#import "UMTNavigationController.h"
#import "UMTRefreshToken.h"
//#import <BaiduMapKit/BaiduMapAPI_Base/BMKBaseComponent.h>
#import "UMTKeychainTool.h"
#import "UMTBaseRequest.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
//    BOOL set = [mapManager start:@"foiZgrIuq4XGlCWUlf6HGlHj3kprgX17" generalDelegate:self];
//    if (!set) {
//        NSLog(@"manager start failed!");
//    }
    NSString *token = [UMTKeychainTool load:kTokenKey];
    
    if (token && token.length > 0) {
        UMTBaseRequest *sharedRequest = [UMTBaseRequest sharedRequest];
        sharedRequest.requestToken = token;
        NSDate *date = [NSDate date];
        NSDate *lastDate = [UMTKeychainTool load:@"lastDate"];
        NSTimeInterval interval = [date timeIntervalSinceDate:lastDate];
        if (interval > 24*3*3600) {
            [UMTRefreshToken refreshTokenWithOldToken:token];
            [UMTKeychainTool save:@"lastDate" data:date];
        }
        UMTRootViewController *rootVc = [[UMTRootViewController alloc]init];
        self.window.rootViewController = rootVc;
    }else{
        UMTLoginViewController *loginVC = [[UMTLoginViewController alloc]init];
        UMTNavigationController *nav = [[UMTNavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
    }
//    [Bmob registerWithAppKey:@"10342bad97d4b80691b2cdb168cb3ea6"];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
