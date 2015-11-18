//
//  LoginViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginViewController.h"
#import "LoginDataSource.h"
#import "ListConstants.h"

@interface LoginViewController ()

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) LoginView *loginView;
@property (strong, nonatomic) LoginDataSource *dataSource;

@end

@implementation LoginViewController

- (instancetype)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
        
        /*
         * Create data source.
         */
        
        self.dataSource = [[LoginDataSource alloc] init];
    }
    return self;
}

- (void)loadView {
    
    /*
     * Create login view.
     */
    
    self.loginView = [[LoginView alloc] init];
    self.loginView.dataSource = self.dataSource;
    self.loginView.delegate = self;
    self.view = self.loginView;
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Attempt to log in with existing token.
     */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [userDefaults objectForKey:kUserDefaultsSessionTokenKey];
    if (sessionToken) {
        [self.session authWithTokenKind:SessionAuthTokenKindSessionToken tokenValue:sessionToken];
    }
    
}

#pragma mark - LoginViewDelegate

- (void)loginView:(LoginView *)loginView buttonTapped:(LoginViewButton)button {
    switch (button) {
            
        /*
         * Login with Facebook.
         */
            
        case LoginViewButtonFacebook: {
            
            FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
            
            /*
             * FB requires you to make sure
             * you're logged out now.
             */
            
            [login logOut];
            
            /*
             * FB login.
             */
            
            [login logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                if (!result.isCancelled && !error) {
                    
                    /*
                     * Attempt to create a session with the token.
                     */
                    
                    FBSDKAccessToken *token = result.token;
                    NSString *tokenString = token.tokenString;
                    [self.session authWithTokenKind:SessionAuthTokenKindFacebookAccessToken tokenValue:tokenString];
                }
            }];
            
            break;
        }
    }
}

@end
