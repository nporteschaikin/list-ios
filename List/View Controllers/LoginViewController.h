//
//  LoginViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"

@interface LoginViewController : UIViewController

- (instancetype)initWithSession:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
