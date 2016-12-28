//
//  AppDelegate.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "AppDelegate.h"
#import <Intents/Intents.h>
#import "SWRevealViewController.h"
#import "XYRearViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()<SWRevealViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //[self setUpSiri];
    
    [self initMainViews];
    
    [self broadcastSettings];
    
    
    
    return YES;
}
-(void)broadcastSettings{

    NSError *error = NULL;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if(error) {
        // Do some error handling
    }
    [session setActive:YES error:&error];
    if (error) {
        // Do some error handling
    }
}
- (void)setUpSiri{
    if([INPreferences siriAuthorizationStatus] == INSiriAuthorizationStatusNotDetermined){
        [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
            NSLog(@"the siri authorization...%ld",(long)status);
        }];
    }
}


/**配置主要视图*/
-(void)initMainViews{
    
    XYRearViewController* rearCtl=[[XYRearViewController alloc]initWithNibName:@"XYRearViewController" bundle:nil];
    UINavigationController *frontNavi = [[UIStoryboard storyboardWithName:@"NotifyList" bundle:nil] instantiateInitialViewController];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearCtl frontViewController:frontNavi];
    revealController.delegate = self;
    
    UIWindow* window=[[UIWindow alloc]initWithFrame: [UIScreen mainScreen].bounds];
    window.rootViewController=revealController;
    self.window=window;
    [self.window makeKeyAndVisible];
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


//程序进入后台,申请一个backgroundTask,持续获取用户位置
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[UIApplication sharedApplication] beginBackgroundTaskWithName:kUSER_CURRENT_LOCATION_NOTIFY expirationHandler:^{
        [NSTimer scheduledTimerWithTimeInterval:5.0 target:[XYUserInfo userInfo] selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }];
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
