//
//  AppDelegate.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LLocationManager.h"
#import "AppearanceHelper.h"
#import "Constants.h"
#import "Session.h"
#import <HockeySDK/HockeySDK.h>

@interface AppDelegate ()

@property (strong, nonatomic) Session *session;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
     * Set up Hockey.
     */
    
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:HockeyIdentifier];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];
    
    /*
     * Set default appearance settings.
     */
    
    [AppearanceHelper customizeAppearance];
    
    /*
     * Create window.
     */
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    /*
     * Start tracking location.
     */
    
    LLocationManager *locationManager = [LLocationManager sharedManager];
    [locationManager start];
    
    /*
     * Create session.
     */
    
    self.session = [[Session alloc] init];
    
    /*
     * Set defaults if none exist.
     */
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:DiscoveryRadiusInMilesUserDefaultsKey]) {
        [defaults setObject:[NSString stringWithFormat:@"%f", DiscoveryRadiusInMilesDefaultValue]
                     forKey:DiscoveryRadiusInMilesUserDefaultsKey];
    }
    
    /*
     * Start w/ login view controller.
     */
    
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithSession:self.session];
    self.window.rootViewController = loginViewController;
    
    [self.window makeKeyAndVisible];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /*
     * Save device token.
     */
    
    NSString *tokenString = [deviceToken description];
    tokenString = [tokenString stringByReplacingOccurrencesOfString: @"<" withString: @""];
    tokenString = [tokenString stringByReplacingOccurrencesOfString: @">" withString: @""];
    tokenString = [tokenString stringByReplacingOccurrencesOfString: @" " withString: @""];
    [self.session saveDeviceToken:tokenString
                       onComplete:nil
                          onError:nil
                           onFail:nil];
    
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

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
