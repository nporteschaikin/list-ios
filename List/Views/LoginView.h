//
//  LoginView.h
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (strong, nonatomic, readonly) UIButton *loginWithFacebookButton;

- (void)loadImagesAnimated:(BOOL)animated
                onComplete:(void(^)(void))onComplete;
- (void)showForegroundViews:(BOOL)show
                   animated:(BOOL)animated;

@end
