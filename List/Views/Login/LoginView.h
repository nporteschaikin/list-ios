//
//  LoginView.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

typedef NS_ENUM(NSUInteger, LoginViewButton) {
    LoginViewButtonFacebook = 0
};

@class LoginView;

@protocol LoginViewDataSource <NSObject>

- (NSString *)loginView:(LoginView *)loginView textForPageAtIndex:(NSInteger)index;
- (NSURL *)loginView:(LoginView *)loginView imageURLForPageAtIndex:(NSInteger)index;
- (NSInteger)numberOfPagesInLoginView:(LoginView *)loginView;

@end

@protocol LoginViewDelegate <NSObject>

@optional
- (void)loginView:(LoginView *)loginView buttonTapped:(LoginViewButton)button;

@end

@interface LoginView : UIView <UIScrollViewDelegate>

@property (weak, nonatomic) id<LoginViewDataSource> dataSource;
@property (weak, nonatomic) id<LoginViewDelegate> delegate;

- (void)reloadView;

@end
