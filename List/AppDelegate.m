//
//  AppDelegate.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AppDelegate.h"
#import "Session.h"
#import "MainViewController.h"
#import "AppearanceHelper.h"
#import "ListConstants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
     * Set appearance sheet.
     */
    
    [AppearanceHelper customizeAppearance];
    
    /*
     * Set user defaults if necessary.
     */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:kUserDefaultsDiscoveryRadiusInMilesKey]) {
        [userDefaults setObject:@5 forKey:kUserDefaultsDiscoveryRadiusInMilesKey];
    }
    
    /*
     * Set status bar style.
     */
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    /*
     * Create window.
     */
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    /*
     * Create session.
     */
    
    Session *session = [[Session alloc] init];
    
    /*
     * Create view controller.
     */
    
    MainViewController *mainViewController = [[MainViewController alloc] initWithSession:session];
    
    /*
     * Display view controller.
     */
    
    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
    
    /*
     * Return with Facebook.
     */
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
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
    
    /*
     * Active Facebook events.
     */
    
    [FBSDKAppEvents activateApp];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
