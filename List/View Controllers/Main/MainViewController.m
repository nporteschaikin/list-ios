//
//  MainViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "BlurNavigationBar.h"
#import "BlackNavigationBar.h"
#import "MyLocationPicturesViewController.h"
#import "MyLocationEventsViewController.h"
#import "UserViewController.h"
#import "SettingsViewController.h"
#import "ListConstants.h"

@interface MainViewController ()

@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) LocationManager *locationManager;
@property (strong, nonatomic) ListUITabBarController *tabBarController;

@end

@implementation MainViewController

- (instancetype)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
        self.session.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set up view.
     */
    
    self.view.backgroundColor = [UIColor listUI_blueColorAlpha:1];
    self.view.clipsToBounds = YES;
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 3.0f;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * If login view controller exists, remove it.
     */
    
    if (self.loginViewController) {
        [self.loginViewController.view removeFromSuperview];
        [self.loginViewController removeFromParentViewController];
        [self.loginViewController didMoveToParentViewController:nil];
    }
    
    /*
     * Create & display login view controller.
     */
    
    self.loginViewController = [[LoginViewController alloc] initWithSession:self.session];
    [self.view addSubview:self.loginViewController.view];
    [self.loginViewController didMoveToParentViewController:self];
    
}

- (void)setupTabBarController {
    
    /*
     * Skip if already set up.
     */
    
    if (self.tabBarController) return;
    
    /*
     * Create pictures view controller.
     */
    
    MyLocationPicturesViewController *picturesViewController = [[MyLocationPicturesViewController alloc] initWithSession:self.session];
    UINavigationController *picturesNavigationController = [[UINavigationController alloc] initWithNavigationBarClass:[BlurNavigationBar class] toolbarClass:nil];
    picturesNavigationController.viewControllers = @[ picturesViewController ];
    picturesNavigationController.listTabBarItem.image = [UIImage listUI_icon:ListUIIconPictures size:kListUITabBarDefaultImageSize];
    picturesNavigationController.listTabBarItem.barBackgroundColor = [UIColor whiteColor];
    
    /*
     * Create events view controller.
     */
    
    MyLocationEventsViewController *eventsViewController = [[MyLocationEventsViewController alloc] initWithSession:self.session];
    UINavigationController *eventsNavigationController = [[UINavigationController alloc] initWithNavigationBarClass:[BlurNavigationBar class] toolbarClass:nil];
    eventsNavigationController.viewControllers = @[ eventsViewController ];
    eventsNavigationController.listTabBarItem.image = [UIImage listUI_icon:ListUIIconEvents size:kListUITabBarDefaultImageSize];
    eventsNavigationController.listTabBarItem.barBackgroundColor = [UIColor whiteColor];
    
    /*
     * Create user view controller.
     */
    
    UserViewController *userViewController = [[UserViewController alloc] initWithUser:self.session.user session:self.session];
    UINavigationController *userNavigationController = [[UINavigationController alloc] initWithNavigationBarClass:nil toolbarClass:nil];
    userNavigationController.viewControllers = @[ userViewController ];
    userNavigationController.listTabBarItem.image = [UIImage listUI_icon:ListUIIconUser size:kListUITabBarDefaultImageSize];
    
    /*
     * Create settings view controller.
     */
    
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    UINavigationController *settingsNavigationController = [[UINavigationController alloc] init];
    settingsNavigationController.viewControllers = @[ settingsViewController ];
    settingsNavigationController.listTabBarItem.image = [UIImage listUI_icon:ListUIIconMenu size:kListUITabBarDefaultImageSize];
    
    /*
     * Create tab bar controller.
     */
    
    ListUITabBarController *tabBarController = self.tabBarController = [[ListUITabBarController alloc] init];
    tabBarController.viewControllers = @[ picturesNavigationController, eventsNavigationController, userNavigationController, settingsNavigationController ];
    
    /*
     * Present tab bar controller.
     */
    
    [self presentViewController:tabBarController animated:YES completion:nil];
    
}

#pragma mark - SessionDelegate

- (void)sessionAuthenticated:(Session *)session {
    
    /*
     * Store token in user defaults.
     */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:session.sessionToken forKey:kUserDefaultsSessionTokenKey];
    
    /*
     * Get rid of login view controller.
     */
    
    LoginViewController *loginViewController = self.loginViewController;
    UIView *loginView = loginViewController.view;
    [UIView animateWithDuration:0.25f animations:^{
        loginView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [loginView removeFromSuperview];
        [loginViewController removeFromParentViewController];
        [loginViewController didMoveToParentViewController:nil];
    }];
    
    /*
     * Create location manager.
     */
    
    self.locationManager = [[LocationManager alloc] init];
    self.locationManager.delegate = self;
    
    /*
     * Ask for when-in-use authorization.
     */
    
    [self.locationManager requestWhenInUseAuthorization];
    
}

- (void)session:(Session *)session failedToAuthenticateWithError:(NSError *)error {
    
    /*
     * Run same message as failed to authenticate.
     */
    
    [self session:session failedToAuthenticateWithResponse:nil];
    
}

- (void)session:(Session *)session failedToAuthenticateWithResponse:(id<NSObject>)body {
    
    /*
     * Handle auth error.
     */
    
    NSLog(@"%@", @"Failed to authenticate.");
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    /*
     * Setup tab bar controller.
     */
    
    [self setupTabBarController];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            
            /*
             * Start updating location.
             */
            
            [manager startUpdatingLocation];
            
            /*
             * If we have a location, use it.
             * Otherwise, start seeking!
             */
            
            if (manager.location) {
                [self setupTabBarController];
            }
            
            break;
        }
        case kCLAuthorizationStatusDenied: {
            
            /*
             * TODO: Show a message advocating
             * for user to share location.
             */
            
            break;
        }
        default: {
            break;
        }
    }
}

@end
