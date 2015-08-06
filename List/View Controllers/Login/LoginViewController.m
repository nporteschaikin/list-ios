//
//  LoginViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginViewController.h"
#import "MainViewController.h"
#import "Session.h"
#import "Constants.h"
#import "LoginView.h"
#import "ActivityIndicatorView.h"
#import "UIColor+List.h"

@interface LoginViewController () <SessionDelegate>

@property (strong, nonatomic) LoginView *loginView;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) Session *session;

@end

@implementation LoginViewController

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
     * Make view blue.
     */
    
    self.view.backgroundColor = [UIColor blackColor];
    
    /*
     * Hide foreground views in login view..
     */
    
    [self.loginView showForegroundViews:NO
                               animated:NO];
    
    /*
     * Add subviews to view.
     */
    
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.activityIndicatorView];
    
    /*
     * Load login view images.
     */
    
    [self.loginView loadImagesAnimated:YES
                            onComplete:^{
                                
                                /*
                                 * Handle existing session.
                                 */
                                
                                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                NSString *sessionToken = [userDefaults objectForKey:SessionTokenUserDefaultsKey];
                                if (sessionToken) {
                                    [self authWithTokenKind:SessionAuthTokenKindSessionToken
                                                 tokenValue:sessionToken];
                                } else {
                                    [self.loginView showForegroundViews:YES
                                                               animated:YES];
                                }
                                
                            }];
    
    
    
}


- (void)authWithTokenKind:(SessionAuthTokenKind)tokenKind
               tokenValue:(NSString *)tokenValue {
    
    /*
     * Start activity indicator.
     */
    
    self.activityIndicatorView.hidden = NO;
    
    /*
     * Hide foreground views.
     */
    
    [self.loginView showForegroundViews:NO
                               animated:YES];
    
    /*
     * If this is a Facebook token, respond a second late.
     * This is a hacky answer to a nasty bug where the frame
     * gets screwed.
     */
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (tokenKind == SessionAuthTokenKindFacebookAccessToken ? 1 : 0) * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self.session authWithTokenKind:tokenKind tokenValue:tokenValue onComplete:^(Session *session) {
            
            /*
             * Hide login view.
             */
            
            [self.loginView showForegroundViews:NO
                                       animated:YES];
            
            /*
             * Stop animating activity indicator.
             */
            
            self.activityIndicatorView.hidden = YES;
            
            /*
             * Save session token to user defaults.
             */
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:session.sessionToken
                             forKey:SessionTokenUserDefaultsKey];
            
            
            /*
             * Ask to register for APN.
             */
            
            UIApplication *application = [UIApplication sharedApplication];
            UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
            [application registerUserNotificationSettings:notificationSettings];
            
            /*
             * Push to new view controller.
             */
            
            [self moveToMainViewController];
            
        } onError:^(NSError *error) {
            
            /*
             * Show login view.
             */
            
            [self.loginView showForegroundViews:YES
                                       animated:YES];
            
            /*
             * Stop animating activity indicator.
             */
            
            self.activityIndicatorView.hidden = YES;
            
        } onFail:^(id<NSObject> body) {
            
            /*
             * Show login view.
             */
            
            [self.loginView showForegroundViews:YES
                                       animated:YES];
            
            /*
             * Stop animating activity indicator.
             */
            
            self.activityIndicatorView.hidden = YES;
            
        }];
        
    });
};

- (void)moveToMainViewController {
    self.mainViewController = [[MainViewController alloc] initWithSession:self.session];
    [self addChildViewController:self.mainViewController];
    [self.view addSubview:self.mainViewController.view];
    [self.mainViewController didMoveToParentViewController:self];

    self.mainViewController.view.alpha = 0.0f;
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.mainViewController.view.alpha = 1.0f;
                     }];
}

- (void)handleLoginWithFacebookButton:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"]
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (!result.isCancelled) {
                                    
                                    /*
                                     * Create a session with the token.
                                     */
                                    
                                    FBSDKAccessToken *token = result.token;
                                    NSString *tokenString = token.tokenString;
                                    [self authWithTokenKind:SessionAuthTokenKindFacebookAccessToken
                                                 tokenValue:tokenString];
                                }
                            }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = (CGRectGetWidth(self.view.bounds) - ActivityIndicatorViewDefaultSize) / 2;
    y = (CGRectGetHeight(self.view.bounds) - ActivityIndicatorViewDefaultSize) / 2;
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
    
    self.loginView.frame = self.view.bounds;
}

#pragma mark - SessionDelegate

- (void)sessionDeauthenticated:(Session *)session {
    
    /*
     * Remove main view controller.
     */
    
    [self.mainViewController.view removeFromSuperview];
    [self.mainViewController removeFromParentViewController];
    [self.mainViewController didMoveToParentViewController:nil];
    self.mainViewController = nil;
    
    /*
     * Show login button, etc.
     */
    
    [self.loginView showForegroundViews:YES
                               animated:YES];
}

#pragma mark - Dynamic getters

- (LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] init];
        
        UIButton *loginWithFacebookButton = _loginView.loginWithFacebookButton;
        [loginWithFacebookButton addTarget:self
                                    action:@selector(handleLoginWithFacebookButton:)
                          forControlEvents:UIControlEventTouchDown];
    }
    return _loginView;
}

- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleWhite];
        _activityIndicatorView.hidden = YES;
    }
    return _activityIndicatorView;
}

@end
