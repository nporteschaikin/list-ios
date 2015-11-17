//
//  LoginViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "LoginView.h"
#import "Session.h"

@interface LoginViewController : ListUIViewController <LoginViewDelegate, SessionDelegate>

- (instancetype)initWithSession:(Session *)session;

@end
